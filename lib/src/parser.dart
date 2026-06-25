import 'dart:convert';
import 'dart:io' as io;
import 'dart:math' as math;
import 'package:path/path.dart' as p;
import 'package:collection/collection.dart';
import 'schema.dart';
import 'utils.dart';
import 'generated/schema_202012.g.dart';

/// A parser to build a [Schema] AST from a decoded JSON schema.
final class SchemaParser {
  final Map<String, Schema> _cache = {};
  final Map<_MergePair, Schema> _mergeCache = {};
  final Map<String, dynamic> _rootJson;
  final String baseUri;
  final Future<List<int>> Function(Uri uri)? uriResolver;
  final Set<String> _loadedFiles = {};
  final bool flatten;
  final bool _disallowExternalRefs;
  final Map<String, _InlineSchema> _inlineSchemas = {};
  final Set<String> _parsingPaths = {};
  Set<String>? _currentVocabularies;
  final Map<String, Set<String>?> _metaschemaVocabularies = {};
  final Map<String, Schema> _dynamicAnchors = {};

  /// Creates a parser for the given [rootJson] schema definition.
  SchemaParser(
    this._rootJson, {
    this.baseUri = 'http://localhost/',
    this.uriResolver,
    this._disallowExternalRefs = false,
    this.flatten = true,
  }) {
    _findInlineIds(_rootJson, baseUri, '$baseUri#');
  }

  /// Parses the schema and returns the resolved [Schema] AST.
  Future<Schema> parse() async {
    final root = await _parseSchema(
      _rootJson,
      '$baseUri#',
      parentResourceUri: baseUri,
    );
    _resolveRefs(root);
    if (flatten) {
      final flattened = _flatten(root);
      _updateResolvedRefs(flattened);
      final flattenedDynamicAnchors = _dynamicAnchors.map(
        (k, v) => MapEntry(k, _flattenCache[v] ?? v),
      );
      return flattened.copyWith(dynamicAnchors: flattenedDynamicAnchors);
    } else {
      _updateResolvedRefs(root);
      return root.copyWith(dynamicAnchors: _dynamicAnchors);
    }
  }

  String _getFileUri(String uri) {
    return uri.split('#').first;
  }

  Future<Set<String>?> _loadVocabularies(String schemaUrl) async {
    schemaUrl = normalizeSchemaUri(schemaUrl);
    if (_metaschemaVocabularies.containsKey(schemaUrl)) {
      return _metaschemaVocabularies[schemaUrl];
    }
    if (schemaUrl == 'https://json-schema.org/draft/2020-12/schema') {
      return null;
    }
    Set<String>? result;
    if (uriResolver != null) {
      try {
        final bytes = await uriResolver!(Uri.parse(schemaUrl));
        final json = jsonDecode(utf8.decode(bytes));
        if (json is Map && json.containsKey(r'$vocabulary')) {
          final vocab = json[r'$vocabulary'];
          if (vocab is Map) {
            result = vocab.entries
                .where((e) => e.value == true)
                .map((e) => e.key as String)
                .toSet();
          }
        }
      } catch (e) {
        print('Warning: failed to load metaschema $schemaUrl: $e');
      }
    }
    _metaschemaVocabularies[schemaUrl] = result;
    return result;
  }

  Future<Schema> _parseSchema(
    dynamic json,
    String path, {
    bool isExternal = false,
    String? parentResourceUri,
  }) async {
    path = normalizeSchemaUri(path);
    if (_cache.containsKey(path)) {
      return _cache[path]!;
    }
    if (json is bool) {
      final schema = json ? Schema.anything : Schema.never;
      _cacheSchema(schema, path, path, null, null);
      return schema;
    }

    if (json is! Map) {
      throw ArgumentError('Schema must be a boolean or a Map');
    }

    var pathToTrack = path;
    if (json.containsKey(r'$id')) {
      final id = json[r'$id'] as String;
      final currentFile = _getFileUri(path);
      pathToTrack = normalizeSchemaUri(
        Uri.parse(currentFile).resolve(id).toString(),
      );
      if (!pathToTrack.contains('#')) {
        pathToTrack = '$pathToTrack#';
      }
    }
    _parsingPaths.add(pathToTrack);

    final savedVocabs = _currentVocabularies;
    if (isExternal) {
      _currentVocabularies = null;
    }
    if (json.containsKey(r'$schema')) {
      final schemaUrl = json[r'$schema'] as String;
      _currentVocabularies = await _loadVocabularies(schemaUrl);
    }

    try {
      final generated = CoreAndValidationSpecificationsMetaSchema.fromJsonValue(
        json,
      );
      return await _mapGenerated(
        generated,
        path,
        json,
        parentResourceUri: parentResourceUri,
      );
    } finally {
      _currentVocabularies = savedVocabs;
      _parsingPaths.remove(pathToTrack);
    }
  }

  void _cacheSchema(
    Schema schema,
    String path,
    String originalPath,
    String? idUrl,
    String? anchorUrl, {
    String? dynamicAnchorUrl,
  }) {
    final normPath = normalizeSchemaUri(path);
    final normOriginalPath = normalizeSchemaUri(originalPath);
    final normIdUrl = idUrl != null ? normalizeSchemaUri(idUrl) : null;
    final normAnchorUrl = anchorUrl != null
        ? normalizeSchemaUri(anchorUrl)
        : null;
    final normDynamicAnchorUrl = dynamicAnchorUrl != null
        ? normalizeSchemaUri(dynamicAnchorUrl)
        : null;

    print(
      'Caching schema ${schema.hashCode}: idUrl parameter: $idUrl, schema.id: ${schema.id}',
    );

    if (normPath.isNotEmpty) {
      print('Caching path: $normPath');
      _cache[normPath] = schema;
    }
    if (normOriginalPath.isNotEmpty && normOriginalPath != normPath) {
      print('Caching original path: $normOriginalPath');
      _cache[normOriginalPath] = schema;
    }
    if (normIdUrl != null && normIdUrl != normPath) {
      print('Caching idUrl: $normIdUrl');
      _cache[normIdUrl] = schema;
    }
    if (normAnchorUrl != null) {
      print('Caching anchorUrl: $normAnchorUrl');
      _cache[normAnchorUrl] = schema;
    }
    if (normDynamicAnchorUrl != null) {
      print('Caching dynamicAnchorUrl: $normDynamicAnchorUrl');
      _cache[normDynamicAnchorUrl] = schema;
      _dynamicAnchors[normDynamicAnchorUrl] = schema;
    }
  }

  void _resolveRefs(Schema root) {
    final visited = <Schema>{};
    void visit(Schema s) {
      if (!visited.add(s)) return;

      final ref = s.ref ?? s.dynamicRef;
      if (ref != null) {
        final normRef = normalizeSchemaUri(ref);
        final target = _cache[normRef];
        if (target == null) {
          throw ArgumentError(
            'Cannot resolve ref: $ref (normalized: $normRef)',
          );
        }
        s.resolvedRef = target;
      }

      if (s.not != null) visit(s.not!);
      s.properties?.values.forEach(visit);
      s.patternProperties?.values.forEach(visit);
      if (s.additionalProperties != null) visit(s.additionalProperties!);
      s.dependentSchemas?.values.forEach(visit);
      if (s.unevaluatedProperties != null) visit(s.unevaluatedProperties!);
      if (s.items != null) visit(s.items!);
      s.prefixItems?.forEach(visit);
      if (s.contains != null) visit(s.contains!);
      if (s.unevaluatedItems != null) visit(s.unevaluatedItems!);
      s.allOf?.forEach(visit);
      s.anyOf?.forEach(visit);
      s.oneOf?.forEach(visit);
      if (s.discriminator?.mapping != null) {
        s.discriminator!.mapping!.values.forEach(visit);
      }
    }

    visit(root);
    _cache.values.forEach(visit);
  }

  void _updateResolvedRefs(Schema root) {
    final visited = <Schema>{};
    void visit(Schema s) {
      if (!visited.add(s)) return;
      if (s.ref != null || s.dynamicRef != null) {
        if (s.resolvedRef != null) {
          s.resolvedRef = _flattenCache[s.resolvedRef] ?? s.resolvedRef;
          visit(s.resolvedRef!);
        }
      }
      if (s.not != null) visit(s.not!);
      s.properties?.values.forEach(visit);
      s.patternProperties?.values.forEach(visit);
      if (s.additionalProperties != null) visit(s.additionalProperties!);
      s.dependentSchemas?.values.forEach(visit);
      if (s.unevaluatedProperties != null) visit(s.unevaluatedProperties!);
      if (s.items != null) visit(s.items!);
      s.prefixItems?.forEach(visit);
      if (s.contains != null) visit(s.contains!);
      if (s.unevaluatedItems != null) visit(s.unevaluatedItems!);
      s.allOf?.forEach(visit);
      s.anyOf?.forEach(visit);
      s.oneOf?.forEach(visit);
      if (s.discriminator?.mapping != null) {
        s.discriminator!.mapping!.values.forEach(visit);
      }
    }

    visit(root);
  }

  final Map<Schema, Schema> _flattenCache = {};

  /// Recursively flattens the schema by resolving and merging `allOf` constraints.
  /// For schemas containing `allOf`, it:
  /// 1. Recursively flattens all sub-schemas in `allOf`.
  /// 2. Merges all these flattened sub-schemas into a single schema using [_mergeAll].
  /// 3. Merges this combined schema with the local schema constraints (excluding `allOf` itself) using [_merge].
  /// 4. Preserves metadata (title, description, etc.) from the original schema.
  ///
  /// It uses [_flattenCache] to avoid infinite loops on self-referential schemas.
  Schema _flatten(Schema schema) {
    if (_flattenCache.containsKey(schema)) {
      return _flattenCache[schema]!;
    }

    final newNot = schema.not != null ? _flatten(schema.not!) : null;
    final notChanged = newNot != schema.not;

    if (schema.ref != null || schema.dynamicRef != null) {
      _flattenCache[schema] = schema;
      if (schema.resolvedRef != null) {
        schema.resolvedRef = _flatten(schema.resolvedRef!);
      }
      return schema;
    }

    _flattenCache[schema] = schema;

    var changed = notChanged;

    Map<String, Schema>? newProps;
    if (schema.properties != null) {
      newProps = {};
      schema.properties!.forEach((k, v) {
        final nv = _flatten(v);
        newProps![k] = nv;
        if (nv != v) changed = true;
      });
    }

    Map<RegExp, Schema>? newPatternProps;
    if (schema.patternProperties != null) {
      newPatternProps = {};
      schema.patternProperties!.forEach((k, v) {
        final nv = _flatten(v);
        newPatternProps![k] = nv;
        if (nv != v) changed = true;
      });
    }

    Schema? newAddProps;
    if (schema.additionalProperties != null) {
      newAddProps = _flatten(schema.additionalProperties!);
      if (newAddProps != schema.additionalProperties) changed = true;
    }

    Map<String, Schema>? newDependentSchemas;
    if (schema.dependentSchemas != null) {
      newDependentSchemas = {};
      schema.dependentSchemas!.forEach((k, v) {
        final nv = _flatten(v);
        newDependentSchemas![k] = nv;
        if (nv != v) changed = true;
      });
    }

    Schema? newUnevaluatedProperties;
    if (schema.unevaluatedProperties != null) {
      newUnevaluatedProperties = _flatten(schema.unevaluatedProperties!);
      if (newUnevaluatedProperties != schema.unevaluatedProperties) {
        changed = true;
      }
    }

    Schema? newItems;
    if (schema.items != null) {
      newItems = _flatten(schema.items!);
      if (newItems != schema.items) changed = true;
    }

    List<Schema>? newPrefixItems;
    var prefixItemsChanged = false;
    if (schema.prefixItems != null) {
      newPrefixItems = [];
      for (final item in schema.prefixItems!) {
        final ni = _flatten(item);
        newPrefixItems.add(ni);
        if (ni != item) prefixItemsChanged = true;
      }
      if (prefixItemsChanged) changed = true;
    }

    Schema? newContains;
    if (schema.contains != null) {
      newContains = _flatten(schema.contains!);
      if (newContains != schema.contains) changed = true;
    }

    Schema? newUnevaluatedItems;
    if (schema.unevaluatedItems != null) {
      newUnevaluatedItems = _flatten(schema.unevaluatedItems!);
      if (newUnevaluatedItems != schema.unevaluatedItems) changed = true;
    }

    List<Schema>? flattenedAllOf;
    var allOfChanged = false;
    if (schema.allOf != null) {
      flattenedAllOf = [];
      for (final sub in schema.allOf!) {
        final ns = _flatten(sub);
        flattenedAllOf.add(ns);
        if (ns != sub) allOfChanged = true;
      }
      if (allOfChanged) changed = true;
    }

    List<Schema>? newAnyOf;
    if (schema.anyOf != null) {
      newAnyOf = [];
      for (final sub in schema.anyOf!) {
        final ns = _flatten(sub);
        newAnyOf.add(ns);
        if (ns != sub) changed = true;
      }
    }

    List<Schema>? newOneOf;
    if (schema.oneOf != null) {
      newOneOf = [];
      for (final sub in schema.oneOf!) {
        final ns = _flatten(sub);
        newOneOf.add(ns);
        if (ns != sub) changed = true;
      }
    }

    Schema? newIfSchema;
    if (schema.ifSchema != null) {
      newIfSchema = _flatten(schema.ifSchema!);
      if (newIfSchema != schema.ifSchema) changed = true;
    }
    Schema? newThenSchema;
    if (schema.thenSchema != null) {
      newThenSchema = _flatten(schema.thenSchema!);
      if (newThenSchema != schema.thenSchema) changed = true;
    }
    Schema? newElseSchema;
    if (schema.elseSchema != null) {
      newElseSchema = _flatten(schema.elseSchema!);
      if (newElseSchema != schema.elseSchema) changed = true;
    }

    var result = schema;
    if (changed) {
      result = schema.copyWith(
        not: newNot,
        properties: newProps,
        patternProperties: newPatternProps,
        additionalProperties: newAddProps,
        dependentSchemas: newDependentSchemas,
        unevaluatedProperties: newUnevaluatedProperties,
        items: newItems,
        prefixItems: newPrefixItems,
        contains: newContains,
        unevaluatedItems: newUnevaluatedItems,
        anyOf: newAnyOf,
        oneOf: newOneOf,
        ifSchema: newIfSchema,
        thenSchema: newThenSchema,
        elseSchema: newElseSchema,
      );
    }

    if (schema.allOf != null) {
      final mergedAllOf = _mergeAll(flattenedAllOf!);
      final localSchema = result.copyWith(clearAllOf: true);
      final finalSchema = _merge(mergedAllOf, localSchema);
      final finalSchemaWithMetadata = finalSchema.copyWith(
        title: schema.title,
        description: schema.description,
        isDeprecated: schema.isDeprecated,
        deprecatedMessage: schema.deprecatedMessage,
        hasDefault: schema.hasDefault,
        defaultValue: schema.defaultValue,
        not: newNot,
        dartName: schema.dartName,
        id: schema.id,
        anchor: schema.anchor,
        dynamicAnchor: schema.dynamicAnchor,
        resourceUri: schema.resourceUri,
      );
      _flattenCache[schema] = finalSchemaWithMetadata;
      return finalSchemaWithMetadata;
    }

    _flattenCache[schema] = result;
    return result;
  }

  Schema _mergeAll(List<Schema> schemas) {
    if (schemas.isEmpty) return Schema.anything;
    var result = schemas.first;
    for (var i = 1; i < schemas.length; i++) {
      result = _merge(result, schemas[i]);
    }
    return result;
  }

  Schema _merge(Schema a, Schema b) {
    final realA = a.realSchema;
    final realB = b.realSchema;
    final pair = _MergePair(realA, realB);
    if (_mergeCache.containsKey(pair)) {
      return _mergeCache[pair]!;
    }

    // To prevent infinite recursion when merging self-referential (cyclic) schemas,
    // we immediately cache a placeholder schema for the current pair.
    // The placeholder uses a unique URI based on the identity hash code of the pair.
    // If the merge algorithm encounters the same pair again during recursive traversal,
    // it will return this placeholder from the cache instead of recursing infinitely.
    // Once the actual merge is complete, we resolve the placeholder's reference to the
    // fully merged schema.
    final placeholder = Schema(ref: 'urn:merge:${identityHashCode(pair)}');
    _mergeCache[pair] = placeholder;

    final merged = _mergeInner(realA, realB);
    final finalMerged = merged.copyWith(not: _mergeNot(realA.not, realB.not));

    placeholder.resolvedRef = finalMerged;
    _mergeCache[pair] = finalMerged;

    return finalMerged;
  }

  Schema? _mergeNot(Schema? a, Schema? b) {
    if (a == null) return b;
    if (b == null) return a;
    return Schema(anyOf: [a, b]);
  }

  Schema _mergeInner(Schema a, Schema b) {
    final realA = a.realSchema;
    final realB = b.realSchema;

    if (realA.isAnything) return b;
    if (realB.isAnything) return a;
    if (realA.isNever) return a;
    if (realB.isNever) return b;

    List<String>? mergedType;
    if (realA.type != null && realB.type != null) {
      mergedType = realA.type!
          .toSet()
          .intersection(realB.type!.toSet())
          .toList();
      if (mergedType.isEmpty) {
        return Schema.never;
      }
    } else {
      mergedType = realA.type ?? realB.type;
    }

    Map<String, Schema>? properties;
    if (realA.properties != null || realB.properties != null) {
      properties = <String, Schema>{}..addAll(realA.properties ?? {});
      realB.properties?.forEach((k, v) {
        if (properties!.containsKey(k)) {
          properties[k] = _merge(properties[k]!, v);
        } else {
          properties[k] = v;
        }
      });
    }

    Map<RegExp, Schema>? patternProperties;
    if (realA.patternProperties != null || realB.patternProperties != null) {
      patternProperties = <RegExp, Schema>{}
        ..addAll(realA.patternProperties ?? {});
      realB.patternProperties?.forEach((k, v) {
        final existingKey = patternProperties!.keys.firstWhereOrNull(
          (key) => key.pattern == k.pattern,
        );
        if (existingKey != null) {
          patternProperties[existingKey] = _merge(
            patternProperties[existingKey]!,
            v,
          );
        } else {
          patternProperties[k] = v;
        }
      });
    }

    Schema? additionalProperties;
    if (realA.additionalProperties == null) {
      additionalProperties = realB.additionalProperties;
    } else if (realB.additionalProperties == null) {
      additionalProperties = realA.additionalProperties;
    } else {
      additionalProperties = _merge(
        realA.additionalProperties!,
        realB.additionalProperties!,
      );
    }

    Set<String>? required;
    if (realA.required != null || realB.required != null) {
      required = (realA.required ?? {}).toSet().union(realB.required ?? {});
    }

    int? minProperties = _mergeMax(
      realA.minProperties,
      realB.minProperties,
    ); // max of mins
    int? maxProperties = _mergeMin(
      realA.maxProperties,
      realB.maxProperties,
    ); // min of maxs

    Map<String, Set<String>>? dependentRequired;
    if (realA.dependentRequired != null || realB.dependentRequired != null) {
      dependentRequired = {};
      realA.dependentRequired?.forEach(
        (k, v) => dependentRequired![k] = Set.from(v),
      );
      realB.dependentRequired?.forEach((k, v) {
        if (dependentRequired!.containsKey(k)) {
          dependentRequired[k]!.addAll(v);
        } else {
          dependentRequired[k] = Set.from(v);
        }
      });
    }

    Map<String, Schema>? dependentSchemas;
    if (realA.dependentSchemas != null || realB.dependentSchemas != null) {
      dependentSchemas = <String, Schema>{}
        ..addAll(realA.dependentSchemas ?? {});
      realB.dependentSchemas?.forEach((k, v) {
        if (dependentSchemas!.containsKey(k)) {
          dependentSchemas[k] = _merge(dependentSchemas[k]!, v);
        } else {
          dependentSchemas[k] = v;
        }
      });
    }

    Schema? unevaluatedProperties;
    if (realA.unevaluatedProperties == null) {
      unevaluatedProperties = realB.unevaluatedProperties;
    } else if (realB.unevaluatedProperties == null) {
      unevaluatedProperties = realA.unevaluatedProperties;
    } else {
      unevaluatedProperties = _merge(
        realA.unevaluatedProperties!,
        realB.unevaluatedProperties!,
      );
    }

    Schema? items;
    if (realA.items == null) {
      items = realB.items;
    } else if (realB.items == null) {
      items = realA.items;
    } else {
      items = _merge(realA.items!, realB.items!);
    }

    List<Schema>? prefixItems;
    if (realA.prefixItems != null || realB.prefixItems != null) {
      prefixItems = [];
      final len = math.max(
        realA.prefixItems?.length ?? 0,
        realB.prefixItems?.length ?? 0,
      );
      for (var i = 0; i < len; i++) {
        final subA = i < (realA.prefixItems?.length ?? 0)
            ? realA.prefixItems![i]
            : null;
        final subB = i < (realB.prefixItems?.length ?? 0)
            ? realB.prefixItems![i]
            : null;
        if (subA != null && subB != null) {
          prefixItems.add(_merge(subA, subB));
        } else {
          prefixItems.add(subA ?? subB!);
        }
      }
    }

    Schema? contains;
    if (realA.contains == null) {
      contains = realB.contains;
    } else if (realB.contains == null) {
      contains = realA.contains;
    } else {
      contains = _merge(realA.contains!, realB.contains!);
    }

    int? minContains = _mergeMax(realA.minContains, realB.minContains);
    int? maxContains = _mergeMin(realA.maxContains, realB.maxContains);

    Schema? unevaluatedItems;
    if (realA.unevaluatedItems == null) {
      unevaluatedItems = realB.unevaluatedItems;
    } else if (realB.unevaluatedItems == null) {
      unevaluatedItems = realA.unevaluatedItems;
    } else {
      unevaluatedItems = _merge(
        realA.unevaluatedItems!,
        realB.unevaluatedItems!,
      );
    }

    int? minLength = _mergeMax(realA.minLength, realB.minLength);
    int? maxLength = _mergeMin(realA.maxLength, realB.maxLength);

    String? pattern;
    if (realA.pattern != null && realB.pattern != null) {
      if (realA.pattern == realB.pattern) {
        pattern = realA.pattern;
      } else {
        // If the patterns are different, we combine them using positive lookaheads.
        // This ensures that the generated RegExp will only match if the input matches
        // both pattern constraints (logical AND).
        pattern = '(?=${realA.pattern})(?=${realB.pattern})';
      }
    } else {
      pattern = realA.pattern ?? realB.pattern;
    }

    final format = realA.format ?? realB.format;

    num? minimum = _mergeMaxNum(realA.minimum, realB.minimum);
    num? maximum = _mergeMinNum(realA.maximum, realB.maximum);
    num? exclusiveMinimum = _mergeMaxNum(
      realA.exclusiveMinimum,
      realB.exclusiveMinimum,
    );
    num? exclusiveMaximum = _mergeMinNum(
      realA.exclusiveMaximum,
      realB.exclusiveMaximum,
    );

    num? multipleOf;
    if (realA.multipleOf != null && realB.multipleOf != null) {
      if (realA.multipleOf == realB.multipleOf) {
        multipleOf = realA.multipleOf;
      } else {
        // To satisfy both `multipleOf` constraints, the merged schema must be a multiple
        // of the Least Common Multiple (LCM) of the two constraints.
        // For example, if a value must be multiple of 2 AND multiple of 3, it must be
        // a multiple of 6.
        multipleOf = lcm(realA.multipleOf!, realB.multipleOf!);
      }
    } else {
      multipleOf = realA.multipleOf ?? realB.multipleOf;
    }

    List<dynamic>? enumValues;
    if (realA.enumValues != null && realB.enumValues != null) {
      enumValues = realA.enumValues!
          .where((v) => realB.enumValues!.any((v2) => deepEquals(v, v2)))
          .toList();
      if (enumValues.isEmpty) {
        return Schema.never;
      }
    } else {
      enumValues = realA.enumValues ?? realB.enumValues;
    }

    List<Schema>? allOf = _mergeLists(realA.allOf, realB.allOf);
    List<Schema>? anyOf = _mergeLists(realA.anyOf, realB.anyOf);
    List<Schema>? oneOf = _mergeLists(realA.oneOf, realB.oneOf);

    return Schema(
      hasExplicitType: realA.hasExplicitType || realB.hasExplicitType,
      title: realA.title ?? realB.title,
      description: realA.description ?? realB.description,
      isDeprecated: realA.isDeprecated || realB.isDeprecated,
      deprecatedMessage: realA.deprecatedMessage ?? realB.deprecatedMessage,
      hasDefault: realA.hasDefault || realB.hasDefault,
      defaultValue: realA.defaultValue ?? realB.defaultValue,
      dartName: realA.dartName ?? realB.dartName,
      type: mergedType,
      properties: properties,
      patternProperties: patternProperties,
      required: required,
      additionalProperties: additionalProperties,
      minProperties: minProperties,
      maxProperties: maxProperties,
      dependentRequired: dependentRequired,
      dependentSchemas: dependentSchemas,
      unevaluatedProperties: unevaluatedProperties,
      items: items,
      prefixItems: prefixItems,
      minItems: _mergeMax(realA.minItems, realB.minItems),
      maxItems: _mergeMin(realA.maxItems, realB.maxItems),
      uniqueItems: realA.uniqueItems == true || realB.uniqueItems == true
          ? true
          : (realA.uniqueItems ?? realB.uniqueItems),
      contains: contains,
      minContains: minContains,
      maxContains: maxContains,
      unevaluatedItems: unevaluatedItems,
      minLength: minLength,
      maxLength: maxLength,
      pattern: pattern,
      format: format,
      minimum: minimum,
      maximum: maximum,
      exclusiveMinimum: exclusiveMinimum,
      exclusiveMaximum: exclusiveMaximum,
      multipleOf: multipleOf,
      enumValues: enumValues,
      allOf: allOf,
      anyOf: anyOf,
      oneOf: oneOf,
    );
  }

  int? _mergeMin(int? a, int? b) =>
      a != null && b != null ? math.min(a, b) : a ?? b;
  int? _mergeMax(int? a, int? b) =>
      a != null && b != null ? math.max(a, b) : a ?? b;
  num? _mergeMinNum(num? a, num? b) =>
      a != null && b != null ? math.min(a, b) : a ?? b;
  num? _mergeMaxNum(num? a, num? b) =>
      a != null && b != null ? math.max(a, b) : a ?? b;

  List<Schema>? _mergeLists(List<Schema>? a, List<Schema>? b) {
    if (a == null) return b;
    if (b == null) return a;
    return [...a, ...b];
  }

  /// A recursive pre-pass that scans the raw JSON structure to find all inline `$id` declarations.
  ///
  /// This populates [_inlineSchemas] with their absolute URIs mapping to their JSON content
  /// and JSON pointer paths. Doing this before actual parsing ensures that absolute `$ref`
  /// lookup targets can be resolved correctly even if they are referenced before they are parsed
  /// lexically.
  void _findInlineIds(dynamic json, String currentUri, String path) {
    if (json is Map) {
      var nextUri = currentUri;
      var nextPath = path;
      if (json.containsKey(r'$id') && json[r'$id'] is String) {
        final id = json[r'$id'] as String;
        nextUri = Uri.parse(currentUri).resolve(id).toString();
        _inlineSchemas[nextUri] = _InlineSchema(json, path);
        _inlineSchemas['$nextUri#'] = _InlineSchema(json, path);
        nextPath = '$nextUri#';
      }
      json.forEach((key, value) {
        final escapedKey = Uri.encodeComponent(key as String);
        _findInlineIds(value, nextUri, '$nextPath/$escapedKey');
      });
    } else if (json is List) {
      for (var i = 0; i < json.length; i++) {
        _findInlineIds(json[i], currentUri, '$path/$i');
      }
    }
  }

  List<String>? _mapType(CoreAndValidationSpecificationsMetaSchema1Type? type) {
    if (type == null) return null;
    if (type is CoreAndValidationSpecificationsMetaSchema1TypeOption0) {
      return [type.value.value];
    }
    if (type is CoreAndValidationSpecificationsMetaSchema1TypeOption1) {
      return type.value.map((e) => e.value).toList();
    }
    return null;
  }

  Future<void> _checkAndLoadExternalRef(
    String ref,
    String path,
    String? currentResourceUri,
  ) async {
    final currentFile = _getFileUri(path);
    var resolvedRefUri = normalizeSchemaUri(
      Uri.parse(currentFile).resolve(ref).toString(),
    );
    if (!resolvedRefUri.contains('#')) {
      resolvedRefUri = '$resolvedRefUri#';
    }

    final refFile = _getFileUri(resolvedRefUri);
    if (refFile != currentFile && refFile.isNotEmpty) {
      if (_disallowExternalRefs) {
        throw ArgumentError('External references are disallowed: $ref');
      }
      if (!_cache.containsKey(refFile) && !_cache.containsKey(resolvedRefUri)) {
        if (_parsingPaths.contains('$refFile#') ||
            _parsingPaths.contains(resolvedRefUri)) {
          print('Cycle detected for $resolvedRefUri, skipping parsing');
        } else if (_inlineSchemas.containsKey(refFile)) {
          final inline = _inlineSchemas[refFile]!;
          await _parseSchema(
            inline.json,
            inline.path,
            parentResourceUri: _getFileUri(inline.path),
          );
        } else if (_inlineSchemas.containsKey(resolvedRefUri)) {
          final inline = _inlineSchemas[resolvedRefUri]!;
          await _parseSchema(
            inline.json,
            inline.path,
            parentResourceUri: _getFileUri(inline.path),
          );
        } else if (!_loadedFiles.contains(refFile)) {
          _loadedFiles.add(refFile);
          if (uriResolver == null) {
            throw ArgumentError(
              'Cannot resolve external ref $ref because no uriResolver was provided.',
            );
          }
          final bytes = await uriResolver!(Uri.parse(refFile));
          final externalJson =
              jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
          _findInlineIds(externalJson, refFile, '$refFile#');
          await _parseSchema(
            externalJson,
            '$refFile#',
            isExternal: true,
            parentResourceUri: refFile,
          );
        }
      }
    }
  }

  Discriminator? _parseDiscriminator(dynamic json, String path) {
    if (json is Map && json['discriminator'] is Map) {
      final discMap = json['discriminator'] as Map;
      final propName = discMap['propertyName'] as String?;
      if (propName != null) {
        final mappingJson = discMap['mapping'] as Map?;
        final currentFile = _getFileUri(path);
        final mapping = mappingJson?.map(
          (k, v) => MapEntry(k as String, () {
            final resolved = Uri.parse(
              currentFile,
            ).resolve(v as String).toString();
            final refFile = _getFileUri(resolved);
            if (refFile != currentFile && refFile.isNotEmpty) {
              if (_disallowExternalRefs) {
                throw ArgumentError('External references are disallowed: $v');
              }
            }
            return Schema(ref: resolved);
          }()),
        );
        return Discriminator(propertyName: propName, mapping: mapping);
      }
    }
    return null;
  }

  Future<Schema> _mapGenerated(
    CoreAndValidationSpecificationsMetaSchema gen,
    String path,
    dynamic json, {
    String? parentResourceUri,
  }) async {
    if (gen is CoreAndValidationSpecificationsMetaSchemaOption1) {
      final schema = gen.value ? Schema.anything : Schema.never;
      _cacheSchema(schema, path, path, null, null);
      return schema;
    }

    final obj = (gen as CoreAndValidationSpecificationsMetaSchemaOption0).value;
    print('Mapping schema at $path. obj.defs: ${obj.defs}');
    if (obj.defs != null) {
      print('  defs keys: ${obj.defs!.additionalProperties.keys}');
    }

    final originalPath = path;
    String? idUrl;
    if (obj.id != null) {
      final currentFile = _getFileUri(path);
      idUrl = Uri.parse(currentFile).resolve(obj.id!).toString();
      path = normalizeSchemaUri(idUrl);
      if (!path.contains('#')) {
        path = '$path#';
      }
    }
    final currentResourceUri = idUrl ?? parentResourceUri;

    String? anchorUrl;
    if (obj.anchor != null) {
      final currentFile = _getFileUri(path);
      anchorUrl = Uri.parse(currentFile).resolve('#${obj.anchor}').toString();
    }
    String? dynamicAnchorUrl;
    if (obj.dynamicAnchor != null) {
      final currentFile = _getFileUri(path);
      dynamicAnchorUrl = Uri.parse(
        currentFile,
      ).resolve('#${obj.dynamicAnchor}').toString();
    }

    String? resolvedRef;
    if (obj.ref != null) {
      final currentFile = _getFileUri(path);
      resolvedRef = normalizeSchemaUri(
        Uri.parse(currentFile).resolve(obj.ref!).toString(),
      );
      if (!resolvedRef.contains('#')) {
        resolvedRef = '$resolvedRef#';
      }
      await _checkAndLoadExternalRef(obj.ref!, path, currentResourceUri);
    }
    String? resolvedDynamicRef;
    if (obj.dynamicRef != null) {
      final currentFile = _getFileUri(path);
      resolvedDynamicRef = normalizeSchemaUri(
        Uri.parse(currentFile).resolve(obj.dynamicRef!).toString(),
      );
      if (!resolvedDynamicRef.contains('#')) {
        resolvedDynamicRef = '$resolvedDynamicRef#';
      }
      await _checkAndLoadExternalRef(obj.dynamicRef!, path, currentResourceUri);
    }

    final jsonMap = json as Map;
    final hasExplicitType = jsonMap.containsKey('type');
    final hasConst = jsonMap.containsKey('const');
    final hasDefault = jsonMap.containsKey('default');

    final constValue = hasConst ? obj.const_ : null;
    final defaultValue = hasDefault ? obj.default_ : null;

    List<Object?>? enumValues = obj.enum_;
    if (hasConst && enumValues == null) {
      enumValues = [constValue];
    }

    // Map subschemas recursively
    Map<String, Schema>? properties;
    if (obj.properties.additionalProperties.isNotEmpty) {
      properties = {};
      for (final entry in obj.properties.additionalProperties.entries) {
        properties[entry.key] = await _mapGenerated(
          entry.value,
          '$path/properties/${entry.key}',
          jsonMap['properties']?[entry.key],
          parentResourceUri: currentResourceUri,
        );
      }
    }

    Map<RegExp, Schema>? patternProperties;
    if (obj.patternProperties_.additionalProperties.isNotEmpty) {
      patternProperties = {};
      for (final entry in obj.patternProperties_.additionalProperties.entries) {
        patternProperties[RegExp(
          entry.key,
          unicode: true,
        )] = await _mapGenerated(
          entry.value,
          '$path/patternProperties/${entry.key}',
          jsonMap['patternProperties']?[entry.key],
          parentResourceUri: currentResourceUri,
        );
      }
    }

    Map<String, Schema>? dependentSchemas;
    if (obj.dependentSchemas.additionalProperties.isNotEmpty) {
      dependentSchemas = {};
      for (final entry in obj.dependentSchemas.additionalProperties.entries) {
        dependentSchemas[entry.key] = await _mapGenerated(
          entry.value,
          '$path/dependentSchemas/${entry.key}',
          jsonMap['dependentSchemas']?[entry.key],
          parentResourceUri: currentResourceUri,
        );
      }
    }

    if (obj.defs != null && obj.defs!.additionalProperties.isNotEmpty) {
      for (final entry in obj.defs!.additionalProperties.entries) {
        await _mapGenerated(
          entry.value,
          '$path/\$defs/${entry.key}',
          jsonMap[r'$defs']?[entry.key],
          parentResourceUri: currentResourceUri,
        );
      }
    }

    if (obj.definitions.additionalProperties.isNotEmpty) {
      for (final entry in obj.definitions.additionalProperties.entries) {
        await _mapGenerated(
          entry.value,
          '$path/definitions/${entry.key}',
          jsonMap['definitions']?[entry.key],
          parentResourceUri: currentResourceUri,
        );
      }
    }

    List<Schema>? allOf;
    if (obj.allOf != null) {
      allOf = [];
      for (var i = 0; i < obj.allOf!.length; i++) {
        allOf.add(
          await _mapGenerated(
            obj.allOf![i],
            '$path/allOf/$i',
            jsonMap['allOf']?[i],
            parentResourceUri: currentResourceUri,
          ),
        );
      }
    }
    List<Schema>? anyOf;
    if (obj.anyOf != null) {
      anyOf = [];
      for (var i = 0; i < obj.anyOf!.length; i++) {
        anyOf.add(
          await _mapGenerated(
            obj.anyOf![i],
            '$path/anyOf/$i',
            jsonMap['anyOf']?[i],
            parentResourceUri: currentResourceUri,
          ),
        );
      }
    }
    List<Schema>? oneOf;
    if (obj.oneOf != null) {
      oneOf = [];
      for (var i = 0; i < obj.oneOf!.length; i++) {
        oneOf.add(
          await _mapGenerated(
            obj.oneOf![i],
            '$path/oneOf/$i',
            jsonMap['oneOf']?[i],
            parentResourceUri: currentResourceUri,
          ),
        );
      }
    }

    final not = obj.not != null
        ? await _mapGenerated(
            obj.not!,
            '$path/not',
            jsonMap['not'],
            parentResourceUri: currentResourceUri,
          )
        : null;
    final ifSchema = obj.if_ != null
        ? await _mapGenerated(
            obj.if_!,
            '$path/if',
            jsonMap['if'],
            parentResourceUri: currentResourceUri,
          )
        : null;
    final thenSchema = obj.then != null
        ? await _mapGenerated(
            obj.then!,
            '$path/then',
            jsonMap['then'],
            parentResourceUri: currentResourceUri,
          )
        : null;
    final elseSchema = obj.else_ != null
        ? await _mapGenerated(
            obj.else_!,
            '$path/else',
            jsonMap['else'],
            parentResourceUri: currentResourceUri,
          )
        : null;
    final items = obj.items != null
        ? await _mapGenerated(
            obj.items!,
            '$path/items',
            jsonMap['items'],
            parentResourceUri: currentResourceUri,
          )
        : null;
    final contains = obj.contains != null
        ? await _mapGenerated(
            obj.contains!,
            '$path/contains',
            jsonMap['contains'],
            parentResourceUri: currentResourceUri,
          )
        : null;

    List<Schema>? prefixItems;
    if (obj.prefixItems != null) {
      prefixItems = [];
      for (var i = 0; i < obj.prefixItems!.length; i++) {
        prefixItems.add(
          await _mapGenerated(
            obj.prefixItems![i],
            '$path/prefixItems/$i',
            jsonMap['prefixItems']?[i],
            parentResourceUri: currentResourceUri,
          ),
        );
      }
    }

    Schema? additionalProperties;
    if (obj.additionalProperties_ != null) {
      additionalProperties = await _mapGenerated(
        obj.additionalProperties_!,
        '$path/additionalProperties',
        jsonMap['additionalProperties'],
        parentResourceUri: currentResourceUri,
      );
    }
    Schema? unevaluatedProperties;
    if (obj.unevaluatedProperties != null) {
      unevaluatedProperties = await _mapGenerated(
        obj.unevaluatedProperties!,
        '$path/unevaluatedProperties',
        jsonMap['unevaluatedProperties'],
        parentResourceUri: currentResourceUri,
      );
    }
    Schema? unevaluatedItems;
    if (obj.unevaluatedItems != null) {
      unevaluatedItems = await _mapGenerated(
        obj.unevaluatedItems!,
        '$path/unevaluatedItems',
        jsonMap['unevaluatedItems'],
        parentResourceUri: currentResourceUri,
      );
    }
    Schema? propertyNames;
    if (obj.propertyNames != null) {
      propertyNames = await _mapGenerated(
        obj.propertyNames!,
        '$path/propertyNames',
        jsonMap['propertyNames'],
        parentResourceUri: currentResourceUri,
      );
    }

    final dartName = obj.additionalProperties['x-dart-name'] as String?;
    final deprecatedMessage =
        obj.additionalProperties['x-deprecated-message'] as String?;

    Set<String>? vocabularies = _currentVocabularies;
    if (obj.vocabulary != null) {
      vocabularies = obj.vocabulary!.additionalProperties.keys.toSet();
    }

    final type = _mapType(obj.type_);
    final required = obj.required_?.toSet();

    Map<String, Set<String>>? dependentRequired;
    if (obj.dependentRequired != null) {
      dependentRequired = obj.dependentRequired!.additionalProperties.map(
        (k, v) => MapEntry(k, v.toSet()),
      );
    }
    final uniqueItems = jsonMap.containsKey('uniqueItems')
        ? obj.uniqueItems
        : null;
    final minContains = jsonMap.containsKey('minContains')
        ? obj.minContains
        : null;

    final schema = Schema(
      hasExplicitType: hasExplicitType,
      title: obj.title,
      description: obj.description,
      isDeprecated: obj.deprecated,
      deprecatedMessage: deprecatedMessage,
      hasDefault: hasDefault,
      defaultValue: defaultValue,
      not: not,
      dartName: dartName,
      id: obj.id,
      anchor: obj.anchor,
      dynamicAnchor: obj.dynamicAnchor,
      ref: resolvedRef,
      dynamicRef: resolvedDynamicRef,
      type: type,
      enumValues: enumValues,
      constValue: constValue,
      properties: properties,
      patternProperties: patternProperties,
      required: required,
      additionalProperties: additionalProperties,
      minProperties: obj.minProperties,
      maxProperties: obj.maxProperties,
      dependentRequired: dependentRequired,
      dependentSchemas: dependentSchemas,
      unevaluatedProperties: unevaluatedProperties,
      propertyNames: propertyNames,
      discriminator: _parseDiscriminator(json, path),
      items: items,
      prefixItems: prefixItems,
      minItems: obj.minItems,
      maxItems: obj.maxItems,
      uniqueItems: uniqueItems,
      contains: contains,
      minContains: minContains,
      maxContains: obj.maxContains,
      unevaluatedItems: unevaluatedItems,
      minLength: obj.minLength,
      maxLength: obj.maxLength,
      pattern: obj.pattern,
      format: obj.format,
      minimum: obj.minimum,
      maximum: obj.maximum,
      exclusiveMinimum: obj.exclusiveMinimum,
      exclusiveMaximum: obj.exclusiveMaximum,
      multipleOf: obj.multipleOf,
      allOf: allOf,
      anyOf: anyOf,
      oneOf: oneOf,
      ifSchema: ifSchema,
      thenSchema: thenSchema,
      elseSchema: elseSchema,
      vocabularies: vocabularies,
      resourceUri: currentResourceUri,
    );

    _cacheSchema(
      schema,
      path,
      originalPath,
      idUrl,
      anchorUrl,
      dynamicAnchorUrl: dynamicAnchorUrl,
    );
    return schema;
  }
}

/// A resolver that loads schemas from the local file system.
Future<List<int>> ioFileResolver(
  Uri uri, {
  io.Directory? rootDirectory,
  bool restrictToRoot = true,
}) async {
  if (uri.scheme != 'file' && uri.scheme != '') {
    throw ArgumentError(
      'Unsupported scheme: ${uri.scheme}. Only file URIs are supported.',
    );
  }

  final path = p.fromUri(uri);
  final file = io.File(path);

  if (restrictToRoot) {
    final root = rootDirectory ?? io.Directory.current;
    final canonicalRoot = p.canonicalize(root.path);
    final canonicalPath = p.canonicalize(file.path);

    if (!p.isWithin(canonicalRoot, canonicalPath) &&
        canonicalRoot != canonicalPath) {
      throw ArgumentError(
        'Access denied: Path is outside the restricted root directory.',
      );
    }
  }

  if (!await file.exists()) {
    throw io.OSError('File not found: $path');
  }

  return file.readAsBytes();
}

class _MergePair {
  final Schema a;
  final Schema b;
  _MergePair(this.a, this.b);
  @override
  bool operator ==(Object other) =>
      other is _MergePair && identical(a, other.a) && identical(b, other.b);
  @override
  int get hashCode => identityHashCode(a) ^ identityHashCode(b);
}

class _InlineSchema {
  final dynamic json;
  final String path;
  _InlineSchema(this.json, this.path);
}
