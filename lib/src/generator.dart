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

import 'dart:io';
import 'schema.dart';

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
    if (schema.not != null || real.not != null) {
      return 'dynamic';
    }
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
  } else if (real is AllOfSchema) {
    if (real.subschemas.length == 1) {
      return dartType(real.subschemas.first, classNames);
    }
    return 'dynamic';
  }
  return 'dynamic';
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
        discoverClasses(sub, '${candidate}_OptionType$index');
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
    _checkAndWarnNot(preferredName, schema);
    if (schema.not != null) {
      discoverClasses(schema.not!, '${preferredName}_Not');
    }
  }

  discoverClasses(rootSchema, rootName);

  final buffer = StringBuffer();
  buffer.writeln('''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code

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

String _generateEnumClass(EnumSchema schema, String className) {
  final buffer = StringBuffer();

  // Detect backing type
  final isString = schema.values.every((v) => v is String);
  final isInt = schema.values.every((v) => v is int);
  final backingType = isString ? 'String' : (isInt ? 'int' : 'dynamic');

  if (schema.isDeprecated) {
    buffer.writeln('@deprecated');
  }
  buffer.writeln('enum $className {');
  for (final val in schema.values) {
    final enumName = _toEnumConstantName(val);
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
    if (real.not != null) {
      return 'NotDescriptor(${_descriptorExpr(real.not!, classNames)})';
    }
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
  } else if (real is AllOfSchema) {
    if (real.subschemas.length == 1) {
      return _descriptorExpr(real.subschemas.first, classNames);
    }
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
                baseType == 'Object?'
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

String? _toDartLiteral(
  Object? value,
  Schema schema,
  Map<Schema, String> classNames, {
  bool raw = false,
}) {
  final real = schema.realSchema;
  if (real is EnumSchema) {
    final className = classNames[real];
    if (className != null && !raw) {
      final constName = _toEnumConstantName(value);
      return '$className.$constName';
    } else {
      return _toDartLiteral(value, real.baseSchema, classNames, raw: raw);
    }
  }
  if (value == null) return 'null';
  if (value is String) {
    return "'${value.replaceAll("'", r"\'")}'";
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
        final lit = _toDartLiteral(val, real.items, classNames, raw: raw);
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
          final lit = _toDartLiteral(v, propSchema, classNames, raw: raw);
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
      fields.writeln('  @deprecated');
    }
    fields.writeln('  final $fieldType $fieldName;');
    if (isRequired) {
      constructorParams.writeln('    required this.$fieldName,');
    } else if (defaultLiteral != null) {
      constructorParams.writeln('    this.$fieldName = $defaultLiteral,');
    } else {
      constructorParams.writeln('    this.$fieldName,');
    }

    final copyWithType =
        (baseType.endsWith('?') || baseType == 'dynamic')
            ? baseType
            : '$baseType?';
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
        "        $fieldName: fields['$name'] as $baseType,",
      );
    } else if (defaultLiteral != null) {
      instantiateArgs.writeln(
        "        $fieldName: fields.containsKey('$name') ? fields['$name'] as $fieldType : $defaultLiteral,",
      );
    } else {
      instantiateArgs.writeln(
        "        $fieldName: fields['$name'] as $fieldType,",
      );
    }
  });

  if (hasAdditionalProps) {
    getFieldsMap.writeln("      ...instance.additionalProperties,");
    final addPropsType = dartType(schema.additionalProperties!, classNames);
    final propKeysLiteral =
        '<String>{${schema.properties.keys.map((k) => "'$k'").join(', ')}}';
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
    getFields: (instance) => {
$getFieldsMap    },
    properties: {
$propDescriptors    },
    required: const [${schema.required.map((r) => "'$r'").join(', ')}],
    ${addPropsExpr != null ? 'additionalProperties: $addPropsExpr,' : ''}
  );''';

  final deprecatedAttr = schema.isDeprecated ? '@deprecated\n' : '';
  return '''
${deprecatedAttr}final class $className implements JsonModel {
$fields
  const $className({
$constructorParams  });

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
      final patternEscaped = real.pattern!.replaceAll("'", r"\'");
      buffer.writeln(
        '      if (!RegExp(r\'$patternEscaped\').hasMatch($valueVar)) $resultVar = false;',
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
    buffer.writeln('    if ($valueVar is $className) {');
    buffer.writeln('      $resultVar = true;');
    buffer.writeln('    } else {');
    buffer.writeln('      try {');
    buffer.writeln('        $className.fromValue($valueVar);');
    buffer.writeln('        $resultVar = true;');
    buffer.writeln('      } catch (_) {}');
    buffer.writeln('    }');
  }
  return buffer.toString();
}

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
          rawEnum: true,
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
        final descExpr = _descriptorExpr(propSchema.not!, classNames);
        buffer.writeln('    bool notMatches_$fieldName = true;');
        buffer.writeln('    try {');
        buffer.writeln('      final rawValue = $valueVar is JsonModel ? $valueVar.toJsonValue() : $valueVar;');
        buffer.writeln('      parseWithDescriptor(JsonReader.fromObject(rawValue), $descExpr, validate: true);');
        buffer.writeln('    } on JsonValidationException {');
        buffer.writeln('      notMatches_$fieldName = false;');
        buffer.writeln('    } on FormatException {');
        buffer.writeln('      notMatches_$fieldName = false;');
        buffer.writeln('    }');
        buffer.writeln('    if (notMatches_$fieldName) {');
        buffer.writeln(
          "      throw JsonValidationException('Property \"$name\" must not match the schema', ['$name']);",
        );
        buffer.writeln('    }');
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
      buffer.writeln('''
    additionalProperties.forEach((key, value) {
      try {
        value.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [key, ...e.path]);
      }
    });''');
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

void _generateSchemaValidations(
  StringBuffer validations,
  Schema schema,
  String valueVar,
  String name,
  Map<Schema, String> classNames, {
  bool checkType = false,
  bool includeNot = true,
  bool rawEnum = false,
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
        '      if ($valueVar.length != $valueVar.toSet().length) {',
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
          validations.writeln('''
      if ($valueVar.length > $i) {
        try {
          $valueVar[$i].validate();
        } on JsonValidationException catch (e) {
          throw JsonValidationException(e.message, ['$name', '[$i]', ...e.path]);
        }
      }''');
        }
      }
    }
    final hasItemValidation = _hasValidationMethod(real.items);
    if (hasItemValidation) {
      final startIndex = real.prefixItems?.length ?? 0;
      validations.writeln('''
      for (var i = $startIndex; i < $valueVar.length; i++) {
        try {
          $valueVar[i].validate();
        } on JsonValidationException catch (e) {
          throw JsonValidationException(e.message, ['$name', '[\$i]', ...e.path]);
        }
      }''');
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
        rawEnum: rawEnum,
      );
    }
    final valuesLiterals = real.values
        .map((v) => _toDartLiteral(v, real, classNames, raw: rawEnum))
        .join(', ');
    validations.writeln(
      '      if (!const [$valuesLiterals].contains($valueVar)) {',
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
        rawEnum: true,
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
      final descExpr = _descriptorExpr(schema.not!, classNames);
      validations.writeln('      bool notMatches = true;');
      validations.writeln('      try {');
      validations.writeln('        final rawValue = $valueVar is JsonModel ? $valueVar.toJsonValue() : $valueVar;');
      validations.writeln('        parseWithDescriptor(JsonReader.fromObject(rawValue), $descExpr, validate: true);');
      validations.writeln('      } on JsonValidationException {');
      validations.writeln('        notMatches = false;');
      validations.writeln('      } on FormatException {');
      validations.writeln('        notMatches = false;');
      validations.writeln('      }');
      validations.writeln('      if (notMatches) {');
      validations.writeln(
        "        throw JsonValidationException('Property \"$name\" must not match the schema', ['$name']);",
      );
      validations.writeln('      }');
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

    final optDeprecatedAttr = sub.isDeprecated ? '@deprecated\n' : '';
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

  final deprecatedAttr = schema.isDeprecated ? '@deprecated\n' : '';
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

void _checkAndWarnNot(String fieldName, Schema propSchema) {
  if (propSchema.not != null) {
    var real = propSchema.realSchema;
    if (real is AllOfSchema && real.subschemas.length == 1) {
      real = real.subschemas.first.realSchema;
    }
    final notReal = propSchema.not!.realSchema;
    
    if (real is AnythingSchema) {
      stderr.writeln('WARNING: Field "$fieldName" has "not" constraint but no explicit type. It will fall back to dynamic.');
    } else if (notReal is! AnythingSchema && _isTypeOnlySchema(notReal)) {
      if (real.runtimeType == notReal.runtimeType) {
        if (real is NumberSchema && notReal is NumberSchema) {
          if (real.isInteger == notReal.isInteger) {
            stderr.writeln('WARNING: Field "$fieldName" negates its own type. It will always fail validation.');
          }
        } else {
          stderr.writeln('WARNING: Field "$fieldName" negates its own type. It will always fail validation.');
        }
      }
    }
  }
}

bool _isTypeOnlySchema(Schema schema) {
  return _hasNoConstraints(schema) && schema.not == null;
}

bool _hasNoConstraints(Schema schema) {
  return switch (schema) {
    StringSchema s => s.minLength == null && s.maxLength == null && s.pattern == null && s.format == null,
    NumberSchema s => s.minimum == null && s.maximum == null && s.exclusiveMinimum == null && s.exclusiveMaximum == null && s.multipleOf == null,
    ArraySchema s => s.minItems == null && s.maxItems == null && s.uniqueItems == null && s.contains == null && s.prefixItems == null,
    ObjectSchema s => s.properties.isEmpty && s.required.isEmpty && s.additionalProperties == null && s.minProperties == null && s.maxProperties == null,
    _ => true,
  };
}
