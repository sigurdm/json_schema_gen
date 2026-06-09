import 'dart:math' as math;
import 'package:jsontool/jsontool.dart';

/// The base class for all parsed JSON Schema representations.
///
/// Resolves internal JSON Schema references and translates them into
/// compiled Dart classes and types.
sealed class Schema {
  /// The title of the schema, if specified.
  final String? title;

  /// The description of the schema, if specified.
  final String? description;

  /// Whether this schema is deprecated.
  final bool isDeprecated;

  /// The deprecation message, if specified.
  final String? deprecatedMessage;

  /// Whether this schema has a default value.
  final bool hasDefault;

  /// The default value, if specified.
  final Object? defaultValue;

  /// Custom name to use for generated Dart class, if specified via x-dart-name.
  final String? dartName;

  /// Const constructor for subclass schemas.
  const Schema({
    this.title,
    this.description,
    this.isDeprecated = false,
    this.deprecatedMessage,
    this.hasDefault = false,
    this.defaultValue,
    this.not,
    this.dartName,
  });

  /// Schema that must not validate successfully.
  final Schema? not;
}

/// Represents an object type schema.
final class ObjectSchema extends Schema {
  /// Map of property names to their respective schemas.
  final Map<String, Schema> properties;

  /// Set of required property names.
  final Set<String> required;

  /// Schema for additional properties, if specified.
  final Schema? additionalProperties;

  /// Minimum number of properties allowed.
  final int? minProperties;

  /// Maximum number of properties allowed.
  final int? maxProperties;

  /// Map of property names to their dependent required properties.
  final Map<String, Set<String>> dependentRequired;

  /// Const constructor for object schemas.
  const ObjectSchema({
    required this.properties,
    required this.required,
    this.additionalProperties,
    this.minProperties,
    this.maxProperties,
    this.dependentRequired = const {},
    super.title,
    super.description,
    super.isDeprecated,
    super.deprecatedMessage,
    super.hasDefault,
    super.defaultValue,
    super.not,
    super.dartName,
  });
}

/// Represents an array type schema wrapping its item schemas.
final class ArraySchema extends Schema {
  /// The schema of items in the array.
  final Schema items;

  /// Positional schemas for tuple-like arrays.
  final List<Schema>? prefixItems;

  /// Minimum number of items allowed in the array.
  final int? minItems;

  /// Maximum number of items allowed in the array.
  final int? maxItems;

  /// Whether items in the array must be unique.
  final bool? uniqueItems;

  /// Schema that at least one item (or minContains items) must match.
  final Schema? contains;

  /// Minimum number of items that must match contains schema.
  final int? minContains;

  /// Maximum number of items that can match contains schema.
  final int? maxContains;

  /// Const constructor for array schemas.
  const ArraySchema({
    required this.items,
    this.prefixItems,
    this.minItems,
    this.maxItems,
    this.uniqueItems,
    this.contains,
    this.minContains,
    this.maxContains,
    super.title,
    super.description,
    super.isDeprecated,
    super.deprecatedMessage,
    super.hasDefault,
    super.defaultValue,
    super.not,
  });
}

/// Represents a string type schema.
final class StringSchema extends Schema {
  /// Minimum character length of the string.
  final int? minLength;

  /// Maximum character length of the string.
  final int? maxLength;

  /// RegEx pattern the string must match.
  final String? pattern;

  /// Format identifier (e.g. `date-time`, `email`, etc.).
  final String? format;

  /// Const constructor for string schemas.
  const StringSchema({
    this.minLength,
    this.maxLength,
    this.pattern,
    this.format,
    super.title,
    super.description,
    super.isDeprecated,
    super.deprecatedMessage,
    super.hasDefault,
    super.defaultValue,
    super.not,
  });
}

/// Represents a numeric type schema.
final class NumberSchema extends Schema {
  /// Whether this numeric schema is restricted to integers.
  final bool isInteger;

  /// Minimum value allowed.
  final num? minimum;

  /// Maximum value allowed.
  final num? maximum;

  /// Exclusive minimum value allowed.
  final num? exclusiveMinimum;

  /// Exclusive maximum value allowed.
  final num? exclusiveMaximum;

  /// The value must be a multiple of this number.
  final num? multipleOf;

  /// Const constructor for number schemas.
  const NumberSchema({
    required this.isInteger,
    this.minimum,
    this.maximum,
    this.exclusiveMinimum,
    this.exclusiveMaximum,
    this.multipleOf,
    super.title,
    super.description,
    super.isDeprecated,
    super.deprecatedMessage,
    super.hasDefault,
    super.defaultValue,
    super.not,
  });
}

/// Represents a boolean type schema.
final class BooleanSchema extends Schema {
  /// Const constructor for boolean schemas.
  const BooleanSchema({
    super.title,
    super.description,
    super.isDeprecated,
    super.deprecatedMessage,
    super.hasDefault,
    super.defaultValue,
    super.not,
  });
}

/// Represents a null type schema.
final class NullSchema extends Schema {
  /// Const constructor for null schemas.
  const NullSchema({
    super.title,
    super.description,
    super.isDeprecated,
    super.deprecatedMessage,
    super.hasDefault,
    super.defaultValue,
    super.not,
  });
}

/// Represents a reference schema pointing to another definition.
final class RefSchema extends Schema {
  /// The reference string, e.g. `#/definitions/Address`.
  final String ref;

  /// The resolved target schema, populated in the resolution pass.
  Schema? resolved;

  /// Constructor for reference schemas.
  RefSchema(
    this.ref, {
    super.title,
    super.description,
    super.isDeprecated,
    super.deprecatedMessage,
    super.hasDefault,
    super.defaultValue,
    super.not,
  });
}

/// Represents a discriminator configuration for union parsing.
final class Discriminator {
  /// The property name to inspect.
  final String propertyName;

  /// Optional explicit mapping of discriminator values to schema references.
  final Map<String, Schema>? mapping;

  /// Const constructor for discriminator configuration.
  const Discriminator({required this.propertyName, this.mapping});
}

/// Represents a union type schema (e.g. `oneOf` or `anyOf`).
final class UnionSchema extends Schema {
  /// The list of candidate schemas.
  final List<Schema> subschemas;

  /// Optional discriminator configuration.
  final Discriminator? discriminator;

  /// Const constructor for union schemas.
  const UnionSchema({
    required this.subschemas,
    this.discriminator,
    super.title,
    super.description,
    super.isDeprecated,
    super.deprecatedMessage,
    super.hasDefault,
    super.defaultValue,
    super.not,
    super.dartName,
  });
}

/// Represents an allOf schema requiring validation against all subschemas.
final class AllOfSchema extends Schema {
  /// The list of subschemas that must all validate.
  final List<Schema> subschemas;

  /// Const constructor for allOf schemas.
  const AllOfSchema({
    required this.subschemas,
    super.title,
    super.description,
    super.isDeprecated,
    super.deprecatedMessage,
    super.hasDefault,
    super.defaultValue,
    super.not,
  });
}

/// Fallback schema representing any JSON value.
final class AnythingSchema extends Schema {
  /// Const constructor for the fallback schema.
  const AnythingSchema({
    super.title,
    super.description,
    super.isDeprecated,
    super.deprecatedMessage,
    super.hasDefault,
    super.defaultValue,
    super.not,
  });
}

/// Represents an enumeration type schema containing a fixed set of allowed values.
final class EnumSchema extends Schema {
  /// The allowed enum values.
  final List<dynamic> values;

  /// The base schema type of the enum.
  final Schema baseSchema;

  /// Const constructor for enum schemas.
  const EnumSchema({
    required this.values,
    required this.baseSchema,
    super.title,
    super.description,
    super.isDeprecated,
    super.deprecatedMessage,
    super.hasDefault,
    super.defaultValue,
    super.not,
    super.dartName,
  });
}

/// Represents a schema that never validates successfully (used for additionalProperties: false).
final class NeverSchema extends Schema {
  /// Const constructor for NeverSchema.
  const NeverSchema({
    super.title,
    super.description,
    super.isDeprecated,
    super.deprecatedMessage,
    super.hasDefault,
    super.defaultValue,
    super.not,
  });
}

/// Utility extension to resolve reference schemas recursively.
extension SchemaExtensions on Schema {
  /// Returns the underlying non-ref schema, resolving `$ref` pointers.
  ///
  /// Throws [StateError] if a reference is unresolved or if a cycle is detected.
  Schema get realSchema {
    var current = this;
    final seen = <RefSchema>{};
    while (current is RefSchema) {
      if (!seen.add(current)) {
        throw StateError('Cyclic reference detected: ${current.ref}');
      }
      final resolved = current.resolved;
      if (resolved == null) {
        throw StateError('Ref has not been resolved: ${current.ref}');
      }
      current = resolved;
    }
    return current;
  }
}

/// Analysis helper for union types.
final class UnionAnalysis {
  /// Whether this union represents a nullable single schema type.
  final bool isNullable;

  /// The primary non-null schema if this union is nullable, otherwise null.
  final Schema? nonNullSchema;

  /// The schemas that are not NullSchema.
  final List<Schema> activeSchemas;

  /// Constructor.
  const UnionAnalysis({
    required this.isNullable,
    this.nonNullSchema,
    required this.activeSchemas,
  });

  /// Analyzes a [UnionSchema] to extract nullability information.
  factory UnionAnalysis.analyze(UnionSchema union) {
    final active = <Schema>[];
    bool nullable = false;
    for (final s in union.subschemas) {
      final real = s.realSchema;
      if (real is NullSchema) {
        nullable = true;
      } else {
        active.add(s);
      }
    }
    if (nullable && active.length == 1) {
      return UnionAnalysis(
        isNullable: true,
        nonNullSchema: active.first,
        activeSchemas: active,
      );
    }
    return UnionAnalysis(
      isNullable: nullable,
      nonNullSchema: null,
      activeSchemas: active,
    );
  }
}

/// A parser to build a [Schema] AST from a decoded JSON schema.
final class SchemaParser {
  final Map<String, Schema> _cache = {};
  final Map<String, dynamic> _rootJson;
  final String baseUri;
  final Future<Map<String, dynamic>> Function(String uri)? uriResolver;
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
          final externalJson = await uriResolver!(refFile);
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
      var changed = false;
      final newProps = <String, Schema>{};
      schema.properties.forEach((k, v) {
        final nv = _flatten(v);
        newProps[k] = nv;
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
          additionalProperties: newAddProps,
          minProperties: schema.minProperties,
          maxProperties: schema.maxProperties,
          dependentRequired: newDependentRequired,
          title: schema.title,
          description: schema.description,
          isDeprecated: schema.isDeprecated,
          hasDefault: schema.hasDefault,
          defaultValue: schema.defaultValue,
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
          prefixItemsChanged) {
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
        );
        _flattenCache[schema] = newSchema;
        return newSchema;
      } else {
        _flattenCache[schema] = schema;
        return schema;
      }
    }

    if (schema is UnionSchema) {
      var changed = false;
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
        hasDefault: schema.hasDefault,
        defaultValue: schema.defaultValue,
      );
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

/// Custom exception tracking the nested path of validation or parse failure.
final class JsonParseException implements FormatException {
  @override
  final String message;

  @override
  final Object? source;

  @override
  final int? offset;

  /// The JSON path segments leading to the failure.
  final List<String> path;

  /// Creates a [JsonParseException] with the failure path.
  JsonParseException(this.message, this.source, this.offset, this.path);

  @override
  String toString() {
    final pathStr = path.isEmpty ? '' : ' at \$.${path.join('.')}';
    return 'JsonParseException$pathStr: $message';
  }
}

/// Helper function to wrap parsing exceptions, adding the path segment.
FormatException wrapException(FormatException e, dynamic pathSegment) {
  final List<String> pathList;
  if (pathSegment is List) {
    pathList = List<String>.from(pathSegment);
  } else {
    pathList = [pathSegment as String];
  }
  if (e is JsonParseException) {
    return JsonParseException(e.message, e.source, e.offset, [
      ...pathList,
      ...e.path,
    ]);
  }
  return JsonParseException(e.message, e.source, e.offset, pathList);
}

/// Base interface for all models generated by json_schema_gen.
abstract class JsonModel implements JsonWritable {
  /// Validates the model instance against schema constraints.
  void validate();

  /// Converts the model to a JSON-compatible Dart value (Map, List, primitive, etc.).
  Object? toJsonValue();
}

/// Exception thrown when schema validation fails.
final class JsonValidationException implements Exception {
  /// The validation error message.
  final String message;

  /// The JSON path segments leading to the validation failure.
  final List<String> path;

  /// Creates a [JsonValidationException] with the validation failure path.
  JsonValidationException(this.message, [this.path = const []]);

  @override
  String toString() {
    final pathStr = path.isEmpty ? '' : ' at \$.${path.join('.')}';
    return 'JsonValidationException$pathStr: $message';
  }
}

/// Read any dynamic JSON value from [reader].
dynamic readAny(JsonReader reader) {
  dynamic result;
  final writer = jsonObjectWriter((value) {
    result = value;
  });
  reader.expectAnyValue(writer);
  return result;
}

/// Writes any arbitrary Dart JSON structure to [sink].
void writeAny(JsonSink sink, dynamic value) {
  if (value == null) {
    sink.addNull();
  } else if (value is bool) {
    sink.addBool(value);
  } else if (value is num) {
    sink.addNumber(value);
  } else if (value is String) {
    sink.addString(value);
  } else if (value is List) {
    sink.startArray();
    for (final item in value) {
      writeAny(sink, item);
    }
    sink.endArray();
  } else if (value is Map) {
    sink.startObject();
    value.forEach((key, val) {
      sink.addKey(key.toString());
      writeAny(sink, val);
    });
    sink.endObject();
  } else if (value is JsonWritable) {
    value.writeJson(sink);
  } else {
    throw ArgumentError(
      'Unsupported value type for serialization: ${value.runtimeType}',
    );
  }
}

/// Formats a name string into PascalCase for Dart class names.
String toPascalCase(String text) {
  final result = text
      .split(RegExp(r'[^a-zA-Z0-9]+'))
      .where((s) => s.isNotEmpty)
      .map((s) => s[0].toUpperCase() + s.substring(1))
      .join('');
  if (result.isEmpty) return '';
  if (RegExp(r'^[0-9]').hasMatch(result)) {
    return 'Schema$result';
  }
  return result;
}

/// Formats a name string into camelCase for Dart properties.
String toCamelCase(String text) {
  final parts = text
      .split(RegExp(r'(?=[A-Z])|[^a-zA-Z0-9]+'))
      .where((s) => s.isNotEmpty)
      .toList();
  if (parts.isEmpty) return 'property';
  final first = parts.first.toLowerCase();
  final rest = parts
      .skip(1)
      .map((s) => s[0].toUpperCase() + s.substring(1))
      .join('');
  var candidate = '$first$rest';
  if (RegExp(r'^[0-9]').hasMatch(candidate)) {
    candidate = 'value$candidate';
  }

  if (_dartKeywords.contains(candidate) ||
      _reservedMemberNames.contains(candidate)) {
    return '${candidate}_';
  }
  return candidate;
}

const _reservedMemberNames = {
  'validate',
  'writeJson',
  'toJson',
  'hashCode',
  'runtimeType',
  'noSuchMethod',
  'toString',
};

const _dartKeywords = {
  'abstract',
  'as',
  'assert',
  'async',
  'await',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'covariant',
  'default',
  'deferred',
  'do',
  'dynamic',
  'else',
  'enum',
  'export',
  'extends',
  'extension',
  'external',
  'factory',
  'false',
  'final',
  'finally',
  'for',
  'Function',
  'get',
  'hide',
  'if',
  'implements',
  'import',
  'in',
  'out',
  'inherited',
  'inline',
  'interface',
  'is',
  'late',
  'library',
  'mixin',
  'new',
  'null',
  'on',
  'operator',
  'part',
  'required',
  'rethrow',
  'return',
  'set',
  'show',
  'static',
  'super',
  'switch',
  'sync',
  'this',
  'throw',
  'true',
  'try',
  'type',
  'typedef',
  'var',
  'void',
  'when',
  'while',
  'with',
  'yield',
};

String _arrayElementType(ArraySchema schema, Map<Schema, String> classNames) {
  if (schema.prefixItems == null || schema.prefixItems!.isEmpty) {
    return dartType(schema.items, classNames);
  }
  final types = <String>{};
  for (final item in schema.prefixItems!) {
    types.add(dartType(item, classNames));
  }
  types.add(dartType(schema.items, classNames));
  if (types.length == 1) {
    return types.first;
  }
  return 'dynamic';
}

/// Computes the Dart type string for the given [schema].
String dartType(Schema schema, Map<Schema, String> classNames) {
  final real = schema.realSchema;
  if (real is ObjectSchema) {
    return classNames[real] ?? 'dynamic';
  } else if (real is ArraySchema) {
    return 'List<${_arrayElementType(real, classNames)}>';
  } else if (real is StringSchema) {
    return 'String';
  } else if (real is NumberSchema) {
    return real.isInteger ? 'int' : 'num';
  } else if (real is BooleanSchema) {
    return 'bool';
  } else if (real is NullSchema) {
    return 'Null';
  } else if (real is AnythingSchema) {
    return 'Object?';
  } else if (real is UnionSchema) {
    final analysis = UnionAnalysis.analyze(real);
    if (analysis.isNullable && analysis.nonNullSchema != null) {
      return '${dartType(analysis.nonNullSchema!, classNames)}?';
    }
    final name = classNames[real];
    if (name == null) return 'dynamic';
    return analysis.isNullable ? '$name?' : name;
  } else if (real is EnumSchema) {
    return classNames[real] ?? 'dynamic';
  } else if (real is NeverSchema) {
    return 'Never';
  }
  return 'dynamic';
}

/// Base class for all runtime descriptors that define how to parse and
/// serialize JSON values according to a schema.
abstract class SchemaDescriptor<T> {
  /// Const constructor for subclasses.
  const SchemaDescriptor();
}

/// Descriptor for JSON objects that map to Dart class [T].
class ObjectDescriptor<T> extends SchemaDescriptor<T> {
  /// The title/name of the object schema.
  final String title;

  /// Factory function to instantiate [T] from a map of parsed fields.
  final T Function(Map<String, dynamic> fields) instantiate;

  /// Map of property names to their descriptors.
  final Map<String, PropertyDescriptor> properties;

  /// List of required property names.
  final List<String> required;

  /// Descriptor for additional properties if allowed, otherwise null.
  final SchemaDescriptor? additionalProperties;

  /// Function to extract fields from an instance of [T] for serialization.
  final Map<String, Object?> Function(dynamic instance) getFields;

  /// Function to check if an instance matches this descriptor.
  final bool Function(dynamic instance) matches;

  /// Creates an [ObjectDescriptor].
  const ObjectDescriptor({
    required this.title,
    required this.instantiate,
    required this.properties,
    this.required = const [],
    this.additionalProperties,
    required this.getFields,
    required this.matches,
  });
}

/// Descriptor for a single property of an object.
class PropertyDescriptor {
  /// The JSON property name.
  final String name;

  /// The descriptor for the property value.
  final SchemaDescriptor schema;

  /// Whether this property is required in the object.
  final bool isRequired;

  /// Creates a [PropertyDescriptor].
  const PropertyDescriptor({
    required this.name,
    required this.schema,
    this.isRequired = false,
  });
}

/// Base class for descriptors of primitive JSON types (string, number, boolean, null).
abstract class PrimitiveDescriptor<T> extends SchemaDescriptor<T> {
  /// Const constructor.
  const PrimitiveDescriptor();

  /// Reads a value of type [T] from [reader].
  ///
  /// Throws [FormatException] if the value is not of the expected type.
  T read(JsonReader reader);

  /// Writes [value] to [sink].
  void write(JsonSink sink, T value);
}

/// Descriptor for JSON strings.
class StringDescriptor extends PrimitiveDescriptor<String> {
  /// Const constructor.
  const StringDescriptor();
  @override
  String read(JsonReader reader) => reader.expectString();
  @override
  void write(JsonSink sink, String value) => sink.addString(value);
}

/// Descriptor for JSON integers.
class IntDescriptor extends PrimitiveDescriptor<int> {
  /// Const constructor.
  const IntDescriptor();
  @override
  int read(JsonReader reader) => reader.expectInt();
  @override
  void write(JsonSink sink, int value) => sink.addNumber(value);
}

/// Descriptor for JSON numbers (integers or doubles).
class NumDescriptor extends PrimitiveDescriptor<num> {
  /// Const constructor.
  const NumDescriptor();
  @override
  num read(JsonReader reader) => reader.expectNum();
  @override
  void write(JsonSink sink, num value) => sink.addNumber(value);
}

/// Descriptor for JSON booleans.
class BoolDescriptor extends PrimitiveDescriptor<bool> {
  /// Const constructor.
  const BoolDescriptor();
  @override
  bool read(JsonReader reader) => reader.expectBool();
  @override
  void write(JsonSink sink, bool value) => sink.addBool(value);
}

/// Descriptor for JSON null values.
class NullDescriptor extends PrimitiveDescriptor<Null> {
  /// Const constructor.
  const NullDescriptor();
  @override
  Null read(JsonReader reader) => reader.expectNull();
  @override
  void write(JsonSink sink, Null value) => sink.addNull();
}

/// Descriptor representing any JSON value (`AnythingSchema`).
class AnythingDescriptor extends PrimitiveDescriptor<dynamic> {
  /// Const constructor.
  const AnythingDescriptor();
  @override
  dynamic read(JsonReader reader) => readAny(reader);
  @override
  void write(JsonSink sink, dynamic value) => writeAny(sink, value);
}

/// Descriptor representing a schema that never validates successfully.
class NeverDescriptor extends SchemaDescriptor<Never> {
  /// Const constructor.
  const NeverDescriptor();
}

/// Descriptor for a nullable type wrapping another descriptor.
class NullableDescriptor<T> extends SchemaDescriptor<T?> {
  /// The descriptor of the non-null value.
  final SchemaDescriptor<T> inner;

  /// Creates a [NullableDescriptor] wrapping [inner].
  const NullableDescriptor(this.inner);
}

/// Descriptor for JSON arrays mapping to Dart `List<T>`.
class ArrayDescriptor<T> extends SchemaDescriptor<List<T>> {
  /// The descriptor for array items.
  final SchemaDescriptor<T> items;

  /// Positional descriptors for tuple-like arrays.
  final List<SchemaDescriptor>? prefixItems;

  /// Creates an [ArrayDescriptor].
  const ArrayDescriptor(this.items, {this.prefixItems});

  _JsonParseFrame _createFrame({required bool validate}) =>
      _ArrayFrame<T>(this, validate: validate);
}

/// Descriptor for JSON enums mapping to Dart enum [T].
class EnumDescriptor<T> extends SchemaDescriptor<T> {
  /// The allowed enum values.
  final List<T> values;

  /// Factory function to convert a raw value to enum [T].
  final T Function(dynamic val) fromValue;

  /// Function to convert enum [T] back to raw value.
  final dynamic Function(dynamic val) toValue;

  /// The descriptor of the base type of the enum.
  final PrimitiveDescriptor base;

  /// Creates an [EnumDescriptor].
  const EnumDescriptor({
    required this.values,
    required this.fromValue,
    required this.toValue,
    required this.base,
  });
}

/// Descriptor for a single option of a union.
class UnionOptionDescriptor<T, V> {
  /// The descriptor for the option value.
  final SchemaDescriptor<V> schema;

  /// Function to wrap the parsed option value into union type [T].
  final T Function(dynamic val) wrap;

  /// Creates a [UnionOptionDescriptor].
  const UnionOptionDescriptor(this.schema, this.wrap);
}

/// Descriptor for JSON unions (oneOf/anyOf) mapping to Dart class [T].
class UnionDescriptor<T> extends SchemaDescriptor<T> {
  /// The title/name of the union schema.
  final String title;

  /// The property name used as discriminator, if any.
  final String? discriminatorProperty;

  /// Optional mapping from discriminator values to option descriptors.
  final Map<String, UnionOptionDescriptor<T, dynamic>>? discriminatorMapping;

  /// List of candidate descriptors for non-discriminated union resolution.
  final List<UnionOptionDescriptor<T, dynamic>> activeOptions;

  /// Creates a [UnionDescriptor].
  const UnionDescriptor({
    required this.title,
    this.discriminatorProperty,
    this.discriminatorMapping,
    required this.activeOptions,
  });
}

abstract class _JsonParseFrame {
  dynamic get result;
  String? get currentPathSegment;
  void resume(dynamic value);
  bool execute(JsonReader reader, List<_JsonParseFrame> stack);
}

class _ObjectFrame extends _JsonParseFrame {
  final ObjectDescriptor desc;
  final bool validate;
  final Map<String, dynamic> fields = {};
  bool _initialized = false;
  String? _currentKey;
  dynamic _result;

  _ObjectFrame(this.desc, {this.validate = true});

  @override
  dynamic get result => _result;

  @override
  String? get currentPathSegment => _currentKey;

  @override
  void resume(dynamic value) {
    if (_currentKey != null) {
      fields[_currentKey!] = value;
      _currentKey = null;
    }
  }

  @override
  bool execute(JsonReader reader, List<_JsonParseFrame> stack) {
    if (!_initialized) {
      reader.expectObject();
      _initialized = true;
    }
    if (reader.hasNextKey()) {
      final key = reader.nextKey()!;
      final prop = desc.properties[key];
      if (prop != null) {
        _currentKey = key;
        _pushSchemaFrame(reader, stack, prop.schema, (val) {
          fields[key] = val;
          _currentKey = null;
        }, validate: validate);
      } else if (desc.additionalProperties != null) {
        _currentKey = key;
        _pushSchemaFrame(reader, stack, desc.additionalProperties!, (val) {
          fields[key] = val;
          _currentKey = null;
        }, validate: validate);
      } else {
        reader.skipAnyValue();
      }
      return false;
    } else {
      for (final req in desc.required) {
        if (!fields.containsKey(req)) {
          throw reader.fail('Missing required property: $req');
        }
      }
      _result = desc.instantiate(fields);
      if (validate && _result is JsonModel) {
        (_result as JsonModel).validate();
      }
      return true;
    }
  }
}

class _ArrayFrame<T> extends _JsonParseFrame {
  final ArrayDescriptor<T> desc;
  final bool validate;
  final List<T> list = [];
  bool _initialized = false;
  int index = 0;

  _ArrayFrame(this.desc, {this.validate = true});

  @override
  dynamic get result => list;

  @override
  String? get currentPathSegment => '[$index]';

  @override
  void resume(dynamic value) {
    list.add(value as T);
    index++;
  }

  @override
  bool execute(JsonReader reader, List<_JsonParseFrame> stack) {
    if (!_initialized) {
      reader.expectArray();
      _initialized = true;
    }
    if (reader.hasNext()) {
      final itemDesc =
          (desc.prefixItems != null && index < desc.prefixItems!.length)
          ? desc.prefixItems![index]
          : desc.items;
      _pushSchemaFrame(reader, stack, itemDesc, (val) {
        list.add(val as T);
        index++;
      }, validate: validate);
      return false;
    } else {
      return true;
    }
  }
}

class _UnionFrame extends _JsonParseFrame {
  final UnionDescriptor desc;
  final bool validate;
  dynamic _result;
  UnionOptionDescriptor? _pendingOption;

  _UnionFrame(this.desc, {this.validate = true});

  @override
  dynamic get result => _result;

  @override
  String? get currentPathSegment => null;

  @override
  void resume(dynamic value) {
    if (_pendingOption != null) {
      _result = _pendingOption!.wrap(value);
      _pendingOption = null;
    } else {
      _result = value;
    }
  }

  @override
  bool execute(JsonReader reader, List<_JsonParseFrame> stack) {
    if (_result != null) {
      if (validate && _result is JsonModel) {
        (_result as JsonModel).validate();
      }
      return true;
    }

    if (desc.discriminatorProperty != null) {
      final rCopy = reader.copy();
      rCopy.expectObject();
      String? discValue;
      while (rCopy.hasNextKey()) {
        final key = rCopy.nextKey();
        if (key == desc.discriminatorProperty) {
          discValue = rCopy.expectString();
          break;
        } else {
          rCopy.skipAnyValue();
        }
      }
      if (discValue == null) {
        throw reader.fail(
          'Missing discriminator property: ${desc.discriminatorProperty}',
        );
      }
      final option = desc.discriminatorMapping?[discValue];
      if (option == null) {
        throw reader.fail('Unknown discriminator value: $discValue');
      }
      _pendingOption = option;
      _pushSchemaFrame(reader, stack, option.schema, (val) {
        _result = option.wrap(val);
        _pendingOption = null;
      }, validate: validate);
      return false;
    } else {
      Exception? lastException;
      for (final option in desc.activeOptions) {
        final rCopy = reader.copy();
        try {
          final parsedValue = _runNonRecursiveWithDescriptor(
            rCopy,
            option.schema,
            validate: validate,
          );
          reader.skipAnyValue();
          final wrapped = option.wrap(parsedValue);
          if (validate && wrapped is JsonModel) {
            wrapped.validate();
          }
          _result = wrapped;
          return true;
        } on FormatException catch (e) {
          lastException = e;
        } on JsonValidationException catch (e) {
          lastException = e;
        }
      }
      throw reader.fail(
        'Failed to parse ${desc.title} union. Last error: $lastException',
      );
    }
  }
}

void _pushSchemaFrame(
  JsonReader reader,
  List<_JsonParseFrame> stack,
  SchemaDescriptor schema,
  void Function(dynamic value) onComplete, {
  required bool validate,
}) {
  if (schema is NullableDescriptor) {
    if (reader.checkNull()) {
      reader.expectNull();
      onComplete(null);
    } else {
      _pushSchemaFrame(
        reader,
        stack,
        schema.inner,
        onComplete,
        validate: validate,
      );
    }
  } else if (schema is PrimitiveDescriptor) {
    onComplete(schema.read(reader));
  } else if (schema is AnythingDescriptor) {
    onComplete(readAny(reader));
  } else if (schema is EnumDescriptor) {
    final val = schema.base.read(reader);
    try {
      onComplete(schema.fromValue(val));
    } catch (e) {
      throw reader.fail('Invalid enum value: $val');
    }
  } else if (schema is ObjectDescriptor) {
    stack.add(_ObjectFrame(schema, validate: validate));
  } else if (schema is ArrayDescriptor) {
    stack.add(schema._createFrame(validate: validate));
  } else if (schema is UnionDescriptor) {
    stack.add(_UnionFrame(schema, validate: validate));
  } else if (schema is NeverDescriptor) {
    throw reader.fail('Value is not allowed here');
  }
}

dynamic _runNonRecursiveWithDescriptor(
  JsonReader reader,
  SchemaDescriptor rootSchema, {
  bool validate = true,
}) {
  if (rootSchema is NullableDescriptor) {
    if (reader.checkNull()) {
      reader.expectNull();
      return null;
    }
    return _runNonRecursiveWithDescriptor(
      reader,
      rootSchema.inner,
      validate: validate,
    );
  }
  if (rootSchema is PrimitiveDescriptor) {
    return rootSchema.read(reader);
  } else if (rootSchema is EnumDescriptor) {
    final val = rootSchema.base.read(reader);
    try {
      return rootSchema.fromValue(val);
    } catch (e) {
      throw reader.fail('Invalid enum value: $val');
    }
  }

  final rootFrame = _createFrameForSchema(rootSchema, validate: validate);
  final stack = <_JsonParseFrame>[rootFrame];
  try {
    while (stack.isNotEmpty) {
      final current = stack.last;
      final isComplete = current.execute(reader, stack);
      if (isComplete) {
        final popped = stack.removeLast();
        if (stack.isNotEmpty) {
          stack.last.resume(popped.result);
        }
      }
    }
    return rootFrame.result;
  } on JsonValidationException catch (e) {
    final path = <String>[];
    for (final frame in stack) {
      final segment = frame.currentPathSegment;
      if (segment != null) {
        path.add(segment);
      }
    }
    throw JsonValidationException(e.message, [...path, ...e.path]);
  } on FormatException catch (e) {
    final path = <String>[];
    for (final frame in stack) {
      final segment = frame.currentPathSegment;
      if (segment != null) {
        path.add(segment);
      }
    }
    throw wrapException(e, path);
  }
}

_JsonParseFrame _createFrameForSchema(
  SchemaDescriptor schema, {
  required bool validate,
}) {
  if (schema is ObjectDescriptor) {
    return _ObjectFrame(schema, validate: validate);
  } else if (schema is ArrayDescriptor) {
    return schema._createFrame(validate: validate);
  } else if (schema is UnionDescriptor) {
    return _UnionFrame(schema, validate: validate);
  }
  throw UnsupportedError('Primitive schemas do not require frame creation.');
}

/// Parses a JSON value from [reader] using the structural definition
/// provided by [schema] descriptor.
///
/// If [validate] is true (default), the parsed value is validated against
/// schema constraints (like minLength, minimum, required fields) immediately
/// after parsing.
///
/// Throws [JsonParseException] if the JSON structure is invalid.
/// Throws [JsonValidationException] if validation is enabled and fails.
dynamic parseWithDescriptor(
  JsonReader reader,
  SchemaDescriptor schema, {
  bool validate = true,
}) {
  return _runNonRecursiveWithDescriptor(reader, schema, validate: validate);
}

/// Serializes [value] to [sink] using the structural definition
/// provided by [schema] descriptor.
void writeWithDescriptor<T>(
  JsonSink sink,
  T value,
  SchemaDescriptor<T> schema,
) {
  _writeSchemaValue(sink, value, schema);
}

bool _descriptorMatches(SchemaDescriptor schema, Object? value) {
  if (schema is NullableDescriptor) {
    if (value == null) return true;
    return _descriptorMatches(schema.inner, value);
  }
  if (schema is StringDescriptor) {
    return value is String;
  }
  if (schema is IntDescriptor) {
    return value is int;
  }
  if (schema is NumDescriptor) {
    return value is num;
  }
  if (schema is BoolDescriptor) {
    return value is bool;
  }
  if (schema is NullDescriptor) {
    return value == null;
  }
  if (schema is AnythingDescriptor) {
    return true;
  }
  if (schema is NeverDescriptor) {
    return false;
  }
  if (schema is ArrayDescriptor) {
    return value is List;
  }
  if (schema is ObjectDescriptor) {
    return schema.matches(value);
  }
  if (schema is EnumDescriptor) {
    return schema.values.contains(value);
  }
  if (schema is UnionDescriptor) {
    for (final option in schema.activeOptions) {
      if (_descriptorMatches(option.schema, value)) {
        return true;
      }
    }
    return false;
  }
  return false;
}

void _writeSchemaValue(JsonSink sink, Object? value, SchemaDescriptor schema) {
  if (schema is NullableDescriptor) {
    if (value == null) {
      sink.addNull();
    } else {
      _writeSchemaValue(sink, value, schema.inner);
    }
    return;
  }
  if (schema is PrimitiveDescriptor) {
    schema.write(sink, value);
  } else if (schema is EnumDescriptor) {
    final backingVal = schema.toValue(value);
    schema.base.write(sink, backingVal);
  } else if (schema is ArrayDescriptor) {
    sink.startArray();
    if (value is List) {
      for (var i = 0; i < value.length; i++) {
        final item = value[i];
        final itemSchema =
            (schema.prefixItems != null && i < schema.prefixItems!.length)
            ? schema.prefixItems![i]
            : schema.items;
        _writeSchemaValue(sink, item, itemSchema);
      }
    }
    sink.endArray();
  } else if (schema is ObjectDescriptor) {
    sink.startObject();
    final fields = schema.getFields(value);
    schema.properties.forEach((key, prop) {
      final val = fields[key];
      if (val != null) {
        sink.addKey(key);
        _writeSchemaValue(sink, val, prop.schema);
      }
    });
    if (schema.additionalProperties != null &&
        schema.additionalProperties is! NeverDescriptor) {
      fields.forEach((key, val) {
        if (!schema.properties.containsKey(key) && val != null) {
          sink.addKey(key);
          _writeSchemaValue(sink, val, schema.additionalProperties!);
        }
      });
    }
    sink.endObject();
  } else if (schema is UnionDescriptor) {
    if (value is JsonWritable) {
      value.writeJson(sink);
    } else {
      var found = false;
      for (final option in schema.activeOptions) {
        if (_descriptorMatches(option.schema, value)) {
          _writeSchemaValue(sink, value, option.schema);
          found = true;
          break;
        }
      }
      if (!found) {
        throw ArgumentError(
          'Value $value does not match any option of union ${schema.title}',
        );
      }
    }
  }
}

/// Entry point to generate code for a parsed JSON Schema.
String generateCode(Schema rootSchema, String rootName) {
  final classNames = Map<Schema, String>.identity();
  final usedNames = <String>{};

  void discoverClasses(Schema schema, String preferredName) {
    final real = schema.realSchema;
    if (real is ObjectSchema) {
      if (classNames.containsKey(real)) return;
      final name = real.dartName ?? real.title ?? preferredName;
      var className = toPascalCase(name);
      if (className.isEmpty) className = 'Model';
      var candidate = className;
      int counter = 1;
      while (usedNames.contains(candidate) ||
          _dartKeywords.contains(candidate) ||
          _dartKeywords.contains(candidate.toLowerCase())) {
        candidate = '$className$counter';
        counter++;
      }
      usedNames.add(candidate);
      classNames[real] = candidate;

      real.properties.forEach((propName, propSchema) {
        discoverClasses(propSchema, '${candidate}_$propName');
      });
      if (real.additionalProperties != null) {
        discoverClasses(
          real.additionalProperties!,
          '${candidate}_AdditionalProperty',
        );
      }
    } else if (real is ArraySchema) {
      discoverClasses(real.items, '${preferredName}Item');
      if (real.contains != null) {
        discoverClasses(real.contains!, '${preferredName}Contains');
      }
      if (real.prefixItems != null) {
        for (var i = 0; i < real.prefixItems!.length; i++) {
          discoverClasses(real.prefixItems![i], '${preferredName}Prefix$i');
        }
      }
    } else if (real is UnionSchema) {
      final analysis = UnionAnalysis.analyze(real);
      if (analysis.isNullable && analysis.nonNullSchema != null) {
        discoverClasses(analysis.nonNullSchema!, preferredName);
        return;
      }
      if (classNames.containsKey(real)) return;
      final name = real.dartName ?? real.title ?? preferredName;
      var className = toPascalCase(name);
      if (className.isEmpty) className = 'Union';
      var candidate = className;
      int counter = 1;
      while (usedNames.contains(candidate) ||
          _dartKeywords.contains(candidate) ||
          _dartKeywords.contains(candidate.toLowerCase())) {
        candidate = '$className$counter';
        counter++;
      }
      usedNames.add(candidate);
      classNames[real] = candidate;

      int index = 0;
      for (final sub in analysis.activeSchemas) {
        discoverClasses(sub, '${candidate}_OptionType$index');
        index++;
      }
    } else if (real is EnumSchema) {
      if (classNames.containsKey(real)) return;
      final name = real.dartName ?? real.title ?? preferredName;
      var className = toPascalCase(name);
      if (className.isEmpty) className = 'Enum';
      var candidate = className;
      int counter = 1;
      while (usedNames.contains(candidate) ||
          _dartKeywords.contains(candidate) ||
          _dartKeywords.contains(candidate.toLowerCase())) {
        candidate = '$className$counter';
        counter++;
      }
      usedNames.add(candidate);
      classNames[real] = candidate;
      discoverClasses(real.baseSchema, '${candidate}_Base');
    }
  }

  discoverClasses(rootSchema, rootName);

  final buffer = StringBuffer();
  buffer.writeln('''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides

import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';
''');

  classNames.forEach((schema, name) {
    if (schema is ObjectSchema) {
      buffer.writeln(_generateObjectClass(schema, name, classNames));
    } else if (schema is UnionSchema) {
      buffer.writeln(_generateUnionClass(schema, name, classNames));
    } else if (schema is EnumSchema) {
      buffer.writeln(_generateEnumClass(schema, name));
    }
  });

  return buffer.toString();
}

String _toEnumConstantName(Object? val) {
  var enumName = toCamelCase(val.toString());
  if (isKeyword(enumName) || int.tryParse(enumName[0]) != null) {
    enumName = 'val${toPascalCase(val.toString())}';
  }
  return enumName;
}

String _enumBackingType(EnumSchema schema) {
  final isString = schema.values.every((v) => v is String);
  final isInt = schema.values.every((v) => v is int);
  return isString ? 'String' : (isInt ? 'int' : 'dynamic');
}

/// Generates a Dart enum class representation for an EnumSchema.
String _generateEnumClass(EnumSchema schema, String className) {
  final buffer = StringBuffer();

  final backingType = _enumBackingType(schema);
  final isString = backingType == 'String';
  final isInt = backingType == 'int';

  if (schema.isDeprecated) {
    if (schema.deprecatedMessage != null) {
      buffer.writeln("@Deprecated('${schema.deprecatedMessage}')");
    } else {
      buffer.writeln('@deprecated');
    }
  }
  buffer.writeln('enum $className {');
  for (final val in schema.values) {
    final enumName = _toEnumConstantName(val);
    final formattedValue = _toBasicDartLiteral(val);
    buffer.writeln("  $enumName($formattedValue),");
  }
  buffer.writeln(';');
  buffer.writeln('  final $backingType value;');
  buffer.writeln('  const $className(this.value);');
  buffer.writeln('  static $className fromValue($backingType val) =>');
  buffer.writeln('      values.firstWhere((e) => e.value == val);');
  final baseDescriptor = isString
      ? 'const StringDescriptor()'
      : (isInt ? 'const IntDescriptor()' : 'const AnythingDescriptor()');
  buffer.writeln('  static final descriptor = EnumDescriptor<$className>(');
  buffer.writeln('    values: values,');
  buffer.writeln('    fromValue: (val) => fromValue(val as $backingType),');
  buffer.writeln('    toValue: (e) => (e as $className).value,');
  buffer.writeln('    base: $baseDescriptor,');
  buffer.writeln('  );');
  buffer.writeln('}');
  return buffer.toString();
}

/// Checks if a string is a reserved Dart keyword.
bool isKeyword(String s) {
  return _dartKeywords.contains(s);
}

String _descriptorExpr(Schema schema, Map<Schema, String> classNames) {
  final real = schema.realSchema;
  if (real is StringSchema) {
    return 'const StringDescriptor()';
  } else if (real is NumberSchema) {
    return real.isInteger ? 'const IntDescriptor()' : 'const NumDescriptor()';
  } else if (real is BooleanSchema) {
    return 'const BoolDescriptor()';
  } else if (real is NullSchema) {
    return 'const NullDescriptor()';
  } else if (real is AnythingSchema) {
    return 'const AnythingDescriptor()';
  } else if (real is NeverSchema) {
    return 'const NeverDescriptor()';
  } else if (real is ArraySchema) {
    final elementType = _arrayElementType(real, classNames);
    if (real.prefixItems == null || real.prefixItems!.isEmpty) {
      return 'ArrayDescriptor<$elementType>(${_descriptorExpr(real.items, classNames)})';
    } else {
      final prefixExprs = real.prefixItems!
          .map((s) => _descriptorExpr(s, classNames))
          .join(', ');
      return 'ArrayDescriptor<$elementType>(${_descriptorExpr(real.items, classNames)}, prefixItems: [$prefixExprs])';
    }
  } else if (real is EnumSchema) {
    final name = classNames[real]!;
    return '$name.descriptor';
  } else if (real is UnionSchema) {
    final analysis = UnionAnalysis.analyze(real);
    if (analysis.isNullable && analysis.nonNullSchema != null) {
      return 'NullableDescriptor(${_descriptorExpr(analysis.nonNullSchema!, classNames)})';
    }
    final name = classNames[real]!;
    return '$name.descriptor';
  } else if (real is ObjectSchema) {
    final name = classNames[real]!;
    return '$name.descriptor';
  }
  throw UnsupportedError(
    'Unsupported schema type for descriptor generation: ${real.runtimeType}',
  );
}

String _fieldType(
  Schema propSchema,
  bool isRequired,
  Map<Schema, String> classNames,
) {
  final baseType = dartType(propSchema, classNames);
  final hasDefault = propSchema.hasDefault;
  String? defaultLiteral;
  if (hasDefault) {
    defaultLiteral = _toDartLiteral(
      propSchema.defaultValue,
      propSchema,
      classNames,
    );
  }
  return (isRequired || (defaultLiteral != null && !baseType.endsWith('?')))
      ? baseType
      : (baseType.endsWith('?') ||
                baseType == 'dynamic' ||
                baseType == 'Object?' ||
                baseType == 'Null'
            ? baseType
            : '$baseType?');
}

bool _isNullable(
  Schema propSchema,
  bool isRequired,
  Map<Schema, String> classNames,
) {
  final type = _fieldType(propSchema, isRequired, classNames);
  return type.endsWith('?') || type == 'dynamic' || type == 'Object?';
}

String _toBasicDartLiteral(Object? value) {
  if (value == null) return 'null';
  if (value is String) {
    return "'${value.replaceAll(r'\', r'\\').replaceAll("'", r"\'")}'";
  }
  if (value is num || value is bool) {
    return value.toString();
  }
  if (value is List) {
    final elements = value.map(_toBasicDartLiteral).join(', ');
    return 'const [$elements]';
  }
  if (value is Map) {
    final entries = value.entries
        .map(
          (e) =>
              "'${e.key.toString().replaceAll("'", r"\'")}': ${_toBasicDartLiteral(e.value)}",
        )
        .join(', ');
    return 'const {$entries}';
  }
  throw ArgumentError('Unsupported value type: ${value.runtimeType}');
}

String? _toDartLiteral(
  Object? value,
  Schema schema,
  Map<Schema, String> classNames,
) {
  final real = schema.realSchema;
  if (real is EnumSchema) {
    final className = classNames[real];
    if (className != null) {
      final constName = _toEnumConstantName(value);
      return '$className.$constName';
    } else {
      return _toDartLiteral(value, real.baseSchema, classNames);
    }
  }
  if (value == null) return 'null';
  if (value is String) {
    return "'${value.replaceAll(r'\', r'\\').replaceAll("'", r"\'")}'";
  }
  if (value is num || value is bool) {
    return value.toString();
  }
  if (value is List) {
    if (value.isEmpty) {
      if (real is ArraySchema) {
        final itemType = dartType(real.items, classNames);
        return 'const <$itemType>[]';
      }
      return 'const []';
    }
    if (real is ArraySchema) {
      final itemType = dartType(real.items, classNames);
      final elements = <String>[];
      for (final val in value) {
        final lit = _toDartLiteral(val, real.items, classNames);
        if (lit == null) return null;
        elements.add(lit);
      }
      return 'const <$itemType>[${elements.join(', ')}]';
    }
  }
  if (value is Map) {
    if (value.isEmpty) {
      if (real is ObjectSchema) {
        final className = classNames[real];
        if (className != null) {
          return 'const $className()';
        }
      }
      return 'const {}';
    }
    if (real is ObjectSchema) {
      final className = classNames[real];
      if (className != null) {
        final args = <String>[];
        var ok = true;
        value.forEach((k, v) {
          final propSchema = real.properties[k];
          if (propSchema == null) {
            ok = false;
            return;
          }
          final lit = _toDartLiteral(v, propSchema, classNames);
          if (lit == null) {
            ok = false;
            return;
          }
          args.add('${toCamelCase(k as String)}: $lit');
        });
        if (ok) {
          return 'const $className(${args.join(', ')})';
        }
      }
    }
  }
  return null;
}

String _generateObjectClass(
  ObjectSchema schema,
  String className,
  Map<Schema, String> classNames,
) {
  final fields = StringBuffer();
  final constructorParams = StringBuffer();
  final equalityProps = <String>[];
  final hashExprs = <String>[];
  final toStringProps = <String>[];
  final copyWithParams = StringBuffer();
  final copyWithArgs = StringBuffer();

  schema.properties.forEach((name, propSchema) {
    final fieldName = toCamelCase(name);
    final isRequired = schema.required.contains(name);
    final baseType = dartType(propSchema, classNames);

    final hasDefault = propSchema.hasDefault;
    String? defaultLiteral;
    if (hasDefault) {
      defaultLiteral = _toDartLiteral(
        propSchema.defaultValue,
        propSchema,
        classNames,
      );
    }

    final fieldType = _fieldType(propSchema, isRequired, classNames);

    if (propSchema.isDeprecated) {
      if (propSchema.deprecatedMessage != null) {
        fields.writeln("  @Deprecated('${propSchema.deprecatedMessage}')");
      } else {
        fields.writeln('  @deprecated');
      }
    }
    fields.writeln('  final $fieldType $fieldName;');
    if (isRequired) {
      constructorParams.writeln('    required this.$fieldName,');
    } else if (defaultLiteral != null) {
      constructorParams.writeln('    this.$fieldName = $defaultLiteral,');
    } else {
      constructorParams.writeln('    this.$fieldName,');
    }

    final copyWithType = (baseType.endsWith('?') || baseType == 'Null')
        ? baseType
        : '$baseType?';
    copyWithParams.writeln('    $copyWithType $fieldName,');
    copyWithArgs.writeln('    $fieldName: $fieldName ?? this.$fieldName,');

    final isColl =
        baseType.startsWith('List') ||
        baseType.startsWith('Map') ||
        baseType == 'dynamic' ||
        baseType == 'Object?';
    if (isColl) {
      equalityProps.add(
        'const DeepCollectionEquality().equals($fieldName, other.$fieldName)',
      );
      hashExprs.add('const DeepCollectionEquality().hash($fieldName)');
    } else {
      equalityProps.add('$fieldName == other.$fieldName');
      hashExprs.add(fieldName);
    }
    toStringProps.add('$fieldName: \${$fieldName}');
  });

  final hasAdditionalProps =
      schema.additionalProperties != null &&
      schema.additionalProperties is! NeverSchema;

  if (hasAdditionalProps) {
    final addPropsType = dartType(schema.additionalProperties!, classNames);
    fields.writeln('  final Map<String, $addPropsType> additionalProperties;');
    constructorParams.writeln('    this.additionalProperties = const {},');
    copyWithParams.writeln(
      '    Map<String, $addPropsType>? additionalProperties,',
    );
    copyWithArgs.writeln(
      '    additionalProperties: additionalProperties ?? this.additionalProperties,',
    );
    equalityProps.add(
      'const DeepCollectionEquality().equals(additionalProperties, other.additionalProperties)',
    );
    hashExprs.add('const DeepCollectionEquality().hash(additionalProperties)');
    toStringProps.add('additionalProperties: \${additionalProperties}');
  }

  final equalityExpr = equalityProps.isEmpty
      ? 'true'
      : equalityProps.join(' && ');

  final validationMethod = _generateValidationMethod(
    schema,
    className,
    classNames,
  );

  final propDescriptors = StringBuffer();
  final getFieldsMap = StringBuffer();
  final instantiateArgs = StringBuffer();

  schema.properties.forEach((name, propSchema) {
    final fieldName = toCamelCase(name);
    final nameEscaped = name.replaceAll("'", r"\'");
    final isRequired = schema.required.contains(name);
    final descExpr = _descriptorExpr(propSchema, classNames);

    propDescriptors.writeln(
      "      '$nameEscaped': PropertyDescriptor(name: '$nameEscaped', isRequired: $isRequired, schema: $descExpr),",
    );
    getFieldsMap.writeln("      '$nameEscaped': typedInstance.$fieldName,");

    final baseType = dartType(propSchema, classNames);
    final hasDefault = propSchema.hasDefault;
    String? defaultLiteral;
    if (hasDefault) {
      defaultLiteral = _toDartLiteral(
        propSchema.defaultValue,
        propSchema,
        classNames,
      );
    }

    final fieldType = _fieldType(propSchema, isRequired, classNames);

    if (isRequired) {
      instantiateArgs.writeln(
        "        $fieldName: fields['$nameEscaped'] as $baseType,",
      );
    } else if (defaultLiteral != null) {
      instantiateArgs.writeln(
        "        $fieldName: fields.containsKey('$nameEscaped') ? fields['$nameEscaped'] as $fieldType : $defaultLiteral,",
      );
    } else {
      instantiateArgs.writeln(
        "        $fieldName: fields['$nameEscaped'] as $fieldType,",
      );
    }
  });

  if (hasAdditionalProps) {
    getFieldsMap.writeln("      ...typedInstance.additionalProperties,");
    final addPropsType = dartType(schema.additionalProperties!, classNames);
    final propKeysLiteral =
        '<String>{${schema.properties.keys.map((k) => "'${k.replaceAll("'", r"\'")}'").join(', ')}}';
    instantiateArgs.writeln(
      "        additionalProperties: fields.entries.where((e) => !const $propKeysLiteral.contains(e.key)).fold<Map<String, $addPropsType>>({}, (m, e) => m..[e.key] = e.value as $addPropsType),",
    );
  }

  String? addPropsExpr;
  if (schema.additionalProperties != null) {
    addPropsExpr = _descriptorExpr(schema.additionalProperties!, classNames);
  }

  final descriptorString =
      '''
  static final descriptor = ObjectDescriptor<$className>(
    title: '$className',
    matches: (instance) => instance is $className,
    instantiate: (fields) => $className(
$instantiateArgs    ),
    getFields: (instance) {
      final typedInstance = instance as $className;
      return {
$getFieldsMap      };
    },
    properties: {
$propDescriptors    },
    required: const [${schema.required.map((r) => "'${r.replaceAll("'", r"\'")}'").join(', ')}],
    ${addPropsExpr != null ? 'additionalProperties: $addPropsExpr,' : ''}
  );''';

  final deprecatedAttr = schema.isDeprecated
      ? (schema.deprecatedMessage != null
            ? "@Deprecated('${schema.deprecatedMessage}')\n"
            : '@deprecated\n')
      : '';

  final constructorStr = constructorParams.isEmpty
      ? '  const $className();'
      : '''
  const $className({
$constructorParams  });''';

  final copyWithStr = copyWithParams.isEmpty
      ? '  $className copyWith() => $className();'
      : '''
  $className copyWith({
$copyWithParams  }) => $className(
$copyWithArgs  );''';

  return '''
${deprecatedAttr}final class $className implements JsonModel {
$fields
$constructorStr

  factory $className.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as $className;

  /// Creates an instance of [$className] from a JSON Map.
  factory $className.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      $className.fromJson(JsonReader.fromObject(map), validate: validate);

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  @override
  Object? toJsonValue() {
    Object? result;
    final sink = jsonObjectWriter((obj) => result = obj);
    writeJson(sink);
    return result;
  }

  /// Converts this instance to a JSON Map.
  Map<String, dynamic> toMap() => toJsonValue() as Map<String, dynamic>;

$copyWithStr

$validationMethod

$descriptorString

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is $className &&
          runtimeType == other.runtimeType &&
          $equalityExpr;

  @override
  int get hashCode => Object.hashAll([
        ${hashExprs.join(',\n        ')}
      ]);

  @override
  String toString() => '$className(${toStringProps.join(', ')})';
}
''';
}

String _generateMatchBlock(
  Schema schema,
  String valueVar,
  String resultVar,
  Map<Schema, String> classNames,
) {
  final buffer = StringBuffer();
  final real = schema.realSchema;
  buffer.writeln('    bool $resultVar = false;');
  if (real is StringSchema) {
    buffer.writeln('    if ($valueVar is String) {');
    buffer.writeln('      $resultVar = true;');
    if (real.minLength != null) {
      buffer.writeln(
        '      if ($valueVar.length < ${real.minLength}) $resultVar = false;',
      );
    }
    if (real.maxLength != null) {
      buffer.writeln(
        '      if ($valueVar.length > ${real.maxLength}) $resultVar = false;',
      );
    }
    if (real.pattern != null) {
      final patternEscaped = real.pattern!
          .replaceAll(r'\', r'\\')
          .replaceAll(r'$', r'\$')
          .replaceAll("'", r"\'");
      buffer.writeln(
        '      if (!RegExp(\'$patternEscaped\').hasMatch($valueVar)) $resultVar = false;',
      );
    }
    if (real.format != null) {
      final fmtBuf = StringBuffer();
      _generateFormatValidation(fmtBuf, valueVar, real.format!, 'item');
      buffer.writeln('      try {');
      buffer.write(fmtBuf.toString());
      buffer.writeln('      } on JsonValidationException catch (_) {');
      buffer.writeln('        $resultVar = false;');
      buffer.writeln('      }');
    }
    buffer.writeln('    }');
  } else if (real is NumberSchema) {
    final typeCheck = real.isInteger ? 'is int' : 'is num';
    buffer.writeln('    if ($valueVar $typeCheck) {');
    buffer.writeln('      $resultVar = true;');
    if (real.minimum != null) {
      buffer.writeln(
        '      if ($valueVar < ${real.minimum}) $resultVar = false;',
      );
    }
    if (real.maximum != null) {
      buffer.writeln(
        '      if ($valueVar > ${real.maximum}) $resultVar = false;',
      );
    }
    if (real.exclusiveMinimum != null) {
      buffer.writeln(
        '      if ($valueVar <= ${real.exclusiveMinimum}) $resultVar = false;',
      );
    }
    if (real.exclusiveMaximum != null) {
      buffer.writeln(
        '      if ($valueVar >= ${real.exclusiveMaximum}) $resultVar = false;',
      );
    }
    if (real.multipleOf != null) {
      if (real.isInteger) {
        buffer.writeln(
          '      if ($valueVar % ${real.multipleOf} != 0) $resultVar = false;',
        );
      } else {
        buffer.writeln(
          '      if (($valueVar / ${real.multipleOf} - ($valueVar / ${real.multipleOf}).round()).abs() > 1e-9) $resultVar = false;',
        );
      }
    }
    buffer.writeln('    }');
  } else if (real is BooleanSchema) {
    buffer.writeln('    if ($valueVar is bool) $resultVar = true;');
  } else if (real is NullSchema) {
    buffer.writeln('    if ($valueVar == null) $resultVar = true;');
  } else if (real is AnythingSchema) {
    buffer.writeln('    $resultVar = true;');
  } else if (real is ObjectSchema) {
    final className = classNames[real]!;
    buffer.writeln('    if ($valueVar is $className) {');
    buffer.writeln('      $resultVar = true;');
    buffer.writeln(
      '      try { $valueVar.validate(); } on JsonValidationException catch (_) { $resultVar = false; }',
    );
    buffer.writeln('    } else if ($valueVar is Map<String, dynamic>) {');
    buffer.writeln('      try {');
    buffer.writeln(
      '        final parsed = $className.fromJson(JsonReader.fromObject($valueVar));',
    );
    buffer.writeln('        $resultVar = true;');
    buffer.writeln('      } catch (_) {}');
    buffer.writeln('    }');
  } else if (real is UnionSchema) {
    final className = classNames[real]!;
    buffer.writeln('    if ($valueVar is $className) {');
    buffer.writeln('      $resultVar = true;');
    buffer.writeln(
      '      try { $valueVar.validate(); } on JsonValidationException catch (_) { $resultVar = false; }',
    );
    buffer.writeln('    } else {');
    buffer.writeln('      try {');
    buffer.writeln(
      '        $className.fromJson(JsonReader.fromObject($valueVar));',
    );
    buffer.writeln('        $resultVar = true;');
    buffer.writeln('      } catch (_) {}');
    buffer.writeln('    }');
  } else if (real is EnumSchema) {
    final className = classNames[real]!;
    final backingType = _enumBackingType(real);
    buffer.writeln('    if ($valueVar is $className) {');
    buffer.writeln('      $resultVar = true;');
    buffer.writeln('    } else {');
    buffer.writeln('      try {');
    if (backingType != 'dynamic') {
      buffer.writeln(
        '        $className.fromValue($valueVar as $backingType);',
      );
    } else {
      buffer.writeln('        $className.fromValue($valueVar);');
    }
    buffer.writeln('        $resultVar = true;');
    buffer.writeln('      } catch (_) {}');
    buffer.writeln('    }');
  }
  return buffer.toString();
}

/// Helper checking if the given schema generates a class type that implements validate().
bool _hasValidationMethod(Schema schema) {
  final real = schema.realSchema;
  if (real is ObjectSchema) {
    return true;
  }
  if (real is UnionSchema) {
    final analysis = UnionAnalysis.analyze(real);
    if (analysis.isNullable && analysis.nonNullSchema != null) {
      return _hasValidationMethod(analysis.nonNullSchema!);
    }
    return true; // Sealed union classes always have validate()
  }
  if (real is ArraySchema) {
    return _hasValidationMethod(real.items);
  }
  return false;
}

/// Generates validation method body checking constraints on class fields.
String _generateValidationMethod(
  ObjectSchema schema,
  String className,
  Map<Schema, String> classNames,
) {
  final buffer = StringBuffer();
  buffer.writeln('  void validate() {');
  if (schema.minProperties != null || schema.maxProperties != null) {
    buffer.writeln('    var count = 0;');
    schema.properties.forEach((key, propSchema) {
      final fieldName = toCamelCase(key);
      final isRequired = schema.required.contains(key);
      final isNullable = _isNullable(propSchema, isRequired, classNames);
      if (isNullable) {
        buffer.writeln('    if ($fieldName != null) count++;');
      } else {
        buffer.writeln('    count++;');
      }
    });
    final hasAdditionalProps =
        schema.additionalProperties != null &&
        schema.additionalProperties is! NeverSchema;
    if (hasAdditionalProps) {
      buffer.writeln('    count += additionalProperties.length;');
    }
    if (schema.minProperties != null) {
      buffer.writeln('    if (count < ${schema.minProperties}) {');
      buffer.writeln(
        "      throw JsonValidationException('Object must have >= ${schema.minProperties} properties', []);",
      );
      buffer.writeln('    }');
    }
    if (schema.maxProperties != null) {
      buffer.writeln('    if (count > ${schema.maxProperties}) {');
      buffer.writeln(
        "      throw JsonValidationException('Object must have <= ${schema.maxProperties} properties', []);",
      );
      buffer.writeln('    }');
    }
  }
  schema.dependentRequired.forEach((key, deps) {
    final fieldName = toCamelCase(key);
    buffer.writeln('    if ($fieldName != null) {');
    for (final dep in deps) {
      final depFieldName = toCamelCase(dep);
      buffer.writeln('      if ($depFieldName == null) {');
      buffer.writeln(
        "        throw JsonValidationException('Property \"$dep\" is required because \"$key\" is present', ['$dep']);",
      );
      buffer.writeln('      }');
    }
    buffer.writeln('    }');
  });
  schema.properties.forEach((name, propSchema) {
    final fieldName = toCamelCase(name);
    final isRequired = schema.required.contains(name);
    final isNullable = _isNullable(propSchema, isRequired, classNames);

    final valueVar = isNullable ? 'val_$fieldName' : fieldName;
    if (isNullable) {
      buffer.writeln('    final val_$fieldName = $fieldName;');
    }
    final validations = StringBuffer();
    _generateSchemaValidations(
      validations,
      propSchema,
      valueVar,
      name,
      classNames,
      includeNot: false,
    );

    if (validations.isNotEmpty) {
      if (isNullable) {
        buffer.writeln('    if (val_$fieldName != null) {');
        buffer.write(validations.toString());
        buffer.writeln('    }');
      } else {
        buffer.write(validations.toString());
      }
    }

    if (propSchema.not != null) {
      final notReal = propSchema.not!.realSchema;
      if (notReal is! ObjectSchema && notReal is! UnionSchema) {
        final notValBuf = StringBuffer();
        _generateSchemaValidations(
          notValBuf,
          propSchema.not!,
          valueVar,
          name,
          classNames,
          checkType: true,
          includeNot: true,
        );
        if (notValBuf.isNotEmpty) {
          buffer.writeln('    bool notMatches_$fieldName = true;');
          buffer.writeln('    try {');
          buffer.write(notValBuf.toString());
          buffer.writeln('    } on JsonValidationException {');
          buffer.writeln('      notMatches_$fieldName = false;');
          buffer.writeln('    }');
          buffer.writeln('    if (notMatches_$fieldName) {');
          buffer.writeln(
            "      throw JsonValidationException('Property \"$name\" must not match the schema', ['$name']);",
          );
          buffer.writeln('    }');
        }
      } else {
        throw UnsupportedError(
          'Complex "not" schemas (object/union) are not supported yet.',
        );
      }
    }
  });

  final hasAdditionalProps =
      schema.additionalProperties != null &&
      schema.additionalProperties is! NeverSchema;
  if (hasAdditionalProps) {
    final addSchema = schema.additionalProperties!;
    final hasAddValidation = _hasValidationMethod(addSchema);
    if (hasAddValidation) {
      buffer.writeln('    additionalProperties.forEach((key, value) {');
      _generateArrayItemValidation(
        buffer,
        addSchema,
        'value',
        r'$key',
        [r'$key'],
        0,
        classNames,
      );
      buffer.writeln('    });');
    } else {
      final validations = StringBuffer();
      _generateSchemaValidations(
        validations,
        addSchema,
        'value',
        r'$key',
        classNames,
        includeNot: false,
      );
      if (validations.isNotEmpty) {
        buffer.writeln('    additionalProperties.forEach((key, value) {');
        buffer.write(validations.toString());
        buffer.writeln('    });');
      }
    }
  }

  buffer.writeln('  }');
  return buffer.toString();
}

void _generateArrayItemValidation(
  StringBuffer validations,
  Schema itemSchema,
  String valueVar,
  String name,
  List<String> path,
  int depth,
  Map<Schema, String> classNames,
) {
  final real = itemSchema.realSchema;
  if (real is ObjectSchema || real is UnionSchema) {
    validations.writeln('''
        try {
          $valueVar.validate();
        } on JsonValidationException catch (e) {
          throw JsonValidationException(e.message, [${path.map((p) => "'$p'").join(', ')}, ...e.path]);
        }''');
  } else if (real is ArraySchema) {
    final itemVar = 'item$depth';
    final indexVar = 'i$depth';
    final hasItemValidation = _hasValidationMethod(real.items);
    if (hasItemValidation) {
      final startIndex = real.prefixItems?.length ?? 0;
      validations.writeln(
        '        for (var $indexVar = $startIndex; $indexVar < $valueVar.length; $indexVar++) {',
      );
      validations.writeln('          final $itemVar = $valueVar[$indexVar];');
      _generateArrayItemValidation(
        validations,
        real.items,
        itemVar,
        name,
        [...path, '[\\\$${indexVar}]'],
        depth + 1,
        classNames,
      );
      validations.writeln('        }');
    }
  }
}

void _generateSchemaValidations(
  StringBuffer validations,
  Schema schema,
  String valueVar,
  String name,
  Map<Schema, String> classNames, {
  bool checkType = false,
  bool includeNot = true,
}) {
  final real = schema.realSchema;
  if (real is StringSchema) {
    if (checkType) {
      validations.writeln('      if ($valueVar is! String) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a string', ['$name']);",
      );
      validations.writeln('      }');
    }
    if (real.minLength != null) {
      validations.writeln('      if ($valueVar.length < ${real.minLength}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" length must be >= ${real.minLength}', ['$name']);",
      );
      validations.writeln('      }');
    }
    if (real.maxLength != null) {
      validations.writeln('      if ($valueVar.length > ${real.maxLength}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" length must be <= ${real.maxLength}', ['$name']);",
      );
      validations.writeln('      }');
    }
    if (real.pattern != null) {
      final patternEscaped = real.pattern!
          .replaceAll(r'\', r'\\')
          .replaceAll(r'$', r'\$')
          .replaceAll("'", r"\'");
      final msgPatternEscaped = real.pattern!
          .replaceAll(r'\', r'\\')
          .replaceAll(r'$', r'\$')
          .replaceAll("'", r"\'")
          .replaceAll('"', '\\"');
      validations.writeln('''
      if (!RegExp('$patternEscaped').hasMatch($valueVar)) {
        throw JsonValidationException('Property "$name" must match pattern "$msgPatternEscaped"', ['$name']);
      }''');
    }
    if (real.format != null) {
      _generateFormatValidation(validations, valueVar, real.format!, name);
    }
  } else if (real is NumberSchema) {
    if (checkType) {
      final typeCheck = real.isInteger ? 'is! int' : 'is! num';
      final typeName = real.isInteger ? 'an integer' : 'a number';
      validations.writeln('      if ($valueVar $typeCheck) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be $typeName', ['$name']);",
      );
      validations.writeln('      }');
    }
    if (real.minimum != null) {
      validations.writeln('      if ($valueVar < ${real.minimum}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be >= ${real.minimum}', ['$name']);",
      );
      validations.writeln('      }');
    }
    if (real.maximum != null) {
      validations.writeln('      if ($valueVar > ${real.maximum}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be <= ${real.maximum}', ['$name']);",
      );
      validations.writeln('      }');
    }
    if (real.exclusiveMinimum != null) {
      validations.writeln('      if ($valueVar <= ${real.exclusiveMinimum}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be > ${real.exclusiveMinimum}', ['$name']);",
      );
      validations.writeln('      }');
    }
    if (real.exclusiveMaximum != null) {
      validations.writeln('      if ($valueVar >= ${real.exclusiveMaximum}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be < ${real.exclusiveMaximum}', ['$name']);",
      );
      validations.writeln('      }');
    }
    if (real.multipleOf != null) {
      if (real.isInteger) {
        validations.writeln('      if ($valueVar % ${real.multipleOf} != 0) {');
      } else {
        validations.writeln(
          '      if (($valueVar / ${real.multipleOf} - ($valueVar / ${real.multipleOf}).round()).abs() > 1e-9) {',
        );
      }
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a multiple of ${real.multipleOf}', ['$name']);",
      );
      validations.writeln('      }');
    }
  } else if (real is ArraySchema) {
    if (checkType) {
      validations.writeln('      if ($valueVar is! List) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be an array', ['$name']);",
      );
      validations.writeln('      }');
    }
    if (real.minItems != null) {
      validations.writeln('      if ($valueVar.length < ${real.minItems}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must have >= ${real.minItems} items', ['$name']);",
      );
      validations.writeln('      }');
    }
    if (real.maxItems != null) {
      validations.writeln('      if ($valueVar.length > ${real.maxItems}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must have <= ${real.maxItems} items', ['$name']);",
      );
      validations.writeln('      }');
    }
    if (real.uniqueItems == true) {
      validations.writeln(
        '      if ($valueVar.length != (LinkedHashSet<dynamic>(equals: const DeepCollectionEquality().equals, hashCode: const DeepCollectionEquality().hash)..addAll($valueVar)).length) {',
      );
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" items must be unique', ['$name']);",
      );
      validations.writeln('      }');
    }
    if (real.contains != null) {
      validations.writeln('      var containsCount = 0;');
      validations.writeln('      for (final dynamic item in $valueVar) {');
      final matchBlock = _generateMatchBlock(
        real.contains!,
        'item',
        'matches',
        classNames,
      );
      validations.write(matchBlock);
      validations.writeln('        if (matches) containsCount++;');
      validations.writeln('      }');
      final minContains = real.minContains ?? 1;
      if (minContains > 0) {
        validations.writeln('      if (containsCount < $minContains) {');
        validations.writeln(
          "        throw JsonValidationException('Property \"$name\" must contain at least $minContains items matching contains schema, but has \$containsCount', ['$name']);",
        );
        validations.writeln('      }');
      }
      if (real.maxContains != null) {
        validations.writeln('      if (containsCount > ${real.maxContains}) {');
        validations.writeln(
          "        throw JsonValidationException('Property \"$name\" must contain at most ${real.maxContains} items matching contains schema, but has \$containsCount', ['$name']);",
        );
        validations.writeln('      }');
      }
    }
    if (real.prefixItems != null) {
      for (var i = 0; i < real.prefixItems!.length; i++) {
        final prefixSchema = real.prefixItems![i];
        if (_hasValidationMethod(prefixSchema)) {
          validations.writeln('      if ($valueVar.length > $i) {');
          _generateArrayItemValidation(
            validations,
            prefixSchema,
            '$valueVar[$i]',
            name,
            [name, '[$i]'],
            0,
            classNames,
          );
          validations.writeln('      }');
        }
      }
    }
    final hasItemValidation = _hasValidationMethod(real.items);
    if (hasItemValidation) {
      final startIndex = real.prefixItems?.length ?? 0;
      validations.writeln(
        '      for (var i = $startIndex; i < $valueVar.length; i++) {',
      );
      _generateArrayItemValidation(
        validations,
        real.items,
        '$valueVar[i]',
        name,
        [name, r'[\$i]'],
        0,
        classNames,
      );
      validations.writeln('      }');
    }
  } else if (real is BooleanSchema) {
    if (checkType) {
      validations.writeln('      if ($valueVar is! bool) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a boolean', ['$name']);",
      );
      validations.writeln('      }');
    }
  } else if (real is NullSchema) {
    if (checkType) {
      validations.writeln('      if ($valueVar != null) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be null', ['$name']);",
      );
      validations.writeln('      }');
    }
  } else if (real is EnumSchema) {
    if (checkType) {
      _generateSchemaValidations(
        validations,
        real.baseSchema,
        valueVar,
        name,
        classNames,
        checkType: true,
      );
    }
    final valuesLiterals = real.values
        .map((v) => _toDartLiteral(v, real, classNames))
        .join(', ');
    validations.writeln(
      '      if (!const [$valuesLiterals].any((v) => const DeepCollectionEquality().equals(v, $valueVar))) {',
    );
    validations.writeln(
      "        throw JsonValidationException('Property \"$name\" must be one of ${real.values}', ['$name']);",
    );
    validations.writeln('      }');
  } else if (real is AnythingSchema) {
    // Always succeeds, so do nothing.
  } else if (real is NeverSchema) {
    validations.writeln(
      "      throw JsonValidationException('Property \"$name\" matches nothing', ['$name']);",
    );
  }

  final hasNestedValidation =
      (real is ObjectSchema || real is UnionSchema) &&
      _hasValidationMethod(real);
  if (hasNestedValidation) {
    validations.writeln('''
      try {
        $valueVar.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['$name', ...e.path]);
      }''');
  }

  if (includeNot && schema.not != null) {
    final notReal = schema.not!.realSchema;
    if (notReal is! ObjectSchema && notReal is! UnionSchema) {
      final notValBuf = StringBuffer();
      _generateSchemaValidations(
        notValBuf,
        schema.not!,
        valueVar,
        name,
        classNames,
        checkType: true,
        includeNot: true,
      );
      if (notValBuf.isNotEmpty) {
        validations.writeln('      bool notMatches = true;');
        validations.writeln('      try {');
        validations.write(notValBuf.toString());
        validations.writeln('      } on JsonValidationException {');
        validations.writeln('        notMatches = false;');
        validations.writeln('      }');
        validations.writeln('      if (notMatches) {');
        validations.writeln(
          "        throw JsonValidationException('Property \"$name\" must not match the schema', ['$name']);",
        );
        validations.writeln('      }');
      }
    } else {
      throw UnsupportedError(
        'Complex "not" schemas (object/union) are not supported yet.',
      );
    }
  }
}

void _generateFormatValidation(
  StringBuffer validations,
  String valueVar,
  String format,
  String name,
) {
  switch (format) {
    case 'date-time':
      validations.writeln('      if (DateTime.tryParse($valueVar) == null) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid RFC 3339 date-time string', ['$name']);",
      );
      validations.writeln('      }');
      break;
    case 'date':
      validations.writeln(
        "      if (!RegExp(r'^\\d{4}-\\d{2}-\\d{2}\$').hasMatch($valueVar)) {",
      );
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid date string (YYYY-MM-DD)', ['$name']);",
      );
      validations.writeln('      }');
      break;
    case 'email':
      validations.writeln(
        "      if (!RegExp(r'^[^@]+@[^@]+\$').hasMatch($valueVar)) {",
      );
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid email address', ['$name']);",
      );
      validations.writeln('      }');
      break;
    case 'ipv4':
      validations.writeln(
        "      if (!RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$').hasMatch($valueVar)) {",
      );
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid IPv4 address', ['$name']);",
      );
      validations.writeln('      }');
      break;
    case 'uuid':
      validations.writeln(
        "      if (!RegExp(r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\$').hasMatch($valueVar)) {",
      );
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid UUID', ['$name']);",
      );
      validations.writeln('      }');
      break;
    case 'uri':
      validations.writeln('      if (!isValidUri($valueVar)) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid absolute URI', ['$name']);",
      );
      validations.writeln('      }');
      break;
    case 'uri-reference':
      validations.writeln('      if (!isValidUriReference($valueVar)) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid URI reference', ['$name']);",
      );
      validations.writeln('      }');
      break;
    case 'ipv6':
      validations.writeln('      if (!isValidIPv6($valueVar)) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid IPv6 address', ['$name']);",
      );
      validations.writeln('      }');
      break;
    case 'hostname':
      validations.writeln('      if (!isValidHostname($valueVar)) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid hostname', ['$name']);",
      );
      validations.writeln('      }');
      break;
    case 'time':
      validations.writeln('      if (!isValidTime($valueVar)) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid time string', ['$name']);",
      );
      validations.writeln('      }');
      break;
  }
}

String _generateUnionClass(
  UnionSchema schema,
  String className,
  Map<Schema, String> classNames,
) {
  final analysis = UnionAnalysis.analyze(schema);
  final subclasses = StringBuffer();

  int index = 0;
  for (final sub in analysis.activeSchemas) {
    final optionType = dartType(sub, classNames);
    final subClassName = '${className}Option$index';

    final hasNestedValidation =
        sub.realSchema is ObjectSchema || sub.realSchema is UnionSchema;
    final validationBody = StringBuffer();
    if (hasNestedValidation) {
      validationBody.writeln('  @override');
      validationBody.writeln('  void validate() {');
      validationBody.writeln('    value.validate();');
      validationBody.writeln('  }');
    } else if (sub.realSchema is ArraySchema) {
      final arraySchema = sub.realSchema as ArraySchema;
      final itemReal = arraySchema.items.realSchema;
      final hasItemValidation =
          itemReal is ObjectSchema ||
          itemReal is UnionSchema ||
          itemReal is ArraySchema;
      validationBody.writeln('  @override');
      validationBody.writeln('  void validate() {');
      if (hasItemValidation) {
        validationBody.writeln('''
    for (var i = 0; i < value.length; i++) {
      try {
        (value[i] as JsonModel).validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['[\$i]', ...e.path]);
      }
    }''');
      }
      validationBody.writeln('  }');
    } else {
      final validations = StringBuffer();
      _generateSchemaValidations(
        validations,
        sub,
        'value',
        'value',
        classNames,
        includeNot: false,
      );
      validationBody.writeln('  @override');
      validationBody.writeln('  void validate() {');
      if (validations.isNotEmpty) {
        validationBody.write(validations.toString());
      }
      validationBody.writeln('  }');
    }

    final descExpr = _descriptorExpr(sub, classNames);

    final optDeprecatedAttr = sub.isDeprecated
        ? (sub.deprecatedMessage != null
              ? "@Deprecated('${sub.deprecatedMessage}')\n"
              : '@deprecated\n')
        : '';

    final isColl =
        optionType.startsWith('List') ||
        optionType.startsWith('Map') ||
        optionType == 'dynamic' ||
        optionType == 'Object?';
    final equalityExpr = isColl
        ? 'const DeepCollectionEquality().equals(value, other.value)'
        : 'value == other.value';
    final hashExpr = isColl
        ? 'const DeepCollectionEquality().hash(value)'
        : 'value.hashCode';

    subclasses.writeln('''
${optDeprecatedAttr}final class $subClassName extends $className {
  final $optionType value;
  const $subClassName(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, $descExpr);
  }

$validationBody

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is $subClassName &&
          runtimeType == other.runtimeType &&
          $equalityExpr;

  @override
  int get hashCode => $hashExpr;

  @override
  String toString() => '$subClassName(value: \$value)';
}
''');

    index++;
  }

  final disc = schema.discriminator;
  final useDiscriminator =
      disc != null &&
      analysis.activeSchemas.every((s) => s.realSchema is ObjectSchema);

  final optionDescriptors = StringBuffer();
  final mappingEntries = StringBuffer();
  int i = 0;
  for (final sub in analysis.activeSchemas) {
    final subClassName = '${className}Option$i';
    final descExpr = _descriptorExpr(sub, classNames);
    final optionType = dartType(sub, classNames);
    optionDescriptors.writeln(
      "      UnionOptionDescriptor<$className, $optionType>($descExpr, (val) => $subClassName(val as $optionType)),",
    );
    i++;
  }

  if (useDiscriminator) {
    int i = 0;
    for (final sub in analysis.activeSchemas) {
      final optionType = dartType(sub, classNames);
      final subClassName = '${className}Option$i';
      final caseLabels = <String>[];
      if (disc.mapping != null) {
        disc.mapping!.forEach((discVal, targetSchema) {
          if (sub.realSchema == targetSchema.realSchema) {
            caseLabels.add(discVal);
          }
        });
      }
      caseLabels.add(optionType);
      caseLabels.add(subClassName);
      if (sub.realSchema.title != null) {
        caseLabels.add(sub.realSchema.title!);
      }

      for (final label in caseLabels.toSet()) {
        mappingEntries.writeln(
          "      '$label': UnionOptionDescriptor<$className, $optionType>(${_descriptorExpr(sub, classNames)}, (val) => $subClassName(val as $optionType)),",
        );
      }
      i++;
    }
  }

  final descriptorString =
      '''
  static final descriptor = UnionDescriptor<$className>(
    title: '$className',
    ${useDiscriminator ? "discriminatorProperty: '${disc.propertyName}'," : ''}
    ${useDiscriminator ? 'discriminatorMapping: {\n$mappingEntries    },' : ''}
    activeOptions: [
$optionDescriptors    ],
  );''';

  final deprecatedAttr = schema.isDeprecated
      ? (schema.deprecatedMessage != null
            ? "@Deprecated('${schema.deprecatedMessage}')\n"
            : '@deprecated\n')
      : '';
  return '''
${deprecatedAttr}sealed class $className implements JsonModel {
  const $className();

  factory $className.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as $className;

  /// Creates an instance of [$className] from a JSON-compatible Dart value.
  factory $className.fromJsonValue(Object? value, {bool validate = true}) =>
      $className.fromJson(JsonReader.fromObject(value), validate: validate);

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  @override
  Object? toJsonValue() {
    Object? result;
    final sink = jsonObjectWriter((obj) => result = obj);
    writeJson(sink);
    return result;
  }

$descriptorString
}

$subclasses
''';
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
  final dn = schema.dartName;
  final dm = schema.deprecatedMessage;

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

/// Validates if a string is a valid hostname according to RFC 1034.
///
/// A hostname must be at most 253 characters long.
/// Labels must be separated by dots and be at most 63 characters long,
/// containing only alphanumeric characters and hyphens, and not starting
/// or ending with a hyphen.
bool isValidHostname(String s) {
  if (s.length > 253) return false;
  final labelRegex = RegExp(
    r'^([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])$',
  );
  final labels = s.split('.');
  for (final label in labels) {
    if (!labelRegex.hasMatch(label)) return false;
  }
  return true;
}

/// Validates if a string is a valid IPv6 address according to RFC 3986.
bool isValidIPv6(String s) {
  final ipv6Regex = RegExp(
    r'^((([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})|'
    r'(([0-9A-Fa-f]{1,4}:){1,7}:)|'
    r'(([0-9A-Fa-f]{1,4}:){1,6}:[0-9A-Fa-f]{1,4})|'
    r'(([0-9A-Fa-f]{1,4}:){1,5}:([0-9A-Fa-f]{1,4}:){1,2}[0-9A-Fa-f]{1,4})|'
    r'(([0-9A-Fa-f]{1,4}:){1,4}:([0-9A-Fa-f]{1,4}:){1,3}[0-9A-Fa-f]{1,4})|'
    r'(([0-9A-Fa-f]{1,4}:){1,3}:([0-9A-Fa-f]{1,4}:){1,4}[0-9A-Fa-f]{1,4})|'
    r'(([0-9A-Fa-f]{1,4}:){1,2}:([0-9A-Fa-f]{1,4}:){1,5}[0-9A-Fa-f]{1,4})|'
    r'([0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){1,6}[0-9A-Fa-f]{1,4})|'
    r'(:(:([0-9A-Fa-f]{1,4}:){0,7}[0-9A-Fa-f]{1,4}|:))|'
    r'(fe80:(:[0-9A-Fa-f]{1,4}){0,4}%[0-9a-zA-Z]{1,})|'
    r'(::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))|'
    r'(([0-9A-Fa-f]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])))$',
  );
  return ipv6Regex.hasMatch(s);
}

/// Validates if a string is a valid time string (HH:MM:SS.sss) according to RFC 3339.
bool isValidTime(String s) {
  final timeRegex = RegExp(
    r'^([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])(\.[0-9]+)?([zZ]|[+-](?:[01][0-9]|2[0-3]):[0-5][0-9])$',
  );
  return timeRegex.hasMatch(s);
}

/// Validates if a string is a valid URI reference according to RFC 3986.
bool isValidUriReference(String s) {
  if (Uri.tryParse(s) == null) return false;
  final allowedChars = RegExp(r"^[A-Za-z0-9\-._~:/?#\[\]@!$&'()*+,;=%]*$");
  if (!allowedChars.hasMatch(s)) return false;

  final percentCheck = RegExp(r'%[0-9a-fA-F]{2}');
  var index = 0;
  while ((index = s.indexOf('%', index)) != -1) {
    if (index + 2 >= s.length) return false;
    final part = s.substring(index, index + 3);
    if (!percentCheck.hasMatch(part)) return false;
    index += 3;
  }
  return true;
}

/// Validates if a string is a valid absolute URI according to RFC 3986.
bool isValidUri(String s) {
  if (!isValidUriReference(s)) return false;
  final parsed = Uri.tryParse(s);
  return parsed != null && parsed.hasScheme;
}

/// Extension on [Schema] to support runtime validation.
extension SchemaValidationExtension on Schema {
  /// Validates [value] against this schema.
  ///
  /// Throws [JsonValidationException] if validation fails.
  void validate(dynamic value) {
    _validate(value, this, []);
  }
}

/// Creates a validator function for the given JSON [schema].
///
/// The returned function takes a decoded JSON value (like [Map], [List],
/// [String], [num], [bool], or `null`) and validates it.
/// It throws [JsonValidationException] if validation fails.
Future<void Function(dynamic)> createValidator(
  Map<String, dynamic> schema, {
  Future<Map<String, dynamic>> Function(String uri)? uriResolver,
  bool disallowExternalRefs = true,
}) async {
  final parser = SchemaParser(schema, uriResolver: uriResolver);
  final parsedSchema = await parser.parse(
    disallowExternalRefs: disallowExternalRefs,
  );
  return parsedSchema.validate;
}

void _validate(dynamic value, Schema schema, List<String> path) {
  // Check 'not' on the current schema level
  if (schema.not != null) {
    bool matches = true;
    try {
      _validate(value, schema.not!, path);
    } on JsonValidationException {
      matches = false;
    }
    if (matches) {
      throw JsonValidationException(
        'Value must not match the "not" schema',
        path,
      );
    }
  }

  if (schema is RefSchema) {
    _validate(value, schema.realSchema, path);
    return;
  }

  switch (schema) {
    case AnythingSchema _:
      break;
    case NeverSchema _:
      throw JsonValidationException('Value matches "never" schema', path);
    case NullSchema _:
      if (value != null) {
        throw JsonValidationException('Value must be null', path);
      }
      break;
    case BooleanSchema _:
      if (value is! bool) {
        throw JsonValidationException('Value must be a boolean', path);
      }
      break;
    case NumberSchema s:
      _validateNumber(value, s, path);
      break;
    case StringSchema s:
      _validateString(value, s, path);
      break;
    case ArraySchema s:
      _validateArray(value, s, path);
      break;
    case ObjectSchema s:
      _validateObject(value, s, path);
      break;
    case EnumSchema s:
      _validateEnum(value, s, path);
      break;
    case UnionSchema s:
      _validateUnion(value, s, path);
      break;
    case AllOfSchema s:
      _validateAllOf(value, s, path);
      break;
    default:
      throw UnimplementedError(
        'Validation for ${schema.runtimeType} is not implemented',
      );
  }
}

void _validateNumber(dynamic value, NumberSchema schema, List<String> path) {
  if (schema.isInteger) {
    if (value is! int) {
      throw JsonValidationException('Value must be an integer', path);
    }
  } else {
    if (value is! num) {
      throw JsonValidationException('Value must be a number', path);
    }
  }

  final val = value as num;
  if (schema.minimum != null && val < schema.minimum!) {
    throw JsonValidationException('Value must be >= ${schema.minimum}', path);
  }
  if (schema.maximum != null && val > schema.maximum!) {
    throw JsonValidationException('Value must be <= ${schema.maximum}', path);
  }
  if (schema.exclusiveMinimum != null && val <= schema.exclusiveMinimum!) {
    throw JsonValidationException(
      'Value must be > ${schema.exclusiveMinimum}',
      path,
    );
  }
  if (schema.exclusiveMaximum != null && val >= schema.exclusiveMaximum!) {
    throw JsonValidationException(
      'Value must be < ${schema.exclusiveMaximum}',
      path,
    );
  }
  if (schema.multipleOf != null) {
    if (schema.isInteger) {
      if (val % schema.multipleOf! != 0) {
        throw JsonValidationException(
          'Value must be a multiple of ${schema.multipleOf}',
          path,
        );
      }
    } else {
      if ((val / schema.multipleOf! - (val / schema.multipleOf!).round())
              .abs() >
          1e-9) {
        throw JsonValidationException(
          'Value must be a multiple of ${schema.multipleOf}',
          path,
        );
      }
    }
  }
}

void _validateString(dynamic value, StringSchema schema, List<String> path) {
  if (value is! String) {
    throw JsonValidationException('Value must be a string', path);
  }
  if (schema.minLength != null && value.length < schema.minLength!) {
    throw JsonValidationException(
      'Value length must be >= ${schema.minLength}',
      path,
    );
  }
  if (schema.maxLength != null && value.length > schema.maxLength!) {
    throw JsonValidationException(
      'Value length must be <= ${schema.maxLength}',
      path,
    );
  }
  if (schema.pattern != null) {
    if (!RegExp(schema.pattern!).hasMatch(value)) {
      throw JsonValidationException(
        'Value must match pattern ${schema.pattern}',
        path,
      );
    }
  }
  if (schema.format != null) {
    _validateFormat(value, schema.format!, path);
  }
}

void _validateFormat(String value, String format, List<String> path) {
  switch (format) {
    case 'date-time':
      if (DateTime.tryParse(value) == null) {
        throw JsonValidationException(
          'Value must be a valid RFC 3339 date-time string',
          path,
        );
      }
      break;
    case 'date':
      if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
        throw JsonValidationException(
          'Value must be a valid date string (YYYY-MM-DD)',
          path,
        );
      }
      break;
    case 'email':
      if (!RegExp(r'^[^@]+@[^@]+$').hasMatch(value)) {
        throw JsonValidationException(
          'Value must be a valid email address',
          path,
        );
      }
      break;
    case 'ipv4':
      if (!RegExp(
        r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
      ).hasMatch(value)) {
        throw JsonValidationException(
          'Value must be a valid IPv4 address',
          path,
        );
      }
      break;
    case 'uuid':
      if (!RegExp(
        r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
      ).hasMatch(value)) {
        throw JsonValidationException('Value must be a valid UUID', path);
      }
      break;
    case 'uri':
      if (!isValidUri(value)) {
        throw JsonValidationException(
          'Value must be a valid absolute URI',
          path,
        );
      }
      break;
    case 'uri-reference':
      if (!isValidUriReference(value)) {
        throw JsonValidationException(
          'Value must be a valid URI reference',
          path,
        );
      }
      break;
    case 'ipv6':
      if (!isValidIPv6(value)) {
        throw JsonValidationException(
          'Value must be a valid IPv6 address',
          path,
        );
      }
      break;
    case 'hostname':
      if (!isValidHostname(value)) {
        throw JsonValidationException('Value must be a valid hostname', path);
      }
      break;
    case 'time':
      if (!isValidTime(value)) {
        throw JsonValidationException(
          'Value must be a valid time string',
          path,
        );
      }
      break;
  }
}

void _validateArray(dynamic value, ArraySchema schema, List<String> path) {
  if (value is! List) {
    throw JsonValidationException('Value must be an array', path);
  }
  if (schema.minItems != null && value.length < schema.minItems!) {
    throw JsonValidationException(
      'Value must have >= ${schema.minItems} items',
      path,
    );
  }
  if (schema.maxItems != null && value.length > schema.maxItems!) {
    throw JsonValidationException(
      'Value must have <= ${schema.maxItems} items',
      path,
    );
  }
  if (schema.uniqueItems == true) {
    for (var i = 0; i < value.length; i++) {
      for (var j = i + 1; j < value.length; j++) {
        if (_deepEquals(value[i], value[j])) {
          throw JsonValidationException('Value items must be unique', path);
        }
      }
    }
  }

  final prefixLength = schema.prefixItems?.length ?? 0;
  if (schema.prefixItems != null) {
    for (var i = 0; i < schema.prefixItems!.length; i++) {
      if (i < value.length) {
        _validate(value[i], schema.prefixItems![i], [...path, '[$i]']);
      }
    }
  }

  for (var i = prefixLength; i < value.length; i++) {
    _validate(value[i], schema.items, [...path, '[$i]']);
  }

  if (schema.contains != null) {
    var containsCount = 0;
    for (var i = 0; i < value.length; i++) {
      try {
        _validate(value[i], schema.contains!, [...path, '[$i]']);
        containsCount++;
      } on JsonValidationException {
        // Ignore
      }
    }
    final minContains = schema.minContains ?? 1;
    if (containsCount < minContains) {
      throw JsonValidationException(
        'Value must contain at least $minContains items matching contains schema',
        path,
      );
    }
    if (schema.maxContains != null && containsCount > schema.maxContains!) {
      throw JsonValidationException(
        'Value must contain at most ${schema.maxContains} items matching contains schema',
        path,
      );
    }
  }
}

void _validateObject(dynamic value, ObjectSchema schema, List<String> path) {
  if (value is! Map) {
    throw JsonValidationException('Value must be an object', path);
  }
  final map = value;

  // Check required
  for (final req in schema.required) {
    if (!map.containsKey(req)) {
      throw JsonValidationException('Missing required property: $req', [
        ...path,
        req,
      ]);
    }
  }

  // Check min/max properties
  if (schema.minProperties != null && map.length < schema.minProperties!) {
    throw JsonValidationException(
      'Object must have >= ${schema.minProperties} properties',
      path,
    );
  }
  if (schema.maxProperties != null && map.length > schema.maxProperties!) {
    throw JsonValidationException(
      'Object must have <= ${schema.maxProperties} properties',
      path,
    );
  }

  // Validate properties
  map.forEach((key, val) {
    if (key is! String) {
      throw JsonValidationException('Object keys must be strings', path);
    }
    final propSchema = schema.properties[key];
    if (propSchema != null) {
      _validate(val, propSchema, [...path, key]);
    } else {
      // Additional properties
      final addProps = schema.additionalProperties;
      if (addProps != null) {
        _validate(val, addProps, [...path, key]);
      }
    }
  });

  // Check dependentRequired
  schema.dependentRequired.forEach((key, deps) {
    if (map.containsKey(key)) {
      for (final dep in deps) {
        if (!map.containsKey(dep)) {
          throw JsonValidationException(
            'Property "$dep" is required because "$key" is present',
            [...path, dep],
          );
        }
      }
    }
  });
}

void _validateEnum(dynamic value, EnumSchema schema, List<String> path) {
  _validate(value, schema.baseSchema, path);
  final contains = schema.values.any((v) => _deepEquals(v, value));
  if (!contains) {
    throw JsonValidationException(
      'Value must be one of ${schema.values}',
      path,
    );
  }
}

void _validateUnion(dynamic value, UnionSchema schema, List<String> path) {
  if (schema.discriminator != null) {
    final disc = schema.discriminator!;
    if (value is! Map || !value.containsKey(disc.propertyName)) {
      throw JsonValidationException(
        'Missing discriminator property: ${disc.propertyName}',
        path,
      );
    }
    final discValue = value[disc.propertyName];
    if (discValue is! String) {
      throw JsonValidationException('Discriminator property must be a string', [
        ...path,
        disc.propertyName,
      ]);
    }

    final matchedSchema = _findMatchingSchema(
      discValue,
      schema.subschemas,
      disc.mapping,
    );
    if (matchedSchema != null) {
      _validate(value, matchedSchema, path);
      return;
    } else {
      throw JsonValidationException(
        'Could not find matching schema for discriminator value "$discValue"',
        path,
      );
    }
  }

  var matchCount = 0;
  final errors = <JsonValidationException>[];
  for (final sub in schema.subschemas) {
    try {
      _validate(value, sub, path);
      matchCount++;
      break; // anyOf, first match is enough for runtime validation
    } on JsonValidationException catch (e) {
      errors.add(e);
    }
  }

  if (matchCount == 0) {
    throw JsonValidationException(
      'Value does not match any of the union schemas. Errors: ${errors.map((e) => e.message).join(', ')}',
      path,
    );
  }
}

Schema? _findMatchingSchema(
  String discValue,
  List<Schema> subschemas,
  Map<String, Schema>? mapping,
) {
  if (mapping != null) {
    final targetSchema = mapping[discValue];
    if (targetSchema != null) {
      for (final sub in subschemas) {
        if (sub.realSchema == targetSchema.realSchema) {
          return sub;
        }
      }
    }
  }

  for (final sub in subschemas) {
    final real = sub.realSchema;
    if (real.title == discValue) {
      return sub;
    }
    if (sub is RefSchema) {
      final lastSegment = sub.ref.split('/').last;
      if (lastSegment == discValue) {
        return sub;
      }
    }
  }
  return null;
}

void _validateAllOf(dynamic value, AllOfSchema schema, List<String> path) {
  for (final sub in schema.subschemas) {
    _validate(value, sub, path);
  }
}

bool _deepEquals(dynamic a, dynamic b) {
  if (identical(a, b)) return true;
  if (a is List && b is List) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!_deepEquals(a[i], b[i])) return false;
    }
    return true;
  }
  if (a is Map && b is Map) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key)) return false;
      if (!_deepEquals(a[key], b[key])) return false;
    }
    return true;
  }
  return a == b;
}
