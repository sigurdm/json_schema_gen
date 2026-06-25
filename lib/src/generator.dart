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

import 'schema.dart';

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

Map<Schema, Map<dynamic, String>>? _currentEnumConstantNames;
Map<Schema, Map<String, String>>? _currentObjectFieldNames;

Map<dynamic, String> _calculateEnumConstantNames(Schema schema) {
  final names = <dynamic, String>{};
  final used = <String>{'values', 'value', 'fromValue', 'descriptor'};

  for (final val in schema.enumValues!) {
    var baseName = _toEnumConstantName(val, null);
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
String generateCode(Schema rootSchema, String rootName) {
  _resolveDynamicRefs(rootSchema, rootSchema);
  final classNames = Map<Schema, String>.identity();
  final usedNames = <String>{};

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
    if (real.enumValues != null) {
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
      discoverClasses(real.removeEnum(), '${candidate}_Base');
    } else if (real.isUnion) {
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
    } else if (real.isObject) {
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

      real.properties?.forEach((propName, propSchema) {
        discoverClasses(propSchema, '${candidate}_$propName');
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

  _currentEnumConstantNames = {};
  _currentObjectFieldNames = {};
  classNames.forEach((schema, name) {
    if (schema.enumValues != null) {
      _currentEnumConstantNames![schema] = _calculateEnumConstantNames(schema);
    } else if (schema.isObject) {
      _currentObjectFieldNames![schema] = _calculateFieldNames(schema);
    }
  });

  try {
    final buffer = StringBuffer();
    buffer.writeln('''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides, unnecessary_null_comparison

import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';
''');

    classNames.forEach((schema, name) {
      if (schema.enumValues != null) {
        buffer.writeln(_generateEnumClass(schema, name));
      } else if (schema.isUnion) {
        buffer.writeln(_generateUnionClass(schema, name, classNames));
      } else if (schema.isObject) {
        buffer.writeln(_generateObjectClass(schema, name, classNames));
      }
    });

    return buffer.toString();
  } finally {
    _currentEnumConstantNames = null;
    _currentObjectFieldNames = null;
  }
}

String _toEnumConstantName(Object? val, [Schema? schema]) {
  if (schema != null && _currentEnumConstantNames != null) {
    final names = _currentEnumConstantNames![schema];
    if (names != null) {
      final name = names[val];
      if (name != null) return name;
    }
  }
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
String _generateEnumClass(Schema schema, String className) {
  final buffer = StringBuffer();

  final backingType = _enumBackingType(schema);
  final isString = backingType == 'String';
  final isInt = backingType == 'int';

  if (schema.isDeprecated) {
    if (schema.deprecatedMessage != null) {
      buffer.writeln("@Deprecated('${schema.deprecatedMessage}')");
    } else {
      buffer.writeln("@Deprecated('deprecated')");
    }
  }
  buffer.writeln('enum $className {');
  for (final val in schema.enumValues!) {
    final enumName = _toEnumConstantName(val, schema);
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
  if (real.enumValues != null) {
    final className = classNames[real];
    if (className != null) {
      final constName = _toEnumConstantName(value, real);
      return '$className.$constName';
    } else {
      return _toDartLiteral(value, real.removeEnum(), classNames);
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
        final lit = _toDartLiteral(
          val,
          real.items ?? Schema.anything,
          classNames,
        );
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
        final fieldNames =
            _currentObjectFieldNames?[real] ?? _calculateFieldNames(real);
        value.forEach((k, v) {
          final propSchema = real.properties?[k];
          if (propSchema == null) {
            ok = false;
            return;
          }
          final lit = _toDartLiteral(v, propSchema, classNames);
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
  Map<Schema, String> classNames,
) {
  final fieldNames =
      _currentObjectFieldNames?[schema] ?? _calculateFieldNames(schema);
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
        classNames,
      );
    }

    final fieldType = _fieldType(propSchema, isRequired, classNames);

    if (propSchema.isDeprecated) {
      if (propSchema.deprecatedMessage != null) {
        fields.writeln("  @Deprecated('${propSchema.deprecatedMessage}')");
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
      final escapedPattern = pattern.pattern.replaceAll("'", r"\'");
      fields.writeln(
        '  static final _patternRegex$i = RegExp(r\'$escapedPattern\');',
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
    classNames,
    fieldNames,
  );

  final propDescriptors = StringBuffer();
  final getFieldsMap = StringBuffer();
  final instantiateArgs = StringBuffer();

  schema.properties?.forEach((name, propSchema) {
    final fieldName = fieldNames[name]!;
    final nameEscaped = name.replaceAll("'", r"\'").replaceAll(r'$', r'\$');
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

  final propKeysLiteral =
      '<String>{${(schema.properties?.keys ?? []).map((k) => "'${k.replaceAll("'", r"\'").replaceAll(r'$', r'\$')}'").join(', ')}}';

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
    required: const [${(schema.required ?? const <String>{}).map((r) => "'${r.replaceAll("'", r"\'").replaceAll(r'$', r'\$')}'").join(', ')}],
    additionalProperties: $addPropsExpr,
  );''';

  final deprecatedAttr = schema.isDeprecated
      ? (schema.deprecatedMessage != null
            ? "@Deprecated('${schema.deprecatedMessage}')\n"
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
  if (real.isString) {
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
  } else if (real.isUnion) {
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
  } else if (real.enumValues != null) {
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
  Map<Schema, String> classNames,
  Map<String, String> fieldNames,
) {
  final buffer = StringBuffer();
  buffer.writeln('  void validate() {');
  if (schema.minProperties != null || schema.maxProperties != null) {
    buffer.writeln('    var count = 0;');
    schema.properties?.forEach((key, propSchema) {
      final fieldName = fieldNames[key]!;
      final isRequired = schema.required?.contains(key) == true;
      final isNullable = _isNullable(propSchema, isRequired, classNames);
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
  schema.dependentRequired?.forEach((key, deps) {
    final escapedKey = key.replaceAll("'", "\\'");
    final fieldName = fieldNames[key]!;
    buffer.writeln('    if ($fieldName != null) {');
    for (final dep in deps) {
      final escapedDep = dep.replaceAll("'", "\\'");
      final depFieldName = fieldNames[dep]!;
      buffer.writeln('      if ($depFieldName == null) {');
      buffer.writeln(
        "        throw JsonValidationException('Property \"$escapedDep\" is required because \"$escapedKey\" is present', ['$escapedDep']);",
      );
      buffer.writeln('      }');
    }
    buffer.writeln('    }');
  });
  schema.properties?.forEach((name, propSchema) {
    final fieldName = fieldNames[name]!;
    final isRequired = schema.required?.contains(name) == true;
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
      if (!notReal.isObject && !notReal.isUnion) {
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
        final escapedName = name.replaceAll("'", "\\'");
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
          "      throw JsonValidationException('Property \"$escapedName\" must not match the schema', ['$escapedName']);",
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
        classNames,
        checkType: true,
        includeNot: true,
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

/// Generates recursive validation code for array items, supporting nested arrays.
///
/// Since arrays can contain other arrays (nested lists), this method handles
/// the recursion:
/// - For **Object/Union items**: Generates a call to `item.validate()` wrapped in a try-catch to propagate the path.
/// - For **Nested Array items**: Generates a loop (e.g., `for (var i = ...; i < list.length; i++)`) and recursively calls
///   [_generateArrayItemValidation] for the next depth level, updating the validation path.
/// - For **Primitive items** (string, number, boolean): Generates inline validations using [_generateSchemaValidations].
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
  if (real.isObject || real.isUnion) {
    validations.writeln('''
        try {
          $valueVar.validate();
        } on JsonValidationException catch (e) {
          throw JsonValidationException(e.message, [${path.map((p) => "'${p.replaceAll("'", "\\'")}'").join(', ')}, ...e.path]);
        }''');
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
        [...path, '[\$$indexVar]'],
        depth + 1,
        classNames,
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
      classNames,
      checkType: true,
      path: path,
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
  Map<Schema, String> classNames, {
  bool checkType = false,
  bool includeNot = true,
  List<String>? path,
}) {
  final unescapedName = name;
  name = name.replaceAll("'", "\\'");
  final real = schema.realSchema;
  final effectivePath = path ?? [unescapedName];
  final effectivePathExpr =
      '[${effectivePath.map((p) => "'${p.replaceAll("'", "\\'")}'").join(', ')}]';
  if (real.isString) {
    if (checkType) {
      validations.writeln('      if ($valueVar is! String) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a string', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
    if (real.minLength != null) {
      validations.writeln('      if ($valueVar.length < ${real.minLength}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" length must be >= ${real.minLength}', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
    if (real.maxLength != null) {
      validations.writeln('      if ($valueVar.length > ${real.maxLength}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" length must be <= ${real.maxLength}', $effectivePathExpr);",
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
        throw JsonValidationException('Property "$name" must match pattern "$msgPatternEscaped"', $effectivePathExpr);
      }''');
    }
    if (real.format != null) {
      _generateFormatValidation(
        validations,
        valueVar,
        real.format!,
        name,
        pathExpr: effectivePathExpr,
      );
    }
  } else if (real.isNumber) {
    if (checkType) {
      final typeCheck = real.isInteger ? 'is! int' : 'is! num';
      final typeName = real.isInteger ? 'an integer' : 'a number';
      validations.writeln('      if ($valueVar $typeCheck) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be $typeName', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
    if (real.minimum != null) {
      validations.writeln('      if ($valueVar < ${real.minimum}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be >= ${real.minimum}', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
    if (real.maximum != null) {
      validations.writeln('      if ($valueVar > ${real.maximum}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be <= ${real.maximum}', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
    if (real.exclusiveMinimum != null) {
      validations.writeln('      if ($valueVar <= ${real.exclusiveMinimum}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be > ${real.exclusiveMinimum}', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
    if (real.exclusiveMaximum != null) {
      validations.writeln('      if ($valueVar >= ${real.exclusiveMaximum}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be < ${real.exclusiveMaximum}', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
    if (real.multipleOf != null) {
      if (real.isInteger) {
        validations.writeln('      if ($valueVar % ${real.multipleOf} != 0) {');
        validations.writeln(
          "        throw JsonValidationException('Property \"$name\" must be a multiple of ${real.multipleOf}', $effectivePathExpr);",
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
        final rounded = div.round();
        final absError = (div - rounded).abs();
        final relError = absError / (div.abs() > 1.0 ? div.abs() : 1.0);
        return relError > 1e-14;
      }()) {
        throw JsonValidationException('Property "$name" must be a multiple of ${real.multipleOf}', $effectivePathExpr);
      }''');
      }
    }
  } else if (real.isArray) {
    if (checkType) {
      validations.writeln('      if ($valueVar is! List) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be an array', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
    if (real.minItems != null) {
      validations.writeln('      if ($valueVar.length < ${real.minItems}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must have >= ${real.minItems} items', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
    if (real.maxItems != null) {
      validations.writeln('      if ($valueVar.length > ${real.maxItems}) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must have <= ${real.maxItems} items', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
    if (real.uniqueItems == true) {
      validations.writeln(
        '      if ($valueVar.length != (LinkedHashSet<dynamic>(equals: const DeepCollectionEquality().equals, hashCode: const DeepCollectionEquality().hash)..addAll($valueVar)).length) {',
      );
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" items must be unique', $effectivePathExpr);",
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
          "        throw JsonValidationException('Property \"$name\" must contain at least $minContains items matching contains schema, but has \$containsCount', $effectivePathExpr);",
        );
        validations.writeln('      }');
      }
      if (real.maxContains != null) {
        validations.writeln('      if (containsCount > ${real.maxContains}) {');
        validations.writeln(
          "        throw JsonValidationException('Property \"$name\" must contain at most ${real.maxContains} items matching contains schema, but has \$containsCount', $effectivePathExpr);",
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
            [...effectivePath, '[$i]'],
            0,
            classNames,
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
        [...effectivePath, '[\$i]'],
        0,
        classNames,
      );
      validations.writeln('      }');
    }
  } else if (real.isBoolean) {
    if (checkType) {
      validations.writeln('      if ($valueVar is! bool) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a boolean', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
  } else if (real.isNull) {
    if (checkType) {
      validations.writeln('      if ($valueVar != null) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be null', $effectivePathExpr);",
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
        classNames,
        checkType: true,
        path: effectivePath,
      );
    }
    final valuesLiterals = real.enumValues!
        .map((v) => _toDartLiteral(v, baseSchema, classNames))
        .join(', ');
    final effectiveValue =
        '$valueVar is Enum ? ($valueVar as dynamic).value : $valueVar';
    validations.writeln(
      '      if (!const [$valuesLiterals].any((v) => const DeepCollectionEquality().equals(v, $effectiveValue))) {',
    );
    validations.writeln(
      "        throw JsonValidationException('Property \"$name\" must be one of ${real.enumValues}', $effectivePathExpr);",
    );
    validations.writeln('      }');
  } else if (real.isObject || real.isUnion) {
    if (checkType) {
      final className = classNames[real]!;
      validations.writeln('      if ($valueVar is! $className) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a $className', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
  } else if (real.isAnything) {
    // Always succeeds, so do nothing.
  } else if (real.isNever) {
    validations.writeln(
      "      throw JsonValidationException('Property \"$name\" matches nothing', $effectivePathExpr);",
    );
  }

  final hasNestedValidation =
      (real.isObject || real.isUnion) && _hasValidationMethod(real);
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
    if (!notReal.isObject && !notReal.isUnion) {
      final notValBuf = StringBuffer();
      _generateSchemaValidations(
        notValBuf,
        schema.not!,
        valueVar,
        unescapedName,
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
          "        throw JsonValidationException('Property \"$name\" must not match the schema', $effectivePathExpr);",
        );
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
        "        throw JsonValidationException('Property \"$name\" must not match the schema', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
  }
}

void _generateFormatValidation(
  StringBuffer validations,
  String valueVar,
  String format,
  String name, {
  String? pathExpr,
}) {
  name = name.replaceAll("'", "\\'");
  final effectivePathExpr = pathExpr ?? "['$name']";
  switch (format) {
    case 'date-time':
      validations.writeln('      if (DateTime.tryParse($valueVar) == null) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid RFC 3339 date-time string', $effectivePathExpr);",
      );
      validations.writeln('      }');
      break;
    case 'date':
      validations.writeln(
        "      if (!RegExp(r'^\\d{4}-\\d{2}-\\d{2}\$').hasMatch($valueVar)) {",
      );
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid date string (YYYY-MM-DD)', $effectivePathExpr);",
      );
      validations.writeln('      }');
      break;
    case 'email':
      validations.writeln(
        "      if (!RegExp(r'^[^@]+@[^@]+\$').hasMatch($valueVar)) {",
      );
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid email address', $effectivePathExpr);",
      );
      validations.writeln('      }');
      break;
    case 'ipv4':
      validations.writeln(
        "      if (!RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$').hasMatch($valueVar)) {",
      );
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid IPv4 address', $effectivePathExpr);",
      );
      validations.writeln('      }');
      break;
    case 'uuid':
      validations.writeln(
        "      if (!RegExp(r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\$').hasMatch($valueVar)) {",
      );
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid UUID', $effectivePathExpr);",
      );
      validations.writeln('      }');
      break;
    case 'uri':
      validations.writeln('      if (!isValidUri($valueVar)) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid absolute URI', $effectivePathExpr);",
      );
      validations.writeln('      }');
      break;
    case 'uri-reference':
      validations.writeln('      if (!isValidUriReference($valueVar)) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid URI reference', $effectivePathExpr);",
      );
      validations.writeln('      }');
      break;
    case 'ipv6':
      validations.writeln('      if (!isValidIPv6($valueVar)) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid IPv6 address', $effectivePathExpr);",
      );
      validations.writeln('      }');
      break;
    case 'hostname':
      validations.writeln('      if (!isValidHostname($valueVar)) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid hostname', $effectivePathExpr);",
      );
      validations.writeln('      }');
      break;
    case 'time':
      validations.writeln('      if (!isValidTime($valueVar)) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a valid time string', $effectivePathExpr);",
      );
      validations.writeln('      }');
      break;
  }
}

String _generateUnionClass(
  Schema schema,
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
        sub.realSchema.isObject || sub.realSchema.isUnion;
    final validationBody = StringBuffer();
    if (hasNestedValidation) {
      validationBody.writeln('  @override');
      validationBody.writeln('  void validate() {');
      validationBody.writeln('    value.validate();');
      validationBody.writeln('  }');
    } else if (sub.realSchema.isArray) {
      final itemReal = sub.realSchema.items?.realSchema ?? Schema.anything;
      final hasItemValidation =
          itemReal.isObject || itemReal.isUnion || itemReal.isArray;
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
            ? "@Deprecated('${schema.deprecatedMessage}')\n"
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
