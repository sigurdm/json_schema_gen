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

import 'dart:math' as math;
import 'schema.dart';

/// A parser to build a [Schema] AST from a decoded JSON schema.
final class SchemaParser {
  final Map<String, Schema> _cache = {};
  final Map<String, dynamic> _rootJson;

  /// Creates a parser for the given [rootJson] schema definition.
  SchemaParser(Map<String, dynamic> rootJson) : _rootJson = rootJson;

  /// Parses the schema structure and resolves all internal references.
  ///
  /// Throws [ArgumentError] if a reference (`$ref`) cannot be resolved.
  /// Throws [TypeError] or [StateError] if the schema JSON structure is invalid
  /// or contains unsupported types for specific keywords.
  Schema parse() {
    final root = _parseSchema(_rootJson, '#');
    _resolveRefs(root);
    final flattenedRoot = _flatten(root);

    // Update cache
    final keys = _cache.keys.toList();
    for (final key in keys) {
      _cache[key] = _flatten(_cache[key]!);
    }

    return flattenedRoot;
  }

  Schema _parseSchema(dynamic json, String path) {
    if (path.isNotEmpty && _cache.containsKey(path)) {
      return _cache[path]!;
    }

    if (json is! Map) {
      return const AnythingSchema();
    }

    final title = json['title'] as String?;
    final description = json['description'] as String?;
    final isDeprecated = json['deprecated'] == true;
    final hasDefault = json.containsKey('default');
    final defaultValue = json['default'];
    final notJson = json['not'];
    final not = notJson != null ? _parseSchema(notJson, '$path/not') : null;

    if (json.containsKey(r'$ref')) {
      final ref = json[r'$ref'] as String;
      final refSchema = RefSchema(
        ref,
        title: title,
        description: description,
        isDeprecated: isDeprecated,
        hasDefault: hasDefault,
        defaultValue: defaultValue,
      );
      if (not != null) {
        return AllOfSchema(
          subschemas: [refSchema],
          not: not,
          title: title,
          description: description,
          isDeprecated: isDeprecated,
          hasDefault: hasDefault,
          defaultValue: defaultValue,
        );
      }
      return refSchema;
    }

    // Parse definitions under local scopes
    if (json[r'$defs'] is Map) {
      (json[r'$defs'] as Map).forEach((key, value) {
        _parseSchema(value, '$path/\$defs/$key');
      });
    }
    if (json['definitions'] is Map) {
      (json['definitions'] as Map).forEach((key, value) {
        _parseSchema(value, '$path/definitions/$key');
      });
    }

    if (json.containsKey('const')) {
      final constValue = json['const'];
      final jsonWithoutConst = Map<String, dynamic>.from(json)..remove('const');
      final baseSchema = _parseSchema(jsonWithoutConst, '$path/base');
      final schema = EnumSchema(
        values: [constValue],
        baseSchema: baseSchema,
        title: title,
        description: description,
        isDeprecated: isDeprecated,
        hasDefault: hasDefault,
        defaultValue: defaultValue,
        not: not,
      );
      if (path.isNotEmpty) {
        _cache[path] = schema;
      }
      return schema;
    }

    if (json.containsKey('enum')) {
      final enumValues = (json['enum'] as List).toList();
      final jsonWithoutEnum = Map<String, dynamic>.from(json)..remove('enum');
      final baseSchema = _parseSchema(jsonWithoutEnum, '$path/base');
      final schema = EnumSchema(
        values: enumValues,
        baseSchema: baseSchema,
        title: title,
        description: description,
        isDeprecated: isDeprecated,
        hasDefault: hasDefault,
        defaultValue: defaultValue,
        not: not,
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
          final mapping = mappingJson?.map(
            (k, v) => MapEntry(k as String, v as String),
          );
          return Discriminator(propertyName: propName, mapping: mapping);
        }
      }
      return null;
    }

    if (json.containsKey('allOf')) {
      final list = json['allOf'] as List;
      final subschemas = list
          .asMap()
          .entries
          .map((e) => _parseSchema(e.value, '$path/allOf/${e.key}'))
          .toList();

      final copy = Map<String, dynamic>.from(json);
      copy.remove('allOf');
      copy.remove('title');
      copy.remove('description');
      copy.remove('deprecated');
      copy.remove('default');
      copy.remove(r'$defs');
      copy.remove('definitions');

      if (copy.isNotEmpty) {
        final restSchema = _parseSchema(copy, '$path/rest');
        if (restSchema is! AnythingSchema) {
          subschemas.add(restSchema);
        }
      }

      schema = AllOfSchema(
        subschemas: subschemas,
        title: title,
        description: description,
        isDeprecated: isDeprecated,
        hasDefault: hasDefault,
        defaultValue: defaultValue,
        not: not,
      );
    } else if (json.containsKey('oneOf')) {
      final list = json['oneOf'] as List;
      final subschemas = list
          .asMap()
          .entries
          .map((e) => _parseSchema(e.value, '$path/oneOf/${e.key}'))
          .toList();
      schema = UnionSchema(
        subschemas: subschemas,
        discriminator: parseDiscriminator(json),
        title: title,
        description: description,
        isDeprecated: isDeprecated,
        hasDefault: hasDefault,
        defaultValue: defaultValue,
        not: not,
      );
    } else if (json.containsKey('anyOf')) {
      final list = json['anyOf'] as List;
      final subschemas = list
          .asMap()
          .entries
          .map((e) => _parseSchema(e.value, '$path/anyOf/${e.key}'))
          .toList();
      schema = UnionSchema(
        subschemas: subschemas,
        discriminator: parseDiscriminator(json),
        title: title,
        description: description,
        isDeprecated: isDeprecated,
        hasDefault: hasDefault,
        defaultValue: defaultValue,
        not: not,
      );
    } else {
      final typeVal = json['type'];
      if (typeVal is List) {
        final subschemas = typeVal.map((t) {
          final singleJson = Map<String, dynamic>.from(json)..['type'] = t;
          return _parseSchema(singleJson, '$path/type/$t');
        }).toList();
        schema = UnionSchema(
          subschemas: subschemas,
          title: title,
          description: description,
          isDeprecated: isDeprecated,
          hasDefault: hasDefault,
          defaultValue: defaultValue,
          not: not,
        );
      } else {
        var type = typeVal as String?;
        if (type == null) {
          if (json.containsKey('properties') ||
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
              (json['properties'] as Map).forEach((key, value) {
                properties[key] = _parseSchema(value, '$path/properties/$key');
              });
            }
            final patternProperties = <RegExp, Schema>{};
            if (json['patternProperties'] is Map) {
              (json['patternProperties'] as Map).forEach((key, value) {
                patternProperties[RegExp(key as String)] = _parseSchema(
                  value,
                  '$path/patternProperties/$key',
                );
              });
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
              additionalProperties = _parseSchema(
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
              required: required,
              patternProperties: patternProperties,
              additionalProperties: additionalProperties,
              minProperties: json['minProperties'] as int?,
              maxProperties: json['maxProperties'] as int?,
              dependentRequired: dependentRequired,
              title: title,
              description: description,
              isDeprecated: isDeprecated,
              hasDefault: hasDefault,
              defaultValue: defaultValue,
              not: not,
            );
            break;
          case 'array':
            final itemsJson = json['items'];
            final items = itemsJson != null
                ? _parseSchema(itemsJson, '$path/items')
                : const AnythingSchema();

            final prefixItemsJson = json['prefixItems'];
            List<Schema>? prefixItems;
            if (prefixItemsJson is List) {
              prefixItems = [];
              for (var i = 0; i < prefixItemsJson.length; i++) {
                prefixItems.add(
                  _parseSchema(prefixItemsJson[i], '$path/prefixItems/$i'),
                );
              }
            }

            final containsJson = json['contains'];
            final contains = containsJson != null
                ? _parseSchema(containsJson, '$path/contains')
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
              hasDefault: hasDefault,
              defaultValue: defaultValue,
              not: not,
            );
        }
      }
    }

    if (path.isNotEmpty) {
      _cache[path] = schema;
    }
    return schema;
  }

  void _resolveRefs(Schema root) {
    final visited = <Schema>{};
    void visit(Schema s) {
      if (!visited.add(s)) return;
      if (s.not != null) visit(s.not!);
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
      } else if (s is AllOfSchema) {
        s.subschemas.forEach(visit);
      } else if (s is EnumSchema) {
        visit(s.baseSchema);
      }
    }

    visit(root);
    _cache.values.forEach(visit);
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
          required: schema.required,
          patternProperties: newPatternProps,
          additionalProperties: newAddProps,
          minProperties: schema.minProperties,
          maxProperties: schema.maxProperties,
          dependentRequired: newDependentRequired,
          title: schema.title,
          description: schema.description,
          isDeprecated: schema.isDeprecated,
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

    if (schema is AllOfSchema) {
      final flattenedSubs = schema.subschemas.map(_flatten).toList();
      final merged = _mergeAll(flattenedSubs);
      final combinedNot = _mergeNot(merged.not, newNot);
      final mergedWithoutNot = _copyWithMetadata(merged, not: null);
      final finalSchema = _attachNot(
        _copyWithMetadata(
          mergedWithoutNot,
          title: schema.title,
          description: schema.description,
          isDeprecated: schema.isDeprecated,
          hasDefault: schema.hasDefault,
          defaultValue: schema.defaultValue,
        ),
        combinedNot,
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

    if (notChanged) {
      final finalSchema = _copyWithMetadata(schema, not: newNot);
      _flattenCache[schema] = finalSchema;
      return finalSchema;
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
    final mergedNot = _mergeNot(a.not, b.not);
    return _attachNot(merged, mergedNot);
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
        required: required,
        patternProperties: patternProperties,
        additionalProperties: additionalProperties,
        minProperties: minProperties,
        maxProperties: maxProperties,
        dependentRequired: dependentRequired,
        title: realA.title ?? realB.title,
        description: realA.description ?? realB.description,
        isDeprecated: realA.isDeprecated || realB.isDeprecated,
        hasDefault: realA.hasDefault || realB.hasDefault,
        defaultValue: realA.defaultValue ?? realB.defaultValue,
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
  bool? hasDefault,
  Object? defaultValue,
  Schema? not,
}) {
  final t = title ?? schema.title;
  final d = description ?? schema.description;
  final dep = isDeprecated ?? schema.isDeprecated;
  final hd = hasDefault ?? schema.hasDefault;
  final dv = defaultValue ?? schema.defaultValue;
  final n = not ?? schema.not;

  return switch (schema) {
    ObjectSchema s => ObjectSchema(
      properties: s.properties,
      required: s.required,
      patternProperties: s.patternProperties,
      additionalProperties: s.additionalProperties,
      minProperties: s.minProperties,
      maxProperties: s.maxProperties,
      dependentRequired: s.dependentRequired,
      title: t,
      description: d,
      isDeprecated: dep,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
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
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    BooleanSchema _ => BooleanSchema(
      title: t,
      description: d,
      isDeprecated: dep,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    NullSchema _ => NullSchema(
      title: t,
      description: d,
      isDeprecated: dep,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    AnythingSchema _ => AnythingSchema(
      title: t,
      description: d,
      isDeprecated: dep,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    NeverSchema _ => NeverSchema(
      title: t,
      description: d,
      isDeprecated: dep,
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    RefSchema s => RefSchema(
      s.ref,
      title: t,
      description: d,
      isDeprecated: dep,
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
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
    AllOfSchema s => AllOfSchema(
      subschemas: s.subschemas,
      title: t,
      description: d,
      isDeprecated: dep,
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
      hasDefault: hd,
      defaultValue: dv,
      not: n,
    ),
  };
}

Schema _attachNot(Schema schema, Schema? not) {
  if (not == null) return schema;
  if (schema is RefSchema) {
    return AllOfSchema(subschemas: [schema], not: not);
  }
  return _copyWithMetadata(schema, not: not);
}
