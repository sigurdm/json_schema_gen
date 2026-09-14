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

import 'package:path/path.dart' as p;
import 'schema.dart';

/// Callback that resolves a JSON Schema [schemaUri] to an import URI string for generated Dart code.
///
/// Returns the Dart import path (such as a relative path `'b.g.dart'` or package URI
/// `'package:my_pkg/b.g.dart'`), or `null` if the referenced schema cannot be resolved
/// to an external Dart library or should fall back to inlining.
///
/// Preconditions:
/// - [schemaUri] must not be empty.
///
/// Reference:
/// - See [JSON Schema Draft 2020-12](https://json-schema.org/draft/2020-12/json-schema-core.html#section-8.2)
///   for details on schema identification and `$ref` resolution.
typedef DartImportResolver = String? Function(Uri schemaUri);

/// Derives the canonical Dart class name for a definition [schema].
///
/// Preconditions:
/// - [schema] must not be null.
///
/// Returns the name derived from `x-dart-name`, `title`, `definitionKey`,
/// [definitionKey], or `'Model'`, formatted in PascalCase.
String getDefinitionClassName(Schema schema, {String? definitionKey}) {
  final real = schema.realSchema;
  var name =
      real.dartName ??
      schema.dartName ??
      real.title ??
      schema.title ??
      real.definitionKey ??
      schema.definitionKey ??
      definitionKey;
  if (name == null) {
    final refStr = schema.ref ?? schema.resolvedRef?.ref;
    if (refStr != null) {
      final uri = Uri.tryParse(refStr);
      if (uri != null) {
        if (uri.hasFragment && uri.fragment.isNotEmpty) {
          final segments = uri.fragment
              .split('/')
              .where((s) => s.isNotEmpty)
              .toList();
          if (segments.isNotEmpty) {
            name = Uri.decodeComponent(segments.last);
          }
        } else if (uri.path.isNotEmpty) {
          final base = p.basenameWithoutExtension(uri.path);
          name = base.endsWith('.schema')
              ? p.basenameWithoutExtension(base)
              : base;
        }
      }
    }
  }
  name ??= 'Model';
  final result = toPascalCase(name);
  return result.isEmpty ? 'Model' : result;
}

/// Formats a name string into PascalCase for Dart class names.
///
/// Preconditions:
/// - [text] must not be null.
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
///
/// Preconditions:
/// - [text] must not be null.
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

/// Escapes [value] for embedding inside a single-quoted Dart string literal,
/// without adding the surrounding quotes.
///
/// Use this when the text is interpolated into a larger generated literal, for
/// example an error message like `'Property "$name" is required'`. When you
/// need a complete literal, use [dartStringLiteral] instead.
///
/// Escapes every character that is significant inside a Dart string literal:
/// backslashes, single quotes, `$` (which would otherwise begin a string
/// interpolation), and control characters that cannot appear literally.
///
/// All schema-derived text — property names, `pattern` values, `title`s,
/// deprecation messages — must pass through this function before being written
/// into generated code. Ad-hoc escaping at the call site has historically
/// produced output that either failed to compile or let schema content inject
/// arbitrary Dart.
String escapeStringContents(String value) {
  final buffer = StringBuffer();
  for (final rune in value.runes) {
    if (rune == 0x5C) {
      buffer.write(r'\\'); // backslash
    } else if (rune == 0x27) {
      buffer.write(r"\'"); // single quote
    } else if (rune == 0x24) {
      buffer.write(r'\$'); // dollar sign (interpolation)
    } else if (rune == 0x0A) {
      buffer.write(r'\n');
    } else if (rune == 0x0D) {
      buffer.write(r'\r');
    } else if (rune == 0x09) {
      buffer.write(r'\t');
    } else if (rune < 0x20 || rune == 0x7F) {
      buffer.write('\\u{${rune.toRadixString(16)}}');
    } else {
      buffer.writeCharCode(rune);
    }
  }
  return buffer.toString();
}

/// Renders [value] as a complete single-quoted Dart string literal, safe to
/// embed directly in generated source.
///
/// See [escapeStringContents] for the escaping rules.
String dartStringLiteral(String value) => "'${escapeStringContents(value)}'";

/// Type names that a generated class must never shadow.
///
/// Generated libraries reference these types unqualified, so a schema whose
/// `title` collides with one of them would otherwise emit code that fails to
/// compile (for example a schema titled `List` produced
/// `The type 'List' is declared with 0 type parameters`). Names here are
/// reserved up-front so the normal de-duplication counter renames the class.
const _reservedTypeNames = {
  // dart:core
  'BigInt', 'bool', 'Comparable', 'DateTime', 'Deprecated', 'double',
  'Duration', 'dynamic', 'Enum', 'Error', 'Exception', 'Function',
  'Future', 'int', 'Iterable', 'Iterator', 'List', 'Map', 'MapEntry',
  'Match', 'Never', 'Null', 'num', 'Object', 'Pattern', 'Record',
  'RegExp', 'Runes', 'Set', 'StackTrace', 'Stream', 'String',
  'StringBuffer', 'StringSink', 'Symbol', 'Type', 'Uri', 'UriData',
  // dart:collection (imported when the output uses LinkedHashSet)
  'HashMap', 'HashSet', 'LinkedHashMap', 'LinkedHashSet', 'ListQueue',
  'Queue', 'SplayTreeMap', 'SplayTreeSet', 'UnmodifiableListView',
  'UnmodifiableMapView',
  // package:collection
  'DeepCollectionEquality', 'ListEquality', 'MapEquality', 'SetEquality',
  // package:jsontool
  'JsonReader', 'JsonSink', 'JsonWriter',
  // package:json_schema_gen runtime surface referenced by generated code
  'AnythingDescriptor', 'ArrayDescriptor', 'BoolDescriptor',
  'EnumDescriptor', 'IntDescriptor', 'JsonModel', 'JsonParseException',
  'JsonValidationException', 'NeverDescriptor', 'NotDescriptor',
  'NullableDescriptor', 'NullDescriptor', 'NumDescriptor',
  'ObjectDescriptor', 'PrimitiveDescriptor', 'PropertyDescriptor',
  'RefDescriptor', 'SchemaDescriptor', 'StringDescriptor',
  'UnionDescriptor', 'UnionOptionDescriptor', 'ValidationError',
};

const _reservedMemberNames = {
  'validate',
  'collectErrors',
  'writeJson',
  'toJson',
  'hashCode',
  'runtimeType',
  'noSuchMethod',
  'toString',
  'copyWith',
  'toMap',
  'toJsonValue',
  'descriptor',
  'additionalProperties',
  'patternProperties',
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

String _arrayElementType(Schema schema, Map<Schema, String> classNames) {
  if (schema.prefixItems == null || schema.prefixItems!.isEmpty) {
    return dartType(schema.items ?? Schema.anything, classNames);
  }
  final types = <String>{};
  for (final item in schema.prefixItems!) {
    types.add(dartType(item, classNames));
  }
  types.add(dartType(schema.items ?? Schema.anything, classNames));
  if (types.length == 1) {
    return types.first;
  }
  return 'dynamic';
}

/// Computes the Dart type string for the given [schema].
///
/// Preconditions:
/// - [schema] must not be null.
/// - [classNames] must not be null.
String dartType(Schema schema, Map<Schema, String> classNames) {
  final real = schema.realSchema;
  if (real.isUnion) {
    final analysis = UnionAnalysis.analyze(real);
    final baseType = analysis.nonNullSchema != null
        ? dartType(analysis.nonNullSchema!, classNames)
        : (classNames[real] ?? 'dynamic');
    return analysis.isNullable ? '$baseType?' : baseType;
  } else if (real.enumValues != null) {
    return classNames[real] ?? _enumBackingType(real);
  } else if (real.isObject) {
    return classNames[real] ?? 'Map<String, dynamic>';
  } else if (real.isArray) {
    final elementType = _arrayElementType(real, classNames);
    return 'List<$elementType>';
  } else if (real.isString) {
    return 'String';
  } else if (real.isNumber) {
    return real.isInteger ? 'int' : 'num';
  } else if (real.isBoolean) {
    return 'bool';
  } else if (real.isNull) {
    return 'Null';
  } else if (real.isAnything) {
    return 'Object?';
  } else if (real.isNever) {
    return 'Never';
  } else if (real.allOf != null) {
    return 'dynamic';
  }
  return 'dynamic';
}

final class _GeneratorContext {
  final Map<Schema, String> classNames;
  final Map<Schema, Map<dynamic, String>> enumConstantNames = {};
  final Map<Schema, Map<String, String>> objectFieldNames = {};

  _GeneratorContext(this.classNames);

  String toEnumConstantName(Object? val, [Schema? schema]) {
    if (schema != null) {
      final names = enumConstantNames[schema];
      if (names != null) {
        final name = names[val];
        if (name != null) return name;
      }
    }
    return _toEnumConstantName(val);
  }

  Map<String, String> fieldNamesFor(Schema schema) {
    return objectFieldNames[schema] ?? _calculateFieldNames(schema);
  }
}

Map<dynamic, String> _calculateEnumConstantNames(Schema schema) {
  final names = <dynamic, String>{};
  final used = <String>{'values', 'value', 'fromValue', 'descriptor'};

  for (final val in schema.enumValues!) {
    var baseName = _toEnumConstantName(val);
    var name = baseName;
    int counter = 1;
    while (used.contains(name)) {
      name = '${baseName}_$counter';
      counter++;
    }
    used.add(name);
    names[val] = name;
  }
  return names;
}

Map<String, String> _calculateFieldNames(Schema schema) {
  final fieldNames = <String, String>{};
  final usedFieldNames = <String>{};
  usedFieldNames.addAll(_reservedMemberNames);

  schema.properties?.forEach((name, propSchema) {
    final baseName = toCamelCase(name);
    var fieldName = baseName;
    int counter = 1;
    while (usedFieldNames.contains(fieldName)) {
      fieldName = '${baseName}_$counter';
      counter++;
    }
    usedFieldNames.add(fieldName);
    fieldNames[name] = fieldName;
  });
  return fieldNames;
}

/// Entry point to generate code for a parsed JSON Schema.
///
/// Preconditions:
/// - [rootSchema] must not be null.
/// - [rootName] must not be empty.
///
/// It is an error if [rootName] is empty.
///
/// If [dartImportResolver] is provided, external `$ref`s pointing to another
/// document will be resolved to imported Dart libraries instead of being inlined,
/// unless inlining is requested explicitly via `x-dart-inline: true`.
String generateCode(
  Schema rootSchema,
  String rootName, {
  DartImportResolver? dartImportResolver,
}) {
  if (rootName.isEmpty) {
    throw ArgumentError.value(rootName, 'rootName', 'Must not be empty.');
  }
  _resolveDynamicRefs(rootSchema, rootSchema);
  final classNames = Map<Schema, String>.identity();
  // Seeded with the types that generated libraries reference unqualified, so
  // that a schema titled e.g. `List` or `Object` is renamed instead of
  // shadowing the real type and producing code that does not compile.
  final usedNames = <String>{..._reservedTypeNames};
  final localClasses = <Schema>{};
  final importPrefixes = <String, String>{};

  bool tryHandleExternalRef(Schema schema) {
    if (dartImportResolver == null) return false;
    if (schema.dartInline == true) return false;
    if (schema.resolvedRef?.dartInline == true) return false;
    if (schema.realSchema.dartInline == true) return false;

    final ref = schema.ref ?? schema.dynamicRef;
    if (ref == null || ref.startsWith('#')) return false;

    final realTarget = schema.realSchema;
    final generatesType =
        realTarget.enumValues != null ||
        realTarget.isObject ||
        (realTarget.isUnion &&
            !(UnionAnalysis.analyze(realTarget).isNullable &&
                UnionAnalysis.analyze(realTarget).nonNullSchema != null));
    if (!generatesType) {
      return false;
    }

    final uri = Uri.tryParse(ref);
    if (uri == null) return false;

    final docUriStr =
        schema.resolvedRef?.documentUri ??
        (uri.hasFragment ? uri.removeFragment().toString() : uri.toString());
    final targetDocUri = Uri.tryParse(docUriStr);
    if (targetDocUri == null) return false;

    if (rootSchema.documentUri != null &&
        targetDocUri.toString() == rootSchema.documentUri) {
      return false;
    }

    final importPath = dartImportResolver(targetDocUri);
    if (importPath == null || importPath.isEmpty) {
      return false;
    }

    final prefix = importPrefixes.putIfAbsent(
      importPath,
      () => 'i${importPrefixes.length + 1}',
    );

    final className = getDefinitionClassName(schema);
    final fullName = '$prefix.$className';
    classNames[realTarget] = fullName;
    classNames[schema] = fullName;
    if (schema.resolvedRef != null) {
      classNames[schema.resolvedRef!] = fullName;
    }

    return true;
  }

  /// Recursively traverses the schema to discover all subschemas that need to be
  /// generated as separate Dart classes (e.g., objects, enums, unions).
  ///
  /// It assigns unique, valid Dart class names to these schemas, storing them in
  /// the [classNames] map.
  ///
  /// Name resolution and deduplication process:
  /// 1. A candidate name is derived from `x-dart-name`, the schema `title`, or a `preferredName` passed from the parent.
  /// 2. The name is normalized to PascalCase.
  /// 3. If the candidate name is empty, a fallback (like 'Enum' or 'Object') is used.
  /// 4. To avoid name collisions, the candidate name is checked against [usedNames] (already assigned class names)
  ///    and Dart keywords. If a collision is found, a counter is appended (e.g., `ClassName1`, `ClassName2`) until a unique name is found.
  /// 5. The resolved unique name is added to [usedNames] to reserve it.
  void discoverClasses(Schema schema, String preferredName) {
    final real = schema.realSchema;
    if (classNames.containsKey(real)) return;

    if (tryHandleExternalRef(schema)) {
      return;
    }

    if (real.enumValues != null) {
      final name =
          real.dartName ?? real.title ?? real.definitionKey ?? preferredName;
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
      localClasses.add(real);
      discoverClasses(real.removeEnum(), '${candidate}_Base');
    } else if (real.isUnion) {
      final analysis = UnionAnalysis.analyze(real);
      if (analysis.isNullable && analysis.nonNullSchema != null) {
        discoverClasses(analysis.nonNullSchema!, preferredName);
        return;
      }
      final name =
          real.dartName ?? real.title ?? real.definitionKey ?? preferredName;
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
      localClasses.add(real);

      int index = 0;
      for (final sub in analysis.activeSchemas) {
        discoverClasses(sub, '${candidate}_OptionType$index');
        index++;
      }
    } else if (real.isObject) {
      final name =
          real.dartName ?? real.title ?? real.definitionKey ?? preferredName;
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
      localClasses.add(real);

      real.properties?.forEach((propName, propSchema) {
        discoverClasses(propSchema, '${candidate}_$propName');
      });
      real.patternProperties?.forEach((pattern, propSchema) {
        discoverClasses(propSchema, '${candidate}_PatternProperty');
      });
      if (real.additionalProperties != null) {
        discoverClasses(
          real.additionalProperties!,
          '${candidate}_AdditionalProperty',
        );
      }
    } else if (real.isArray) {
      discoverClasses(real.items ?? Schema.anything, '${preferredName}Item');
      if (real.contains != null) {
        discoverClasses(real.contains!, '${preferredName}Contains');
      }
      if (real.prefixItems != null) {
        for (var i = 0; i < real.prefixItems!.length; i++) {
          discoverClasses(real.prefixItems![i], '${preferredName}Prefix$i');
        }
      }
    }
    if (schema.not != null) {
      discoverClasses(schema.not!, '${preferredName}_Not');
    }
  }

  discoverClasses(rootSchema, rootName);

  void discoverDefs(Schema schema) {
    schema.defs?.forEach((key, defSchema) {
      final candidateName = getDefinitionClassName(
        defSchema,
        definitionKey: key,
      );
      discoverClasses(defSchema, candidateName);
      discoverDefs(defSchema);
    });
    schema.definitions?.forEach((key, defSchema) {
      final candidateName = getDefinitionClassName(
        defSchema,
        definitionKey: key,
      );
      discoverClasses(defSchema, candidateName);
      discoverDefs(defSchema);
    });
  }

  final isStandaloneDefLibrary =
      rootSchema.properties == null || rootSchema.properties!.isEmpty;
  if (isStandaloneDefLibrary) {
    discoverDefs(rootSchema);
  }

  final context = _GeneratorContext(classNames);
  classNames.forEach((schema, name) {
    if (schema.enumValues != null) {
      context.enumConstantNames[schema] = _calculateEnumConstantNames(schema);
    } else if (schema.isObject) {
      context.objectFieldNames[schema] = _calculateFieldNames(schema);
    }
  });

  // Generate the class bodies first so the import list can be tailored to
  // what the output actually references.
  final body = StringBuffer();
  for (final schema in localClasses) {
    final name = classNames[schema]!;
    if (schema.enumValues != null) {
      body.writeln(_generateEnumClass(schema, name, context));
    } else if (schema.isUnion) {
      body.writeln(_generateUnionClass(schema, name, context));
    } else if (schema.isObject) {
      body.writeln(_generateObjectClass(schema, name, context));
    }
  }
  final bodyCode = body.toString();

  final buffer = StringBuffer();
  buffer.writeln('''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides, unnecessary_null_comparison
// ignore_for_file: prefer_is_empty, unnecessary_string_interpolations, avoid_init_to_null, unnecessary_const
// ignore_for_file: unnecessary_question_mark, unnecessary_cast
''');
  if (bodyCode.contains('LinkedHashSet')) {
    buffer.writeln("import 'dart:collection';");
  }
  buffer.writeln('''import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';''');

  for (final entry in importPrefixes.entries) {
    buffer.writeln("import '${entry.key}' as ${entry.value};");
  }

  buffer.writeln();
  buffer.write(bodyCode);

  return buffer.toString();
}

String _toEnumConstantName(Object? val) {
  var enumName = toCamelCase(val.toString());
  if (isKeyword(enumName) || int.tryParse(enumName[0]) != null) {
    enumName = 'val${toPascalCase(val.toString())}';
  }
  return enumName;
}

String _enumBackingType(Schema schema) {
  if (schema.enumValues == null) return 'dynamic';
  final isString = schema.enumValues!.every((v) => v is String);
  final isInt = schema.enumValues!.every((v) => v is int);
  return isString ? 'String' : (isInt ? 'int' : 'dynamic');
}

/// Generates a Dart enum class representation for an EnumSchema.
String _generateEnumClass(
  Schema schema,
  String className,
  _GeneratorContext context,
) {
  final buffer = StringBuffer();

  final backingType = _enumBackingType(schema);
  final isString = backingType == 'String';
  final isInt = backingType == 'int';

  if (schema.isDeprecated) {
    if (schema.deprecatedMessage != null) {
      buffer.writeln(
        '@Deprecated(${dartStringLiteral(schema.deprecatedMessage!)})',
      );
    } else {
      buffer.writeln("@Deprecated('deprecated')");
    }
  }
  buffer.writeln('enum $className {');
  for (final val in schema.enumValues!) {
    final enumName = context.toEnumConstantName(val, schema);
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
  buffer.writeln(
    '  static final EnumDescriptor<$className> descriptor = EnumDescriptor<$className>(',
  );
  buffer.writeln('    values: values,');
  buffer.writeln('    fromValue: (val) => fromValue(val as $backingType),');
  buffer.writeln('    toValue: (e) => (e as $className).value,');
  buffer.writeln('    base: $baseDescriptor,');
  buffer.writeln('  );');
  buffer.writeln('}');
  return buffer.toString();
}

/// Checks if a string is a reserved Dart keyword.
///
/// Preconditions:
/// - [s] must not be null.
bool isKeyword(String s) {
  return _dartKeywords.contains(s);
}

String _descriptorExpr(Schema schema, Map<Schema, String> classNames) {
  final real = schema.realSchema;
  if (real.isUnion) {
    final analysis = UnionAnalysis.analyze(real);
    final baseDesc = analysis.nonNullSchema != null
        ? _descriptorExpr(analysis.nonNullSchema!, classNames)
        : 'RefDescriptor<${classNames[real]!}>(() => ${classNames[real]!}.descriptor)';
    if (analysis.isNullable) {
      return 'NullableDescriptor($baseDesc)';
    }
    return baseDesc;
  } else if (real.enumValues != null) {
    final name = classNames[real]!;
    return '$name.descriptor';
  } else if (real.isString) {
    return 'const StringDescriptor()';
  } else if (real.isNumber) {
    return real.isInteger ? 'const IntDescriptor()' : 'const NumDescriptor()';
  } else if (real.isBoolean) {
    return 'const BoolDescriptor()';
  } else if (real.isNull) {
    return 'const NullDescriptor()';
  } else if (real.isAnything) {
    return 'const AnythingDescriptor()';
  } else if (real.isNever) {
    return 'const NeverDescriptor()';
  } else if (real.isArray) {
    final elementType = _arrayElementType(real, classNames);
    if (real.prefixItems == null || real.prefixItems!.isEmpty) {
      return 'ArrayDescriptor<$elementType>(${_descriptorExpr(real.items ?? Schema.anything, classNames)})';
    } else {
      final prefixExprs = real.prefixItems!
          .map((s) => _descriptorExpr(s, classNames))
          .join(', ');
      return 'ArrayDescriptor<$elementType>(${_descriptorExpr(real.items ?? Schema.anything, classNames)}, prefixItems: [$prefixExprs])';
    }
  } else if (real.isObject) {
    final name = classNames[real]!;
    return 'RefDescriptor<$name>(() => $name.descriptor)';
  }
  return 'const AnythingDescriptor()';
}

String _fieldType(
  Schema propSchema,
  bool isRequired,
  _GeneratorContext context,
) {
  final baseType = dartType(propSchema, context.classNames);
  final hasDefault = propSchema.hasDefault;
  String? defaultLiteral;
  if (hasDefault) {
    defaultLiteral = _toDartLiteral(
      propSchema.defaultValue,
      propSchema,
      context,
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
  _GeneratorContext context,
) {
  final type = _fieldType(propSchema, isRequired, context);
  return type.endsWith('?') || type == 'dynamic' || type == 'Object?';
}

String _toBasicDartLiteral(Object? value) {
  if (value == null) return 'null';
  if (value is String) {
    return dartStringLiteral(value);
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
              '${dartStringLiteral(e.key.toString())}: '
              '${_toBasicDartLiteral(e.value)}',
        )
        .join(', ');
    return 'const {$entries}';
  }
  throw ArgumentError('Unsupported value type: ${value.runtimeType}');
}

String? _toDartLiteral(
  Object? value,
  Schema schema,
  _GeneratorContext context,
) {
  final classNames = context.classNames;
  final real = schema.realSchema;
  if (real.enumValues != null) {
    final className = classNames[real];
    if (className != null) {
      final constName = context.toEnumConstantName(value, real);
      return '$className.$constName';
    } else {
      return _toDartLiteral(value, real.removeEnum(), context);
    }
  }
  if (value == null) return 'null';
  if (value is String) {
    return dartStringLiteral(value);
  }
  if (value is num || value is bool) {
    return value.toString();
  }
  if (value is List) {
    if (value.isEmpty) {
      if (real.isArray) {
        final itemType = dartType(real.items ?? Schema.anything, classNames);
        return 'const <$itemType>[]';
      }
      return 'const []';
    }
    if (real.isArray) {
      final itemType = dartType(real.items ?? Schema.anything, classNames);
      final elements = <String>[];
      for (final val in value) {
        final lit = _toDartLiteral(val, real.items ?? Schema.anything, context);
        if (lit == null) return null;
        elements.add(lit);
      }
      return 'const <$itemType>[${elements.join(', ')}]';
    }
  }
  if (value is Map) {
    if (value.isEmpty) {
      if (real.isObject) {
        final className = classNames[real];
        if (className != null) {
          return 'const $className()';
        }
      }
      return 'const {}';
    }
    if (real.isObject) {
      final className = classNames[real];
      if (className != null) {
        final args = <String>[];
        var ok = true;
        final fieldNames = context.fieldNamesFor(real);
        value.forEach((k, v) {
          final propSchema = real.properties?[k];
          if (propSchema == null) {
            ok = false;
            return;
          }
          final lit = _toDartLiteral(v, propSchema, context);
          if (lit == null) {
            ok = false;
            return;
          }
          final dartFieldName = fieldNames[k] ?? toCamelCase(k as String);
          args.add('$dartFieldName: $lit');
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
  Schema schema,
  String className,
  _GeneratorContext context,
) {
  final classNames = context.classNames;
  final fieldNames = context.fieldNamesFor(schema);
  final fields = StringBuffer();
  final constructorParams = StringBuffer();
  final equalityProps = <String>[];
  final hashExprs = <String>[];
  final toStringProps = <String>[];
  final copyWithParams = StringBuffer();
  final copyWithArgs = StringBuffer();

  schema.properties?.forEach((name, propSchema) {
    final fieldName = fieldNames[name]!;
    final isRequired = schema.required?.contains(name) == true;
    final baseType = dartType(propSchema, classNames);

    final hasDefault = propSchema.hasDefault;
    String? defaultLiteral;
    if (hasDefault) {
      defaultLiteral = _toDartLiteral(
        propSchema.defaultValue,
        propSchema,
        context,
      );
    }

    final fieldType = _fieldType(propSchema, isRequired, context);

    if (propSchema.isDeprecated) {
      if (propSchema.deprecatedMessage != null) {
        fields.writeln(
          '  @Deprecated(${dartStringLiteral(propSchema.deprecatedMessage!)})',
        );
      } else {
        fields.writeln("  @Deprecated('deprecated')");
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
      schema.additionalProperties == null ||
      !schema.additionalProperties!.isNever;

  final hasPatternProps = schema.patternProperties?.isNotEmpty == true;
  final patterns = schema.patternProperties?.keys.toList() ?? [];

  if (hasPatternProps) {
    for (var i = 0; i < patterns.length; i++) {
      final pattern = patterns[i];
      fields.writeln(
        '  static final _patternRegex$i = '
        'RegExp(${dartStringLiteral(pattern.pattern)});',
      );
    }
    fields.writeln('  final Map<String, dynamic> patternProperties;');
    constructorParams.writeln('    this.patternProperties = const {},');
    copyWithParams.writeln('    Map<String, dynamic>? patternProperties,');
    copyWithArgs.writeln(
      '    patternProperties: patternProperties ?? this.patternProperties,',
    );
    equalityProps.add(
      'const DeepCollectionEquality().equals(patternProperties, other.patternProperties)',
    );
    hashExprs.add('const DeepCollectionEquality().hash(patternProperties)');
    toStringProps.add('patternProperties: \${patternProperties}');
  }

  if (hasAdditionalProps) {
    final addPropsType = dartType(
      schema.additionalProperties ?? Schema.anything,
      classNames,
    );
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
    context,
    fieldNames,
  );

  final propDescriptors = StringBuffer();
  final getFieldsMap = StringBuffer();
  final instantiateArgs = StringBuffer();

  schema.properties?.forEach((name, propSchema) {
    final fieldName = fieldNames[name]!;
    final nameEscaped = escapeStringContents(name);
    final isRequired = schema.required?.contains(name) == true;
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
        context,
      );
    }

    final fieldType = _fieldType(propSchema, isRequired, context);

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

  final propKeysLiteral =
      '<String>{${(schema.properties?.keys ?? []).map(dartStringLiteral).join(', ')}}';

  String patternMatchExpr = 'false';
  if (hasPatternProps) {
    final patternMatches = <String>[];
    for (var i = 0; i < patterns.length; i++) {
      patternMatches.add('_patternRegex$i.hasMatch(e.key)');
    }
    patternMatchExpr = patternMatches.join(' || ');
  }

  if (hasPatternProps) {
    getFieldsMap.writeln("      ...typedInstance.patternProperties,");
    instantiateArgs.writeln('''
        patternProperties: fields.entries.where((e) {
          if (const $propKeysLiteral.contains(e.key)) return false;
          return $patternMatchExpr;
        }).fold<Map<String, dynamic>>({}, (m, e) => m..[e.key] = e.value),''');
  }

  if (hasAdditionalProps) {
    getFieldsMap.writeln("      ...typedInstance.additionalProperties,");
    final addPropsType = dartType(
      schema.additionalProperties ?? Schema.anything,
      classNames,
    );
    final condExpr = hasPatternProps ? '!($patternMatchExpr)' : 'true';
    instantiateArgs.writeln(
      "        additionalProperties: fields.entries.where((e) => !const $propKeysLiteral.contains(e.key) && $condExpr).fold<Map<String, $addPropsType>>({}, (m, e) => m..[e.key] = e.value as $addPropsType),",
    );
  }

  final addPropsExpr = _descriptorExpr(
    schema.additionalProperties ?? Schema.anything,
    classNames,
  );

  final patternPropsExprs = <String>[];
  var i = 0;
  schema.patternProperties?.forEach((pattern, patternSchema) {
    final descExpr = _descriptorExpr(patternSchema, classNames);
    patternPropsExprs.add('_patternRegex$i: $descExpr');
    i++;
  });
  final patternPropsExpr = patternPropsExprs.isEmpty
      ? ''
      : 'patternProperties: {${patternPropsExprs.join(', ')}},';

  final descriptorString =
      '''
  static final ObjectDescriptor<$className> descriptor = ObjectDescriptor<$className>(
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
    $patternPropsExpr
    required: const [${(schema.required ?? const <String>{}).map(dartStringLiteral).join(', ')}],
    additionalProperties: $addPropsExpr,
  );''';

  final deprecatedAttr = schema.isDeprecated
      ? (schema.deprecatedMessage != null
            ? '@Deprecated(${dartStringLiteral(schema.deprecatedMessage!)})\n'
            : "@Deprecated('deprecated')\n")
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
  if (real.enumValues != null) {
    final className = classNames[real];
    if (className != null) {
      final backingType = _enumBackingType(real);
      buffer.writeln('    if ($valueVar is $className) {');
      buffer.writeln('      $resultVar = true;');
      buffer.writeln('    } else {');
      buffer.writeln('      try {');
      if (backingType != 'dynamic') {
        buffer.writeln('        if ($valueVar is $backingType) {');
        buffer.writeln('          $className.fromValue($valueVar);');
        buffer.writeln('          $resultVar = true;');
        buffer.writeln('        }');
      } else {
        buffer.writeln('        $className.fromValue($valueVar);');
        buffer.writeln('        $resultVar = true;');
      }
      buffer.writeln('      } on StateError catch (_) {}');
      buffer.writeln('    }');
    }
  } else if (real.isString) {
    buffer.writeln('    if ($valueVar is String) {');
    buffer.writeln('      $resultVar = true;');
    if (real.minLength != null) {
      buffer.writeln(
        '      if ($valueVar.runes.length < ${real.minLength}) $resultVar = false;',
      );
    }
    if (real.maxLength != null) {
      buffer.writeln(
        '      if ($valueVar.runes.length > ${real.maxLength}) $resultVar = false;',
      );
    }
    if (real.pattern != null) {
      buffer.writeln(
        '      if (!RegExp(${dartStringLiteral(real.pattern!)})'
        '.hasMatch($valueVar)) $resultVar = false;',
      );
    }
    if (real.format != null) {
      final cond = _getFormatCondition(valueVar, real.format!);
      if (cond != null) {
        buffer.writeln('      if (!($cond)) $resultVar = false;');
      }
    }
    buffer.writeln('    }');
  } else if (real.isNumber) {
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
  } else if (real.isBoolean) {
    buffer.writeln('    if ($valueVar is bool) $resultVar = true;');
  } else if (real.isNull) {
    buffer.writeln('    if ($valueVar == null) $resultVar = true;');
  } else if (real.isAnything) {
    buffer.writeln('    $resultVar = true;');
  } else if (real.isObject) {
    final className = classNames[real]!;
    buffer.writeln('    if ($valueVar is $className) {');
    buffer.writeln('      $resultVar = $valueVar.collectErrors().isEmpty;');
    buffer.writeln('    } else if ($valueVar is Map<String, dynamic>) {');
    buffer.writeln('      try {');
    buffer.writeln(
      '        final parsed = $className.fromJson(JsonReader.fromObject($valueVar));',
    );
    buffer.writeln('        $resultVar = parsed.collectErrors().isEmpty;');
    buffer.writeln('      } on JsonValidationException catch (_) {');
    buffer.writeln('      } on FormatException catch (_) {}');
    buffer.writeln('    }');
  } else if (real.isUnion) {
    final className = classNames[real]!;
    buffer.writeln('    if ($valueVar is $className) {');
    buffer.writeln('      $resultVar = $valueVar.collectErrors().isEmpty;');
    buffer.writeln('    } else {');
    buffer.writeln('      try {');
    buffer.writeln(
      '        final parsed = $className.fromJson(JsonReader.fromObject($valueVar));',
    );
    buffer.writeln('        $resultVar = parsed.collectErrors().isEmpty;');
    buffer.writeln('      } on JsonValidationException catch (_) {');
    buffer.writeln('      } on FormatException catch (_) {}');
    buffer.writeln('    }');
  }
  return buffer.toString();
}

/// Helper checking if the given schema generates a class type that implements validate().
bool _hasValidationMethod(Schema schema) {
  final real = schema.realSchema;
  if (real.enumValues != null) {
    return false;
  }
  if (real.isObject) {
    return true;
  }
  if (real.isUnion) {
    final analysis = UnionAnalysis.analyze(real);
    if (analysis.isNullable && analysis.nonNullSchema != null) {
      return _hasValidationMethod(analysis.nonNullSchema!);
    }
    return true; // Sealed union classes always have validate()
  }
  if (real.isArray) {
    return _hasValidationMethod(real.items ?? Schema.anything);
  }
  return false;
}

bool _hasItemValidation(Schema schema) {
  final real = schema.realSchema;
  if (_hasValidationMethod(real)) return true;
  if (real.isString) {
    return real.minLength != null ||
        real.maxLength != null ||
        real.pattern != null ||
        real.format != null ||
        real.not != null;
  }
  if (real.isNumber) {
    return real.minimum != null ||
        real.maximum != null ||
        real.exclusiveMinimum != null ||
        real.exclusiveMaximum != null ||
        real.multipleOf != null ||
        real.not != null;
  }
  if (real.enumValues != null) {
    return true;
  }
  if (real.isArray) {
    if (real.minItems != null ||
        real.maxItems != null ||
        real.uniqueItems == true ||
        real.contains != null) {
      return true;
    }
    if (real.prefixItems != null && real.prefixItems!.any(_hasItemValidation)) {
      return true;
    }
    return _hasItemValidation(real.items ?? Schema.anything);
  }
  if (real.not != null) return true;
  return false;
}

/// Generates the `validate()` method body for a generated Dart class.
///
/// The generated method validates the class instance's fields against the
/// schema's constraints.
///
/// High-level structure of the generated `validate()` method:
/// 1. **Object-level constraints**: Validates `minProperties` and `maxProperties` by counting non-null fields and additional properties.
/// 2. **Dependent Required**: Enforces that if a property is present (non-null), its dependent properties must also be present.
/// 3. **Property-level validation**: Iterates through defined properties and generates inline validation checks (type, range, pattern, etc.)
///    by calling [_generateSchemaValidations]. If a property is nullable, these checks are wrapped in an `if (field != null)` block.
/// 4. **Pattern Properties**: Generates code to iterate over `patternProperties` Map and validate keys/values against matching RegExp schemas.
/// 5. **Additional Properties**: Generates validation for any properties not explicitly defined, using `_generateArrayItemValidation` or inline validations.
String _generateValidationMethod(
  Schema schema,
  String className,
  _GeneratorContext context,
  Map<String, String> fieldNames,
) {
  final classNames = context.classNames;
  final buffer = StringBuffer();
  buffer.writeln('  @override');
  buffer.writeln('  List<ValidationError> collectErrors() {');
  buffer.writeln('    final errors = <ValidationError>[];');
  if (schema.minProperties != null || schema.maxProperties != null) {
    buffer.writeln('    var count = 0;');
    schema.properties?.forEach((key, propSchema) {
      final fieldName = fieldNames[key]!;
      final isRequired = schema.required?.contains(key) == true;
      final isNullable = _isNullable(propSchema, isRequired, context);
      if (isNullable) {
        buffer.writeln('    if ($fieldName != null) count++;');
      } else {
        buffer.writeln('    count++;');
      }
    });
    final hasAdditionalProps =
        schema.additionalProperties == null ||
        !schema.additionalProperties!.isNever;
    if (hasAdditionalProps) {
      buffer.writeln('    count += additionalProperties.length;');
    }
    if (schema.minProperties != null) {
      buffer.writeln('    if (count < ${schema.minProperties}) {');
      buffer.writeln(
        "      errors.add(ValidationError(message: 'Object must have >= ${schema.minProperties} properties', keyword: 'minProperties'));",
      );
      buffer.writeln('    }');
    }
    if (schema.maxProperties != null) {
      buffer.writeln('    if (count > ${schema.maxProperties}) {');
      buffer.writeln(
        "      errors.add(ValidationError(message: 'Object must have <= ${schema.maxProperties} properties', keyword: 'maxProperties'));",
      );
      buffer.writeln('    }');
    }
  }
  schema.dependentRequired?.forEach((key, deps) {
    final escapedKey = escapeStringContents(key);
    final fieldName = fieldNames[key]!;
    buffer.writeln('    if ($fieldName != null) {');
    for (final dep in deps) {
      final escapedDep = escapeStringContents(dep);
      final depFieldName = fieldNames[dep]!;
      buffer.writeln('      if ($depFieldName == null) {');
      buffer.writeln(
        "        errors.add(ValidationError(message: 'Property \"$escapedDep\" is required because \"$escapedKey\" is present', path: ['$escapedDep'], keyword: 'dependentRequired'));",
      );
      buffer.writeln('      }');
    }
    buffer.writeln('    }');
  });
  schema.properties?.forEach((name, propSchema) {
    final fieldName = fieldNames[name]!;
    final isRequired = schema.required?.contains(name) == true;
    final isNullable = _isNullable(propSchema, isRequired, context);

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
      context,
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
      if (!notReal.isObject && !notReal.isUnion) {
        final notValBuf = StringBuffer();
        _generateSchemaValidations(
          notValBuf,
          propSchema.not!,
          valueVar,
          name,
          context,
          checkType: true,
          includeNot: true,
          errorsVar: 'notErrors_$fieldName',
        );
        if (notValBuf.isNotEmpty) {
          final escapedName = escapeStringContents(name);
          buffer.writeln('    {');
          buffer.writeln(
            '      final notErrors_$fieldName = <ValidationError>[];',
          );
          buffer.write(notValBuf.toString());
          buffer.writeln('      if (notErrors_$fieldName.isEmpty) {');
          buffer.writeln(
            "        errors.add(ValidationError(message: 'Property \"$escapedName\" must not match the schema', path: ['$escapedName'], keyword: 'not'));",
          );
          buffer.writeln('      }');
          buffer.writeln('    }');
        }
      } else {
        final escapedName = escapeStringContents(name);
        final descExpr = _descriptorExpr(propSchema.not!, classNames);
        buffer.writeln('    bool notMatches_$fieldName = true;');
        buffer.writeln('    try {');
        buffer.writeln(
          '      final rawValue = $valueVar is JsonModel ? ($valueVar as JsonModel).toJsonValue() : $valueVar;',
        );
        buffer.writeln(
          '      parseWithDescriptor(JsonReader.fromObject(rawValue), $descExpr, validate: true);',
        );
        buffer.writeln('    } on JsonValidationException {');
        buffer.writeln('      notMatches_$fieldName = false;');
        buffer.writeln('    } on FormatException {');
        buffer.writeln('      notMatches_$fieldName = false;');
        buffer.writeln('    }');
        buffer.writeln('    if (notMatches_$fieldName) {');
        buffer.writeln(
          "      errors.add(ValidationError(message: 'Property \"$escapedName\" must not match the schema', path: ['$escapedName'], keyword: 'not'));",
        );
        buffer.writeln('    }');
      }
    }
  });

  final hasPatternProps = schema.patternProperties?.isNotEmpty == true;
  if (hasPatternProps) {
    buffer.writeln('    patternProperties.forEach((key, value) {');
    var i = 0;
    schema.patternProperties?.forEach((pattern, patternSchema) {
      buffer.writeln('      if (_patternRegex$i.hasMatch(key)) {');
      final validations = StringBuffer();
      _generateSchemaValidations(
        validations,
        patternSchema,
        'value',
        r'$key',
        context,
        checkType: true,
        includeNot: true,
        escapeName: false,
      );
      buffer.write(validations.toString());
      buffer.writeln('      }');
      i++;
    });
    buffer.writeln('    });');
  }

  final hasAdditionalProps =
      schema.additionalProperties == null ||
      !schema.additionalProperties!.isNever;
  if (hasAdditionalProps) {
    final addSchema = schema.additionalProperties ?? Schema.anything;
    final hasAddValidation = _hasValidationMethod(addSchema);
    if (hasAddValidation) {
      buffer.writeln('    additionalProperties.forEach((key, value) {');
      _generateArrayItemValidation(
        buffer,
        addSchema,
        'value',
        r'$key',
        [r"'$key'"],
        0,
        context,
        escapeName: false,
      );
      buffer.writeln('    });');
    } else {
      final validations = StringBuffer();
      _generateSchemaValidations(
        validations,
        addSchema,
        'value',
        r'$key',
        context,
        checkType: true,
        includeNot: false,
        escapeName: false,
      );
      if (validations.isNotEmpty) {
        buffer.writeln('    additionalProperties.forEach((key, value) {');
        buffer.write(validations.toString());
        buffer.writeln('    });');
      }
    }
  }

  buffer.writeln('    return errors;');
  buffer.writeln('  }');
  buffer.writeln();
  buffer.writeln('  @override');
  buffer.writeln('  void validate() {');
  buffer.writeln('    final errors = collectErrors();');
  buffer.writeln('    if (errors.isNotEmpty) {');
  buffer.writeln('      throw JsonValidationException(errors);');
  buffer.writeln('    }');
  buffer.writeln('  }');
  return buffer.toString();
}

/// Generates recursive validation code for array items, supporting nested arrays.
///
/// Since arrays can contain other arrays (nested lists), this method handles
/// the recursion:
/// - For **Object/Union items**: Generates a call to `item.collectErrors()` to propagate the path.
/// - For **Nested Array items**: Generates a loop (e.g., `for (var i = ...; i < list.length; i++)`) and recursively calls
///   [_generateArrayItemValidation] for the next depth level, updating the validation path.
/// - For **Primitive items** (string, number, boolean): Generates inline validations using [_generateSchemaValidations].
void _generateArrayItemValidation(
  StringBuffer validations,
  Schema itemSchema,
  String valueVar,
  String name,
  List<String> pathExprs,
  int depth,
  _GeneratorContext context, {
  bool escapeName = true,
  String errorsVar = 'errors',
}) {
  final real = itemSchema.realSchema;
  if (real.isObject || real.isUnion) {
    validations.writeln('''
        $errorsVar.addAll(($valueVar as JsonModel).collectErrors().map((ValidationError e) => ValidationError(
          message: e.message,
          path: [${pathExprs.join(', ')}, ...e.path],
          keyword: e.keyword,
          schema: e.schema,
          value: e.value,
          nestedErrors: e.nestedErrors,
        )));''');
  } else if (real.isArray) {
    final itemVar = 'item$depth';
    final indexVar = 'i$depth';
    final hasItemValidation = _hasItemValidation(real.items ?? Schema.anything);
    if (hasItemValidation) {
      final startIndex = real.prefixItems?.length ?? 0;
      validations.writeln(
        '        for (var $indexVar = $startIndex; $indexVar < $valueVar.length; $indexVar++) {',
      );
      validations.writeln('          final $itemVar = $valueVar[$indexVar];');
      _generateArrayItemValidation(
        validations,
        real.items ?? Schema.anything,
        itemVar,
        name,
        [...pathExprs, "'[\$$indexVar]'"],
        depth + 1,
        context,
        escapeName: escapeName,
        errorsVar: errorsVar,
      );
      validations.writeln('        }');
    }
  } else {
    final primitiveValidations = StringBuffer();
    _generateSchemaValidations(
      primitiveValidations,
      real,
      valueVar,
      name,
      context,
      checkType: true,
      pathExprs: pathExprs,
      escapeName: escapeName,
      errorsVar: errorsVar,
    );
    if (primitiveValidations.isNotEmpty) {
      final indent = '  ' * (depth + 1);
      final lines = primitiveValidations.toString().split('\n');
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (line.isNotEmpty) {
          validations.writeln('$indent$line');
        } else if (i < lines.length - 1) {
          validations.writeln();
        }
      }
    }
  }
}

void _generateSchemaValidations(
  StringBuffer validations,
  Schema schema,
  String valueVar,
  String name,
  _GeneratorContext context, {
  bool checkType = false,
  bool includeNot = true,
  List<String>? pathExprs,
  bool escapeName = true,
  String errorsVar = 'errors',
}) {
  final classNames = context.classNames;
  final unescapedName = name;
  // `name` is interpolated into generated error messages. Normally it is a
  // schema-derived property name and must be escaped; callers that pass a
  // deliberate code fragment (such as `$key` inside an
  // `additionalProperties.forEach`) opt out with `escapeName: false`.
  name = escapeName ? escapeStringContents(name) : name;
  final real = schema.realSchema;
  final effectivePath = pathExprs ?? [dartStringLiteral(unescapedName)];
  final effectivePathExpr = '[${effectivePath.join(', ')}]';
  if (real.isString) {
    if (checkType) {
      validations.writeln('      if ($valueVar is! String) {');
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must be a string', path: $effectivePathExpr, keyword: 'type'));",
      );
      validations.writeln('      } else {');
    }
    if (real.minLength != null) {
      validations.writeln(
        '      if ($valueVar.runes.length < ${real.minLength}) {',
      );
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" length must be >= ${real.minLength}', path: $effectivePathExpr, keyword: 'minLength'));",
      );
      validations.writeln('      }');
    }
    if (real.maxLength != null) {
      validations.writeln(
        '      if ($valueVar.runes.length > ${real.maxLength}) {',
      );
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" length must be <= ${real.maxLength}', path: $effectivePathExpr, keyword: 'maxLength'));",
      );
      validations.writeln('      }');
    }
    if (real.pattern != null) {
      final patternLiteral = dartStringLiteral(real.pattern!);
      final msgPatternEscaped = escapeStringContents(real.pattern!);
      validations.writeln('''
      if (!RegExp($patternLiteral).hasMatch($valueVar)) {
        $errorsVar.add(ValidationError(message: 'Property "$name" must match pattern "$msgPatternEscaped"', path: $effectivePathExpr, keyword: 'pattern'));
      }''');
    }
    if (real.format != null) {
      _generateFormatValidation(
        validations,
        valueVar,
        real.format!,
        name,
        pathExpr: effectivePathExpr,
        errorsVar: errorsVar,
      );
    }
    if (checkType) {
      validations.writeln('      }');
    }
  } else if (real.isNumber) {
    if (checkType) {
      final typeCheck = real.isInteger ? 'is! int' : 'is! num';
      final typeName = real.isInteger ? 'an integer' : 'a number';
      validations.writeln('      if ($valueVar $typeCheck) {');
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must be $typeName', path: $effectivePathExpr, keyword: 'type'));",
      );
      validations.writeln('      } else {');
    }
    if (real.minimum != null) {
      validations.writeln('      if ($valueVar < ${real.minimum}) {');
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must be >= ${real.minimum}', path: $effectivePathExpr, keyword: 'minimum'));",
      );
      validations.writeln('      }');
    }
    if (real.maximum != null) {
      validations.writeln('      if ($valueVar > ${real.maximum}) {');
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must be <= ${real.maximum}', path: $effectivePathExpr, keyword: 'maximum'));",
      );
      validations.writeln('      }');
    }
    if (real.exclusiveMinimum != null) {
      validations.writeln('      if ($valueVar <= ${real.exclusiveMinimum}) {');
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must be > ${real.exclusiveMinimum}', path: $effectivePathExpr, keyword: 'exclusiveMinimum'));",
      );
      validations.writeln('      }');
    }
    if (real.exclusiveMaximum != null) {
      validations.writeln('      if ($valueVar >= ${real.exclusiveMaximum}) {');
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must be < ${real.exclusiveMaximum}', path: $effectivePathExpr, keyword: 'exclusiveMaximum'));",
      );
      validations.writeln('      }');
    }
    if (real.multipleOf != null) {
      if (real.isInteger) {
        validations.writeln('      if ($valueVar % ${real.multipleOf} != 0) {');
        validations.writeln(
          "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must be a multiple of ${real.multipleOf}', path: $effectivePathExpr, keyword: 'multipleOf'));",
        );
        validations.writeln('      }');
      } else {
        // Floating point division can introduce precision errors under IEEE-754 constraints.
        // Instead of a strict modulo (`%`), we calculate the relative error between the
        // division result and its nearest integer. A tolerance of `1e-14` is used to allow
        // for minor rounding errors while still catching genuine invalid values.
        validations.writeln('''
      if (() {
        final div = $valueVar / ${real.multipleOf};
        if (!div.isFinite) return true;
        final rounded = div.round();
        final absError = (div - rounded).abs();
        final relError = absError / (div.abs() > 1.0 ? div.abs() : 1.0);
        return relError > 1e-14;
      }()) {
        $errorsVar.add(ValidationError(message: 'Property "$name" must be a multiple of ${real.multipleOf}', path: $effectivePathExpr, keyword: 'multipleOf'));
      }''');
      }
    }
    if (checkType) {
      validations.writeln('      }');
    }
  } else if (real.isArray) {
    if (checkType) {
      validations.writeln('      if ($valueVar is! List) {');
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must be an array', path: $effectivePathExpr, keyword: 'type'));",
      );
      validations.writeln('      } else {');
    }
    if (real.minItems != null) {
      validations.writeln('      if ($valueVar.length < ${real.minItems}) {');
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must have >= ${real.minItems} items', path: $effectivePathExpr, keyword: 'minItems'));",
      );
      validations.writeln('      }');
    }
    if (real.maxItems != null) {
      validations.writeln('      if ($valueVar.length > ${real.maxItems}) {');
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must have <= ${real.maxItems} items', path: $effectivePathExpr, keyword: 'maxItems'));",
      );
      validations.writeln('      }');
    }
    if (real.uniqueItems == true) {
      validations.writeln(
        '      if ($valueVar.length != (LinkedHashSet<dynamic>(equals: const DeepCollectionEquality().equals, hashCode: const DeepCollectionEquality().hash)..addAll($valueVar)).length) {',
      );
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" items must be unique', path: $effectivePathExpr, keyword: 'uniqueItems'));",
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
          "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must contain at least $minContains items matching contains schema, but has \$containsCount', path: $effectivePathExpr, keyword: 'minContains'));",
        );
        validations.writeln('      }');
      }
      if (real.maxContains != null) {
        validations.writeln('      if (containsCount > ${real.maxContains}) {');
        validations.writeln(
          "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must contain at most ${real.maxContains} items matching contains schema, but has \$containsCount', path: $effectivePathExpr, keyword: 'maxContains'));",
        );
        validations.writeln('      }');
      }
    }
    if (real.prefixItems != null) {
      for (var i = 0; i < real.prefixItems!.length; i++) {
        final prefixSchema = real.prefixItems![i];
        if (_hasItemValidation(prefixSchema)) {
          validations.writeln('      if ($valueVar.length > $i) {');
          _generateArrayItemValidation(
            validations,
            prefixSchema,
            '$valueVar[$i]',
            name,
            [...effectivePath, "'[$i]'"],
            0,
            context,
            errorsVar: errorsVar,
          );
          validations.writeln('      }');
        }
      }
    }
    final hasItemValidation = _hasItemValidation(real.items ?? Schema.anything);
    if (hasItemValidation) {
      final startIndex = real.prefixItems?.length ?? 0;
      validations.writeln(
        '      for (var i = $startIndex; i < $valueVar.length; i++) {',
      );
      _generateArrayItemValidation(
        validations,
        real.items ?? Schema.anything,
        '$valueVar[i]',
        name,
        [...effectivePath, "'[\$i]'"],
        0,
        context,
        errorsVar: errorsVar,
      );
      validations.writeln('      }');
    }
    if (checkType) {
      validations.writeln('      }');
    }
  } else if (real.isBoolean) {
    if (checkType) {
      validations.writeln('      if ($valueVar is! bool) {');
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must be a boolean', path: $effectivePathExpr, keyword: 'type'));",
      );
      validations.writeln('      }');
    }
  } else if (real.isNull) {
    if (checkType) {
      validations.writeln('      if ($valueVar != null) {');
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must be null', path: $effectivePathExpr, keyword: 'type'));",
      );
      validations.writeln('      }');
    }
  } else if (real.enumValues != null) {
    final baseSchema = real.removeEnum();
    if (checkType) {
      _generateSchemaValidations(
        validations,
        baseSchema,
        valueVar,
        unescapedName,
        context,
        checkType: true,
        pathExprs: effectivePath,
        errorsVar: errorsVar,
      );
    }
    final valuesLiterals = real.enumValues!
        .map((v) => _toDartLiteral(v, baseSchema, context))
        .join(', ');
    final effectiveValue =
        '$valueVar is Enum ? ($valueVar as dynamic).value : $valueVar';
    validations.writeln(
      '      if (!const [$valuesLiterals].any((v) => const DeepCollectionEquality().equals(v, $effectiveValue))) {',
    );
    validations.writeln(
      "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must be one of ${real.enumValues}', path: $effectivePathExpr, keyword: 'enum'));",
    );
    validations.writeln('      }');
  } else if (real.isObject || real.isUnion) {
    if (checkType) {
      final className = classNames[real]!;
      validations.writeln('      if ($valueVar is! $className) {');
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must be a $className', path: $effectivePathExpr, keyword: 'type'));",
      );
      if (_hasValidationMethod(real)) {
        validations.writeln('      } else {');
        validations.writeln('''
        $errorsVar.addAll(($valueVar as JsonModel).collectErrors().map((ValidationError e) => ValidationError(
          message: e.message,
          path: [${effectivePath.join(', ')}, ...e.path],
          keyword: e.keyword,
          schema: e.schema,
          value: e.value,
          nestedErrors: e.nestedErrors,
        )));''');
      }
      validations.writeln('      }');
    } else if (_hasValidationMethod(real)) {
      validations.writeln('''
      $errorsVar.addAll(($valueVar as JsonModel).collectErrors().map((ValidationError e) => ValidationError(
        message: e.message,
        path: [${effectivePath.join(', ')}, ...e.path],
        keyword: e.keyword,
        schema: e.schema,
        value: e.value,
        nestedErrors: e.nestedErrors,
      )));''');
    }
  } else if (real.isAnything) {
    // Always succeeds, so do nothing.
  } else if (real.isNever) {
    validations.writeln(
      "      $errorsVar.add(ValidationError(message: 'Property \"$name\" matches nothing', path: $effectivePathExpr, keyword: 'false'));",
    );
  }

  if (includeNot && schema.not != null) {
    final notReal = schema.not!.realSchema;
    if (!notReal.isObject && !notReal.isUnion) {
      final notValBuf = StringBuffer();
      _generateSchemaValidations(
        notValBuf,
        schema.not!,
        valueVar,
        unescapedName,
        context,
        checkType: true,
        includeNot: true,
        errorsVar: 'notErrors',
      );
      if (notValBuf.isNotEmpty) {
        validations.writeln('      {');
        validations.writeln('        final notErrors = <ValidationError>[];');
        validations.write(notValBuf.toString());
        validations.writeln('        if (notErrors.isEmpty) {');
        validations.writeln(
          "          $errorsVar.add(ValidationError(message: 'Property \"$name\" must not match the schema', path: $effectivePathExpr, keyword: 'not'));",
        );
        validations.writeln('        }');
        validations.writeln('      }');
      }
    } else {
      final descExpr = _descriptorExpr(schema.not!, classNames);
      validations.writeln('      bool notMatches = true;');
      validations.writeln('      try {');
      validations.writeln(
        '        final rawValue = $valueVar is JsonModel ? ($valueVar as JsonModel).toJsonValue() : $valueVar;',
      );
      validations.writeln(
        '        parseWithDescriptor(JsonReader.fromObject(rawValue), $descExpr, validate: true);',
      );
      validations.writeln('      } on JsonValidationException {');
      validations.writeln('        notMatches = false;');
      validations.writeln('      } on FormatException {');
      validations.writeln('        notMatches = false;');
      validations.writeln('      }');
      validations.writeln('      if (notMatches) {');
      validations.writeln(
        "        $errorsVar.add(ValidationError(message: 'Property \"$name\" must not match the schema', path: $effectivePathExpr, keyword: 'not'));",
      );
      validations.writeln('      }');
    }
  }
}

String? _getFormatCondition(String valueVar, String format) {
  switch (format) {
    case 'date-time':
      return 'DateTime.tryParse($valueVar) != null';
    case 'date':
      return "RegExp(r'^\\d{4}-\\d{2}-\\d{2}\$').hasMatch($valueVar)";
    case 'email':
      return "RegExp(r'^[^@]+@[^@]+\$').hasMatch($valueVar)";
    case 'ipv4':
      return "RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$').hasMatch($valueVar)";
    case 'uuid':
      return "RegExp(r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\$').hasMatch($valueVar)";
    case 'uri':
      return 'isValidUri($valueVar)';
    case 'uri-reference':
      return 'isValidUriReference($valueVar)';
    case 'ipv6':
      return 'isValidIPv6($valueVar)';
    case 'hostname':
      return 'isValidHostname($valueVar)';
    case 'time':
      return 'isValidTime($valueVar)';
    default:
      return null;
  }
}

String? _getFormatErrorMessage(String name, String format) {
  switch (format) {
    case 'date-time':
      return 'Property "$name" must be a valid RFC 3339 date-time string';
    case 'date':
      return 'Property "$name" must be a valid date string (YYYY-MM-DD)';
    case 'email':
      return 'Property "$name" must be a valid email address';
    case 'ipv4':
      return 'Property "$name" must be a valid IPv4 address';
    case 'uuid':
      return 'Property "$name" must be a valid UUID';
    case 'uri':
      return 'Property "$name" must be a valid absolute URI';
    case 'uri-reference':
      return 'Property "$name" must be a valid URI reference';
    case 'ipv6':
      return 'Property "$name" must be a valid IPv6 address';
    case 'hostname':
      return 'Property "$name" must be a valid hostname';
    case 'time':
      return 'Property "$name" must be a valid time string';
    default:
      return null;
  }
}

void _generateFormatValidation(
  StringBuffer validations,
  String valueVar,
  String format,
  String name, {
  String? pathExpr,
  String errorsVar = 'errors',
}) {
  final msg = _getFormatErrorMessage(name, format);
  if (msg == null) return;
  final cond = format == 'date-time'
      ? 'DateTime.tryParse($valueVar) == null'
      : '!(${_getFormatCondition(valueVar, format)})';
  // [name] arrives already escaped (or as a deliberate code fragment) from
  // the caller; escaping again here would double up the backslashes.
  final effectivePathExpr = pathExpr ?? "['$name']";
  validations.writeln('      if ($cond) {');
  validations.writeln(
    "        $errorsVar.add(ValidationError(message: '$msg', path: $effectivePathExpr, keyword: 'format'));",
  );
  validations.writeln('      }');
}

String _generateUnionClass(
  Schema schema,
  String className,
  _GeneratorContext context,
) {
  final classNames = context.classNames;
  final analysis = UnionAnalysis.analyze(schema);
  final subclasses = StringBuffer();

  int index = 0;
  for (final sub in analysis.activeSchemas) {
    final optionType = dartType(sub, classNames);
    final subClassName = '${className}Option$index';

    final hasNestedValidation =
        sub.realSchema.isObject || sub.realSchema.isUnion;
    final validationBody = StringBuffer();
    if (hasNestedValidation) {
      validationBody.writeln('  @override');
      validationBody.writeln(
        '  List<ValidationError> collectErrors() => value.collectErrors();',
      );
    } else if (sub.realSchema.isArray) {
      final itemReal = sub.realSchema.items?.realSchema ?? Schema.anything;
      final hasItemValidation =
          itemReal.isObject || itemReal.isUnion || itemReal.isArray;
      validationBody.writeln('  @override');
      validationBody.writeln('  List<ValidationError> collectErrors() {');
      if (hasItemValidation) {
        validationBody.writeln('''
    final errors = <ValidationError>[];
    for (var i = 0; i < value.length; i++) {
      errors.addAll((value[i] as JsonModel).collectErrors().map((e) => ValidationError(
        message: e.message,
        path: ['[\$i]', ...e.path],
        keyword: e.keyword,
        schema: e.schema,
        value: e.value,
        nestedErrors: e.nestedErrors,
      )));
    }
    return errors;''');
      } else {
        validationBody.writeln('    return const [];');
      }
      validationBody.writeln('  }');
    } else {
      final validations = StringBuffer();
      _generateSchemaValidations(
        validations,
        sub,
        'value',
        'value',
        context,
        includeNot: false,
      );
      validationBody.writeln('  @override');
      validationBody.writeln('  List<ValidationError> collectErrors() {');
      if (validations.isNotEmpty) {
        validationBody.writeln('    final errors = <ValidationError>[];');
        validationBody.write(validations.toString());
        validationBody.writeln('    return errors;');
      } else {
        validationBody.writeln('    return const [];');
      }
      validationBody.writeln('  }');
    }

    final descExpr = _descriptorExpr(sub, classNames);

    final optDeprecatedAttr = sub.isDeprecated
        ? (sub.deprecatedMessage != null
              ? '@Deprecated(${dartStringLiteral(sub.deprecatedMessage!)})\n'
              : "@Deprecated('deprecated')\n")
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
      analysis.activeSchemas.every((s) => s.realSchema.isObject);

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
  static final UnionDescriptor<$className> descriptor = UnionDescriptor<$className>(
    title: '$className',
    ${useDiscriminator ? "discriminatorProperty: '${disc.propertyName}'," : ''}
    ${useDiscriminator ? 'discriminatorMapping: {\n$mappingEntries    },' : ''}
    activeOptions: [
$optionDescriptors    ],
  );''';

  final deprecatedAttr = schema.isDeprecated
      ? (schema.deprecatedMessage != null
            ? '@Deprecated(${dartStringLiteral(schema.deprecatedMessage!)})\n'
            : "@Deprecated('deprecated')\n")
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

  @override
  List<ValidationError> collectErrors();

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

$descriptorString
}

$subclasses
''';
}

bool _isSameSchemaResource(Schema a, Schema b) {
  if (a.id != null && b.id != null) {
    final idA = a.id!.endsWith('#')
        ? a.id!.substring(0, a.id!.length - 1)
        : a.id!;
    final idB = b.id!.endsWith('#')
        ? b.id!.substring(0, b.id!.length - 1)
        : b.id!;
    return idA == idB;
  }
  if (a.resourceUri != null && b.resourceUri != null) {
    return a.resourceUri == b.resourceUri;
  }
  return false;
}

/// Resolves `$dynamicRef` references to their corresponding `$dynamicAnchor` definitions for code generation.
///
/// Under Draft 2020-12, a `$dynamicRef` behaves like a normal `$ref` unless the
/// target anchor is defined as a `$dynamicAnchor`. In that case, the reference
/// resolves to the first schema in the dynamic evaluation path that defines
/// that anchor.
///
/// This is a pre-generation pass that resolves dynamic references statically
/// relative to the [root] schema of the generation context (where possible,
/// or establishes the default target).
/// It constructs the absolute URI of the anchor using the root's ID and the fragment,
/// and checks if the root (or any of its subschemas) defines a matching `$dynamicAnchor`
/// (stored in [root.dynamicAnchors]). If found, it maps the [current] schema's
/// `resolvedRef` to that target schema.
void _resolveDynamicRefs(Schema root, Schema current, [Set<Schema>? seen]) {
  seen ??= <Schema>{};
  if (!seen.add(current)) return;

  if (current.dynamicRef != null) {
    final uri = Uri.parse(current.dynamicRef!);
    final fragment = uri.fragment;
    if (fragment.isNotEmpty) {
      final rootId = root.id ?? root.resourceUri ?? 'http://localhost/';
      final normalizedRootId = rootId.endsWith('#')
          ? rootId.substring(0, rootId.length - 1)
          : rootId;
      final rootAnchorUri = '$normalizedRootId#$fragment';
      if (root.dynamicAnchors != null &&
          root.dynamicAnchors!.containsKey(rootAnchorUri)) {
        var target = root.dynamicAnchors![rootAnchorUri]!;
        if (target != root && _isSameSchemaResource(target, root)) {
          target = root;
        }
        current.resolvedRef = target;
      }
    }
  }
  if (current.defs != null) {
    for (final s in current.defs!.values) {
      _resolveDynamicRefs(root, s, seen);
    }
  }
  if (current.definitions != null) {
    for (final s in current.definitions!.values) {
      _resolveDynamicRefs(root, s, seen);
    }
  }
  if (current.properties != null) {
    for (final s in current.properties!.values) {
      _resolveDynamicRefs(root, s, seen);
    }
  }
  if (current.patternProperties != null) {
    for (final s in current.patternProperties!.values) {
      _resolveDynamicRefs(root, s, seen);
    }
  }
  if (current.additionalProperties != null) {
    _resolveDynamicRefs(root, current.additionalProperties!, seen);
  }
  if (current.unevaluatedProperties != null) {
    _resolveDynamicRefs(root, current.unevaluatedProperties!, seen);
  }
  if (current.propertyNames != null) {
    _resolveDynamicRefs(root, current.propertyNames!, seen);
  }
  if (current.items != null) {
    _resolveDynamicRefs(root, current.items!, seen);
  }
  if (current.prefixItems != null) {
    for (final s in current.prefixItems!) {
      _resolveDynamicRefs(root, s, seen);
    }
  }
  if (current.contains != null) {
    _resolveDynamicRefs(root, current.contains!, seen);
  }
  if (current.unevaluatedItems != null) {
    _resolveDynamicRefs(root, current.unevaluatedItems!, seen);
  }
  if (current.allOf != null) {
    for (final s in current.allOf!) {
      _resolveDynamicRefs(root, s, seen);
    }
  }
  if (current.anyOf != null) {
    for (final s in current.anyOf!) {
      _resolveDynamicRefs(root, s, seen);
    }
  }
  if (current.oneOf != null) {
    for (final s in current.oneOf!) {
      _resolveDynamicRefs(root, s, seen);
    }
  }
  if (current.not != null) {
    _resolveDynamicRefs(root, current.not!, seen);
  }
  if (current.ifSchema != null) {
    _resolveDynamicRefs(root, current.ifSchema!, seen);
  }
  if (current.thenSchema != null) {
    _resolveDynamicRefs(root, current.thenSchema!, seen);
  }
  if (current.elseSchema != null) {
    _resolveDynamicRefs(root, current.elseSchema!, seen);
  }
  if (current.dependentSchemas != null) {
    for (final s in current.dependentSchemas!.values) {
      _resolveDynamicRefs(root, s, seen);
    }
  }
  if (current.resolvedRef != null) {
    _resolveDynamicRefs(root, current.resolvedRef!, seen);
  }
}
