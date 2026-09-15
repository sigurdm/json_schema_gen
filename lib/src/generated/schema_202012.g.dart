// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides, unnecessary_null_comparison
// ignore_for_file: prefer_is_empty, unnecessary_string_interpolations, avoid_init_to_null, unnecessary_const
// ignore_for_file: unnecessary_question_mark, unnecessary_cast

import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';

sealed class CoreAndValidationSpecificationsMetaSchema implements JsonModel {
  const CoreAndValidationSpecificationsMetaSchema();

  factory CoreAndValidationSpecificationsMetaSchema.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as CoreAndValidationSpecificationsMetaSchema;

  /// Creates an instance of [CoreAndValidationSpecificationsMetaSchema] from a JSON-compatible Dart value.
  factory CoreAndValidationSpecificationsMetaSchema.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => CoreAndValidationSpecificationsMetaSchema.fromJson(
    JsonReader.fromObject(value),
    validate: validate,
  );

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

  static final UnionDescriptor<CoreAndValidationSpecificationsMetaSchema>
  descriptor = UnionDescriptor<CoreAndValidationSpecificationsMetaSchema>(
    title: 'CoreAndValidationSpecificationsMetaSchema',

    activeOptions: [
      UnionOptionDescriptor<
        CoreAndValidationSpecificationsMetaSchema,
        CoreAndValidationSpecificationsMetaSchema1
      >(
        RefDescriptor<CoreAndValidationSpecificationsMetaSchema1>(
          () => CoreAndValidationSpecificationsMetaSchema1.descriptor,
        ),
        (val) => CoreAndValidationSpecificationsMetaSchemaOption0(
          val as CoreAndValidationSpecificationsMetaSchema1,
        ),
      ),
      UnionOptionDescriptor<CoreAndValidationSpecificationsMetaSchema, bool>(
        const BoolDescriptor(),
        (val) => CoreAndValidationSpecificationsMetaSchemaOption1(val as bool),
      ),
    ],
  );
}

final class CoreAndValidationSpecificationsMetaSchemaOption0
    extends CoreAndValidationSpecificationsMetaSchema {
  final CoreAndValidationSpecificationsMetaSchema1 value;
  const CoreAndValidationSpecificationsMetaSchemaOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(
      target,
      value,
      RefDescriptor<CoreAndValidationSpecificationsMetaSchema1>(
        () => CoreAndValidationSpecificationsMetaSchema1.descriptor,
      ),
    );
  }

  @override
  List<ValidationError> collectErrors() => value.collectErrors();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAndValidationSpecificationsMetaSchemaOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchemaOption0(value: $value)';
}

final class CoreAndValidationSpecificationsMetaSchemaOption1
    extends CoreAndValidationSpecificationsMetaSchema {
  final bool value;
  const CoreAndValidationSpecificationsMetaSchemaOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const BoolDescriptor());
  }

  @override
  List<ValidationError> collectErrors() {
    return const [];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAndValidationSpecificationsMetaSchemaOption1 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchemaOption1(value: $value)';
}

final class CoreAndValidationSpecificationsMetaSchema1 implements JsonModel {
  /// Comment: Non-empty fragments not allowed.
  final String? id;
  final String? schema;
  final String? ref;
  final String? anchor;
  final String? dynamicRef;
  final String? dynamicAnchor;
  final CoreAndValidationSpecificationsMetaSchema1Vocabulary? vocabulary;
  final String? comment;
  final CoreAndValidationSpecificationsMetaSchema1Defs? defs;
  final List<CoreAndValidationSpecificationsMetaSchema>? prefixItems;
  final CoreAndValidationSpecificationsMetaSchema? items;
  final CoreAndValidationSpecificationsMetaSchema? contains;
  final CoreAndValidationSpecificationsMetaSchema? additionalProperties_;
  final CoreAndValidationSpecificationsMetaSchema1Properties properties;
  final CoreAndValidationSpecificationsMetaSchema1PatternProperties
  patternProperties_;
  final CoreAndValidationSpecificationsMetaSchema1DependentSchemas
  dependentSchemas;
  final CoreAndValidationSpecificationsMetaSchema? propertyNames;
  final CoreAndValidationSpecificationsMetaSchema? if_;
  final CoreAndValidationSpecificationsMetaSchema? then;
  final CoreAndValidationSpecificationsMetaSchema? else_;
  final List<CoreAndValidationSpecificationsMetaSchema>? allOf;
  final List<CoreAndValidationSpecificationsMetaSchema>? anyOf;
  final List<CoreAndValidationSpecificationsMetaSchema>? oneOf;
  final CoreAndValidationSpecificationsMetaSchema? not;
  final CoreAndValidationSpecificationsMetaSchema? unevaluatedItems;
  final CoreAndValidationSpecificationsMetaSchema? unevaluatedProperties;
  final CoreAndValidationSpecificationsMetaSchema1Type? type_;
  final Object? const_;
  final List<Object?>? enum_;
  final num? multipleOf;
  final num? maximum;
  final num? exclusiveMaximum;
  final num? minimum;
  final num? exclusiveMinimum;
  final int? maxLength;
  final int? minLength;
  final String? pattern;
  final int? maxItems;
  final int? minItems;
  final bool uniqueItems;
  final int? maxContains;
  final int minContains;
  final int? maxProperties;
  final int? minProperties;
  final List<String>? required_;
  final CoreAndValidationSpecificationsMetaSchema1DependentRequired?
  dependentRequired;
  final String? title;
  final String? description;
  final Object? default_;
  final bool deprecated;
  final bool readOnly;
  final bool writeOnly;
  final List<Object?>? examples;
  final String? format;
  final String? contentEncoding;
  final String? contentMediaType;
  final CoreAndValidationSpecificationsMetaSchema? contentSchema;

  /// Comment: "definitions" has been replaced by "$defs".
  @Deprecated('deprecated')
  final CoreAndValidationSpecificationsMetaSchema1Definitions definitions;

  /// Comment: "dependencies" has been split and replaced by "dependentSchemas" and "dependentRequired" in order to serve their differing semantics.
  @Deprecated('deprecated')
  final CoreAndValidationSpecificationsMetaSchema1Dependencies dependencies;

  /// Comment: "$recursiveAnchor" has been replaced by "$dynamicAnchor".
  @Deprecated('deprecated')
  final String? recursiveAnchor;

  /// Comment: "$recursiveRef" has been replaced by "$dynamicRef".
  @Deprecated('deprecated')
  final String? recursiveRef;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const CoreAndValidationSpecificationsMetaSchema1({
    this.id,
    this.schema,
    this.ref,
    this.anchor,
    this.dynamicRef,
    this.dynamicAnchor,
    this.vocabulary,
    this.comment,
    this.defs,
    this.prefixItems,
    this.items,
    this.contains,
    this.additionalProperties_,
    this.properties =
        const CoreAndValidationSpecificationsMetaSchema1Properties(),
    this.patternProperties_ =
        const CoreAndValidationSpecificationsMetaSchema1PatternProperties(),
    this.dependentSchemas =
        const CoreAndValidationSpecificationsMetaSchema1DependentSchemas(),
    this.propertyNames,
    this.if_,
    this.then,
    this.else_,
    this.allOf,
    this.anyOf,
    this.oneOf,
    this.not,
    this.unevaluatedItems,
    this.unevaluatedProperties,
    this.type_,
    this.const_,
    this.enum_,
    this.multipleOf,
    this.maximum,
    this.exclusiveMaximum,
    this.minimum,
    this.exclusiveMinimum,
    this.maxLength,
    this.minLength,
    this.pattern,
    this.maxItems,
    this.minItems,
    this.uniqueItems = false,
    this.maxContains,
    this.minContains = 1,
    this.maxProperties,
    this.minProperties,
    this.required_,
    this.dependentRequired,
    this.title,
    this.description,
    this.default_,
    this.deprecated = false,
    this.readOnly = false,
    this.writeOnly = false,
    this.examples,
    this.format,
    this.contentEncoding,
    this.contentMediaType,
    this.contentSchema,
    this.definitions =
        const CoreAndValidationSpecificationsMetaSchema1Definitions(),
    this.dependencies =
        const CoreAndValidationSpecificationsMetaSchema1Dependencies(),
    this.recursiveAnchor,
    this.recursiveRef,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory CoreAndValidationSpecificationsMetaSchema1.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as CoreAndValidationSpecificationsMetaSchema1;

  /// Creates an instance of [CoreAndValidationSpecificationsMetaSchema1] from a JSON Map.
  factory CoreAndValidationSpecificationsMetaSchema1.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => CoreAndValidationSpecificationsMetaSchema1.fromJson(
    JsonReader.fromObject(map),
    validate: validate,
  );

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

  CoreAndValidationSpecificationsMetaSchema1 copyWith({
    String? id,
    String? schema,
    String? ref,
    String? anchor,
    String? dynamicRef,
    String? dynamicAnchor,
    CoreAndValidationSpecificationsMetaSchema1Vocabulary? vocabulary,
    String? comment,
    CoreAndValidationSpecificationsMetaSchema1Defs? defs,
    List<CoreAndValidationSpecificationsMetaSchema>? prefixItems,
    CoreAndValidationSpecificationsMetaSchema? items,
    CoreAndValidationSpecificationsMetaSchema? contains,
    CoreAndValidationSpecificationsMetaSchema? additionalProperties_,
    CoreAndValidationSpecificationsMetaSchema1Properties? properties,
    CoreAndValidationSpecificationsMetaSchema1PatternProperties?
    patternProperties_,
    CoreAndValidationSpecificationsMetaSchema1DependentSchemas?
    dependentSchemas,
    CoreAndValidationSpecificationsMetaSchema? propertyNames,
    CoreAndValidationSpecificationsMetaSchema? if_,
    CoreAndValidationSpecificationsMetaSchema? then,
    CoreAndValidationSpecificationsMetaSchema? else_,
    List<CoreAndValidationSpecificationsMetaSchema>? allOf,
    List<CoreAndValidationSpecificationsMetaSchema>? anyOf,
    List<CoreAndValidationSpecificationsMetaSchema>? oneOf,
    CoreAndValidationSpecificationsMetaSchema? not,
    CoreAndValidationSpecificationsMetaSchema? unevaluatedItems,
    CoreAndValidationSpecificationsMetaSchema? unevaluatedProperties,
    CoreAndValidationSpecificationsMetaSchema1Type? type_,
    Object? const_,
    List<Object?>? enum_,
    num? multipleOf,
    num? maximum,
    num? exclusiveMaximum,
    num? minimum,
    num? exclusiveMinimum,
    int? maxLength,
    int? minLength,
    String? pattern,
    int? maxItems,
    int? minItems,
    bool? uniqueItems,
    int? maxContains,
    int? minContains,
    int? maxProperties,
    int? minProperties,
    List<String>? required_,
    CoreAndValidationSpecificationsMetaSchema1DependentRequired?
    dependentRequired,
    String? title,
    String? description,
    Object? default_,
    bool? deprecated,
    bool? readOnly,
    bool? writeOnly,
    List<Object?>? examples,
    String? format,
    String? contentEncoding,
    String? contentMediaType,
    CoreAndValidationSpecificationsMetaSchema? contentSchema,
    CoreAndValidationSpecificationsMetaSchema1Definitions? definitions,
    CoreAndValidationSpecificationsMetaSchema1Dependencies? dependencies,
    String? recursiveAnchor,
    String? recursiveRef,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (id != null) {
      nextKeys?.add('\$id');
    }
    if (schema != null) {
      nextKeys?.add('\$schema');
    }
    if (ref != null) {
      nextKeys?.add('\$ref');
    }
    if (anchor != null) {
      nextKeys?.add('\$anchor');
    }
    if (dynamicRef != null) {
      nextKeys?.add('\$dynamicRef');
    }
    if (dynamicAnchor != null) {
      nextKeys?.add('\$dynamicAnchor');
    }
    if (vocabulary != null) {
      nextKeys?.add('\$vocabulary');
    }
    if (comment != null) {
      nextKeys?.add('\$comment');
    }
    if (defs != null) {
      nextKeys?.add('\$defs');
    }
    if (prefixItems != null) {
      nextKeys?.add('prefixItems');
    }
    if (items != null) {
      nextKeys?.add('items');
    }
    if (contains != null) {
      nextKeys?.add('contains');
    }
    if (additionalProperties_ != null) {
      nextKeys?.add('additionalProperties');
    }
    if (properties != null) {
      nextKeys?.add('properties');
    }
    if (patternProperties_ != null) {
      nextKeys?.add('patternProperties');
    }
    if (dependentSchemas != null) {
      nextKeys?.add('dependentSchemas');
    }
    if (propertyNames != null) {
      nextKeys?.add('propertyNames');
    }
    if (if_ != null) {
      nextKeys?.add('if');
    }
    if (then != null) {
      nextKeys?.add('then');
    }
    if (else_ != null) {
      nextKeys?.add('else');
    }
    if (allOf != null) {
      nextKeys?.add('allOf');
    }
    if (anyOf != null) {
      nextKeys?.add('anyOf');
    }
    if (oneOf != null) {
      nextKeys?.add('oneOf');
    }
    if (not != null) {
      nextKeys?.add('not');
    }
    if (unevaluatedItems != null) {
      nextKeys?.add('unevaluatedItems');
    }
    if (unevaluatedProperties != null) {
      nextKeys?.add('unevaluatedProperties');
    }
    if (type_ != null) {
      nextKeys?.add('type');
    }
    if (const_ != null) {
      nextKeys?.add('const');
    }
    if (enum_ != null) {
      nextKeys?.add('enum');
    }
    if (multipleOf != null) {
      nextKeys?.add('multipleOf');
    }
    if (maximum != null) {
      nextKeys?.add('maximum');
    }
    if (exclusiveMaximum != null) {
      nextKeys?.add('exclusiveMaximum');
    }
    if (minimum != null) {
      nextKeys?.add('minimum');
    }
    if (exclusiveMinimum != null) {
      nextKeys?.add('exclusiveMinimum');
    }
    if (maxLength != null) {
      nextKeys?.add('maxLength');
    }
    if (minLength != null) {
      nextKeys?.add('minLength');
    }
    if (pattern != null) {
      nextKeys?.add('pattern');
    }
    if (maxItems != null) {
      nextKeys?.add('maxItems');
    }
    if (minItems != null) {
      nextKeys?.add('minItems');
    }
    if (uniqueItems != null) {
      nextKeys?.add('uniqueItems');
    }
    if (maxContains != null) {
      nextKeys?.add('maxContains');
    }
    if (minContains != null) {
      nextKeys?.add('minContains');
    }
    if (maxProperties != null) {
      nextKeys?.add('maxProperties');
    }
    if (minProperties != null) {
      nextKeys?.add('minProperties');
    }
    if (required_ != null) {
      nextKeys?.add('required');
    }
    if (dependentRequired != null) {
      nextKeys?.add('dependentRequired');
    }
    if (title != null) {
      nextKeys?.add('title');
    }
    if (description != null) {
      nextKeys?.add('description');
    }
    if (default_ != null) {
      nextKeys?.add('default');
    }
    if (deprecated != null) {
      nextKeys?.add('deprecated');
    }
    if (readOnly != null) {
      nextKeys?.add('readOnly');
    }
    if (writeOnly != null) {
      nextKeys?.add('writeOnly');
    }
    if (examples != null) {
      nextKeys?.add('examples');
    }
    if (format != null) {
      nextKeys?.add('format');
    }
    if (contentEncoding != null) {
      nextKeys?.add('contentEncoding');
    }
    if (contentMediaType != null) {
      nextKeys?.add('contentMediaType');
    }
    if (contentSchema != null) {
      nextKeys?.add('contentSchema');
    }
    if (definitions != null) {
      nextKeys?.add('definitions');
    }
    if (dependencies != null) {
      nextKeys?.add('dependencies');
    }
    if (recursiveAnchor != null) {
      nextKeys?.add('\$recursiveAnchor');
    }
    if (recursiveRef != null) {
      nextKeys?.add('\$recursiveRef');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return CoreAndValidationSpecificationsMetaSchema1(
      id: id ?? this.id,
      schema: schema ?? this.schema,
      ref: ref ?? this.ref,
      anchor: anchor ?? this.anchor,
      dynamicRef: dynamicRef ?? this.dynamicRef,
      dynamicAnchor: dynamicAnchor ?? this.dynamicAnchor,
      vocabulary: vocabulary ?? this.vocabulary,
      comment: comment ?? this.comment,
      defs: defs ?? this.defs,
      prefixItems: prefixItems ?? this.prefixItems,
      items: items ?? this.items,
      contains: contains ?? this.contains,
      additionalProperties_:
          additionalProperties_ ?? this.additionalProperties_,
      properties: properties ?? this.properties,
      patternProperties_: patternProperties_ ?? this.patternProperties_,
      dependentSchemas: dependentSchemas ?? this.dependentSchemas,
      propertyNames: propertyNames ?? this.propertyNames,
      if_: if_ ?? this.if_,
      then: then ?? this.then,
      else_: else_ ?? this.else_,
      allOf: allOf ?? this.allOf,
      anyOf: anyOf ?? this.anyOf,
      oneOf: oneOf ?? this.oneOf,
      not: not ?? this.not,
      unevaluatedItems: unevaluatedItems ?? this.unevaluatedItems,
      unevaluatedProperties:
          unevaluatedProperties ?? this.unevaluatedProperties,
      type_: type_ ?? this.type_,
      const_: const_ ?? this.const_,
      enum_: enum_ ?? this.enum_,
      multipleOf: multipleOf ?? this.multipleOf,
      maximum: maximum ?? this.maximum,
      exclusiveMaximum: exclusiveMaximum ?? this.exclusiveMaximum,
      minimum: minimum ?? this.minimum,
      exclusiveMinimum: exclusiveMinimum ?? this.exclusiveMinimum,
      maxLength: maxLength ?? this.maxLength,
      minLength: minLength ?? this.minLength,
      pattern: pattern ?? this.pattern,
      maxItems: maxItems ?? this.maxItems,
      minItems: minItems ?? this.minItems,
      uniqueItems: uniqueItems ?? this.uniqueItems,
      maxContains: maxContains ?? this.maxContains,
      minContains: minContains ?? this.minContains,
      maxProperties: maxProperties ?? this.maxProperties,
      minProperties: minProperties ?? this.minProperties,
      required_: required_ ?? this.required_,
      dependentRequired: dependentRequired ?? this.dependentRequired,
      title: title ?? this.title,
      description: description ?? this.description,
      default_: default_ ?? this.default_,
      deprecated: deprecated ?? this.deprecated,
      readOnly: readOnly ?? this.readOnly,
      writeOnly: writeOnly ?? this.writeOnly,
      examples: examples ?? this.examples,
      format: format ?? this.format,
      contentEncoding: contentEncoding ?? this.contentEncoding,
      contentMediaType: contentMediaType ?? this.contentMediaType,
      contentSchema: contentSchema ?? this.contentSchema,
      definitions: definitions ?? this.definitions,
      dependencies: dependencies ?? this.dependencies,
      recursiveAnchor: recursiveAnchor ?? this.recursiveAnchor,
      recursiveRef: recursiveRef ?? this.recursiveRef,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_id = id;
    if (val_id != null) {
      if (!(isValidUriReference(val_id))) {
        errors.add(
          ValidationError(
            message: 'Property "\$id" must be a valid URI reference',
            path: ['\$id'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_schema = schema;
    if (val_schema != null) {
      if (!(isValidUri(val_schema))) {
        errors.add(
          ValidationError(
            message: 'Property "\$schema" must be a valid absolute URI',
            path: ['\$schema'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_ref = ref;
    if (val_ref != null) {
      if (!(isValidUriReference(val_ref))) {
        errors.add(
          ValidationError(
            message: 'Property "\$ref" must be a valid URI reference',
            path: ['\$ref'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_anchor = anchor;
    if (val_anchor != null) {
      if (!RegExp('^[A-Za-z_][-A-Za-z0-9._]*\$').hasMatch(val_anchor)) {
        errors.add(
          ValidationError(
            message:
                'Property "\$anchor" must match pattern "^[A-Za-z_][-A-Za-z0-9._]*\$"',
            path: ['\$anchor'],
            keyword: 'pattern',
          ),
        );
      }
    }
    final val_dynamicRef = dynamicRef;
    if (val_dynamicRef != null) {
      if (!(isValidUriReference(val_dynamicRef))) {
        errors.add(
          ValidationError(
            message: 'Property "\$dynamicRef" must be a valid URI reference',
            path: ['\$dynamicRef'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_dynamicAnchor = dynamicAnchor;
    if (val_dynamicAnchor != null) {
      if (!RegExp('^[A-Za-z_][-A-Za-z0-9._]*\$').hasMatch(val_dynamicAnchor)) {
        errors.add(
          ValidationError(
            message:
                'Property "\$dynamicAnchor" must match pattern "^[A-Za-z_][-A-Za-z0-9._]*\$"',
            path: ['\$dynamicAnchor'],
            keyword: 'pattern',
          ),
        );
      }
    }
    final val_vocabulary = vocabulary;
    if (val_vocabulary != null) {
      errors.addAll(
        (val_vocabulary as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['\$vocabulary', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_comment = comment;
    final val_defs = defs;
    if (val_defs != null) {
      errors.addAll(
        (val_defs as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['\$defs', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_prefixItems = prefixItems;
    if (val_prefixItems != null) {
      if (val_prefixItems.length < 1) {
        errors.add(
          ValidationError(
            message: 'Property "prefixItems" must have >= 1 items',
            path: ['prefixItems'],
            keyword: 'minItems',
          ),
        );
      }
      for (var i = 0; i < val_prefixItems.length; i++) {
        errors.addAll(
          (val_prefixItems[i] as JsonModel).collectErrors().map(
            (ValidationError e) => ValidationError(
              message: e.message,
              path: ['prefixItems', '[$i]', ...e.path],
              keyword: e.keyword,
              schema: e.schema,
              value: e.value,
              nestedErrors: e.nestedErrors,
            ),
          ),
        );
      }
    }
    final val_items = items;
    if (val_items != null) {
      errors.addAll(
        (val_items as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['items', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_contains = contains;
    if (val_contains != null) {
      errors.addAll(
        (val_contains as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['contains', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_additionalProperties_ = additionalProperties_;
    if (val_additionalProperties_ != null) {
      errors.addAll(
        (val_additionalProperties_ as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['additionalProperties', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    errors.addAll(
      (properties as JsonModel).collectErrors().map(
        (ValidationError e) => ValidationError(
          message: e.message,
          path: ['properties', ...e.path],
          keyword: e.keyword,
          schema: e.schema,
          value: e.value,
          nestedErrors: e.nestedErrors,
        ),
      ),
    );
    errors.addAll(
      (patternProperties_ as JsonModel).collectErrors().map(
        (ValidationError e) => ValidationError(
          message: e.message,
          path: ['patternProperties', ...e.path],
          keyword: e.keyword,
          schema: e.schema,
          value: e.value,
          nestedErrors: e.nestedErrors,
        ),
      ),
    );
    errors.addAll(
      (dependentSchemas as JsonModel).collectErrors().map(
        (ValidationError e) => ValidationError(
          message: e.message,
          path: ['dependentSchemas', ...e.path],
          keyword: e.keyword,
          schema: e.schema,
          value: e.value,
          nestedErrors: e.nestedErrors,
        ),
      ),
    );
    final val_propertyNames = propertyNames;
    if (val_propertyNames != null) {
      errors.addAll(
        (val_propertyNames as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['propertyNames', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_if_ = if_;
    if (val_if_ != null) {
      errors.addAll(
        (val_if_ as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['if', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_then = then;
    if (val_then != null) {
      errors.addAll(
        (val_then as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['then', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_else_ = else_;
    if (val_else_ != null) {
      errors.addAll(
        (val_else_ as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['else', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_allOf = allOf;
    if (val_allOf != null) {
      if (val_allOf.length < 1) {
        errors.add(
          ValidationError(
            message: 'Property "allOf" must have >= 1 items',
            path: ['allOf'],
            keyword: 'minItems',
          ),
        );
      }
      for (var i = 0; i < val_allOf.length; i++) {
        errors.addAll(
          (val_allOf[i] as JsonModel).collectErrors().map(
            (ValidationError e) => ValidationError(
              message: e.message,
              path: ['allOf', '[$i]', ...e.path],
              keyword: e.keyword,
              schema: e.schema,
              value: e.value,
              nestedErrors: e.nestedErrors,
            ),
          ),
        );
      }
    }
    final val_anyOf = anyOf;
    if (val_anyOf != null) {
      if (val_anyOf.length < 1) {
        errors.add(
          ValidationError(
            message: 'Property "anyOf" must have >= 1 items',
            path: ['anyOf'],
            keyword: 'minItems',
          ),
        );
      }
      for (var i = 0; i < val_anyOf.length; i++) {
        errors.addAll(
          (val_anyOf[i] as JsonModel).collectErrors().map(
            (ValidationError e) => ValidationError(
              message: e.message,
              path: ['anyOf', '[$i]', ...e.path],
              keyword: e.keyword,
              schema: e.schema,
              value: e.value,
              nestedErrors: e.nestedErrors,
            ),
          ),
        );
      }
    }
    final val_oneOf = oneOf;
    if (val_oneOf != null) {
      if (val_oneOf.length < 1) {
        errors.add(
          ValidationError(
            message: 'Property "oneOf" must have >= 1 items',
            path: ['oneOf'],
            keyword: 'minItems',
          ),
        );
      }
      for (var i = 0; i < val_oneOf.length; i++) {
        errors.addAll(
          (val_oneOf[i] as JsonModel).collectErrors().map(
            (ValidationError e) => ValidationError(
              message: e.message,
              path: ['oneOf', '[$i]', ...e.path],
              keyword: e.keyword,
              schema: e.schema,
              value: e.value,
              nestedErrors: e.nestedErrors,
            ),
          ),
        );
      }
    }
    final val_not = not;
    if (val_not != null) {
      errors.addAll(
        (val_not as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['not', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_unevaluatedItems = unevaluatedItems;
    if (val_unevaluatedItems != null) {
      errors.addAll(
        (val_unevaluatedItems as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['unevaluatedItems', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_unevaluatedProperties = unevaluatedProperties;
    if (val_unevaluatedProperties != null) {
      errors.addAll(
        (val_unevaluatedProperties as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['unevaluatedProperties', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_type_ = type_;
    if (val_type_ != null) {
      errors.addAll(
        (val_type_ as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['type', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_const_ = const_;
    final val_enum_ = enum_;
    final val_multipleOf = multipleOf;
    if (val_multipleOf != null) {
      if (val_multipleOf <= 0) {
        errors.add(
          ValidationError(
            message: 'Property "multipleOf" must be > 0',
            path: ['multipleOf'],
            keyword: 'exclusiveMinimum',
          ),
        );
      }
    }
    final val_maximum = maximum;
    final val_exclusiveMaximum = exclusiveMaximum;
    final val_minimum = minimum;
    final val_exclusiveMinimum = exclusiveMinimum;
    final val_maxLength = maxLength;
    if (val_maxLength != null) {
      if (val_maxLength < 0) {
        errors.add(
          ValidationError(
            message: 'Property "maxLength" must be >= 0',
            path: ['maxLength'],
            keyword: 'minimum',
          ),
        );
      }
    }
    final val_minLength = minLength;
    if (val_minLength != null) {
      if (val_minLength < 0) {
        errors.add(
          ValidationError(
            message: 'Property "minLength" must be >= 0',
            path: ['minLength'],
            keyword: 'minimum',
          ),
        );
      }
    }
    final val_pattern = pattern;
    final val_maxItems = maxItems;
    if (val_maxItems != null) {
      if (val_maxItems < 0) {
        errors.add(
          ValidationError(
            message: 'Property "maxItems" must be >= 0',
            path: ['maxItems'],
            keyword: 'minimum',
          ),
        );
      }
    }
    final val_minItems = minItems;
    if (val_minItems != null) {
      if (val_minItems < 0) {
        errors.add(
          ValidationError(
            message: 'Property "minItems" must be >= 0',
            path: ['minItems'],
            keyword: 'minimum',
          ),
        );
      }
    }
    final val_maxContains = maxContains;
    if (val_maxContains != null) {
      if (val_maxContains < 0) {
        errors.add(
          ValidationError(
            message: 'Property "maxContains" must be >= 0',
            path: ['maxContains'],
            keyword: 'minimum',
          ),
        );
      }
    }
    if (minContains < 0) {
      errors.add(
        ValidationError(
          message: 'Property "minContains" must be >= 0',
          path: ['minContains'],
          keyword: 'minimum',
        ),
      );
    }
    final val_maxProperties = maxProperties;
    if (val_maxProperties != null) {
      if (val_maxProperties < 0) {
        errors.add(
          ValidationError(
            message: 'Property "maxProperties" must be >= 0',
            path: ['maxProperties'],
            keyword: 'minimum',
          ),
        );
      }
    }
    final val_minProperties = minProperties;
    if (val_minProperties != null) {
      if (val_minProperties < 0) {
        errors.add(
          ValidationError(
            message: 'Property "minProperties" must be >= 0',
            path: ['minProperties'],
            keyword: 'minimum',
          ),
        );
      }
    }
    final val_required_ = required_;
    if (val_required_ != null) {
      if (val_required_.length !=
          (LinkedHashSet<dynamic>(
            equals: const DeepCollectionEquality().equals,
            hashCode: const DeepCollectionEquality().hash,
          )..addAll(val_required_)).length) {
        errors.add(
          ValidationError(
            message: 'Property "required" items must be unique',
            path: ['required'],
            keyword: 'uniqueItems',
          ),
        );
      }
    }
    final val_dependentRequired = dependentRequired;
    if (val_dependentRequired != null) {
      errors.addAll(
        (val_dependentRequired as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['dependentRequired', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_title = title;
    final val_description = description;
    final val_default_ = default_;
    final val_examples = examples;
    final val_format = format;
    final val_contentEncoding = contentEncoding;
    final val_contentMediaType = contentMediaType;
    final val_contentSchema = contentSchema;
    if (val_contentSchema != null) {
      errors.addAll(
        (val_contentSchema as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['contentSchema', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    errors.addAll(
      (definitions as JsonModel).collectErrors().map(
        (ValidationError e) => ValidationError(
          message: e.message,
          path: ['definitions', ...e.path],
          keyword: e.keyword,
          schema: e.schema,
          value: e.value,
          nestedErrors: e.nestedErrors,
        ),
      ),
    );
    errors.addAll(
      (dependencies as JsonModel).collectErrors().map(
        (ValidationError e) => ValidationError(
          message: e.message,
          path: ['dependencies', ...e.path],
          keyword: e.keyword,
          schema: e.schema,
          value: e.value,
          nestedErrors: e.nestedErrors,
        ),
      ),
    );
    final val_recursiveAnchor = recursiveAnchor;
    if (val_recursiveAnchor != null) {
      if (!RegExp(
        '^[A-Za-z_][-A-Za-z0-9._]*\$',
      ).hasMatch(val_recursiveAnchor)) {
        errors.add(
          ValidationError(
            message:
                'Property "\$recursiveAnchor" must match pattern "^[A-Za-z_][-A-Za-z0-9._]*\$"',
            path: ['\$recursiveAnchor'],
            keyword: 'pattern',
          ),
        );
      }
    }
    final val_recursiveRef = recursiveRef;
    if (val_recursiveRef != null) {
      if (!(isValidUriReference(val_recursiveRef))) {
        errors.add(
          ValidationError(
            message: 'Property "\$recursiveRef" must be a valid URI reference',
            path: ['\$recursiveRef'],
            keyword: 'format',
          ),
        );
      }
    }
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<CoreAndValidationSpecificationsMetaSchema1>
  descriptor = ObjectDescriptor<CoreAndValidationSpecificationsMetaSchema1>(
    title: 'CoreAndValidationSpecificationsMetaSchema1',
    matches: (instance) =>
        instance is CoreAndValidationSpecificationsMetaSchema1,
    instantiate: (fields) => CoreAndValidationSpecificationsMetaSchema1(
      id: fields['\$id'] as String?,
      schema: fields['\$schema'] as String?,
      ref: fields['\$ref'] as String?,
      anchor: fields['\$anchor'] as String?,
      dynamicRef: fields['\$dynamicRef'] as String?,
      dynamicAnchor: fields['\$dynamicAnchor'] as String?,
      vocabulary:
          fields['\$vocabulary']
              as CoreAndValidationSpecificationsMetaSchema1Vocabulary?,
      comment: fields['\$comment'] as String?,
      defs: fields['\$defs'] as CoreAndValidationSpecificationsMetaSchema1Defs?,
      prefixItems:
          fields['prefixItems']
              as List<CoreAndValidationSpecificationsMetaSchema>?,
      items: fields['items'] as CoreAndValidationSpecificationsMetaSchema?,
      contains:
          fields['contains'] as CoreAndValidationSpecificationsMetaSchema?,
      additionalProperties_:
          fields['additionalProperties']
              as CoreAndValidationSpecificationsMetaSchema?,
      properties: fields.containsKey('properties')
          ? fields['properties']
                as CoreAndValidationSpecificationsMetaSchema1Properties
          : const CoreAndValidationSpecificationsMetaSchema1Properties(),
      patternProperties_: fields.containsKey('patternProperties')
          ? fields['patternProperties']
                as CoreAndValidationSpecificationsMetaSchema1PatternProperties
          : const CoreAndValidationSpecificationsMetaSchema1PatternProperties(),
      dependentSchemas: fields.containsKey('dependentSchemas')
          ? fields['dependentSchemas']
                as CoreAndValidationSpecificationsMetaSchema1DependentSchemas
          : const CoreAndValidationSpecificationsMetaSchema1DependentSchemas(),
      propertyNames:
          fields['propertyNames'] as CoreAndValidationSpecificationsMetaSchema?,
      if_: fields['if'] as CoreAndValidationSpecificationsMetaSchema?,
      then: fields['then'] as CoreAndValidationSpecificationsMetaSchema?,
      else_: fields['else'] as CoreAndValidationSpecificationsMetaSchema?,
      allOf:
          fields['allOf'] as List<CoreAndValidationSpecificationsMetaSchema>?,
      anyOf:
          fields['anyOf'] as List<CoreAndValidationSpecificationsMetaSchema>?,
      oneOf:
          fields['oneOf'] as List<CoreAndValidationSpecificationsMetaSchema>?,
      not: fields['not'] as CoreAndValidationSpecificationsMetaSchema?,
      unevaluatedItems:
          fields['unevaluatedItems']
              as CoreAndValidationSpecificationsMetaSchema?,
      unevaluatedProperties:
          fields['unevaluatedProperties']
              as CoreAndValidationSpecificationsMetaSchema?,
      type_: fields['type'] as CoreAndValidationSpecificationsMetaSchema1Type?,
      const_: fields['const'] as Object?,
      enum_: fields['enum'] as List<Object?>?,
      multipleOf: fields['multipleOf'] as num?,
      maximum: fields['maximum'] as num?,
      exclusiveMaximum: fields['exclusiveMaximum'] as num?,
      minimum: fields['minimum'] as num?,
      exclusiveMinimum: fields['exclusiveMinimum'] as num?,
      maxLength: fields['maxLength'] as int?,
      minLength: fields['minLength'] as int?,
      pattern: fields['pattern'] as String?,
      maxItems: fields['maxItems'] as int?,
      minItems: fields['minItems'] as int?,
      uniqueItems: fields.containsKey('uniqueItems')
          ? fields['uniqueItems'] as bool
          : false,
      maxContains: fields['maxContains'] as int?,
      minContains: fields.containsKey('minContains')
          ? fields['minContains'] as int
          : 1,
      maxProperties: fields['maxProperties'] as int?,
      minProperties: fields['minProperties'] as int?,
      required_: fields['required'] as List<String>?,
      dependentRequired:
          fields['dependentRequired']
              as CoreAndValidationSpecificationsMetaSchema1DependentRequired?,
      title: fields['title'] as String?,
      description: fields['description'] as String?,
      default_: fields['default'] as Object?,
      deprecated: fields.containsKey('deprecated')
          ? fields['deprecated'] as bool
          : false,
      readOnly: fields.containsKey('readOnly')
          ? fields['readOnly'] as bool
          : false,
      writeOnly: fields.containsKey('writeOnly')
          ? fields['writeOnly'] as bool
          : false,
      examples: fields['examples'] as List<Object?>?,
      format: fields['format'] as String?,
      contentEncoding: fields['contentEncoding'] as String?,
      contentMediaType: fields['contentMediaType'] as String?,
      contentSchema:
          fields['contentSchema'] as CoreAndValidationSpecificationsMetaSchema?,
      definitions: fields.containsKey('definitions')
          ? fields['definitions']
                as CoreAndValidationSpecificationsMetaSchema1Definitions
          : const CoreAndValidationSpecificationsMetaSchema1Definitions(),
      dependencies: fields.containsKey('dependencies')
          ? fields['dependencies']
                as CoreAndValidationSpecificationsMetaSchema1Dependencies
          : const CoreAndValidationSpecificationsMetaSchema1Dependencies(),
      recursiveAnchor: fields['\$recursiveAnchor'] as String?,
      recursiveRef: fields['\$recursiveRef'] as String?,
      additionalProperties: fields.entries
          .where(
            (e) =>
                !const <String>{
                  '\$id',
                  '\$schema',
                  '\$ref',
                  '\$anchor',
                  '\$dynamicRef',
                  '\$dynamicAnchor',
                  '\$vocabulary',
                  '\$comment',
                  '\$defs',
                  'prefixItems',
                  'items',
                  'contains',
                  'additionalProperties',
                  'properties',
                  'patternProperties',
                  'dependentSchemas',
                  'propertyNames',
                  'if',
                  'then',
                  'else',
                  'allOf',
                  'anyOf',
                  'oneOf',
                  'not',
                  'unevaluatedItems',
                  'unevaluatedProperties',
                  'type',
                  'const',
                  'enum',
                  'multipleOf',
                  'maximum',
                  'exclusiveMaximum',
                  'minimum',
                  'exclusiveMinimum',
                  'maxLength',
                  'minLength',
                  'pattern',
                  'maxItems',
                  'minItems',
                  'uniqueItems',
                  'maxContains',
                  'minContains',
                  'maxProperties',
                  'minProperties',
                  'required',
                  'dependentRequired',
                  'title',
                  'description',
                  'default',
                  'deprecated',
                  'readOnly',
                  'writeOnly',
                  'examples',
                  'format',
                  'contentEncoding',
                  'contentMediaType',
                  'contentSchema',
                  'definitions',
                  'dependencies',
                  '\$recursiveAnchor',
                  '\$recursiveRef',
                }.contains(e.key) &&
                true,
          )
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance =
          instance as CoreAndValidationSpecificationsMetaSchema1;
      final map = <String, dynamic>{
        '\$id': typedInstance.id,
        '\$schema': typedInstance.schema,
        '\$ref': typedInstance.ref,
        '\$anchor': typedInstance.anchor,
        '\$dynamicRef': typedInstance.dynamicRef,
        '\$dynamicAnchor': typedInstance.dynamicAnchor,
        '\$vocabulary': typedInstance.vocabulary,
        '\$comment': typedInstance.comment,
        '\$defs': typedInstance.defs,
        'prefixItems': typedInstance.prefixItems,
        'items': typedInstance.items,
        'contains': typedInstance.contains,
        'additionalProperties': typedInstance.additionalProperties_,
        'properties': typedInstance.properties,
        'patternProperties': typedInstance.patternProperties_,
        'dependentSchemas': typedInstance.dependentSchemas,
        'propertyNames': typedInstance.propertyNames,
        'if': typedInstance.if_,
        'then': typedInstance.then,
        'else': typedInstance.else_,
        'allOf': typedInstance.allOf,
        'anyOf': typedInstance.anyOf,
        'oneOf': typedInstance.oneOf,
        'not': typedInstance.not,
        'unevaluatedItems': typedInstance.unevaluatedItems,
        'unevaluatedProperties': typedInstance.unevaluatedProperties,
        'type': typedInstance.type_,
        'const': typedInstance.const_,
        'enum': typedInstance.enum_,
        'multipleOf': typedInstance.multipleOf,
        'maximum': typedInstance.maximum,
        'exclusiveMaximum': typedInstance.exclusiveMaximum,
        'minimum': typedInstance.minimum,
        'exclusiveMinimum': typedInstance.exclusiveMinimum,
        'maxLength': typedInstance.maxLength,
        'minLength': typedInstance.minLength,
        'pattern': typedInstance.pattern,
        'maxItems': typedInstance.maxItems,
        'minItems': typedInstance.minItems,
        'uniqueItems': typedInstance.uniqueItems,
        'maxContains': typedInstance.maxContains,
        'minContains': typedInstance.minContains,
        'maxProperties': typedInstance.maxProperties,
        'minProperties': typedInstance.minProperties,
        'required': typedInstance.required_,
        'dependentRequired': typedInstance.dependentRequired,
        'title': typedInstance.title,
        'description': typedInstance.description,
        'default': typedInstance.default_,
        'deprecated': typedInstance.deprecated,
        'readOnly': typedInstance.readOnly,
        'writeOnly': typedInstance.writeOnly,
        'examples': typedInstance.examples,
        'format': typedInstance.format,
        'contentEncoding': typedInstance.contentEncoding,
        'contentMediaType': typedInstance.contentMediaType,
        'contentSchema': typedInstance.contentSchema,
        'definitions': typedInstance.definitions,
        'dependencies': typedInstance.dependencies,
        '\$recursiveAnchor': typedInstance.recursiveAnchor,
        '\$recursiveRef': typedInstance.recursiveRef,
        ...typedInstance.additionalProperties,
      };
      final explicit = typedInstance._$explicitKeys;
      if (explicit != null) {
        return map.entries
            .where((e) => e.value != null || explicit.contains(e.key))
            .fold<Map<String, dynamic>>({}, (m, e) => m..[e.key] = e.value);
      }
      return map..removeWhere((k, v) => v == null);
    },
    properties: {
      '\$id': PropertyDescriptor(
        name: '\$id',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      '\$schema': PropertyDescriptor(
        name: '\$schema',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      '\$ref': PropertyDescriptor(
        name: '\$ref',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      '\$anchor': PropertyDescriptor(
        name: '\$anchor',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      '\$dynamicRef': PropertyDescriptor(
        name: '\$dynamicRef',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      '\$dynamicAnchor': PropertyDescriptor(
        name: '\$dynamicAnchor',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      '\$vocabulary': PropertyDescriptor(
        name: '\$vocabulary',
        isRequired: false,
        schema:
            RefDescriptor<CoreAndValidationSpecificationsMetaSchema1Vocabulary>(
              () => CoreAndValidationSpecificationsMetaSchema1Vocabulary
                  .descriptor,
            ),
      ),
      '\$comment': PropertyDescriptor(
        name: '\$comment',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      '\$defs': PropertyDescriptor(
        name: '\$defs',
        isRequired: false,
        schema: RefDescriptor<CoreAndValidationSpecificationsMetaSchema1Defs>(
          () => CoreAndValidationSpecificationsMetaSchema1Defs.descriptor,
        ),
      ),
      'prefixItems': PropertyDescriptor(
        name: 'prefixItems',
        isRequired: false,
        schema: ArrayDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
            () => CoreAndValidationSpecificationsMetaSchema.descriptor,
          ),
        ),
      ),
      'items': PropertyDescriptor(
        name: 'items',
        isRequired: false,
        schema: RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          () => CoreAndValidationSpecificationsMetaSchema.descriptor,
        ),
      ),
      'contains': PropertyDescriptor(
        name: 'contains',
        isRequired: false,
        schema: RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          () => CoreAndValidationSpecificationsMetaSchema.descriptor,
        ),
      ),
      'additionalProperties': PropertyDescriptor(
        name: 'additionalProperties',
        isRequired: false,
        schema: RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          () => CoreAndValidationSpecificationsMetaSchema.descriptor,
        ),
      ),
      'properties': PropertyDescriptor(
        name: 'properties',
        isRequired: false,
        schema:
            RefDescriptor<CoreAndValidationSpecificationsMetaSchema1Properties>(
              () => CoreAndValidationSpecificationsMetaSchema1Properties
                  .descriptor,
            ),
      ),
      'patternProperties': PropertyDescriptor(
        name: 'patternProperties',
        isRequired: false,
        schema:
            RefDescriptor<
              CoreAndValidationSpecificationsMetaSchema1PatternProperties
            >(
              () => CoreAndValidationSpecificationsMetaSchema1PatternProperties
                  .descriptor,
            ),
      ),
      'dependentSchemas': PropertyDescriptor(
        name: 'dependentSchemas',
        isRequired: false,
        schema:
            RefDescriptor<
              CoreAndValidationSpecificationsMetaSchema1DependentSchemas
            >(
              () => CoreAndValidationSpecificationsMetaSchema1DependentSchemas
                  .descriptor,
            ),
      ),
      'propertyNames': PropertyDescriptor(
        name: 'propertyNames',
        isRequired: false,
        schema: RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          () => CoreAndValidationSpecificationsMetaSchema.descriptor,
        ),
      ),
      'if': PropertyDescriptor(
        name: 'if',
        isRequired: false,
        schema: RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          () => CoreAndValidationSpecificationsMetaSchema.descriptor,
        ),
      ),
      'then': PropertyDescriptor(
        name: 'then',
        isRequired: false,
        schema: RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          () => CoreAndValidationSpecificationsMetaSchema.descriptor,
        ),
      ),
      'else': PropertyDescriptor(
        name: 'else',
        isRequired: false,
        schema: RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          () => CoreAndValidationSpecificationsMetaSchema.descriptor,
        ),
      ),
      'allOf': PropertyDescriptor(
        name: 'allOf',
        isRequired: false,
        schema: ArrayDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
            () => CoreAndValidationSpecificationsMetaSchema.descriptor,
          ),
        ),
      ),
      'anyOf': PropertyDescriptor(
        name: 'anyOf',
        isRequired: false,
        schema: ArrayDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
            () => CoreAndValidationSpecificationsMetaSchema.descriptor,
          ),
        ),
      ),
      'oneOf': PropertyDescriptor(
        name: 'oneOf',
        isRequired: false,
        schema: ArrayDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
            () => CoreAndValidationSpecificationsMetaSchema.descriptor,
          ),
        ),
      ),
      'not': PropertyDescriptor(
        name: 'not',
        isRequired: false,
        schema: RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          () => CoreAndValidationSpecificationsMetaSchema.descriptor,
        ),
      ),
      'unevaluatedItems': PropertyDescriptor(
        name: 'unevaluatedItems',
        isRequired: false,
        schema: RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          () => CoreAndValidationSpecificationsMetaSchema.descriptor,
        ),
      ),
      'unevaluatedProperties': PropertyDescriptor(
        name: 'unevaluatedProperties',
        isRequired: false,
        schema: RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          () => CoreAndValidationSpecificationsMetaSchema.descriptor,
        ),
      ),
      'type': PropertyDescriptor(
        name: 'type',
        isRequired: false,
        schema: RefDescriptor<CoreAndValidationSpecificationsMetaSchema1Type>(
          () => CoreAndValidationSpecificationsMetaSchema1Type.descriptor,
        ),
      ),
      'const': PropertyDescriptor(
        name: 'const',
        isRequired: false,
        schema: const AnythingDescriptor(),
      ),
      'enum': PropertyDescriptor(
        name: 'enum',
        isRequired: false,
        schema: ArrayDescriptor<Object?>(const AnythingDescriptor()),
      ),
      'multipleOf': PropertyDescriptor(
        name: 'multipleOf',
        isRequired: false,
        schema: const NumDescriptor(),
      ),
      'maximum': PropertyDescriptor(
        name: 'maximum',
        isRequired: false,
        schema: const NumDescriptor(),
      ),
      'exclusiveMaximum': PropertyDescriptor(
        name: 'exclusiveMaximum',
        isRequired: false,
        schema: const NumDescriptor(),
      ),
      'minimum': PropertyDescriptor(
        name: 'minimum',
        isRequired: false,
        schema: const NumDescriptor(),
      ),
      'exclusiveMinimum': PropertyDescriptor(
        name: 'exclusiveMinimum',
        isRequired: false,
        schema: const NumDescriptor(),
      ),
      'maxLength': PropertyDescriptor(
        name: 'maxLength',
        isRequired: false,
        schema: const IntDescriptor(),
      ),
      'minLength': PropertyDescriptor(
        name: 'minLength',
        isRequired: false,
        schema: const IntDescriptor(),
      ),
      'pattern': PropertyDescriptor(
        name: 'pattern',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'maxItems': PropertyDescriptor(
        name: 'maxItems',
        isRequired: false,
        schema: const IntDescriptor(),
      ),
      'minItems': PropertyDescriptor(
        name: 'minItems',
        isRequired: false,
        schema: const IntDescriptor(),
      ),
      'uniqueItems': PropertyDescriptor(
        name: 'uniqueItems',
        isRequired: false,
        schema: const BoolDescriptor(),
      ),
      'maxContains': PropertyDescriptor(
        name: 'maxContains',
        isRequired: false,
        schema: const IntDescriptor(),
      ),
      'minContains': PropertyDescriptor(
        name: 'minContains',
        isRequired: false,
        schema: const IntDescriptor(),
      ),
      'maxProperties': PropertyDescriptor(
        name: 'maxProperties',
        isRequired: false,
        schema: const IntDescriptor(),
      ),
      'minProperties': PropertyDescriptor(
        name: 'minProperties',
        isRequired: false,
        schema: const IntDescriptor(),
      ),
      'required': PropertyDescriptor(
        name: 'required',
        isRequired: false,
        schema: ArrayDescriptor<String>(const StringDescriptor()),
      ),
      'dependentRequired': PropertyDescriptor(
        name: 'dependentRequired',
        isRequired: false,
        schema:
            RefDescriptor<
              CoreAndValidationSpecificationsMetaSchema1DependentRequired
            >(
              () => CoreAndValidationSpecificationsMetaSchema1DependentRequired
                  .descriptor,
            ),
      ),
      'title': PropertyDescriptor(
        name: 'title',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'description': PropertyDescriptor(
        name: 'description',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'default': PropertyDescriptor(
        name: 'default',
        isRequired: false,
        schema: const AnythingDescriptor(),
      ),
      'deprecated': PropertyDescriptor(
        name: 'deprecated',
        isRequired: false,
        schema: const BoolDescriptor(),
      ),
      'readOnly': PropertyDescriptor(
        name: 'readOnly',
        isRequired: false,
        schema: const BoolDescriptor(),
      ),
      'writeOnly': PropertyDescriptor(
        name: 'writeOnly',
        isRequired: false,
        schema: const BoolDescriptor(),
      ),
      'examples': PropertyDescriptor(
        name: 'examples',
        isRequired: false,
        schema: ArrayDescriptor<Object?>(const AnythingDescriptor()),
      ),
      'format': PropertyDescriptor(
        name: 'format',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'contentEncoding': PropertyDescriptor(
        name: 'contentEncoding',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'contentMediaType': PropertyDescriptor(
        name: 'contentMediaType',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'contentSchema': PropertyDescriptor(
        name: 'contentSchema',
        isRequired: false,
        schema: RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          () => CoreAndValidationSpecificationsMetaSchema.descriptor,
        ),
      ),
      'definitions': PropertyDescriptor(
        name: 'definitions',
        isRequired: false,
        schema:
            RefDescriptor<
              CoreAndValidationSpecificationsMetaSchema1Definitions
            >(
              () => CoreAndValidationSpecificationsMetaSchema1Definitions
                  .descriptor,
            ),
      ),
      'dependencies': PropertyDescriptor(
        name: 'dependencies',
        isRequired: false,
        schema:
            RefDescriptor<
              CoreAndValidationSpecificationsMetaSchema1Dependencies
            >(
              () => CoreAndValidationSpecificationsMetaSchema1Dependencies
                  .descriptor,
            ),
      ),
      '\$recursiveAnchor': PropertyDescriptor(
        name: '\$recursiveAnchor',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      '\$recursiveRef': PropertyDescriptor(
        name: '\$recursiveRef',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
    },

    required: const [],
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAndValidationSpecificationsMetaSchema1 &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          schema == other.schema &&
          ref == other.ref &&
          anchor == other.anchor &&
          dynamicRef == other.dynamicRef &&
          dynamicAnchor == other.dynamicAnchor &&
          vocabulary == other.vocabulary &&
          comment == other.comment &&
          defs == other.defs &&
          const DeepCollectionEquality().equals(
            prefixItems,
            other.prefixItems,
          ) &&
          items == other.items &&
          contains == other.contains &&
          additionalProperties_ == other.additionalProperties_ &&
          properties == other.properties &&
          patternProperties_ == other.patternProperties_ &&
          dependentSchemas == other.dependentSchemas &&
          propertyNames == other.propertyNames &&
          if_ == other.if_ &&
          then == other.then &&
          else_ == other.else_ &&
          const DeepCollectionEquality().equals(allOf, other.allOf) &&
          const DeepCollectionEquality().equals(anyOf, other.anyOf) &&
          const DeepCollectionEquality().equals(oneOf, other.oneOf) &&
          not == other.not &&
          unevaluatedItems == other.unevaluatedItems &&
          unevaluatedProperties == other.unevaluatedProperties &&
          type_ == other.type_ &&
          const DeepCollectionEquality().equals(const_, other.const_) &&
          const DeepCollectionEquality().equals(enum_, other.enum_) &&
          multipleOf == other.multipleOf &&
          maximum == other.maximum &&
          exclusiveMaximum == other.exclusiveMaximum &&
          minimum == other.minimum &&
          exclusiveMinimum == other.exclusiveMinimum &&
          maxLength == other.maxLength &&
          minLength == other.minLength &&
          pattern == other.pattern &&
          maxItems == other.maxItems &&
          minItems == other.minItems &&
          uniqueItems == other.uniqueItems &&
          maxContains == other.maxContains &&
          minContains == other.minContains &&
          maxProperties == other.maxProperties &&
          minProperties == other.minProperties &&
          const DeepCollectionEquality().equals(required_, other.required_) &&
          dependentRequired == other.dependentRequired &&
          title == other.title &&
          description == other.description &&
          const DeepCollectionEquality().equals(default_, other.default_) &&
          deprecated == other.deprecated &&
          readOnly == other.readOnly &&
          writeOnly == other.writeOnly &&
          const DeepCollectionEquality().equals(examples, other.examples) &&
          format == other.format &&
          contentEncoding == other.contentEncoding &&
          contentMediaType == other.contentMediaType &&
          contentSchema == other.contentSchema &&
          definitions == other.definitions &&
          dependencies == other.dependencies &&
          recursiveAnchor == other.recursiveAnchor &&
          recursiveRef == other.recursiveRef &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    id,
    schema,
    ref,
    anchor,
    dynamicRef,
    dynamicAnchor,
    vocabulary,
    comment,
    defs,
    const DeepCollectionEquality().hash(prefixItems),
    items,
    contains,
    additionalProperties_,
    properties,
    patternProperties_,
    dependentSchemas,
    propertyNames,
    if_,
    then,
    else_,
    const DeepCollectionEquality().hash(allOf),
    const DeepCollectionEquality().hash(anyOf),
    const DeepCollectionEquality().hash(oneOf),
    not,
    unevaluatedItems,
    unevaluatedProperties,
    type_,
    const DeepCollectionEquality().hash(const_),
    const DeepCollectionEquality().hash(enum_),
    multipleOf,
    maximum,
    exclusiveMaximum,
    minimum,
    exclusiveMinimum,
    maxLength,
    minLength,
    pattern,
    maxItems,
    minItems,
    uniqueItems,
    maxContains,
    minContains,
    maxProperties,
    minProperties,
    const DeepCollectionEquality().hash(required_),
    dependentRequired,
    title,
    description,
    const DeepCollectionEquality().hash(default_),
    deprecated,
    readOnly,
    writeOnly,
    const DeepCollectionEquality().hash(examples),
    format,
    contentEncoding,
    contentMediaType,
    contentSchema,
    definitions,
    dependencies,
    recursiveAnchor,
    recursiveRef,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchema1(id: ${id}, schema: ${schema}, ref: ${ref}, anchor: ${anchor}, dynamicRef: ${dynamicRef}, dynamicAnchor: ${dynamicAnchor}, vocabulary: ${vocabulary}, comment: ${comment}, defs: ${defs}, prefixItems: ${prefixItems}, items: ${items}, contains: ${contains}, additionalProperties_: ${additionalProperties_}, properties: ${properties}, patternProperties_: ${patternProperties_}, dependentSchemas: ${dependentSchemas}, propertyNames: ${propertyNames}, if_: ${if_}, then: ${then}, else_: ${else_}, allOf: ${allOf}, anyOf: ${anyOf}, oneOf: ${oneOf}, not: ${not}, unevaluatedItems: ${unevaluatedItems}, unevaluatedProperties: ${unevaluatedProperties}, type_: ${type_}, const_: ${const_}, enum_: ${enum_}, multipleOf: ${multipleOf}, maximum: ${maximum}, exclusiveMaximum: ${exclusiveMaximum}, minimum: ${minimum}, exclusiveMinimum: ${exclusiveMinimum}, maxLength: ${maxLength}, minLength: ${minLength}, pattern: ${pattern}, maxItems: ${maxItems}, minItems: ${minItems}, uniqueItems: ${uniqueItems}, maxContains: ${maxContains}, minContains: ${minContains}, maxProperties: ${maxProperties}, minProperties: ${minProperties}, required_: ${required_}, dependentRequired: ${dependentRequired}, title: ${title}, description: ${description}, default_: ${default_}, deprecated: ${deprecated}, readOnly: ${readOnly}, writeOnly: ${writeOnly}, examples: ${examples}, format: ${format}, contentEncoding: ${contentEncoding}, contentMediaType: ${contentMediaType}, contentSchema: ${contentSchema}, definitions: ${definitions}, dependencies: ${dependencies}, recursiveAnchor: ${recursiveAnchor}, recursiveRef: ${recursiveRef}, additionalProperties: ${additionalProperties})';
}

final class CoreAndValidationSpecificationsMetaSchema1Vocabulary
    implements JsonModel {
  final Map<String, bool> additionalProperties;
  final Set<String>? _$explicitKeys;

  const CoreAndValidationSpecificationsMetaSchema1Vocabulary({
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory CoreAndValidationSpecificationsMetaSchema1Vocabulary.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as CoreAndValidationSpecificationsMetaSchema1Vocabulary;

  /// Creates an instance of [CoreAndValidationSpecificationsMetaSchema1Vocabulary] from a JSON Map.
  factory CoreAndValidationSpecificationsMetaSchema1Vocabulary.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => CoreAndValidationSpecificationsMetaSchema1Vocabulary.fromJson(
    JsonReader.fromObject(map),
    validate: validate,
  );

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

  CoreAndValidationSpecificationsMetaSchema1Vocabulary copyWith({
    Map<String, bool>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return CoreAndValidationSpecificationsMetaSchema1Vocabulary(
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    additionalProperties.forEach((key, value) {
      if (value is! bool) {
        errors.add(
          ValidationError(
            message: 'Property "$key" must be a boolean',
            path: ['\$key'],
            keyword: 'type',
          ),
        );
      }
    });
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<
    CoreAndValidationSpecificationsMetaSchema1Vocabulary
  >
  descriptor =
      ObjectDescriptor<CoreAndValidationSpecificationsMetaSchema1Vocabulary>(
        title: 'CoreAndValidationSpecificationsMetaSchema1Vocabulary',
        matches: (instance) =>
            instance is CoreAndValidationSpecificationsMetaSchema1Vocabulary,
        instantiate: (fields) =>
            CoreAndValidationSpecificationsMetaSchema1Vocabulary(
              additionalProperties: fields.entries
                  .where((e) => !const <String>{}.contains(e.key) && true)
                  .fold<Map<String, bool>>(
                    {},
                    (m, e) => m..[e.key] = e.value as bool,
                  ),
              explicitKeys: fields.keys.toSet(),
            ),
        getFields: (instance) {
          final typedInstance =
              instance as CoreAndValidationSpecificationsMetaSchema1Vocabulary;
          final map = <String, dynamic>{...typedInstance.additionalProperties};
          final explicit = typedInstance._$explicitKeys;
          if (explicit != null) {
            return map.entries
                .where((e) => e.value != null || explicit.contains(e.key))
                .fold<Map<String, dynamic>>({}, (m, e) => m..[e.key] = e.value);
          }
          return map..removeWhere((k, v) => v == null);
        },
        properties: {},

        required: const [],
        additionalProperties: const BoolDescriptor(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAndValidationSpecificationsMetaSchema1Vocabulary &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchema1Vocabulary(additionalProperties: ${additionalProperties})';
}

final class CoreAndValidationSpecificationsMetaSchema1Defs
    implements JsonModel {
  final Map<String, CoreAndValidationSpecificationsMetaSchema>
  additionalProperties;
  final Set<String>? _$explicitKeys;

  const CoreAndValidationSpecificationsMetaSchema1Defs({
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory CoreAndValidationSpecificationsMetaSchema1Defs.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as CoreAndValidationSpecificationsMetaSchema1Defs;

  /// Creates an instance of [CoreAndValidationSpecificationsMetaSchema1Defs] from a JSON Map.
  factory CoreAndValidationSpecificationsMetaSchema1Defs.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => CoreAndValidationSpecificationsMetaSchema1Defs.fromJson(
    JsonReader.fromObject(map),
    validate: validate,
  );

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

  CoreAndValidationSpecificationsMetaSchema1Defs copyWith({
    Map<String, CoreAndValidationSpecificationsMetaSchema>?
    additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return CoreAndValidationSpecificationsMetaSchema1Defs(
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    additionalProperties.forEach((key, value) {
      errors.addAll(
        (value as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['$key', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    });
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<CoreAndValidationSpecificationsMetaSchema1Defs>
  descriptor = ObjectDescriptor<CoreAndValidationSpecificationsMetaSchema1Defs>(
    title: 'CoreAndValidationSpecificationsMetaSchema1Defs',
    matches: (instance) =>
        instance is CoreAndValidationSpecificationsMetaSchema1Defs,
    instantiate: (fields) => CoreAndValidationSpecificationsMetaSchema1Defs(
      additionalProperties: fields.entries
          .where((e) => !const <String>{}.contains(e.key) && true)
          .fold<Map<String, CoreAndValidationSpecificationsMetaSchema>>(
            {},
            (m, e) => m
              ..[e.key] = e.value as CoreAndValidationSpecificationsMetaSchema,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance =
          instance as CoreAndValidationSpecificationsMetaSchema1Defs;
      final map = <String, dynamic>{...typedInstance.additionalProperties};
      final explicit = typedInstance._$explicitKeys;
      if (explicit != null) {
        return map.entries
            .where((e) => e.value != null || explicit.contains(e.key))
            .fold<Map<String, dynamic>>({}, (m, e) => m..[e.key] = e.value);
      }
      return map..removeWhere((k, v) => v == null);
    },
    properties: {},

    required: const [],
    additionalProperties:
        RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
          () => CoreAndValidationSpecificationsMetaSchema.descriptor,
        ),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAndValidationSpecificationsMetaSchema1Defs &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchema1Defs(additionalProperties: ${additionalProperties})';
}

final class CoreAndValidationSpecificationsMetaSchema1Properties
    implements JsonModel {
  final Map<String, CoreAndValidationSpecificationsMetaSchema>
  additionalProperties;
  final Set<String>? _$explicitKeys;

  const CoreAndValidationSpecificationsMetaSchema1Properties({
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory CoreAndValidationSpecificationsMetaSchema1Properties.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as CoreAndValidationSpecificationsMetaSchema1Properties;

  /// Creates an instance of [CoreAndValidationSpecificationsMetaSchema1Properties] from a JSON Map.
  factory CoreAndValidationSpecificationsMetaSchema1Properties.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => CoreAndValidationSpecificationsMetaSchema1Properties.fromJson(
    JsonReader.fromObject(map),
    validate: validate,
  );

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

  CoreAndValidationSpecificationsMetaSchema1Properties copyWith({
    Map<String, CoreAndValidationSpecificationsMetaSchema>?
    additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return CoreAndValidationSpecificationsMetaSchema1Properties(
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    additionalProperties.forEach((key, value) {
      errors.addAll(
        (value as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['$key', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    });
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<
    CoreAndValidationSpecificationsMetaSchema1Properties
  >
  descriptor =
      ObjectDescriptor<CoreAndValidationSpecificationsMetaSchema1Properties>(
        title: 'CoreAndValidationSpecificationsMetaSchema1Properties',
        matches: (instance) =>
            instance is CoreAndValidationSpecificationsMetaSchema1Properties,
        instantiate: (fields) =>
            CoreAndValidationSpecificationsMetaSchema1Properties(
              additionalProperties: fields.entries
                  .where((e) => !const <String>{}.contains(e.key) && true)
                  .fold<Map<String, CoreAndValidationSpecificationsMetaSchema>>(
                    {},
                    (m, e) => m
                      ..[e.key] =
                          e.value as CoreAndValidationSpecificationsMetaSchema,
                  ),
              explicitKeys: fields.keys.toSet(),
            ),
        getFields: (instance) {
          final typedInstance =
              instance as CoreAndValidationSpecificationsMetaSchema1Properties;
          final map = <String, dynamic>{...typedInstance.additionalProperties};
          final explicit = typedInstance._$explicitKeys;
          if (explicit != null) {
            return map.entries
                .where((e) => e.value != null || explicit.contains(e.key))
                .fold<Map<String, dynamic>>({}, (m, e) => m..[e.key] = e.value);
          }
          return map..removeWhere((k, v) => v == null);
        },
        properties: {},

        required: const [],
        additionalProperties:
            RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
              () => CoreAndValidationSpecificationsMetaSchema.descriptor,
            ),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAndValidationSpecificationsMetaSchema1Properties &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchema1Properties(additionalProperties: ${additionalProperties})';
}

final class CoreAndValidationSpecificationsMetaSchema1PatternProperties
    implements JsonModel {
  final Map<String, CoreAndValidationSpecificationsMetaSchema>
  additionalProperties;
  final Set<String>? _$explicitKeys;

  const CoreAndValidationSpecificationsMetaSchema1PatternProperties({
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory CoreAndValidationSpecificationsMetaSchema1PatternProperties.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as CoreAndValidationSpecificationsMetaSchema1PatternProperties;

  /// Creates an instance of [CoreAndValidationSpecificationsMetaSchema1PatternProperties] from a JSON Map.
  factory CoreAndValidationSpecificationsMetaSchema1PatternProperties.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => CoreAndValidationSpecificationsMetaSchema1PatternProperties.fromJson(
    JsonReader.fromObject(map),
    validate: validate,
  );

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

  CoreAndValidationSpecificationsMetaSchema1PatternProperties copyWith({
    Map<String, CoreAndValidationSpecificationsMetaSchema>?
    additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return CoreAndValidationSpecificationsMetaSchema1PatternProperties(
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    additionalProperties.forEach((key, value) {
      errors.addAll(
        (value as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['$key', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    });
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<
    CoreAndValidationSpecificationsMetaSchema1PatternProperties
  >
  descriptor =
      ObjectDescriptor<
        CoreAndValidationSpecificationsMetaSchema1PatternProperties
      >(
        title: 'CoreAndValidationSpecificationsMetaSchema1PatternProperties',
        matches: (instance) =>
            instance
                is CoreAndValidationSpecificationsMetaSchema1PatternProperties,
        instantiate: (fields) =>
            CoreAndValidationSpecificationsMetaSchema1PatternProperties(
              additionalProperties: fields.entries
                  .where((e) => !const <String>{}.contains(e.key) && true)
                  .fold<Map<String, CoreAndValidationSpecificationsMetaSchema>>(
                    {},
                    (m, e) => m
                      ..[e.key] =
                          e.value as CoreAndValidationSpecificationsMetaSchema,
                  ),
              explicitKeys: fields.keys.toSet(),
            ),
        getFields: (instance) {
          final typedInstance =
              instance
                  as CoreAndValidationSpecificationsMetaSchema1PatternProperties;
          final map = <String, dynamic>{...typedInstance.additionalProperties};
          final explicit = typedInstance._$explicitKeys;
          if (explicit != null) {
            return map.entries
                .where((e) => e.value != null || explicit.contains(e.key))
                .fold<Map<String, dynamic>>({}, (m, e) => m..[e.key] = e.value);
          }
          return map..removeWhere((k, v) => v == null);
        },
        properties: {},

        required: const [],
        additionalProperties:
            RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
              () => CoreAndValidationSpecificationsMetaSchema.descriptor,
            ),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAndValidationSpecificationsMetaSchema1PatternProperties &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchema1PatternProperties(additionalProperties: ${additionalProperties})';
}

final class CoreAndValidationSpecificationsMetaSchema1DependentSchemas
    implements JsonModel {
  final Map<String, CoreAndValidationSpecificationsMetaSchema>
  additionalProperties;
  final Set<String>? _$explicitKeys;

  const CoreAndValidationSpecificationsMetaSchema1DependentSchemas({
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory CoreAndValidationSpecificationsMetaSchema1DependentSchemas.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as CoreAndValidationSpecificationsMetaSchema1DependentSchemas;

  /// Creates an instance of [CoreAndValidationSpecificationsMetaSchema1DependentSchemas] from a JSON Map.
  factory CoreAndValidationSpecificationsMetaSchema1DependentSchemas.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => CoreAndValidationSpecificationsMetaSchema1DependentSchemas.fromJson(
    JsonReader.fromObject(map),
    validate: validate,
  );

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

  CoreAndValidationSpecificationsMetaSchema1DependentSchemas copyWith({
    Map<String, CoreAndValidationSpecificationsMetaSchema>?
    additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return CoreAndValidationSpecificationsMetaSchema1DependentSchemas(
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    additionalProperties.forEach((key, value) {
      errors.addAll(
        (value as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['$key', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    });
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<
    CoreAndValidationSpecificationsMetaSchema1DependentSchemas
  >
  descriptor =
      ObjectDescriptor<
        CoreAndValidationSpecificationsMetaSchema1DependentSchemas
      >(
        title: 'CoreAndValidationSpecificationsMetaSchema1DependentSchemas',
        matches: (instance) =>
            instance
                is CoreAndValidationSpecificationsMetaSchema1DependentSchemas,
        instantiate: (fields) =>
            CoreAndValidationSpecificationsMetaSchema1DependentSchemas(
              additionalProperties: fields.entries
                  .where((e) => !const <String>{}.contains(e.key) && true)
                  .fold<Map<String, CoreAndValidationSpecificationsMetaSchema>>(
                    {},
                    (m, e) => m
                      ..[e.key] =
                          e.value as CoreAndValidationSpecificationsMetaSchema,
                  ),
              explicitKeys: fields.keys.toSet(),
            ),
        getFields: (instance) {
          final typedInstance =
              instance
                  as CoreAndValidationSpecificationsMetaSchema1DependentSchemas;
          final map = <String, dynamic>{...typedInstance.additionalProperties};
          final explicit = typedInstance._$explicitKeys;
          if (explicit != null) {
            return map.entries
                .where((e) => e.value != null || explicit.contains(e.key))
                .fold<Map<String, dynamic>>({}, (m, e) => m..[e.key] = e.value);
          }
          return map..removeWhere((k, v) => v == null);
        },
        properties: {},

        required: const [],
        additionalProperties:
            RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
              () => CoreAndValidationSpecificationsMetaSchema.descriptor,
            ),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAndValidationSpecificationsMetaSchema1DependentSchemas &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchema1DependentSchemas(additionalProperties: ${additionalProperties})';
}

sealed class CoreAndValidationSpecificationsMetaSchema1Type
    implements JsonModel {
  const CoreAndValidationSpecificationsMetaSchema1Type();

  factory CoreAndValidationSpecificationsMetaSchema1Type.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as CoreAndValidationSpecificationsMetaSchema1Type;

  /// Creates an instance of [CoreAndValidationSpecificationsMetaSchema1Type] from a JSON-compatible Dart value.
  factory CoreAndValidationSpecificationsMetaSchema1Type.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => CoreAndValidationSpecificationsMetaSchema1Type.fromJson(
    JsonReader.fromObject(value),
    validate: validate,
  );

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

  static final UnionDescriptor<CoreAndValidationSpecificationsMetaSchema1Type>
  descriptor = UnionDescriptor<CoreAndValidationSpecificationsMetaSchema1Type>(
    title: 'CoreAndValidationSpecificationsMetaSchema1Type',

    activeOptions: [
      UnionOptionDescriptor<
        CoreAndValidationSpecificationsMetaSchema1Type,
        SimpleTypes
      >(
        SimpleTypes.descriptor,
        (val) => CoreAndValidationSpecificationsMetaSchema1TypeOption0(
          val as SimpleTypes,
        ),
      ),
      UnionOptionDescriptor<
        CoreAndValidationSpecificationsMetaSchema1Type,
        List<SimpleTypes>
      >(
        ArrayDescriptor<SimpleTypes>(SimpleTypes.descriptor),
        (val) => CoreAndValidationSpecificationsMetaSchema1TypeOption1(
          val as List<SimpleTypes>,
        ),
      ),
    ],
  );
}

final class CoreAndValidationSpecificationsMetaSchema1TypeOption0
    extends CoreAndValidationSpecificationsMetaSchema1Type {
  final SimpleTypes value;
  const CoreAndValidationSpecificationsMetaSchema1TypeOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, SimpleTypes.descriptor);
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (!const [
      'array',
      'boolean',
      'integer',
      'null',
      'number',
      'object',
      'string',
    ].any(
      (v) => const DeepCollectionEquality().equals(
        v,
        value is Enum ? (value as dynamic).value : value,
      ),
    )) {
      errors.add(
        ValidationError(
          message:
              'Property "value" must be one of [array, boolean, integer, null, number, object, string]',
          path: ['value'],
          keyword: 'enum',
        ),
      );
    }
    return errors;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAndValidationSpecificationsMetaSchema1TypeOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchema1TypeOption0(value: $value)';
}

final class CoreAndValidationSpecificationsMetaSchema1TypeOption1
    extends CoreAndValidationSpecificationsMetaSchema1Type {
  final List<SimpleTypes> value;
  const CoreAndValidationSpecificationsMetaSchema1TypeOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(
      target,
      value,
      ArrayDescriptor<SimpleTypes>(SimpleTypes.descriptor),
    );
  }

  @override
  List<ValidationError> collectErrors() {
    return const [];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAndValidationSpecificationsMetaSchema1TypeOption1 &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(value, other.value);

  @override
  int get hashCode => const DeepCollectionEquality().hash(value);

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchema1TypeOption1(value: $value)';
}

enum SimpleTypes {
  array('array'),
  boolean('boolean'),
  integer('integer'),
  null_('null'),
  number('number'),
  object('object'),
  string('string');

  final String value;
  const SimpleTypes(this.value);
  static SimpleTypes fromValue(String val) =>
      values.firstWhere((e) => e.value == val);
  static final EnumDescriptor<SimpleTypes> descriptor =
      EnumDescriptor<SimpleTypes>(
        values: values,
        fromValue: (val) => fromValue(val as String),
        toValue: (e) => (e as SimpleTypes).value,
        base: const StringDescriptor(),
      );
}

final class CoreAndValidationSpecificationsMetaSchema1DependentRequired
    implements JsonModel {
  final Map<String, List<String>> additionalProperties;
  final Set<String>? _$explicitKeys;

  const CoreAndValidationSpecificationsMetaSchema1DependentRequired({
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory CoreAndValidationSpecificationsMetaSchema1DependentRequired.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as CoreAndValidationSpecificationsMetaSchema1DependentRequired;

  /// Creates an instance of [CoreAndValidationSpecificationsMetaSchema1DependentRequired] from a JSON Map.
  factory CoreAndValidationSpecificationsMetaSchema1DependentRequired.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => CoreAndValidationSpecificationsMetaSchema1DependentRequired.fromJson(
    JsonReader.fromObject(map),
    validate: validate,
  );

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

  CoreAndValidationSpecificationsMetaSchema1DependentRequired copyWith({
    Map<String, List<String>>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return CoreAndValidationSpecificationsMetaSchema1DependentRequired(
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    additionalProperties.forEach((key, value) {
      if (value is! List) {
        errors.add(
          ValidationError(
            message: 'Property "$key" must be an array',
            path: ['\$key'],
            keyword: 'type',
          ),
        );
      } else {
        if (value.length !=
            (LinkedHashSet<dynamic>(
              equals: const DeepCollectionEquality().equals,
              hashCode: const DeepCollectionEquality().hash,
            )..addAll(value)).length) {
          errors.add(
            ValidationError(
              message: 'Property "$key" items must be unique',
              path: ['\$key'],
              keyword: 'uniqueItems',
            ),
          );
        }
      }
    });
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<
    CoreAndValidationSpecificationsMetaSchema1DependentRequired
  >
  descriptor =
      ObjectDescriptor<
        CoreAndValidationSpecificationsMetaSchema1DependentRequired
      >(
        title: 'CoreAndValidationSpecificationsMetaSchema1DependentRequired',
        matches: (instance) =>
            instance
                is CoreAndValidationSpecificationsMetaSchema1DependentRequired,
        instantiate: (fields) =>
            CoreAndValidationSpecificationsMetaSchema1DependentRequired(
              additionalProperties: fields.entries
                  .where((e) => !const <String>{}.contains(e.key) && true)
                  .fold<Map<String, List<String>>>(
                    {},
                    (m, e) => m..[e.key] = e.value as List<String>,
                  ),
              explicitKeys: fields.keys.toSet(),
            ),
        getFields: (instance) {
          final typedInstance =
              instance
                  as CoreAndValidationSpecificationsMetaSchema1DependentRequired;
          final map = <String, dynamic>{...typedInstance.additionalProperties};
          final explicit = typedInstance._$explicitKeys;
          if (explicit != null) {
            return map.entries
                .where((e) => e.value != null || explicit.contains(e.key))
                .fold<Map<String, dynamic>>({}, (m, e) => m..[e.key] = e.value);
          }
          return map..removeWhere((k, v) => v == null);
        },
        properties: {},

        required: const [],
        additionalProperties: ArrayDescriptor<String>(const StringDescriptor()),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAndValidationSpecificationsMetaSchema1DependentRequired &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchema1DependentRequired(additionalProperties: ${additionalProperties})';
}

@Deprecated('deprecated')
final class CoreAndValidationSpecificationsMetaSchema1Definitions
    implements JsonModel {
  final Map<String, CoreAndValidationSpecificationsMetaSchema>
  additionalProperties;
  final Set<String>? _$explicitKeys;

  const CoreAndValidationSpecificationsMetaSchema1Definitions({
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory CoreAndValidationSpecificationsMetaSchema1Definitions.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as CoreAndValidationSpecificationsMetaSchema1Definitions;

  /// Creates an instance of [CoreAndValidationSpecificationsMetaSchema1Definitions] from a JSON Map.
  factory CoreAndValidationSpecificationsMetaSchema1Definitions.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => CoreAndValidationSpecificationsMetaSchema1Definitions.fromJson(
    JsonReader.fromObject(map),
    validate: validate,
  );

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

  CoreAndValidationSpecificationsMetaSchema1Definitions copyWith({
    Map<String, CoreAndValidationSpecificationsMetaSchema>?
    additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return CoreAndValidationSpecificationsMetaSchema1Definitions(
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    additionalProperties.forEach((key, value) {
      errors.addAll(
        (value as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['$key', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    });
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<
    CoreAndValidationSpecificationsMetaSchema1Definitions
  >
  descriptor =
      ObjectDescriptor<CoreAndValidationSpecificationsMetaSchema1Definitions>(
        title: 'CoreAndValidationSpecificationsMetaSchema1Definitions',
        matches: (instance) =>
            instance is CoreAndValidationSpecificationsMetaSchema1Definitions,
        instantiate: (fields) =>
            CoreAndValidationSpecificationsMetaSchema1Definitions(
              additionalProperties: fields.entries
                  .where((e) => !const <String>{}.contains(e.key) && true)
                  .fold<Map<String, CoreAndValidationSpecificationsMetaSchema>>(
                    {},
                    (m, e) => m
                      ..[e.key] =
                          e.value as CoreAndValidationSpecificationsMetaSchema,
                  ),
              explicitKeys: fields.keys.toSet(),
            ),
        getFields: (instance) {
          final typedInstance =
              instance as CoreAndValidationSpecificationsMetaSchema1Definitions;
          final map = <String, dynamic>{...typedInstance.additionalProperties};
          final explicit = typedInstance._$explicitKeys;
          if (explicit != null) {
            return map.entries
                .where((e) => e.value != null || explicit.contains(e.key))
                .fold<Map<String, dynamic>>({}, (m, e) => m..[e.key] = e.value);
          }
          return map..removeWhere((k, v) => v == null);
        },
        properties: {},

        required: const [],
        additionalProperties:
            RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
              () => CoreAndValidationSpecificationsMetaSchema.descriptor,
            ),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAndValidationSpecificationsMetaSchema1Definitions &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchema1Definitions(additionalProperties: ${additionalProperties})';
}

@Deprecated('deprecated')
final class CoreAndValidationSpecificationsMetaSchema1Dependencies
    implements JsonModel {
  final Map<
    String,
    CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty
  >
  additionalProperties;
  final Set<String>? _$explicitKeys;

  const CoreAndValidationSpecificationsMetaSchema1Dependencies({
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory CoreAndValidationSpecificationsMetaSchema1Dependencies.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as CoreAndValidationSpecificationsMetaSchema1Dependencies;

  /// Creates an instance of [CoreAndValidationSpecificationsMetaSchema1Dependencies] from a JSON Map.
  factory CoreAndValidationSpecificationsMetaSchema1Dependencies.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => CoreAndValidationSpecificationsMetaSchema1Dependencies.fromJson(
    JsonReader.fromObject(map),
    validate: validate,
  );

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

  CoreAndValidationSpecificationsMetaSchema1Dependencies copyWith({
    Map<
      String,
      CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty
    >?
    additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return CoreAndValidationSpecificationsMetaSchema1Dependencies(
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    additionalProperties.forEach((key, value) {
      errors.addAll(
        (value as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['$key', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    });
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<
    CoreAndValidationSpecificationsMetaSchema1Dependencies
  >
  descriptor = ObjectDescriptor<CoreAndValidationSpecificationsMetaSchema1Dependencies>(
    title: 'CoreAndValidationSpecificationsMetaSchema1Dependencies',
    matches: (instance) =>
        instance is CoreAndValidationSpecificationsMetaSchema1Dependencies,
    instantiate: (fields) => CoreAndValidationSpecificationsMetaSchema1Dependencies(
      additionalProperties: fields.entries
          .where((e) => !const <String>{}.contains(e.key) && true)
          .fold<
            Map<
              String,
              CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty
            >
          >(
            {},
            (m, e) => m
              ..[e.key] =
                  e.value
                      as CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance =
          instance as CoreAndValidationSpecificationsMetaSchema1Dependencies;
      final map = <String, dynamic>{...typedInstance.additionalProperties};
      final explicit = typedInstance._$explicitKeys;
      if (explicit != null) {
        return map.entries
            .where((e) => e.value != null || explicit.contains(e.key))
            .fold<Map<String, dynamic>>({}, (m, e) => m..[e.key] = e.value);
      }
      return map..removeWhere((k, v) => v == null);
    },
    properties: {},

    required: const [],
    additionalProperties:
        RefDescriptor<
          CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty
        >(
          () =>
              CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty
                  .descriptor,
        ),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreAndValidationSpecificationsMetaSchema1Dependencies &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchema1Dependencies(additionalProperties: ${additionalProperties})';
}

sealed class CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty
    implements JsonModel {
  const CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty();

  factory CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty;

  /// Creates an instance of [CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty] from a JSON-compatible Dart value.
  factory CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) =>
      CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty.fromJson(
        JsonReader.fromObject(value),
        validate: validate,
      );

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

  static final UnionDescriptor<
    CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty
  >
  descriptor =
      UnionDescriptor<
        CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty
      >(
        title:
            'CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty',

        activeOptions: [
          UnionOptionDescriptor<
            CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty,
            CoreAndValidationSpecificationsMetaSchema
          >(
            RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
              () => CoreAndValidationSpecificationsMetaSchema.descriptor,
            ),
            (val) =>
                CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalPropertyOption0(
                  val as CoreAndValidationSpecificationsMetaSchema,
                ),
          ),
          UnionOptionDescriptor<
            CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty,
            List<String>
          >(
            ArrayDescriptor<String>(const StringDescriptor()),
            (val) =>
                CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalPropertyOption1(
                  val as List<String>,
                ),
          ),
        ],
      );
}

final class CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalPropertyOption0
    extends
        CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty {
  final CoreAndValidationSpecificationsMetaSchema value;
  const CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalPropertyOption0(
    this.value,
  );

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(
      target,
      value,
      RefDescriptor<CoreAndValidationSpecificationsMetaSchema>(
        () => CoreAndValidationSpecificationsMetaSchema.descriptor,
      ),
    );
  }

  @override
  List<ValidationError> collectErrors() => value.collectErrors();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other
              is CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalPropertyOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalPropertyOption0(value: $value)';
}

final class CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalPropertyOption1
    extends
        CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalProperty {
  final List<String> value;
  const CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalPropertyOption1(
    this.value,
  );

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(
      target,
      value,
      ArrayDescriptor<String>(const StringDescriptor()),
    );
  }

  @override
  List<ValidationError> collectErrors() {
    return const [];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other
              is CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalPropertyOption1 &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(value, other.value);

  @override
  int get hashCode => const DeepCollectionEquality().hash(value);

  @override
  String toString() =>
      'CoreAndValidationSpecificationsMetaSchema1DependenciesAdditionalPropertyOption1(value: $value)';
}
