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

/// The base class for all parsed JSON Schema representations.
sealed class Schema {
  /// The title of the schema, if specified.
  final String? title;

  /// The description of the schema, if specified.
  final String? description;

  /// Whether this schema is deprecated.
  final bool isDeprecated;

  /// Whether this schema has a default value.
  final bool hasDefault;

  /// The default value, if specified.
  final Object? defaultValue;

  /// Schema that must not validate successfully.
  final Schema? not;

  /// Const constructor for subclass schemas.
  const Schema({
    this.title,
    this.description,
    this.isDeprecated = false,
    this.hasDefault = false,
    this.defaultValue,
    this.not,
  });
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
    super.hasDefault,
    super.defaultValue,
    super.not,
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
    super.isDeprecated,
    super.hasDefault,
    super.defaultValue,
    super.not,
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
    super.hasDefault,
    super.defaultValue,
    super.not,
  });
}

/// Represents a schema that never validates successfully (used for additionalProperties: false).
final class NeverSchema extends Schema {
  /// Const constructor for NeverSchema.
  const NeverSchema({
    super.title,
    super.description,
    super.isDeprecated,
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
