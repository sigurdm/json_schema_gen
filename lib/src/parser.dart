import 'dart:convert';
import 'dart:io' as io;
import 'dart:math' as math;
import 'package:path/path.dart' as p;
import 'package:collection/collection.dart';
import 'schema.dart';
import 'utils.dart';

/// A parser to build a [Schema] AST from a decoded JSON schema.
final class SchemaParser {
  final Map<String, Schema> _cache = {};
  final Map<_MergePair, Schema> _mergeCache = {};
  final Map<String, dynamic> _rootJson;
  final String baseUri;
  final Future<List<int>> Function(Uri uri)? uriResolver;
  final Set<String> _loadedFiles = {};
  final bool flatten;
  bool _disallowExternalRefs = false;
  final Map<String, dynamic> _inlineSchemas = {};
  final Set<String> _parsingPaths = {};
  Set<String>? _currentVocabularies;
  final Map<String, Set<String>?> _metaschemaVocabularies = {};
  final Map<String, Schema> _dynamicAnchors = {};

  /// Creates a parser for the given [rootJson] schema definition.
  SchemaParser(
    this._rootJson, {
    this.baseUri = 'http://localhost/',
    this.uriResolver,
    bool disallowExternalRefs = false,
    this.flatten = true,
  }) : _disallowExternalRefs = disallowExternalRefs {
    _findInlineIds(_rootJson, baseUri);
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
      return flattened.copyWith(dynamicAnchors: _dynamicAnchors);
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

    final pathToTrack = path;
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
      final originalPath = path;
      final hasExplicitType = json.containsKey('type');
      String? idUrl;
      if (json.containsKey(r'$id')) {
        final id = json[r'$id'] as String;
        final currentFile = _getFileUri(path);
        idUrl = Uri.parse(currentFile).resolve(id).toString();
        path = normalizeSchemaUri(idUrl);
        if (!path.contains('#')) {
          path = '$path#';
        }
      }

      final currentResourceUri = idUrl ?? parentResourceUri;

      String? anchorUrl;
      if (json.containsKey(r'$anchor')) {
        final anchor = json[r'$anchor'] as String;
        final currentFile = _getFileUri(path);
        anchorUrl = Uri.parse(currentFile).resolve('#$anchor').toString();
      }
      String? dynamicAnchorUrl;
      if (json.containsKey(r'$dynamicAnchor')) {
        final dynamicAnchor = json[r'$dynamicAnchor'] as String;
        final currentFile = _getFileUri(path);
        dynamicAnchorUrl = Uri.parse(
          currentFile,
        ).resolve('#$dynamicAnchor').toString();
      }

      // Extract metadata
      final title = json['title'] as String?;
      final description = json['description'] as String?;
      final isDeprecated = json['deprecated'] as bool? ?? false;
      final deprecatedMessage = json['x-deprecated-message'] as String?;
      final hasDefault = json.containsKey('default');
      final defaultValue = json['default'];
      final notJson = json['not'];
      final not = notJson != null
          ? await _parseSchema(
              notJson,
              '$path/not',
              parentResourceUri: currentResourceUri,
            )
          : null;
      final dartName = json['x-dart-name'] as String?;

      // defs
      if (json[r'$defs'] is Map) {
        for (final entry in (json[r'$defs'] as Map).entries) {
          await _parseSchema(
            entry.value,
            '$path/\$defs/${entry.key}',
            parentResourceUri: currentResourceUri,
          );
        }
      }
      if (json['definitions'] is Map) {
        for (final entry in (json['definitions'] as Map).entries) {
          await _parseSchema(
            entry.value,
            '$path/definitions/${entry.key}',
            parentResourceUri: currentResourceUri,
          );
        }
      }

      // Resolve refs (do NOT return early)
      String? resolvedRefUri;
      if (json.containsKey(r'$ref')) {
        final ref = json[r'$ref'] as String;
        final currentFile = _getFileUri(path);
        resolvedRefUri = normalizeSchemaUri(
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
          if (!_cache.containsKey(refFile) &&
              !_cache.containsKey(resolvedRefUri)) {
            if (_parsingPaths.contains('$refFile#') ||
                _parsingPaths.contains(resolvedRefUri)) {
              print('Cycle detected for $resolvedRefUri, skipping parsing');
            } else if (_inlineSchemas.containsKey(refFile)) {
              await _parseSchema(
                _inlineSchemas[refFile],
                '$refFile#',
                parentResourceUri: refFile,
              );
            } else if (_inlineSchemas.containsKey(resolvedRefUri)) {
              await _parseSchema(
                _inlineSchemas[resolvedRefUri],
                resolvedRefUri,
                parentResourceUri: refFile,
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

      String? resolvedDynamicRefUri;
      if (json.containsKey(r'$dynamicRef')) {
        final dynamicRef = json[r'$dynamicRef'] as String;
        final currentFile = _getFileUri(path);
        resolvedDynamicRefUri = normalizeSchemaUri(
          Uri.parse(currentFile).resolve(dynamicRef).toString(),
        );
        if (!resolvedDynamicRefUri.contains('#')) {
          resolvedDynamicRefUri = '$resolvedDynamicRefUri#';
        }

        final refFile = _getFileUri(resolvedDynamicRefUri);
        if (refFile != currentFile && refFile.isNotEmpty) {
          if (_disallowExternalRefs) {
            throw ArgumentError(
              'External references are disallowed: $dynamicRef',
            );
          }
          if (!_cache.containsKey(refFile) &&
              !_cache.containsKey(resolvedDynamicRefUri)) {
            if (_parsingPaths.contains('$refFile#') ||
                _parsingPaths.contains(resolvedDynamicRefUri)) {
              print(
                'Cycle detected for $resolvedDynamicRefUri, skipping parsing',
              );
            } else if (_inlineSchemas.containsKey(refFile)) {
              await _parseSchema(
                _inlineSchemas[refFile],
                '$refFile#',
                parentResourceUri: refFile,
              );
            } else if (_inlineSchemas.containsKey(resolvedDynamicRefUri)) {
              await _parseSchema(
                _inlineSchemas[resolvedDynamicRefUri],
                resolvedDynamicRefUri,
                parentResourceUri: refFile,
              );
            } else if (!_loadedFiles.contains(refFile)) {
              _loadedFiles.add(refFile);
              if (uriResolver == null) {
                throw ArgumentError(
                  'Cannot resolve external ref $dynamicRef because no uriResolver was provided.',
                );
              }
              final bytes = await uriResolver!(Uri.parse(refFile));
              final externalJson =
                  jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
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

      // Parse const and enum
      dynamic constValue;
      List<dynamic>? enumValues;
      if (json.containsKey('const')) {
        constValue = json['const'];
        enumValues = [constValue];
      }
      if (json.containsKey('enum')) {
        enumValues = (json['enum'] as List).toList();
      }

      // Parse type
      List<String>? type;
      final typeVal = json['type'];
      if (typeVal is String) {
        type = [typeVal];
      } else if (typeVal is List) {
        type = typeVal.cast<String>();
      } else if (typeVal == null) {
        if (json.containsKey('properties') ||
            json.containsKey('patternProperties') ||
            json.containsKey('required') ||
            json.containsKey('additionalProperties') ||
            json.containsKey('dependentRequired') ||
            json.containsKey('minProperties') ||
            json.containsKey('maxProperties') ||
            json.containsKey('propertyNames')) {
          type = ['object'];
        } else if (json.containsKey('items') ||
            json.containsKey('prefixItems') ||
            json.containsKey('minItems') ||
            json.containsKey('maxItems') ||
            json.containsKey('uniqueItems') ||
            json.containsKey('contains')) {
          type = ['array'];
        } else if (json.containsKey('minLength') ||
            json.containsKey('maxLength') ||
            json.containsKey('pattern') ||
            json.containsKey('format')) {
          type = ['string'];
        } else if (json.containsKey('minimum') ||
            json.containsKey('maximum') ||
            json.containsKey('exclusiveMinimum') ||
            json.containsKey('exclusiveMaximum') ||
            json.containsKey('multipleOf')) {
          type = ['number'];
        }
      }

      // Parse constraints
      Map<String, Schema>? properties;
      Map<RegExp, Schema>? patternProperties;
      Set<String>? required;
      Schema? additionalProperties;
      int? minProperties;
      int? maxProperties;
      Map<String, Set<String>>? dependentRequired;
      Map<String, Schema>? dependentSchemas;
      Schema? unevaluatedProperties;
      Schema? propertyNames;

      if (json['properties'] is Map) {
        properties = {};
        for (final entry in (json['properties'] as Map).entries) {
          properties[entry.key as String] = await _parseSchema(
            entry.value,
            '$path/properties/${entry.key}',
            parentResourceUri: currentResourceUri,
          );
        }
      }
      if (json['patternProperties'] is Map) {
        patternProperties = {};
        for (final entry in (json['patternProperties'] as Map).entries) {
          patternProperties[RegExp(
            entry.key as String,
            unicode: true,
          )] = await _parseSchema(
            entry.value,
            '$path/patternProperties/${entry.key}',
            parentResourceUri: currentResourceUri,
          );
        }
      }
      if (json['required'] is List) {
        required = (json['required'] as List).cast<String>().toSet();
      }
      final addPropsVal = json['additionalProperties'];
      if (addPropsVal is bool) {
        additionalProperties = addPropsVal ? Schema.anything : Schema.never;
      } else if (addPropsVal is Map) {
        additionalProperties = await _parseSchema(
          addPropsVal,
          '$path/additionalProperties',
          parentResourceUri: currentResourceUri,
        );
      }
      minProperties = parseInt(json['minProperties']);
      maxProperties = parseInt(json['maxProperties']);

      if (json['dependentRequired'] is Map) {
        dependentRequired = {};
        (json['dependentRequired'] as Map).forEach((key, value) {
          if (value is List) {
            dependentRequired![key as String] = value.cast<String>().toSet();
          }
        });
      }

      if (json['dependentSchemas'] is Map) {
        dependentSchemas = {};
        for (final entry in (json['dependentSchemas'] as Map).entries) {
          dependentSchemas[entry.key as String] = await _parseSchema(
            entry.value,
            '$path/dependentSchemas/${entry.key}',
            parentResourceUri: currentResourceUri,
          );
        }
      }

      final unevalPropsVal = json['unevaluatedProperties'];
      if (unevalPropsVal is bool) {
        unevaluatedProperties = unevalPropsVal ? Schema.anything : Schema.never;
      } else if (unevalPropsVal is Map) {
        unevaluatedProperties = await _parseSchema(
          unevalPropsVal,
          '$path/unevaluatedProperties',
          parentResourceUri: currentResourceUri,
        );
      }

      final propNamesVal = json['propertyNames'];
      if (propNamesVal is Map) {
        propertyNames = await _parseSchema(
          propNamesVal,
          '$path/propertyNames',
          parentResourceUri: currentResourceUri,
        );
      } else if (propNamesVal is bool) {
        propertyNames = propNamesVal ? Schema.anything : Schema.never;
      }

      // Array constraints
      Schema? items;
      List<Schema>? prefixItems;
      int? minItems;
      int? maxItems;
      bool? uniqueItems;
      Schema? contains;
      int? minContains;
      int? maxContains;
      Schema? unevaluatedItems;

      final itemsJson = json['items'];
      if (itemsJson != null) {
        items = await _parseSchema(
          itemsJson,
          '$path/items',
          parentResourceUri: currentResourceUri,
        );
      }
      final prefixItemsJson = json['prefixItems'];
      if (prefixItemsJson is List) {
        prefixItems = [];
        for (var i = 0; i < prefixItemsJson.length; i++) {
          prefixItems.add(
            await _parseSchema(
              prefixItemsJson[i],
              '$path/prefixItems/$i',
              parentResourceUri: currentResourceUri,
            ),
          );
        }
      }
      minItems = parseInt(json['minItems']);
      maxItems = parseInt(json['maxItems']);
      uniqueItems = json['uniqueItems'] as bool?;
      final containsJson = json['contains'];
      if (containsJson != null) {
        contains = await _parseSchema(
          containsJson,
          '$path/contains',
          parentResourceUri: currentResourceUri,
        );
      }
      minContains = parseInt(json['minContains']);
      maxContains = parseInt(json['maxContains']);

      final unevalItemsVal = json['unevaluatedItems'];
      if (unevalItemsVal is bool) {
        unevaluatedItems = unevalItemsVal ? Schema.anything : Schema.never;
      } else if (unevalItemsVal is Map) {
        unevaluatedItems = await _parseSchema(
          unevalItemsVal,
          '$path/unevaluatedItems',
          parentResourceUri: currentResourceUri,
        );
      }

      // String constraints
      int? minLength = parseInt(json['minLength']);
      int? maxLength = parseInt(json['maxLength']);
      String? pattern = json['pattern'] as String?;
      String? format = json['format'] as String?;

      // Number constraints
      num? minimum = json['minimum'] as num?;
      num? maximum = json['maximum'] as num?;
      num? exclusiveMinimum = json['exclusiveMinimum'] as num?;
      num? exclusiveMaximum = json['exclusiveMaximum'] as num?;
      num? multipleOf = json['multipleOf'] as num?;

      // Parse combinators
      List<Schema>? allOf;
      if (json['allOf'] is List) {
        allOf = await Future.wait(
          (json['allOf'] as List).asMap().entries.map(
            (e) => _parseSchema(
              e.value,
              '$path/allOf/${e.key}',
              parentResourceUri: currentResourceUri,
            ),
          ),
        );
      }
      List<Schema>? anyOf;
      if (json['anyOf'] is List) {
        anyOf = await Future.wait(
          (json['anyOf'] as List).asMap().entries.map(
            (e) => _parseSchema(
              e.value,
              '$path/anyOf/${e.key}',
              parentResourceUri: currentResourceUri,
            ),
          ),
        );
      }
      List<Schema>? oneOf;
      if (json['oneOf'] is List) {
        oneOf = await Future.wait(
          (json['oneOf'] as List).asMap().entries.map(
            (e) => _parseSchema(
              e.value,
              '$path/oneOf/${e.key}',
              parentResourceUri: currentResourceUri,
            ),
          ),
        );
      }

      Schema? ifSchema;
      if (json.containsKey('if')) {
        ifSchema = await _parseSchema(
          json['if'],
          '$path/if',
          parentResourceUri: currentResourceUri,
        );
      }
      Schema? thenSchema;
      if (json.containsKey('then')) {
        thenSchema = await _parseSchema(
          json['then'],
          '$path/then',
          parentResourceUri: currentResourceUri,
        );
      }
      Schema? elseSchema;
      if (json.containsKey('else')) {
        elseSchema = await _parseSchema(
          json['else'],
          '$path/else',
          parentResourceUri: currentResourceUri,
        );
      }

      Discriminator? parseDiscriminator(dynamic json) {
        if (json['discriminator'] is Map) {
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
                    throw ArgumentError(
                      'External references are disallowed: $v',
                    );
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

      final schema = Schema(
        hasExplicitType: hasExplicitType,
        title: title,
        description: description,
        isDeprecated: isDeprecated,
        deprecatedMessage: deprecatedMessage,
        hasDefault: hasDefault,
        defaultValue: defaultValue,
        not: not,
        dartName: dartName,
        id: idUrl ?? json[r'$id'] as String?,
        anchor: json[r'$anchor'] as String?,
        dynamicAnchor: json[r'$dynamicAnchor'] as String?,
        ref: resolvedRefUri,
        dynamicRef: resolvedDynamicRefUri,
        type: type,
        enumValues: enumValues,
        constValue: constValue,
        properties: properties,
        patternProperties: patternProperties,
        required: required,
        additionalProperties: additionalProperties,
        minProperties: minProperties,
        maxProperties: maxProperties,
        dependentRequired: dependentRequired,
        dependentSchemas: dependentSchemas,
        unevaluatedProperties: unevaluatedProperties,
        propertyNames: propertyNames,
        items: items,
        prefixItems: prefixItems,
        minItems: minItems,
        maxItems: maxItems,
        uniqueItems: uniqueItems,
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
        allOf: allOf,
        anyOf: anyOf,
        oneOf: oneOf,
        ifSchema: ifSchema,
        thenSchema: thenSchema,
        elseSchema: elseSchema,
        discriminator: parseDiscriminator(json),
        vocabularies: _currentVocabularies,
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
      if (newUnevaluatedProperties != schema.unevaluatedProperties)
        changed = true;
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

  void _findInlineIds(dynamic json, String currentUri) {
    if (json is Map) {
      var nextUri = currentUri;
      if (json.containsKey(r'$id')) {
        final id = json[r'$id'] as String;
        nextUri = Uri.parse(currentUri).resolve(id).toString();
        _inlineSchemas[nextUri] = json;
        _inlineSchemas['$nextUri#'] = json;
      }
      json.forEach((key, value) {
        _findInlineIds(value, nextUri);
      });
    } else if (json is List) {
      for (final item in json) {
        _findInlineIds(item, currentUri);
      }
    }
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
