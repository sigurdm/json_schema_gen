// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:convert';
import 'dart:io' as io;
import 'dart:math' as math;
import 'package:path/path.dart' as p;
import 'schema.dart';

/// A parser to build a [Schema] AST from a decoded JSON schema.
final class SchemaParser {
  final Map<String, Schema> _cache = {};
  final Map<String, dynamic> _rootJson;
  final String baseUri;
  final Future<List<int>> Function(Uri uri)? uriResolver;
  final Set<String> _loadedFiles = {};
  bool _disallowExternalRefs = false;

  /// Creates a parser for the given [rootJson] schema definition.
  SchemaParser(
    Map<String, dynamic> rootJson, {
    this.baseUri = '',
    this.uriResolver,
  }) : _rootJson = rootJson {
    _loadedFiles.add(baseUri);
  }

  /// Parses the schema structure and resolves all internal references.
  Future<Schema> parse({bool disallowExternalRefs = true}) async {
    _disallowExternalRefs = disallowExternalRefs;
    final root = await _parseSchema(_rootJson, '$baseUri#');
    _resolveRefs(root);
    final flattenedRoot = _flatten(root);

    // Update cache
    final keys = _cache.keys.toList();
    for (final key in keys) {
      _cache[key] = _flatten(_cache[key]!);
    }

    _updateResolvedRefs(flattenedRoot);
    for (final key in _cache.keys) {
      _updateResolvedRefs(_cache[key]!);
    }

    return flattenedRoot;
  }

  String _getFileUri(String path) {
    return path.split('#')[0];
  }

  Future<Schema> _parseSchema(dynamic json, String path) async {
    if (path.isNotEmpty && _cache.containsKey(path)) {
      return _cache[path]!;
    }

    if (json is! Map) {
      if (json == false) {
        return const NeverSchema();
      }
      return const AnythingSchema();
    }

    final title = json['title'] as String?;
    final description = json['description'] as String?;
    final deprecatedMessage = json['x-deprecated-message'] as String?;
    final isDeprecated =
        json['deprecated'] == true || deprecatedMessage != null;
    final hasDefault = json.containsKey('default');
    final defaultValue = json['default'];
    final notJson = json['not'];
    final not = notJson != null
        ? await _parseSchema(notJson, '$path/not')
        : null;
    final dartName = json['x-dart-name'] as String?;

    // Parse definitions under local scopes BEFORE ref check
    if (json[r'$defs'] is Map) {
      for (final entry in (json[r'$defs'] as Map).entries) {
        await _parseSchema(entry.value, '$path/\$defs/${entry.key}');
      }
    }
    if (json['definitions'] is Map) {
      for (final entry in (json['definitions'] as Map).entries) {
        await _parseSchema(entry.value, '$path/definitions/${entry.key}');
      }
    }

    if (json.containsKey(r'$ref')) {
      final ref = json[r'$ref'] as String;
      final currentFile = _getFileUri(path);
      final resolvedRefUri = Uri.parse(currentFile).resolve(ref).toString();

      final refFile = _getFileUri(resolvedRefUri);
      if (refFile != currentFile && refFile.isNotEmpty) {
        if (_disallowExternalRefs) {
          throw ArgumentError('External references are disallowed: $ref');
        }
        if (!_loadedFiles.contains(refFile)) {
          _loadedFiles.add(refFile);
          if (uriResolver == null) {
            throw ArgumentError(
              'Cannot resolve external ref $ref because no uriResolver was provided.',
            );
          }
          final bytes = await uriResolver!(Uri.parse(refFile));
          final externalJson =
              jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
          await _parseSchema(externalJson, '$refFile#');
        }
      }

      final refSchema = RefSchema(
        resolvedRefUri,
        title: title,
        description: description,
        isDeprecated: isDeprecated,
        deprecatedMessage: deprecatedMessage,
        hasDefault: hasDefault,
        defaultValue: defaultValue,
        not: not,
      );
      if (path.isNotEmpty) {
        _cache[path] = refSchema;
      }
      return refSchema;
    }

    if (json.containsKey('const')) {
      final constValue = json['const'];
      final jsonWithoutConst = Map<String, dynamic>.from(json)..remove('const');
      final baseSchema = await _parseSchema(jsonWithoutConst, '$path/base');
      final schema = EnumSchema(
        values: [constValue],
        baseSchema: baseSchema,
        title: title,
        description: description,
        isDeprecated: isDeprecated,
        deprecatedMessage: deprecatedMessage,
        hasDefault: hasDefault,
        defaultValue: defaultValue,
        not: not,
        dartName: dartName,
      );
      if (path.isNotEmpty) {
        _cache[path] = schema;
      }
      return schema;
    }

    if (json.containsKey('enum')) {
      final enumValues = (json['enum'] as List).toList();
      final jsonWithoutEnum = Map<String, dynamic>.from(json)..remove('enum');
      final baseSchema = await _parseSchema(jsonWithoutEnum, '$path/base');
      final schema = EnumSchema(
        values: enumValues,
        baseSchema: baseSchema,
        title: title,
        description: description,
        isDeprecated: isDeprecated,
        deprecatedMessage: deprecatedMessage,
        hasDefault: hasDefault,
        defaultValue: defaultValue,
        not: not,
        dartName: dartName,
      );
      if (path.isNotEmpty) {
        _cache[path] = schema;
      }
      return schema;
    }

    Schema schema;

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
                  throw ArgumentError('External references are disallowed: $v');
                }
              }
              return RefSchema(resolved) as Schema;
            }()),
          );
          return Discriminator(propertyName: propName, mapping: mapping);
        }
      }
      return null;
    }

    if (json.containsKey('allOf')) {
      final list = json['allOf'] as List;
      final subschemas = await Future.wait(
        list.asMap().entries.map(
          (e) => _parseSchema(e.value, '$path/allOf/${e.key}'),
        ),
      );

      final copy = Map<String, dynamic>.from(json);
      copy.remove('allOf');
      copy.remove('title');
      copy.remove('description');
      copy.remove('deprecated');
      copy.remove('default');
      copy.remove(r'$defs');
      copy.remove('definitions');

      if (copy.isNotEmpty) {
        final restSchema = await _parseSchema(copy, '$path/rest');
        if (restSchema is! AnythingSchema) {
          subschemas.add(restSchema);
        }
      }

      schema = AllOfSchema(
        subschemas: subschemas,
        title: title,
        description: description,
        isDeprecated: isDeprecated,
        deprecatedMessage: deprecatedMessage,
        hasDefault: hasDefault,
        defaultValue: defaultValue,
        not: not,
      );
    } else if (json.containsKey('oneOf')) {
      final list = json['oneOf'] as List;
      final subschemas = await Future.wait(
        list.asMap().entries.map(
          (e) => _parseSchema(e.value, '$path/oneOf/${e.key}'),
        ),
      );
      schema = UnionSchema(
        subschemas: subschemas,
        discriminator: parseDiscriminator(json),
        title: title,
        description: description,
        isDeprecated: isDeprecated,
        deprecatedMessage: deprecatedMessage,
        hasDefault: hasDefault,
        defaultValue: defaultValue,
        not: not,
        dartName: dartName,
      );
    } else if (json.containsKey('anyOf')) {
      final list = json['anyOf'] as List;
      final subschemas = await Future.wait(
        list.asMap().entries.map(
          (e) => _parseSchema(e.value, '$path/anyOf/${e.key}'),
        ),
      );
      schema = UnionSchema(
        subschemas: subschemas,
        discriminator: parseDiscriminator(json),
        title: title,
        description: description,
        isDeprecated: isDeprecated,
        deprecatedMessage: deprecatedMessage,
        hasDefault: hasDefault,
        defaultValue: defaultValue,
        not: not,
        dartName: dartName,
      );
    } else {
      final typeVal = json['type'];
      if (typeVal is List) {
        final subschemas = await Future.wait(
          typeVal.map((t) {
            final singleJson = Map<String, dynamic>.from(json)..['type'] = t;
            return _parseSchema(singleJson, '$path/type/$t');
          }),
        );
        schema = UnionSchema(
          subschemas: subschemas,
          title: title,
          description: description,
          isDeprecated: isDeprecated,
          deprecatedMessage: deprecatedMessage,
          hasDefault: hasDefault,
          defaultValue: defaultValue,
          not: not,
          dartName: dartName,
        );
      } else {
        var type = typeVal as String?;
        if (type == null) {
          if (json.containsKey('properties') ||
              json.containsKey('patternProperties') ||
              json.containsKey('required') ||
              json.containsKey('additionalProperties') ||
              json.containsKey('dependentRequired')) {
            type = 'object';
          } else if (json.containsKey('items') ||
              json.containsKey('prefixItems')) {
            type = 'array';
          } else if (json.containsKey('minLength') ||
              json.containsKey('maxLength') ||
              json.containsKey('pattern') ||
              json.containsKey('format')) {
            type = 'string';
          } else if (json.containsKey('minimum') ||
              json.containsKey('maximum') ||
              json.containsKey('exclusiveMinimum') ||
              json.containsKey('exclusiveMaximum') ||
              json.containsKey('multipleOf')) {
            type = 'number';
          }
        }
        switch (type) {
          case 'object':
            final properties = <String, Schema>{};
            if (json['properties'] is Map) {
              for (final entry in (json['properties'] as Map).entries) {
                properties[entry.key as String] = await _parseSchema(
                  entry.value,
                  '$path/properties/${entry.key}',
                );
              }
            }
            final patternProperties = <RegExp, Schema>{};
            if (json['patternProperties'] is Map) {
              for (final entry in (json['patternProperties'] as Map).entries) {
                patternProperties[RegExp(
                  entry.key as String,
                )] = await _parseSchema(
                  entry.value,
                  '$path/patternProperties/${entry.key}',
                );
              }
            }
            final required =
                (json['required'] as List?)?.cast<String>().toSet() ?? {};
            final addPropsVal = json['additionalProperties'];
            Schema? additionalProperties;
            if (addPropsVal is bool) {
              if (addPropsVal == false) {
                additionalProperties = const NeverSchema();
              } else {
                additionalProperties = const AnythingSchema();
              }
            } else if (addPropsVal is Map) {
              additionalProperties = await _parseSchema(
                addPropsVal,
                '$path/additionalProperties',
              );
            }
            final dependentRequired = <String, Set<String>>{};
            if (json['dependentRequired'] is Map) {
              (json['dependentRequired'] as Map).forEach((key, value) {
                if (value is List) {
                  dependentRequired[key as String] = value
                      .cast<String>()
                      .toSet();
                }
              });
            }
            schema = ObjectSchema(
              properties: properties,
              patternProperties: patternProperties,
              required: required,
              additionalProperties: additionalProperties,
              minProperties: json['minProperties'] as int?,
              maxProperties: json['maxProperties'] as int?,
              dependentRequired: dependentRequired,
              title: title,
              description: description,
              isDeprecated: isDeprecated,
              deprecatedMessage: deprecatedMessage,
              hasDefault: hasDefault,
              defaultValue: defaultValue,
              not: not,
              dartName: dartName,
            );
            break;
          case 'array':
            final itemsJson = json['items'];
            final items = itemsJson != null
                ? await _parseSchema(itemsJson, '$path/items')
                : const AnythingSchema();

            final prefixItemsJson = json['prefixItems'];
            List<Schema>? prefixItems;
            if (prefixItemsJson is List) {
              prefixItems = [];
              for (var i = 0; i < prefixItemsJson.length; i++) {
                prefixItems.add(
                  await _parseSchema(
                    prefixItemsJson[i],
                    '$path/prefixItems/$i',
                  ),
                );
              }
            }

            final containsJson = json['contains'];
            final contains = containsJson != null
                ? await _parseSchema(containsJson, '$path/contains')
                : null;
            schema = ArraySchema(
              items: items,
              prefixItems: prefixItems,
              minItems: json['minItems'] as int?,
              maxItems: json['maxItems'] as int?,
              uniqueItems: json['uniqueItems'] as bool?,
              contains: contains,
              minContains: json['minContains'] as int?,
              maxContains: json['maxContains'] as int?,
              title: title,
              description: description,
              isDeprecated: isDeprecated,
              deprecatedMessage: deprecatedMessage,
              hasDefault: hasDefault,
              defaultValue: defaultValue,
              not: not,
            );
            break;
          case 'string':
            schema = StringSchema(
              minLength: json['minLength'] as int?,
              maxLength: json['maxLength'] as int?,
              pattern: json['pattern'] as String?,
              format: json['format'] as String?,
              title: title,
              description: description,
              isDeprecated: isDeprecated,
              deprecatedMessage: deprecatedMessage,
              hasDefault: hasDefault,
              defaultValue: defaultValue,
              not: not,
            );
            break;
          case 'number':
            schema = NumberSchema(
              isInteger: false,
              minimum: json['minimum'] as num?,
              maximum: json['maximum'] as num?,
              exclusiveMinimum: json['exclusiveMinimum'] as num?,
              exclusiveMaximum: json['exclusiveMaximum'] as num?,
              multipleOf: json['multipleOf'] as num?,
              title: title,
              description: description,
              isDeprecated: isDeprecated,
              deprecatedMessage: deprecatedMessage,
              hasDefault: hasDefault,
              defaultValue: defaultValue,
              not: not,
            );
            break;
          case 'integer':
            schema = NumberSchema(
              isInteger: true,
              minimum: json['minimum'] as num?,
              maximum: json['maximum'] as num?,
              exclusiveMinimum: json['exclusiveMinimum'] as num?,
              exclusiveMaximum: json['exclusiveMaximum'] as num?,
              multipleOf: json['multipleOf'] as num?,
              title: title,
              description: description,
              isDeprecated: isDeprecated,
              deprecatedMessage: deprecatedMessage,
              hasDefault: hasDefault,
              defaultValue: defaultValue,
              not: not,
            );
            break;
          case 'boolean':
            schema = BooleanSchema(
              title: title,
              description: description,
              isDeprecated: isDeprecated,
              deprecatedMessage: deprecatedMessage,
              hasDefault: hasDefault,
              defaultValue: defaultValue,
              not: not,
            );
            break;
          case 'null':
            schema = NullSchema(
              title: title,
              description: description,
              isDeprecated: isDeprecated,
              deprecatedMessage: deprecatedMessage,
              hasDefault: hasDefault,
              defaultValue: defaultValue,
              not: not,
            );
            break;
          default:
            schema = AnythingSchema(
              title: title,
              description: description,
              isDeprecated: isDeprecated,
              deprecatedMessage: deprecatedMessage,
              hasDefault: hasDefault,
              defaultValue: defaultValue,
              not: not,
            );
        }
      }
    }

    if (path.isNotEmpty) {
      print('Caching path: $path');
      _cache[path] = schema;
    }
    return schema;
  }

  void _resolveRefs(Schema root) {
    final visited = <Schema>{};
    void visit(Schema s) {
      if (!visited.add(s)) return;
      if (s is RefSchema) {
        final target = _cache[s.ref];
        if (target == null) {
          throw ArgumentError('Cannot resolve ref: ${s.ref}');
        }
        s.resolved = target;
      }
      if (s is ObjectSchema) {
        s.properties.values.forEach(visit);
        s.patternProperties.values.forEach(visit);
      } else if (s is ArraySchema) {
        visit(s.items);
        s.prefixItems?.forEach(visit);
        if (s.contains != null) visit(s.contains!);
      } else if (s is UnionSchema) {
        s.subschemas.forEach(visit);
        if (s.discriminator?.mapping != null) {
          s.discriminator!.mapping!.values.forEach(visit);
        }
      } else if (s is AllOfSchema) {
        s.subschemas.forEach(visit);
      }
    }

    visit(root);
    _cache.values.forEach(visit);
  }

  void _updateResolvedRefs(Schema root) {
    final visited = <Schema>{};
    void visit(Schema s) {
      if (!visited.add(s)) return;
      if (s is RefSchema) {
        if (s.resolved != null) {
          s.resolved = _flattenCache[s.resolved] ?? s.resolved;
          visit(s.resolved!);
        }
      }
      if (s is ObjectSchema) {
        s.properties.values.forEach(visit);
        s.patternProperties.values.forEach(visit);
        if (s.additionalProperties != null) visit(s.additionalProperties!);
      } else if (s is ArraySchema) {
        visit(s.items);
        s.prefixItems?.forEach(visit);
        if (s.contains != null) visit(s.contains!);
      } else if (s is UnionSchema) {
        s.subschemas.forEach(visit);
        if (s.discriminator?.mapping != null) {
          s.discriminator!.mapping!.values.forEach(visit);
        }
      } else if (s is AllOfSchema) {
        s.subschemas.forEach(visit);
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

    if (schema is RefSchema) {
      _flattenCache[schema] = schema;
      if (schema.resolved != null) {
        schema.resolved = _flatten(schema.resolved!);
      }
      return schema;
    }

    // Cache the schema as itself initially to handle cyclic references
    _flattenCache[schema] = schema;

    if (schema is ObjectSchema) {
      var changed = notChanged;
      final newProps = <String, Schema>{};
      schema.properties.forEach((k, v) {
        final nv = _flatten(v);
        newProps[k] = nv;
        if (nv != v) changed = true;
      });
      final newPatternProps = <RegExp, Schema>{};
      schema.patternProperties.forEach((k, v) {
        final nv = _flatten(v);
        newPatternProps[k] = nv;
        if (nv != v) changed = true;
      });
      final newAddProps = schema.additionalProperties != null
          ? _flatten(schema.additionalProperties!)
          : null;
      if (newAddProps != schema.additionalProperties) changed = true;

      final newDependentRequired = <String, Set<String>>{};
      schema.dependentRequired.forEach((k, v) {
        newDependentRequired[k] = v;
      });

      if (changed) {
        final newSchema = ObjectSchema(
          properties: newProps,
          patternProperties: newPatternProps,
          required: schema.required,
          additionalProperties: newAddProps,
          minProperties: schema.minProperties,
          maxProperties: schema.maxProperties,
          dependentRequired: newDependentRequired,
          title: schema.title,
          description: schema.description,
          isDeprecated: schema.isDeprecated,
          deprecatedMessage: schema.deprecatedMessage,
          hasDefault: schema.hasDefault,
          defaultValue: schema.defaultValue,
          not: newNot,
          dartName: schema.dartName,
        );
        _flattenCache[schema] = newSchema;
        return newSchema;
      } else {
        _flattenCache[schema] = schema;
        return schema;
      }
    }

    if (schema is ArraySchema) {
      final newItems = _flatten(schema.items);
      final newContains = schema.contains != null
          ? _flatten(schema.contains!)
          : null;

      var prefixItemsChanged = false;
      List<Schema>? newPrefixItems;
      if (schema.prefixItems != null) {
        newPrefixItems = [];
        for (final item in schema.prefixItems!) {
          final ni = _flatten(item);
          newPrefixItems.add(ni);
          if (ni != item) prefixItemsChanged = true;
        }
      }

      if (newItems != schema.items ||
          newContains != schema.contains ||
          prefixItemsChanged ||
          notChanged) {
        final newSchema = ArraySchema(
          items: newItems,
          prefixItems: newPrefixItems,
          minItems: schema.minItems,
          maxItems: schema.maxItems,
          uniqueItems: schema.uniqueItems,
          contains: newContains,
          minContains: schema.minContains,
          maxContains: schema.maxContains,
          title: schema.title,
          description: schema.description,
          isDeprecated: schema.isDeprecated,
          deprecatedMessage: schema.deprecatedMessage,
          hasDefault: schema.hasDefault,
          defaultValue: schema.defaultValue,
          not: newNot,
        );
        _flattenCache[schema] = newSchema;
        return newSchema;
      } else {
        _flattenCache[schema] = schema;
        return schema;
      }
    }

    if (schema is UnionSchema) {
      var changed = notChanged;
      final newSubs = <Schema>[];
      for (final sub in schema.subschemas) {
        final ns = _flatten(sub);
        newSubs.add(ns);
        if (ns != sub) changed = true;
      }
      if (changed) {
        final newSchema = UnionSchema(
          subschemas: newSubs,
          discriminator: schema.discriminator,
          title: schema.title,
          description: schema.description,
          isDeprecated: schema.isDeprecated,
          deprecatedMessage: schema.deprecatedMessage,
          hasDefault: schema.hasDefault,
          defaultValue: schema.defaultValue,
          not: newNot,
          dartName: schema.dartName,
        );
        _flattenCache[schema] = newSchema;
        return newSchema;
      } else {
        _flattenCache[schema] = schema;
        return schema;
      }
    }

    if (schema is AllOfSchema) {
      final flattenedSubs = schema.subschemas.map(_flatten).toList();
      final merged = _mergeAll(flattenedSubs);
      final finalSchema = _copyWithMetadata(
        merged,
        title: schema.title,
        description: schema.description,
        isDeprecated: schema.isDeprecated,
        deprecatedMessage: schema.deprecatedMessage,
        hasDefault: schema.hasDefault,
        defaultValue: schema.defaultValue,
        not: newNot,
      );
      _flattenCache[schema] = finalSchema;
      return finalSchema;
    }

    if (schema is EnumSchema) {
      final newBase = _flatten(schema.baseSchema);
      if (newBase != schema.baseSchema || notChanged) {
        final newSchema = EnumSchema(
          values: schema.values,
          baseSchema: newBase,
          title: schema.title,
          description: schema.description,
          isDeprecated: schema.isDeprecated,
          deprecatedMessage: schema.deprecatedMessage,
          hasDefault: schema.hasDefault,
          defaultValue: schema.defaultValue,
          not: newNot,
          dartName: schema.dartName,
        );
        _flattenCache[schema] = newSchema;
        return newSchema;
      } else {
        _flattenCache[schema] = schema;
        return schema;
      }
    }

    // For other leaf schemas (Boolean, Null, Anything, Never), we only recreate them if 'not' changed.
    if (notChanged) {
      final newSchema = _copyWithMetadata(
        schema,
        not: newNot,
        deprecatedMessage: schema.deprecatedMessage,
        dartName: schema.dartName,
      );
      _flattenCache[schema] = newSchema;
      return newSchema;
    }

    _flattenCache[schema] = schema;
    return schema;
  }

  Schema _mergeAll(List<Schema> schemas) {
    if (schemas.isEmpty) return const AnythingSchema();
    var result = schemas.first;
    for (var i = 1; i < schemas.length; i++) {
      result = _merge(result, schemas[i]);
    }
    return result;
  }

  Schema _merge(Schema a, Schema b) {
    final merged = _mergeInner(a, b);
    return _copyWithMetadata(merged, not: _mergeNot(a.not, b.not));
  }

  Schema? _mergeNot(Schema? a, Schema? b) {
    if (a == null) return b;
    if (b == null) return a;
    return UnionSchema(subschemas: [a, b]);
  }

  Schema _mergeInner(Schema a, Schema b) {
    final realA = a.realSchema;
    final realB = b.realSchema;

    if (realA is AnythingSchema) return b;
    if (realB is AnythingSchema) return a;
    if (realA is NeverSchema) return a;
    if (realB is NeverSchema) return b;

    if (realA is ObjectSchema && realB is ObjectSchema) {
      final properties = <String, Schema>{}..addAll(realA.properties);
      realB.properties.forEach((k, v) {
        if (properties.containsKey(k)) {
          properties[k] = _merge(properties[k]!, v);
        } else {
          properties[k] = v;
        }
      });

      final required = <String>{}
        ..addAll(realA.required)
        ..addAll(realB.required);

      final patternProperties = <RegExp, Schema>{};
      RegExp? findRegExp(Map<RegExp, Schema> map, String pattern) {
        for (final key in map.keys) {
          if (key.pattern == pattern) return key;
        }
        return null;
      }

      realA.patternProperties.forEach((k, v) {
        patternProperties[k] = v;
      });
      realB.patternProperties.forEach((k, v) {
        final existingKey = findRegExp(patternProperties, k.pattern);
        if (existingKey != null) {
          patternProperties[existingKey] = _merge(
            patternProperties[existingKey]!,
            v,
          );
        } else {
          patternProperties[k] = v;
        }
      });

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

      int? minProperties;
      if (realA.minProperties != null && realB.minProperties != null) {
        minProperties = math.max(realA.minProperties!, realB.minProperties!);
      } else {
        minProperties = realA.minProperties ?? realB.minProperties;
      }

      int? maxProperties;
      if (realA.maxProperties != null && realB.maxProperties != null) {
        maxProperties = math.min(realA.maxProperties!, realB.maxProperties!);
      } else {
        maxProperties = realA.maxProperties ?? realB.maxProperties;
      }

      final dependentRequired = <String, Set<String>>{};
      realA.dependentRequired.forEach(
        (k, v) => dependentRequired[k] = Set.from(v),
      );
      realB.dependentRequired.forEach((k, v) {
        if (dependentRequired.containsKey(k)) {
          dependentRequired[k]!.addAll(v);
        } else {
          dependentRequired[k] = Set.from(v);
        }
      });

      return ObjectSchema(
        properties: properties,
        patternProperties: patternProperties,
        required: required,
        additionalProperties: additionalProperties,
        minProperties: minProperties,
        maxProperties: maxProperties,
        dependentRequired: dependentRequired,
        title: realA.title ?? realB.title,
        description: realA.description ?? realB.description,
        isDeprecated: realA.isDeprecated || realB.isDeprecated,
        deprecatedMessage: realA.deprecatedMessage ?? realB.deprecatedMessage,
        hasDefault: realA.hasDefault || realB.hasDefault,
        defaultValue: realA.defaultValue ?? realB.defaultValue,
        dartName: realA.dartName ?? realB.dartName,
      );
    }

    if (realA is StringSchema && realB is StringSchema) {
      int? minLength;
      if (realA.minLength != null && realB.minLength != null) {
        minLength = math.max(realA.minLength!, realB.minLength!);
      } else {
        minLength = realA.minLength ?? realB.minLength;
      }

      int? maxLength;
      if (realA.maxLength != null && realB.maxLength != null) {
        maxLength = math.min(realA.maxLength!, realB.maxLength!);
      } else {
        maxLength = realA.maxLength ?? realB.maxLength;
      }

      final pattern = realA.pattern ?? realB.pattern;
      final format = realA.format ?? realB.format;

      return StringSchema(
        minLength: minLength,
        maxLength: maxLength,
        pattern: pattern,
        format: format,
        title: realA.title ?? realB.title,
        description: realA.description ?? realB.description,
        isDeprecated: realA.isDeprecated || realB.isDeprecated,
        hasDefault: realA.hasDefault || realB.hasDefault,
        defaultValue: realA.defaultValue ?? realB.defaultValue,
      );
    }

    if (realA is NumberSchema && realB is NumberSchema) {
      final isInteger = realA.isInteger || realB.isInteger;

      num? minimum;
      if (realA.minimum != null && realB.minimum != null) {
        minimum = math.max(realA.minimum!, realB.minimum!);
      } else {
        minimum = realA.minimum ?? realB.minimum;
      }

      num? maximum;
      if (realA.maximum != null && realB.maximum != null) {
        maximum = math.min(realA.maximum!, realB.maximum!);
      } else {
        maximum = realA.maximum ?? realB.maximum;
      }

      num? exclusiveMinimum;
      if (realA.exclusiveMinimum != null && realB.exclusiveMinimum != null) {
        exclusiveMinimum = math.max(
          realA.exclusiveMinimum!,
          realB.exclusiveMinimum!,
        );
      } else {
        exclusiveMinimum = realA.exclusiveMinimum ?? realB.exclusiveMinimum;
      }

      num? exclusiveMaximum;
      if (realA.exclusiveMaximum != null && realB.exclusiveMaximum != null) {
        exclusiveMaximum = math.min(
          realA.exclusiveMaximum!,
          realB.exclusiveMaximum!,
        );
      } else {
        exclusiveMaximum = realA.exclusiveMaximum ?? realB.exclusiveMaximum;
      }

      final multipleOf = realA.multipleOf ?? realB.multipleOf;

      return NumberSchema(
        isInteger: isInteger,
        minimum: minimum,
        maximum: maximum,
        exclusiveMinimum: exclusiveMinimum,
        exclusiveMaximum: exclusiveMaximum,
        multipleOf: multipleOf,
        title: realA.title ?? realB.title,
        description: realA.description ?? realB.description,
        isDeprecated: realA.isDeprecated || realB.isDeprecated,
        hasDefault: realA.hasDefault || realB.hasDefault,
        defaultValue: realA.defaultValue ?? realB.defaultValue,
      );
    }

    return const NeverSchema();
  }
}

Schema _copyWithMetadata(
  Schema schema, {
  String? title,
  String? description,
  bool? isDeprecated,
  String? deprecatedMessage,
  bool? hasDefault,
  Object? defaultValue,
  Schema? not,
  String? dartName,
}) {
  final t = title ?? schema.title;
  final d = description ?? schema.description;
  final dep = isDeprecated ?? schema.isDeprecated;
  final dm = deprecatedMessage ?? schema.deprecatedMessage;
  final hd = hasDefault ?? schema.hasDefault;
  final dv = defaultValue ?? schema.defaultValue;
  final n = not ?? schema.not;
  final dn = dartName ?? schema.dartName;

  return switch (schema) {
    ObjectSchema s => ObjectSchema(
      properties: s.properties,
      required: s.required,
      additionalProperties: s.additionalProperties,
      minProperties: s.minProperties,
      maxProperties: s.maxProperties,
      dependentRequired: s.dependentRequired,
      title: t,
      description: d,
      isDeprecated: dep,
      deprecatedMessage: dm,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
      dartName: dn,
    ),
    ArraySchema s => ArraySchema(
      items: s.items,
      prefixItems: s.prefixItems,
      minItems: s.minItems,
      maxItems: s.maxItems,
      uniqueItems: s.uniqueItems,
      contains: s.contains,
      minContains: s.minContains,
      maxContains: s.maxContains,
      title: t,
      description: d,
      isDeprecated: dep,
      deprecatedMessage: dm,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    StringSchema s => StringSchema(
      minLength: s.minLength,
      maxLength: s.maxLength,
      pattern: s.pattern,
      format: s.format,
      title: t,
      description: d,
      isDeprecated: dep,
      deprecatedMessage: dm,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    NumberSchema s => NumberSchema(
      isInteger: s.isInteger,
      minimum: s.minimum,
      maximum: s.maximum,
      exclusiveMinimum: s.exclusiveMinimum,
      exclusiveMaximum: s.exclusiveMaximum,
      multipleOf: s.multipleOf,
      title: t,
      description: d,
      isDeprecated: dep,
      deprecatedMessage: dm,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    BooleanSchema _ => BooleanSchema(
      title: t,
      description: d,
      isDeprecated: dep,
      deprecatedMessage: dm,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    NullSchema _ => NullSchema(
      title: t,
      description: d,
      isDeprecated: dep,
      deprecatedMessage: dm,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    AnythingSchema _ => AnythingSchema(
      title: t,
      description: d,
      isDeprecated: dep,
      deprecatedMessage: dm,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    NeverSchema _ => NeverSchema(
      title: t,
      description: d,
      isDeprecated: dep,
      deprecatedMessage: dm,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    RefSchema s => RefSchema(
      s.ref,
      title: t,
      description: d,
      isDeprecated: dep,
      deprecatedMessage: dm,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    )..resolved = s.resolved,
    UnionSchema s => UnionSchema(
      subschemas: s.subschemas,
      discriminator: s.discriminator,
      title: t,
      description: d,
      isDeprecated: dep,
      deprecatedMessage: dm,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
      dartName: dn,
    ),
    AllOfSchema s => AllOfSchema(
      subschemas: s.subschemas,
      title: t,
      description: d,
      isDeprecated: dep,
      deprecatedMessage: dm,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    EnumSchema s => EnumSchema(
      values: s.values,
      baseSchema: s.baseSchema,
      title: t,
      description: d,
      isDeprecated: dep,
      deprecatedMessage: dm,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
      dartName: dn,
    ),
  };
}

/// A resolver that loads schemas from the local file system.
///
/// By default, it restricts access to files within [rootDirectory] (defaulting
/// to the current working directory) to prevent path traversal attacks.
/// To disable this restriction, set [restrictToRoot] to false.
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
  final file = io.File.fromUri(uri);
  if (restrictToRoot) {
    final root = rootDirectory ?? io.Directory.current;
    final rootPath = p.canonicalize(root.path);
    final filePath = p.canonicalize(file.path);

    if (!p.isWithin(rootPath, filePath) && !p.equals(rootPath, filePath)) {
      throw ArgumentError(
        'Access denied: $uri is outside of restricted root $rootPath',
      );
    }
  }
  return file.readAsBytes();
}
