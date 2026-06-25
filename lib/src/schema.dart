import 'dart:core';

/// Represents a discriminator mapping.
class Discriminator {
  /// The name of the property to discriminate on.
  final String propertyName;

  /// Optional mapping of property values to schemas.
  final Map<String, Schema>? mapping;

  /// Const constructor.
  const Discriminator({required this.propertyName, this.mapping});
}

/// A unified representation of a JSON Schema.
///
/// Supports all Draft 2020-12 keywords. Sibling keywords can coexist with `$ref`.
final class Schema {
  /// Whether this schema had an explicit type in the source JSON.
  final bool hasExplicitType;

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

  /// Schema that must not validate successfully.
  final Schema? not;

  /// Custom name to use for generated Dart class, if specified via x-dart-name.
  final String? dartName;

  // Identity and Refs

  /// The `$id` of the schema.
  final String? id;

  /// The `$anchor` of the schema.
  final String? anchor;

  /// The `$dynamicAnchor` of the schema.
  final String? dynamicAnchor;

  /// The `$ref` URI.
  final String? ref;

  /// The `$dynamicRef` URI.
  final String? dynamicRef;

  /// The active vocabularies for this schema. If null, all vocabularies are active.
  final Set<String>? vocabularies;

  /// All dynamic anchors in the schema document, keyed by absolute URI (resourceUri#anchor).
  final Map<String, Schema>? dynamicAnchors;

  /// The URI of the enclosing schema resource (usually the nearest ancestor with $id).
  final String? resourceUri;

  /// The lexically resolved target schema for [ref] or [dynamicRef].
  Schema? resolvedRef;

  // Core Keywords

  /// The allowed types for this schema.
  final List<String>? type;

  /// The allowed values for this schema (from `enum`).
  final List<dynamic>? enumValues;

  /// The constant value for this schema (from `const`).
  final dynamic constValue;

  // Object Constraints

  /// Map of property names to their schemas.
  final Map<String, Schema>? properties;

  /// Map of regular expressions to schemas for pattern properties.
  final Map<RegExp, Schema>? patternProperties;

  /// Set of required property names.
  final Set<String>? required;

  /// Schema for additional properties.
  final Schema? additionalProperties;

  /// Minimum number of properties.
  final int? minProperties;

  /// Maximum number of properties.
  final int? maxProperties;

  /// Dependent required properties.
  final Map<String, Set<String>>? dependentRequired;

  /// Dependent schemas.
  final Map<String, Schema>? dependentSchemas;

  /// Schema for unevaluated properties.
  final Schema? unevaluatedProperties;

  /// Schema for property names validation.
  final Schema? propertyNames;

  /// Discriminator for unions.
  final Discriminator? discriminator;

  // Array Constraints

  /// Schema for array items.
  final Schema? items;

  /// Schemas for prefix items (tuple-like).
  final List<Schema>? prefixItems;

  /// Minimum number of items.
  final int? minItems;

  /// Maximum number of items.
  final int? maxItems;

  /// Whether all items must be unique.
  final bool? uniqueItems;

  /// Schema that at least one item must validate against.
  final Schema? contains;

  /// Minimum number of items that must validate against [contains].
  final int? minContains;

  /// Maximum number of items that must validate against [contains].
  final int? maxContains;

  /// Schema for unevaluated items.
  final Schema? unevaluatedItems;

  // String Constraints

  /// Minimum length of the string.
  final int? minLength;

  /// Maximum length of the string.
  final int? maxLength;

  /// Regular expression pattern the string must match.
  final String? pattern;

  /// Format assertion (e.g., 'date-time', 'email').
  final String? format;

  // Number Constraints

  /// Minimum value.
  final num? minimum;

  /// Maximum value.
  final num? maximum;

  /// Exclusive minimum value.
  final num? exclusiveMinimum;

  /// Exclusive maximum value.
  final num? exclusiveMaximum;

  /// Value must be a multiple of this.
  final num? multipleOf;

  // Subschemas (Combinators)

  /// Subschemas that must all validate successfully.
  final List<Schema>? allOf;

  /// Subschemas where at least one must validate successfully.
  final List<Schema>? anyOf;

  /// Subschemas where exactly one must validate successfully.
  final List<Schema>? oneOf;

  /// The `if` subschema.
  final Schema? ifSchema;

  /// The `then` subschema.
  final Schema? thenSchema;

  /// The `else` subschema.
  final Schema? elseSchema;

  // Boolean Schema Representation (true / false)

  /// If non-null, represents a boolean schema (true = always passes, false = always fails).
  final bool? booleanValue;

  /// Const constructor.
  Schema({
    this.hasExplicitType = true,
    this.title,
    this.description,
    this.isDeprecated = false,
    this.deprecatedMessage,
    this.hasDefault = false,
    this.defaultValue,
    this.not,
    this.dartName,
    this.id,
    this.anchor,
    this.dynamicAnchor,
    this.ref,
    this.dynamicRef,
    this.type,
    this.enumValues,
    this.constValue,
    this.properties,
    this.patternProperties,
    this.required,
    this.additionalProperties,
    this.minProperties,
    this.maxProperties,
    this.dependentRequired,
    this.dependentSchemas,
    this.unevaluatedProperties,
    this.propertyNames,
    this.discriminator,
    this.items,
    this.prefixItems,
    this.minItems,
    this.maxItems,
    this.uniqueItems,
    this.contains,
    this.minContains,
    this.maxContains,
    this.unevaluatedItems,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.format,
    this.minimum,
    this.maximum,
    this.exclusiveMinimum,
    this.exclusiveMaximum,
    this.multipleOf,
    this.allOf,
    this.anyOf,
    this.oneOf,
    this.ifSchema,
    this.thenSchema,
    this.elseSchema,
    this.booleanValue,
    this.vocabularies,
    this.dynamicAnchors,
    this.resourceUri,
  });

  /// Creates a copy of this schema with the given fields replaced with the new values.
  ///
  /// If [clearAllOf] is true, the `allOf` field will be cleared (set to null)
  /// instead of copied from the original schema.
  Schema copyWith({
    bool? hasExplicitType,
    String? title,
    String? description,
    bool? isDeprecated,
    String? deprecatedMessage,
    bool? hasDefault,
    Object? defaultValue,
    Schema? not,
    String? dartName,
    String? id,
    String? anchor,
    String? dynamicAnchor,
    String? ref,
    String? dynamicRef,
    List<String>? type,
    List<dynamic>? enumValues,
    dynamic constValue,
    Map<String, Schema>? properties,
    Map<RegExp, Schema>? patternProperties,
    Set<String>? required,
    Schema? additionalProperties,
    int? minProperties,
    int? maxProperties,
    Map<String, Set<String>>? dependentRequired,
    Map<String, Schema>? dependentSchemas,
    Schema? unevaluatedProperties,
    Schema? propertyNames,
    Discriminator? discriminator,
    Schema? items,
    List<Schema>? prefixItems,
    int? minItems,
    int? maxItems,
    bool? uniqueItems,
    Schema? contains,
    int? minContains,
    int? maxContains,
    Schema? unevaluatedItems,
    int? minLength,
    int? maxLength,
    String? pattern,
    String? format,
    num? minimum,
    num? maximum,
    num? exclusiveMinimum,
    num? exclusiveMaximum,
    num? multipleOf,
    List<Schema>? allOf,
    bool clearAllOf = false,
    List<Schema>? anyOf,
    List<Schema>? oneOf,
    Schema? ifSchema,
    Schema? thenSchema,
    Schema? elseSchema,
    bool? booleanValue,
    Set<String>? vocabularies,
    Map<String, Schema>? dynamicAnchors,
    String? resourceUri,
  }) {
    final newSchema = Schema(
      hasExplicitType: hasExplicitType ?? this.hasExplicitType,
      title: title ?? this.title,
      description: description ?? this.description,
      isDeprecated: isDeprecated ?? this.isDeprecated,
      deprecatedMessage: deprecatedMessage ?? this.deprecatedMessage,
      hasDefault: hasDefault ?? this.hasDefault,
      defaultValue: defaultValue ?? this.defaultValue,
      not: not ?? this.not,
      dartName: dartName ?? this.dartName,
      id: id ?? this.id,
      anchor: anchor ?? this.anchor,
      dynamicAnchor: dynamicAnchor ?? this.dynamicAnchor,
      ref: ref ?? this.ref,
      dynamicRef: dynamicRef ?? this.dynamicRef,
      type: type ?? this.type,
      enumValues: enumValues ?? this.enumValues,
      constValue: constValue ?? this.constValue,
      properties: properties ?? this.properties,
      patternProperties: patternProperties ?? this.patternProperties,
      required: required ?? this.required,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      minProperties: minProperties ?? this.minProperties,
      maxProperties: maxProperties ?? this.maxProperties,
      dependentRequired: dependentRequired ?? this.dependentRequired,
      dependentSchemas: dependentSchemas ?? this.dependentSchemas,
      unevaluatedProperties:
          unevaluatedProperties ?? this.unevaluatedProperties,
      propertyNames: propertyNames ?? this.propertyNames,
      discriminator: discriminator ?? this.discriminator,
      items: items ?? this.items,
      prefixItems: prefixItems ?? this.prefixItems,
      minItems: minItems ?? this.minItems,
      maxItems: maxItems ?? this.maxItems,
      uniqueItems: uniqueItems ?? this.uniqueItems,
      contains: contains ?? this.contains,
      minContains: minContains ?? this.minContains,
      maxContains: maxContains ?? this.maxContains,
      unevaluatedItems: unevaluatedItems ?? this.unevaluatedItems,
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
      pattern: pattern ?? this.pattern,
      format: format ?? this.format,
      minimum: minimum ?? this.minimum,
      maximum: maximum ?? this.maximum,
      exclusiveMinimum: exclusiveMinimum ?? this.exclusiveMinimum,
      exclusiveMaximum: exclusiveMaximum ?? this.exclusiveMaximum,
      multipleOf: multipleOf ?? this.multipleOf,
      allOf: clearAllOf ? null : (allOf ?? this.allOf),
      anyOf: anyOf ?? this.anyOf,
      oneOf: oneOf ?? this.oneOf,
      ifSchema: ifSchema ?? this.ifSchema,
      thenSchema: thenSchema ?? this.thenSchema,
      elseSchema: elseSchema ?? this.elseSchema,
      booleanValue: booleanValue ?? this.booleanValue,
      vocabularies: vocabularies ?? this.vocabularies,
      dynamicAnchors: dynamicAnchors ?? this.dynamicAnchors,
      resourceUri: resourceUri ?? this.resourceUri,
    );
    newSchema.resolvedRef = resolvedRef;
    return newSchema;
  }

  /// Returns a new [Schema] that is a copy of this schema but with [enumValues]
  /// set to null.
  ///
  /// This is used during code generation to separate the enum class definition
  /// from the base schema type validations.
  Schema removeEnum() {
    final newSchema = Schema(
      hasExplicitType: hasExplicitType,
      title: title,
      description: description,
      isDeprecated: isDeprecated,
      deprecatedMessage: deprecatedMessage,
      hasDefault: hasDefault,
      defaultValue: defaultValue,
      not: not,
      dartName: dartName,
      id: id,
      anchor: anchor,
      dynamicAnchor: dynamicAnchor,
      ref: ref,
      dynamicRef: dynamicRef,
      type: type,
      enumValues: null,
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
      discriminator: discriminator,
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
      booleanValue: booleanValue,
      vocabularies: vocabularies,
      dynamicAnchors: dynamicAnchors,
      resourceUri: resourceUri,
    );
    newSchema.resolvedRef = resolvedRef;
    return newSchema;
  }

  /// Predefined schema that always passes validation.
  static final Schema anything = Schema(booleanValue: true);

  /// Predefined schema that always fails validation.
  static final Schema never = Schema(booleanValue: false);
}

/// Helper extensions on [Schema] to ease migration and support validation/generation.
extension SchemaHelpers on Schema {
  /// Whether this schema always fails validation.
  bool get isNever => booleanValue == false;

  /// Whether this schema always passes validation (empty schema or `true`).
  bool get isAnything =>
      booleanValue == true ||
      (booleanValue == null &&
          ref == null &&
          dynamicRef == null &&
          type == null &&
          enumValues == null &&
          constValue == null &&
          properties == null &&
          patternProperties == null &&
          required == null &&
          additionalProperties == null &&
          minProperties == null &&
          maxProperties == null &&
          dependentRequired == null &&
          dependentSchemas == null &&
          unevaluatedProperties == null &&
          propertyNames == null &&
          discriminator == null &&
          items == null &&
          prefixItems == null &&
          minItems == null &&
          maxItems == null &&
          uniqueItems == null &&
          contains == null &&
          minContains == null &&
          maxContains == null &&
          unevaluatedItems == null &&
          minLength == null &&
          maxLength == null &&
          pattern == null &&
          format == null &&
          minimum == null &&
          maximum == null &&
          exclusiveMinimum == null &&
          exclusiveMaximum == null &&
          multipleOf == null &&
          allOf == null &&
          anyOf == null &&
          oneOf == null &&
          ifSchema == null &&
          thenSchema == null &&
          elseSchema == null &&
          not == null);

  /// Whether this schema contains object constraints.
  bool get isObject =>
      type?.contains('object') == true ||
      (type == null &&
          (properties != null ||
              patternProperties != null ||
              required != null ||
              additionalProperties != null ||
              minProperties != null ||
              maxProperties != null ||
              dependentRequired != null ||
              dependentSchemas != null ||
              unevaluatedProperties != null ||
              propertyNames != null));

  /// Whether this schema contains array constraints.
  bool get isArray =>
      type?.contains('array') == true ||
      (type == null &&
          (items != null ||
              prefixItems != null ||
              minItems != null ||
              maxItems != null ||
              uniqueItems != null ||
              contains != null ||
              unevaluatedItems != null));

  /// Whether this schema contains string constraints.
  bool get isString =>
      type?.contains('string') == true ||
      (type == null &&
          (minLength != null ||
              maxLength != null ||
              pattern != null ||
              format != null));

  /// Whether this schema contains numeric constraints.
  bool get isNumber =>
      type?.contains('number') == true ||
      type?.contains('integer') == true ||
      (type == null &&
          (minimum != null ||
              maximum != null ||
              exclusiveMinimum != null ||
              exclusiveMaximum != null ||
              multipleOf != null));

  /// Whether this schema is strictly an integer.
  bool get isInteger => type?.contains('integer') == true;

  /// Whether this schema is strictly a boolean.
  bool get isBoolean => type?.contains('boolean') == true;

  /// Whether this schema is strictly null.
  bool get isNull => type?.contains('null') == true;

  /// Whether this schema represents a union of types or schemas.
  bool get isUnion =>
      anyOf != null || oneOf != null || (type != null && type!.length > 1);

  /// Resolves references recursively (lexically).
  Schema get realSchema {
    var current = this;
    final seen = <Schema>{};
    while (current.ref != null || current.dynamicRef != null) {
      if (!seen.add(current)) {
        throw StateError('Cyclic reference detected');
      }
      final resolved = current.resolvedRef;
      if (resolved == null) {
        throw StateError(
          'Ref has not been resolved: ${current.ref ?? current.dynamicRef}',
        );
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

  static final Expando<UnionAnalysis> _cache = Expando();

  /// Analyzes a [Schema] (which must be a union) to extract nullability information.
  factory UnionAnalysis.analyze(Schema schema) {
    final real = schema.realSchema;
    final cached = _cache[real];
    if (cached != null) return cached;
    final active = <Schema>[];
    bool nullable = false;

    if (real.type != null && real.type!.length > 1) {
      for (final t in real.type!) {
        if (t == 'null') {
          nullable = true;
        } else {
          active.add(real.copyWith(type: [t]));
        }
      }
    } else if (real.anyOf != null) {
      for (final s in real.anyOf!) {
        final r = s.realSchema;
        if (r.isNull) {
          nullable = true;
        } else {
          active.add(s);
        }
      }
    } else if (real.oneOf != null) {
      for (final s in real.oneOf!) {
        final r = s.realSchema;
        if (r.isNull) {
          nullable = true;
        } else {
          active.add(s);
        }
      }
    }

    final result = (nullable && active.length == 1)
        ? UnionAnalysis(
            isNullable: true,
            nonNullSchema: active.first,
            activeSchemas: active,
          )
        : UnionAnalysis(
            isNullable: nullable,
            nonNullSchema: null,
            activeSchemas: active,
          );
    _cache[real] = result;
    return result;
  }
}
