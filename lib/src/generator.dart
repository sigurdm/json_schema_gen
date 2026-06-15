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
  } else if (real is NeverSchema) {
    return 'Never';
  } else if (real is EnumSchema) {
    return classNames[real] ?? _enumBackingType(real);
  } else if (real is UnionSchema) {
    final analysis = UnionAnalysis.analyze(real);
    if (analysis.isNullable && analysis.nonNullSchema != null) {
      final baseType = dartType(analysis.nonNullSchema!, classNames);
      return (baseType == 'dynamic' ||
              baseType == 'Object?' ||
              baseType.endsWith('?'))
          ? baseType
          : '$baseType?';
    }
    final name = classNames[real];
    if (name == null) return 'dynamic';
    return analysis.isNullable ? '$name?' : name;
  } else if (real is AllOfSchema) {
    return 'dynamic';
  }
  throw UnsupportedError(
    'Unsupported schema type for type generation: ${real.runtimeType}',
  );
}

/// Entry point to generate code for a parsed JSON Schema.
Map<EnumSchema, Map<dynamic, String>>? _currentEnumConstantNames;
Map<ObjectSchema, Map<String, String>>? _currentObjectFieldNames;

Map<dynamic, String> _calculateEnumConstantNames(EnumSchema schema) {
  final names = <dynamic, String>{};
  final used = <String>{'values', 'value', 'fromValue', 'descriptor'};

  for (final val in schema.values) {
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

Map<String, String> _calculateFieldNames(ObjectSchema schema) {
  final fieldNames = <String, String>{};
  final usedFieldNames = <String>{};
  usedFieldNames.addAll(_reservedMemberNames);

  schema.properties.forEach((name, propSchema) {
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
    if (schema.not != null) {
      discoverClasses(schema.not!, '${preferredName}_Not');
    }
  }

  discoverClasses(rootSchema, rootName);

  _currentEnumConstantNames = {};
  _currentObjectFieldNames = {};
  classNames.forEach((schema, name) {
    if (schema is EnumSchema) {
      _currentEnumConstantNames![schema] = _calculateEnumConstantNames(schema);
    } else if (schema is ObjectSchema) {
      _currentObjectFieldNames![schema] = _calculateFieldNames(schema);
    }
  });

  try {
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
  } finally {
    _currentEnumConstantNames = null;
    _currentObjectFieldNames = null;
  }
}

String _toEnumConstantName(Object? val, [EnumSchema? schema]) {
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
    final baseDesc = analysis.nonNullSchema != null
        ? _descriptorExpr(analysis.nonNullSchema!, classNames)
        : '${classNames[real]!}.descriptor';
    if (analysis.isNullable) {
      return 'NullableDescriptor($baseDesc)';
    }
    return baseDesc;
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
      final constName = _toEnumConstantName(value, real);
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
        final fieldNames =
            _currentObjectFieldNames?[real] ?? _calculateFieldNames(real);
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
  ObjectSchema schema,
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

  schema.properties.forEach((name, propSchema) {
    final fieldName = fieldNames[name]!;
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

  final hasPatternProps = schema.patternProperties.isNotEmpty;
  final patterns = schema.patternProperties.keys.toList();

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
    fieldNames,
  );

  final propDescriptors = StringBuffer();
  final getFieldsMap = StringBuffer();
  final instantiateArgs = StringBuffer();

  schema.properties.forEach((name, propSchema) {
    final fieldName = fieldNames[name]!;
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

  final propKeysLiteral =
      '<String>{${schema.properties.keys.map((k) => "'${k.replaceAll("'", r"\'")}'").join(', ')}}';

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
    final addPropsType = dartType(schema.additionalProperties!, classNames);
    final condExpr = hasPatternProps ? '!($patternMatchExpr)' : 'true';
    instantiateArgs.writeln(
      "        additionalProperties: fields.entries.where((e) => !const $propKeysLiteral.contains(e.key) && $condExpr).fold<Map<String, $addPropsType>>({}, (m, e) => m..[e.key] = e.value as $addPropsType),",
    );
  }

  String? addPropsExpr;
  if (schema.additionalProperties != null) {
    addPropsExpr = _descriptorExpr(schema.additionalProperties!, classNames);
  }

  final patternPropsExprs = <String>[];
  var i = 0;
  schema.patternProperties.forEach((pattern, patternSchema) {
    final descExpr = _descriptorExpr(patternSchema, classNames);
    patternPropsExprs.add('_patternRegex$i: $descExpr');
    i++;
  });
  final patternPropsExpr = patternPropsExprs.isEmpty
      ? ''
      : 'patternProperties: {${patternPropsExprs.join(', ')}},';

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
    $patternPropsExpr
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

bool _hasItemValidation(Schema schema) {
  final real = schema.realSchema;
  if (_hasValidationMethod(real)) return true;
  if (real is StringSchema) {
    return real.minLength != null ||
        real.maxLength != null ||
        real.pattern != null ||
        real.format != null ||
        real.not != null;
  }
  if (real is NumberSchema) {
    return real.minimum != null ||
        real.maximum != null ||
        real.exclusiveMinimum != null ||
        real.exclusiveMaximum != null ||
        real.multipleOf != null ||
        real.not != null;
  }
  if (real is EnumSchema) {
    return true;
  }
  if (real is ArraySchema) {
    if (real.minItems != null ||
        real.maxItems != null ||
        real.uniqueItems == true ||
        real.contains != null) {
      return true;
    }
    if (real.prefixItems != null && real.prefixItems!.any(_hasItemValidation)) {
      return true;
    }
    return _hasItemValidation(real.items);
  }
  if (real.not != null) return true;
  return false;
}

/// Generates validation method body checking constraints on class fields.
String _generateValidationMethod(
  ObjectSchema schema,
  String className,
  Map<Schema, String> classNames,
  Map<String, String> fieldNames,
) {
  final buffer = StringBuffer();
  buffer.writeln('  void validate() {');
  if (schema.minProperties != null || schema.maxProperties != null) {
    buffer.writeln('    var count = 0;');
    schema.properties.forEach((key, propSchema) {
      final fieldName = fieldNames[key]!;
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
  schema.properties.forEach((name, propSchema) {
    final fieldName = fieldNames[name]!;
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
        final escapedName = name.replaceAll("'", "\\'");
        final descExpr = _descriptorExpr(propSchema.not!, classNames);
        buffer.writeln('    bool notMatches_$fieldName = true;');
        buffer.writeln('    try {');
        buffer.writeln(
          '      final rawValue = $valueVar is JsonModel ? $valueVar.toJsonValue() : $valueVar;',
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

  final hasPatternProps = schema.patternProperties.isNotEmpty;
  if (hasPatternProps) {
    buffer.writeln('    patternProperties.forEach((key, value) {');
    var i = 0;
    schema.patternProperties.forEach((pattern, patternSchema) {
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
          throw JsonValidationException(e.message, [${path.map((p) => "'${p.replaceAll("'", "\\'")}'").join(', ')}, ...e.path]);
        }''');
  } else if (real is ArraySchema) {
    final itemVar = 'item$depth';
    final indexVar = 'i$depth';
    final hasItemValidation = _hasItemValidation(real.items);
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
  if (real is StringSchema) {
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
  } else if (real is NumberSchema) {
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
      } else {
        validations.writeln(
          '      if (($valueVar / ${real.multipleOf} - ($valueVar / ${real.multipleOf}).round()).abs() > 1e-9) {',
        );
      }
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a multiple of ${real.multipleOf}', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
  } else if (real is ArraySchema) {
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
    final hasItemValidation = _hasItemValidation(real.items);
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
        [...effectivePath, '[\$i]'],
        0,
        classNames,
      );
      validations.writeln('      }');
    }
  } else if (real is BooleanSchema) {
    if (checkType) {
      validations.writeln('      if ($valueVar is! bool) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a boolean', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
  } else if (real is NullSchema) {
    if (checkType) {
      validations.writeln('      if ($valueVar != null) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be null', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
  } else if (real is EnumSchema) {
    if (checkType) {
      _generateSchemaValidations(
        validations,
        real.baseSchema,
        valueVar,
        unescapedName,
        classNames,
        checkType: true,
        path: effectivePath,
      );
    }
    final valuesLiterals = real.values
        .map((v) => _toDartLiteral(v, real.baseSchema, classNames))
        .join(', ');
    final effectiveValue =
        '$valueVar is Enum ? ($valueVar as dynamic).value : $valueVar';
    validations.writeln(
      '      if (!const [$valuesLiterals].any((v) => const DeepCollectionEquality().equals(v, $effectiveValue))) {',
    );
    validations.writeln(
      "        throw JsonValidationException('Property \"$name\" must be one of ${real.values}', $effectivePathExpr);",
    );
    validations.writeln('      }');
  } else if (real is ObjectSchema || real is UnionSchema) {
    if (checkType) {
      final className = classNames[real]!;
      validations.writeln('      if ($valueVar is! $className) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must be a $className', $effectivePathExpr);",
      );
      validations.writeln('      }');
    }
  } else if (real is AnythingSchema) {
    // Always succeeds, so do nothing.
  } else if (real is NeverSchema) {
    validations.writeln(
      "      throw JsonValidationException('Property \"$name\" matches nothing', $effectivePathExpr);",
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
        '        final rawValue = $valueVar is JsonModel ? $valueVar.toJsonValue() : $valueVar;',
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
