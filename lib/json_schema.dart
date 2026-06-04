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

  /// Const constructor for subclass schemas.
  const Schema({this.title, this.description});
}

/// Represents an object type schema.
final class ObjectSchema extends Schema {
  /// Map of property names to their respective schemas.
  final Map<String, Schema> properties;

  /// Set of required property names.
  final Set<String> required;

  /// Schema for additional properties, if specified.
  final Schema? additionalProperties;

  /// Const constructor for object schemas.
  const ObjectSchema({
    required this.properties,
    required this.required,
    this.additionalProperties,
    super.title,
    super.description,
  });
}

/// Represents an array type schema wrapping its item schemas.
final class ArraySchema extends Schema {
  /// The schema of items in the array.
  final Schema items;

  /// Minimum number of items allowed in the array.
  final int? minItems;

  /// Maximum number of items allowed in the array.
  final int? maxItems;

  /// Whether items in the array must be unique.
  final bool? uniqueItems;

  /// Const constructor for array schemas.
  const ArraySchema({
    required this.items,
    this.minItems,
    this.maxItems,
    this.uniqueItems,
    super.title,
    super.description,
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

  /// The value must be a multiple of this number.
  final num? multipleOf;

  /// Const constructor for number schemas.
  const NumberSchema({
    required this.isInteger,
    this.minimum,
    this.maximum,
    this.multipleOf,
    super.title,
    super.description,
  });
}

/// Represents a boolean type schema.
final class BooleanSchema extends Schema {
  /// Const constructor for boolean schemas.
  const BooleanSchema({super.title, super.description});
}

/// Represents a null type schema.
final class NullSchema extends Schema {
  /// Const constructor for null schemas.
  const NullSchema({super.title, super.description});
}

/// Represents a reference schema pointing to another definition.
final class RefSchema extends Schema {
  /// The reference string, e.g. `#/definitions/Address`.
  final String ref;

  /// The resolved target schema, populated in the resolution pass.
  Schema? resolved;

  /// Constructor for reference schemas.
  RefSchema(this.ref, {super.title, super.description});
}

/// Represents a discriminator configuration for union parsing.
final class Discriminator {
  /// The property name to inspect.
  final String propertyName;

  /// Optional explicit mapping of discriminator values to schema references.
  final Map<String, String>? mapping;

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
  });
}

/// Fallback schema representing any JSON value.
final class AnythingSchema extends Schema {
  /// Const constructor for the fallback schema.
  const AnythingSchema({super.title, super.description});
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
  });
}

/// Represents a schema that never validates successfully (used for additionalProperties: false).
final class NeverSchema extends Schema {
  /// Const constructor for NeverSchema.
  const NeverSchema({super.title, super.description});
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

  /// Creates a parser for the given [rootJson] schema definition.
  SchemaParser(Map<String, dynamic> rootJson) : _rootJson = rootJson;

  /// Parses the schema structure and resolves all internal references.
  Schema parse() {
    final root = _parseSchema(_rootJson, '#');
    _resolveRefs(root);
    return root;
  }

  Schema _parseSchema(dynamic json, String path) {
    if (path.isNotEmpty && _cache.containsKey(path)) {
      return _cache[path]!;
    }

    if (json is! Map) {
      return const AnythingSchema();
    }

    if (json.containsKey(r'$ref')) {
      final ref = json[r'$ref'] as String;
      return RefSchema(ref);
    }

    final title = json['title'] as String?;
    final description = json['description'] as String?;

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

    if (json.containsKey('enum')) {
      final enumValues = (json['enum'] as List).toList();
      final jsonWithoutEnum = Map<String, dynamic>.from(json)..remove('enum');
      final baseSchema = _parseSchema(jsonWithoutEnum, '');
      final schema = EnumSchema(
        values: enumValues,
        baseSchema: baseSchema,
        title: title,
        description: description,
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

    if (json.containsKey('oneOf')) {
      final list = json['oneOf'] as List;
      final subschemas = list.map((item) => _parseSchema(item, '')).toList();
      schema = UnionSchema(
        subschemas: subschemas,
        discriminator: parseDiscriminator(json),
        title: title,
        description: description,
      );
    } else if (json.containsKey('anyOf')) {
      final list = json['anyOf'] as List;
      final subschemas = list.map((item) => _parseSchema(item, '')).toList();
      schema = UnionSchema(
        subschemas: subschemas,
        discriminator: parseDiscriminator(json),
        title: title,
        description: description,
      );
    } else {
      final typeVal = json['type'];
      if (typeVal is List) {
        final subschemas = typeVal.map((t) {
          final singleJson = Map<String, dynamic>.from(json)..['type'] = t;
          return _parseSchema(singleJson, '');
        }).toList();
        schema = UnionSchema(
          subschemas: subschemas,
          title: title,
          description: description,
        );
      } else {
        final type = typeVal as String?;
        switch (type) {
          case 'object':
            final properties = <String, Schema>{};
            if (json['properties'] is Map) {
              (json['properties'] as Map).forEach((key, value) {
                properties[key] = _parseSchema(value, '$path/properties/$key');
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
            schema = ObjectSchema(
              properties: properties,
              required: required,
              additionalProperties: additionalProperties,
              title: title,
              description: description,
            );
            break;
          case 'array':
            final itemsJson = json['items'];
            final items = itemsJson != null
                ? _parseSchema(itemsJson, '$path/items')
                : const AnythingSchema();
            schema = ArraySchema(
              items: items,
              minItems: json['minItems'] as int?,
              maxItems: json['maxItems'] as int?,
              uniqueItems: json['uniqueItems'] as bool?,
              title: title,
              description: description,
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
            );
            break;
          case 'number':
            schema = NumberSchema(
              isInteger: false,
              minimum: json['minimum'] as num?,
              maximum: json['maximum'] as num?,
              multipleOf: json['multipleOf'] as num?,
              title: title,
              description: description,
            );
            break;
          case 'integer':
            schema = NumberSchema(
              isInteger: true,
              minimum: json['minimum'] as num?,
              maximum: json['maximum'] as num?,
              multipleOf: json['multipleOf'] as num?,
              title: title,
              description: description,
            );
            break;
          case 'boolean':
            schema = BooleanSchema(title: title, description: description);
            break;
          case 'null':
            schema = NullSchema(title: title, description: description);
            break;
          default:
            schema = AnythingSchema(title: title, description: description);
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
      } else if (s is UnionSchema) {
        s.subschemas.forEach(visit);
      }
    }

    visit(root);
    _cache.values.forEach(visit);
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
  return text
      .split(RegExp(r'[^a-zA-Z0-9]+'))
      .where((s) => s.isNotEmpty)
      .map((s) => s[0].toUpperCase() + s.substring(1))
      .join('');
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
  final candidate = '$first$rest';

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

/// Computes the Dart type string for the given [schema].
String dartType(Schema schema, Map<Schema, String> classNames) {
  final real = schema.realSchema;
  if (real is ObjectSchema) {
    return classNames[real] ?? 'dynamic';
  } else if (real is ArraySchema) {
    return 'List<${dartType(real.items, classNames)}>';
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
    return name;
  } else if (real is EnumSchema) {
    return classNames[real] ?? 'dynamic';
  } else if (real is NeverSchema) {
    return 'Never';
  }
  return 'dynamic';
}

/// Generates code for reading a single non-array property value.
String generateReadExpression(
  Schema schema,
  String readerVar,
  Map<Schema, String> classNames, {
  String? validateExpr,
}) {
  final real = schema.realSchema;
  if (real is StringSchema) {
    return '$readerVar.expectString()';
  } else if (real is NumberSchema) {
    return real.isInteger ? '$readerVar.expectInt()' : '$readerVar.expectNum()';
  } else if (real is BooleanSchema) {
    return '$readerVar.expectBool()';
  } else if (real is NullSchema) {
    return '$readerVar.expectNull()';
  } else if (real is AnythingSchema) {
    return 'readAny($readerVar)';
  } else if (real is ObjectSchema) {
    final className = classNames[real]!;
    final suffix = validateExpr != null ? ', validate: $validateExpr' : '';
    return '$className.fromJson($readerVar$suffix)';
  } else if (real is UnionSchema) {
    final analysis = UnionAnalysis.analyze(real);
    if (analysis.isNullable && analysis.nonNullSchema != null) {
      return '$readerVar.checkNull() ? ($readerVar.expectNull() as dynamic) : ${generateReadExpression(analysis.nonNullSchema!, readerVar, classNames, validateExpr: validateExpr)}';
    }
    final className = classNames[real]!;
    final suffix = validateExpr != null ? ', validate: $validateExpr' : '';
    return '$className.fromJson($readerVar$suffix)';
  } else if (real is EnumSchema) {
    final className = classNames[real]!;
    final readBase = generateReadExpression(
      real.baseSchema,
      readerVar,
      classNames,
      validateExpr: validateExpr,
    );
    return '$className.fromValue($readBase)';
  }
  throw UnsupportedError(
    'Unsupported schema type for expression reading: ${real.runtimeType}',
  );
}

/// Generates statements to read a schema value (supporting nested arrays).
String generateReadExpressionOrStatements(
  Schema schema,
  String targetVar,
  String readerVar,
  Map<Schema, String> classNames, {
  int depth = 0,
  String? validateExpr,
}) {
  final real = schema.realSchema;
  if (real is ArraySchema) {
    final itemType = dartType(real.items, classNames);
    final itemVar = 'item\$depth';
    final childStatements = generateReadExpressionOrStatements(
      real.items,
      itemVar,
      readerVar,
      classNames,
      depth: depth + 1,
      validateExpr: validateExpr,
    );
    return '''
      $readerVar.expectArray();
      final list\$depth = <$itemType>[];
      var index\$depth = 0;
      while ($readerVar.hasNext()) {
        try {
          final $itemType $itemVar;
          $childStatements
          list\$depth.add($itemVar);
        } on FormatException catch (e) {
          throw wrapException(e, '[\${index\$depth}]');
        } on JsonValidationException catch (e) {
          throw JsonValidationException(e.message, ['[\${index\$depth}]', ...e.path]);
        }
        index\$depth++;
      }
      $targetVar = list\$depth;
    ''';
  }
  return '$targetVar = ${generateReadExpression(schema, readerVar, classNames, validateExpr: validateExpr)};';
}

/// Generates statements to write a schema value to a JsonSink.
String generateWriteStatements(
  Schema schema,
  String valueVar,
  String sinkVar, {
  int depth = 0,
}) {
  final real = schema.realSchema;
  if (real is UnionSchema) {
    final analysis = UnionAnalysis.analyze(real);
    if (analysis.isNullable && analysis.nonNullSchema != null) {
      return generateWriteStatements(
        analysis.nonNullSchema!,
        valueVar,
        sinkVar,
        depth: depth,
      );
    }
  }
  if (real is StringSchema) {
    return '$sinkVar.addString($valueVar);';
  } else if (real is NumberSchema) {
    return '$sinkVar.addNumber($valueVar);';
  } else if (real is BooleanSchema) {
    return '$sinkVar.addBool($valueVar);';
  } else if (real is NullSchema) {
    return '$sinkVar.addNull();';
  } else if (real is AnythingSchema) {
    return 'writeAny($sinkVar, $valueVar);';
  } else if (real is ObjectSchema || real is UnionSchema) {
    return '$valueVar.writeJson($sinkVar);';
  } else if (real is EnumSchema) {
    return generateWriteStatements(
      real.baseSchema,
      '$valueVar.value',
      sinkVar,
      depth: depth,
    );
  } else if (real is ArraySchema) {
    final itemVar = 'item\$depth';
    final writeItem = generateWriteStatements(
      real.items,
      itemVar,
      sinkVar,
      depth: depth + 1,
    );
    return '''
      $sinkVar.startArray();
      for (final $itemVar in $valueVar) {
        $writeItem
      }
      $sinkVar.endArray();
    ''';
  }
  return '';
}

abstract class SchemaDescriptor<T> {
  const SchemaDescriptor();
}

class ObjectDescriptor<T> extends SchemaDescriptor<T> {
  final String title;
  final T Function(Map<String, dynamic> fields) instantiate;
  final Map<String, PropertyDescriptor> properties;
  final List<String> required;
  final SchemaDescriptor? additionalProperties;
  final Map<String, Object?> Function(dynamic instance) getFields;
  final bool Function(dynamic instance) matches;

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

class PropertyDescriptor {
  final String name;
  final SchemaDescriptor schema;
  final bool isRequired;

  const PropertyDescriptor({
    required this.name,
    required this.schema,
    this.isRequired = false,
  });
}

abstract class PrimitiveDescriptor<T> extends SchemaDescriptor<T> {
  const PrimitiveDescriptor();
  T read(JsonReader reader);
  void write(JsonSink sink, T value);
}

class StringDescriptor extends PrimitiveDescriptor<String> {
  const StringDescriptor();
  @override
  String read(JsonReader reader) => reader.expectString();
  @override
  void write(JsonSink sink, String value) => sink.addString(value);
}

class IntDescriptor extends PrimitiveDescriptor<int> {
  const IntDescriptor();
  @override
  int read(JsonReader reader) => reader.expectInt();
  @override
  void write(JsonSink sink, int value) => sink.addNumber(value);
}

class NumDescriptor extends PrimitiveDescriptor<num> {
  const NumDescriptor();
  @override
  num read(JsonReader reader) => reader.expectNum();
  @override
  void write(JsonSink sink, num value) => sink.addNumber(value);
}

class BoolDescriptor extends PrimitiveDescriptor<bool> {
  const BoolDescriptor();
  @override
  bool read(JsonReader reader) => reader.expectBool();
  @override
  void write(JsonSink sink, bool value) => sink.addBool(value);
}

class NullDescriptor extends PrimitiveDescriptor<Null> {
  const NullDescriptor();
  @override
  Null read(JsonReader reader) => reader.expectNull();
  @override
  void write(JsonSink sink, Null value) => sink.addNull();
}

class AnythingDescriptor extends SchemaDescriptor<dynamic> {
  const AnythingDescriptor();
}

class NullableDescriptor<T> extends SchemaDescriptor<T?> {
  final SchemaDescriptor<T> inner;
  const NullableDescriptor(this.inner);
}

class ArrayDescriptor<T> extends SchemaDescriptor<List<T>> {
  final SchemaDescriptor<T> items;
  const ArrayDescriptor(this.items);

  _JsonParseFrame createFrame({required bool validate}) =>
      _ArrayFrame<T>(this, validate: validate);
}

class EnumDescriptor<T> extends SchemaDescriptor<T> {
  final List<T> values;
  final T Function(dynamic val) fromValue;
  final dynamic Function(dynamic val) toValue;
  final PrimitiveDescriptor base;

  const EnumDescriptor({
    required this.values,
    required this.fromValue,
    required this.toValue,
    required this.base,
  });
}

class UnionOptionDescriptor<T, V> {
  final SchemaDescriptor<V> schema;
  final T Function(V val) wrap;
  const UnionOptionDescriptor(this.schema, this.wrap);
}

class UnionDescriptor<T> extends SchemaDescriptor<T> {
  final String title;
  final String? discriminatorProperty;
  final Map<String, UnionOptionDescriptor<T, dynamic>>? discriminatorMapping;
  final List<UnionOptionDescriptor<T, dynamic>> activeOptions;

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
      stack.removeLast();
      if (stack.isNotEmpty) {
        stack.last.resume(_result);
      }
      return false;
    }
  }
}

class _ArrayFrame<T> extends _JsonParseFrame {
  final ArrayDescriptor<T> desc;
  final bool validate;
  final List<T> list = [];
  bool _initialized = false;
  int index = 0;
  dynamic _result;

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
      _pushSchemaFrame(reader, stack, desc.items, (val) {
        list.add(val as T);
        index++;
      }, validate: validate);
      return false;
    } else {
      _result = list;
      stack.removeLast();
      if (stack.isNotEmpty) {
        stack.last.resume(_result);
      }
      return false;
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
      stack.removeLast();
      if (stack.isNotEmpty) {
        stack.last.resume(_result);
      }
      return false;
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
      FormatException? lastException;
      for (final option in desc.activeOptions) {
        final rCopy = reader.copy();
        try {
          _runNonRecursiveWithDescriptor(rCopy, option.schema, validate: false);
          _pendingOption = option;
          _pushSchemaFrame(reader, stack, option.schema, (val) {
            _result = option.wrap(val);
            _pendingOption = null;
          }, validate: validate);
          return false;
        } on FormatException catch (e) {
          lastException = e;
        }
      }
      throw reader.fail(
        'Failed to parse ${desc.title} union. Last error: ${lastException?.message}',
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
    onComplete(schema.fromValue(schema.base.read(reader)));
  } else if (schema is ObjectDescriptor) {
    stack.add(_ObjectFrame(schema, validate: validate));
  } else if (schema is ArrayDescriptor) {
    stack.add(schema.createFrame(validate: validate));
  } else if (schema is UnionDescriptor) {
    stack.add(_UnionFrame(schema, validate: validate));
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
  } else if (rootSchema is AnythingDescriptor) {
    return readAny(reader);
  } else if (rootSchema is EnumDescriptor) {
    return rootSchema.fromValue(rootSchema.base.read(reader));
  }

  final rootFrame = _createFrameForSchema(rootSchema, validate: validate);
  final stack = <_JsonParseFrame>[rootFrame];
  try {
    while (stack.isNotEmpty) {
      final current = stack.last;
      final isComplete = current.execute(reader, stack);
      if (isComplete) {
        stack.removeLast();
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
    return schema.createFrame(validate: validate);
  } else if (schema is UnionDescriptor) {
    return _UnionFrame(schema, validate: validate);
  }
  throw UnsupportedError('Primitive schemas do not require frame creation.');
}

dynamic parseWithDescriptor(
  JsonReader reader,
  SchemaDescriptor schema, {
  bool validate = true,
}) {
  if (schema is NullableDescriptor) {
    if (reader.checkNull()) {
      reader.expectNull();
      return null;
    }
    return parseWithDescriptor(reader, schema.inner, validate: validate);
  }
  if (schema is PrimitiveDescriptor) {
    return schema.read(reader);
  } else if (schema is AnythingDescriptor) {
    return readAny(reader);
  } else if (schema is EnumDescriptor) {
    return schema.fromValue(schema.base.read(reader));
  }
  return _runNonRecursiveWithDescriptor(reader, schema, validate: validate);
}

void writeWithDescriptor<T>(
  JsonSink sink,
  T value,
  SchemaDescriptor<T> schema,
) {
  _writeSchemaValue(sink, value, schema);
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
  } else if (schema is AnythingDescriptor) {
    _writeAny(sink, value);
  } else if (schema is EnumDescriptor) {
    final backingVal = schema.toValue(value);
    schema.base.write(sink, backingVal);
  } else if (schema is ArrayDescriptor) {
    sink.startArray();
    if (value is List) {
      for (final item in value) {
        _writeSchemaValue(sink, item, schema.items);
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
    sink.endObject();
  } else if (schema is UnionDescriptor) {
    if (value is JsonWritable) {
      value.writeJson(sink);
    }
  }
}

void _writeAny(JsonSink sink, Object? value) {
  if (value == null) {
    sink.addNull();
  } else if (value is String) {
    sink.addString(value);
  } else if (value is num) {
    sink.addNumber(value);
  } else if (value is bool) {
    sink.addBool(value);
  } else if (value is List) {
    sink.startArray();
    for (final item in value) {
      _writeAny(sink, item);
    }
    sink.endArray();
  } else if (value is Map<String, dynamic>) {
    sink.startObject();
    value.forEach((k, v) {
      sink.addKey(k);
      _writeAny(sink, v);
    });
    sink.endObject();
  } else if (value is JsonWritable) {
    value.writeJson(sink);
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
      final name = real.title ?? preferredName;
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
    } else if (real is UnionSchema) {
      final analysis = UnionAnalysis.analyze(real);
      if (analysis.isNullable && analysis.nonNullSchema != null) {
        discoverClasses(analysis.nonNullSchema!, preferredName);
        return;
      }
      if (classNames.containsKey(real)) return;
      final name = real.title ?? preferredName;
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
        discoverClasses(sub, '${candidate}_Option$index');
        index++;
      }
    } else if (real is EnumSchema) {
      if (classNames.containsKey(real)) return;
      final name = real.title ?? preferredName;
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

/// Generates a Dart enum class representation for an EnumSchema.
String _generateEnumClass(EnumSchema schema, String className) {
  final buffer = StringBuffer();

  // Detect backing type
  final isString = schema.values.every((v) => v is String);
  final isInt = schema.values.every((v) => v is int);
  final backingType = isString ? 'String' : (isInt ? 'int' : 'dynamic');

  buffer.writeln('enum $className {');
  for (final val in schema.values) {
    var enumName = toCamelCase(val.toString());
    if (isKeyword(enumName) || int.tryParse(enumName[0]) != null) {
      enumName = 'val${toPascalCase(val.toString())}';
    }
    final formattedValue = isString ? "'$val'" : '$val';
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
  const keywords = {
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
    'typedef',
    'var',
    'void',
    'yield',
  };
  return keywords.contains(s);
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
  } else if (real is ArraySchema) {
    return 'ArrayDescriptor(${_descriptorExpr(real.items, classNames)})';
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

String _generateObjectClass(
  ObjectSchema schema,
  String className,
  Map<Schema, String> classNames,
) {
  final fields = StringBuffer();
  final constructorParams = StringBuffer();
  final equalityProps = <String>[];
  final toStringProps = <String>[];
  final copyWithParams = StringBuffer();
  final copyWithArgs = StringBuffer();

  schema.properties.forEach((name, propSchema) {
    final fieldName = toCamelCase(name);
    final isRequired = schema.required.contains(name);
    final baseType = dartType(propSchema, classNames);
    final fieldType = isRequired
        ? baseType
        : (baseType.endsWith('?') ||
                  baseType == 'dynamic' ||
                  baseType == 'Object?'
              ? baseType
              : '$baseType?');

    fields.writeln('  final $fieldType $fieldName;');
    if (isRequired) {
      constructorParams.writeln('    required this.$fieldName,');
    } else {
      constructorParams.writeln('    this.$fieldName,');
    }

    final copyWithType = baseType.endsWith('?') ? baseType : '$baseType?';
    copyWithParams.writeln('    $copyWithType $fieldName,');
    copyWithArgs.writeln('    $fieldName: $fieldName ?? this.$fieldName,');

    equalityProps.add('$fieldName == other.$fieldName');
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
      'additionalProperties.length == other.additionalProperties.length && additionalProperties.keys.every((k) => other.additionalProperties.containsKey(k) && other.additionalProperties[k] == additionalProperties[k])',
    );
    toStringProps.add('additionalProperties: \${additionalProperties}');
  }

  final equalityExpr = equalityProps.isEmpty
      ? 'true'
      : equalityProps.join(' && ');

  final hashFields = schema.properties.keys
      .map((name) => toCamelCase(name))
      .toList();
  if (hasAdditionalProps) {
    hashFields.add(
      'additionalProperties.entries.fold<int>(0, (sum, entry) => sum ^ Object.hash(entry.key, entry.value))',
    );
  }

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
    final isRequired = schema.required.contains(name);
    final descExpr = _descriptorExpr(propSchema, classNames);

    propDescriptors.writeln(
      "      '$name': PropertyDescriptor(name: '$name', isRequired: $isRequired, schema: $descExpr),",
    );
    getFieldsMap.writeln("      '$name': instance.$fieldName,");

    final baseType = dartType(propSchema, classNames);
    if (isRequired) {
      instantiateArgs.writeln(
        "        $fieldName: fields['$name'] as $baseType,",
      );
    } else {
      final fieldType = baseType.endsWith('?') ? baseType : '$baseType?';
      instantiateArgs.writeln(
        "        $fieldName: fields['$name'] as $fieldType,",
      );
    }
  });

  if (hasAdditionalProps) {
    getFieldsMap.writeln("      ...instance.additionalProperties,");
    final addPropsType = dartType(schema.additionalProperties!, classNames);
    instantiateArgs.writeln(
      "        additionalProperties: fields.entries.where((e) => !descriptor.properties.containsKey(e.key)).fold<Map<String, $addPropsType>>({}, (m, e) => m..[e.key] = e.value as $addPropsType),",
    );
  }

  String? addPropsExpr;
  if (hasAdditionalProps) {
    addPropsExpr = _descriptorExpr(schema.additionalProperties!, classNames);
  }

  final descriptorString =
      '''
  static final descriptor = ObjectDescriptor<$className>(
    title: '$className',
    matches: (instance) => instance is $className,
    instantiate: (fields) => $className(
$instantiateArgs    ),
    getFields: (instance) => {
$getFieldsMap    },
    properties: {
$propDescriptors    },
    required: const [${schema.required.map((r) => "'$r'").join(', ')}],
    ${addPropsExpr != null ? 'additionalProperties: $addPropsExpr,' : ''}
  );''';

  return '''
final class $className implements JsonModel {
$fields
  const $className({
$constructorParams  });

  factory $className.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as $className;

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  $className copyWith({
$copyWithParams  }) => $className(
$copyWithArgs  );

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
        ${hashFields.join(',\n        ')}
      ]);

  @override
  String toString() => '$className(${toStringProps.join(', ')})';
}
''';
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
  schema.properties.forEach((name, propSchema) {
    final fieldName = toCamelCase(name);
    final isRequired = schema.required.contains(name);
    final real = propSchema.realSchema;
    final isNullable =
        !isRequired || dartType(propSchema, classNames).endsWith('?');

    final valueVar = isNullable ? 'val_$fieldName' : fieldName;
    final validations = StringBuffer();

    if (real is StringSchema) {
      if (real.minLength != null) {
        validations.writeln(
          '      if ($valueVar.length < ${real.minLength}) {',
        );
        validations.writeln(
          "        throw JsonValidationException('Property \"$name\" length must be >= ${real.minLength}', ['$name']);",
        );
        validations.writeln('      }');
      }
      if (real.maxLength != null) {
        validations.writeln(
          '      if ($valueVar.length > ${real.maxLength}) {',
        );
        validations.writeln(
          "        throw JsonValidationException('Property \"$name\" length must be <= ${real.maxLength}', ['$name']);",
        );
        validations.writeln('      }');
      }
      if (real.pattern != null) {
        final patternEscaped = real.pattern!.replaceAll("'", r"\'");
        final msgPatternEscaped = real.pattern!
            .replaceAll(r'$', r'\$')
            .replaceAll("'", r"\'")
            .replaceAll('"', '\\"');
        validations.writeln('''
      if (!RegExp(r'$patternEscaped').hasMatch($valueVar)) {
        throw JsonValidationException('Property "$name" must match pattern "$msgPatternEscaped"', ['$name']);
      }''');
      }
      if (real.format != null) {
        _generateFormatValidation(validations, valueVar, real.format!, name);
      }
    } else if (real is NumberSchema) {
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
      if (real.multipleOf != null) {
        if (real.isInteger) {
          validations.writeln(
            '      if ($valueVar % ${real.multipleOf} != 0) {',
          );
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
          '      if ($valueVar.length != $valueVar.toSet().length) {',
        );
        validations.writeln(
          "        throw JsonValidationException('Property \"$name\" items must be unique', ['$name']);",
        );
        validations.writeln('      }');
      }
      final hasItemValidation = _hasValidationMethod(real.items);
      if (hasItemValidation) {
        validations.writeln('''
      for (var i = 0; i < $valueVar.length; i++) {
        try {
          $valueVar[i].validate();
        } on JsonValidationException catch (e) {
          throw JsonValidationException(e.message, ['$name', '[\$i]', ...e.path]);
        }
      }''');
      }
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

    if (validations.isNotEmpty) {
      if (isNullable) {
        buffer.writeln('    final val_$fieldName = $fieldName;');
        buffer.writeln('    if (val_$fieldName != null) {');
        buffer.write(validations.toString());
        buffer.writeln('    }');
      } else {
        buffer.write(validations.toString());
      }
    }
  });

  final hasAdditionalProps =
      schema.additionalProperties != null &&
      schema.additionalProperties is! NeverSchema;
  if (hasAdditionalProps) {
    final hasAddValidation = _hasValidationMethod(schema.additionalProperties!);
    if (hasAddValidation) {
      buffer.writeln('''
    additionalProperties.forEach((key, value) {
      try {
        value.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [key, ...e.path]);
      }
    });''');
    }
  }

  buffer.writeln('  }');
  return buffer.toString();
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
      validations.writeln('      final parsedUri = Uri.tryParse($valueVar);');
      validations.writeln(
        '      if (parsedUri == null || !parsedUri.hasScheme) {',
      );
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid absolute URI', ['$name']);",
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
      validationBody.writeln('  @override');
      validationBody.writeln('  void validate() {}');
    }

    final descExpr = _descriptorExpr(sub, classNames);

    subclasses.writeln('''
final class $subClassName extends $className {
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
          value == other.value;

  @override
  int get hashCode => value.hashCode;

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
    optionDescriptors.writeln(
      "      UnionOptionDescriptor<$className, dynamic>($descExpr, (val) => $subClassName(val)),",
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
        disc.mapping!.forEach((discVal, targetStr) {
          final lastSegment = targetStr.split('/').last;
          if (optionType.toLowerCase().endsWith(lastSegment.toLowerCase())) {
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
          "      '$label': UnionOptionDescriptor<$className, dynamic>(${_descriptorExpr(sub, classNames)}, (val) => $subClassName(val)),",
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

  return '''
sealed class $className implements JsonModel {
  const $className();

  factory $className.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as $className;

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

$descriptorString
}

$subclasses
''';
}
