// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides

import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';

final class TestRoot implements JsonModel {
  final String name;
  final TestRootConstValue? constValue;
  final int age;
  final int? exclusiveAge;
  final num? height;
  final String? email;
  final String? uuid;
  final bool isAwesome;
  final String? class_;
  final String? reader;
  final String? stack;
  final String? validate_;
  final String? result;
  final Address address;
  final List<String>? tags;
  final List<Score>? scores;
  final TestRootUnionValue? unionValue;
  final TestRootNullableUnionValue? nullableUnionValue;
  final RequiredNullableUnionObject? requiredNullableUnionObject;
  final String? nullableString;
  final Pet? pet;
  final RestrictedObject? restrictedObject;
  final DependentObject? dependentObject;
  final List<String>? primitiveArrayWithValidation;
  final List<int>? restrictedArray;
  @deprecated
  final String? deprecatedField;
  final DeprecatedObject? deprecatedRef;
  final String defaultString;
  final String defaultBackslash;
  final List<List<Address>>? nestedArray;
  final String? singleQuoteKey;
  final TestRootMixedEnum? mixedEnum;
  final int defaultInt;
  final bool defaultBool;
  final List<String> defaultList;
  final Address defaultObject;
  final String? defaultNullableString;
  final Merged? mergedValue;
  final List<dynamic>? tupleArray;
  final List<dynamic>? tupleObjectArray;
  final String? ipv6Value;
  final String? hostnameValue;
  final String? timeValue;
  final String? uriReferenceValue;
  final MapObject? additionalPropertiesObject;
  final StrictObject? strictObject;
  final NotObject? notObject;
  final TestRootAnyOfValue? anyOfValue;
  final MergedAllOfObject? mergedAllOfObject;
  final ComplexMergedObject? complexMerged;
  final MyEnum? myEnumField;
  final List<Object?>? unionContainsArray;
  final List<Object?>? objectContainsArray;
  final List<Object?>? enumContainsArray;
  final List<Object?>? booleanContainsArray;
  final List<Object?>? nullContainsArray;
  final List<Object?>? anyContainsArray;
  final List<Object?>? stringContainsArray;
  final List<Object?>? numberContainsArray;
  final ObjectWithDynamicProps? dynamicProps;
  final String? dateTimeField;
  final String? dateField;
  final String? ipv4Field;
  final String? uriField;
  final List<String> defaultEmptyList;
  final MapObject defaultEmptyObject;
  final TestRootUnionWithArrayOption? unionWithArrayOption;
  final Never? impossibleField;
  final List<String>? tupleSameTypeArray;
  final List<TestRootArrayWithAllOfItemsItem>? arrayWithAllOfItems;
  final TestRootUnionWithAllOfOption? unionWithAllOfOption;
  @Deprecated('Use newAwesomeField instead')
  final String? deprecatedFieldWithMessage;
  final MyCustomClassName? customNamedObject;
  @Deprecated('This union is deprecated, use MyCustomUnionName2')
  final MyCustomUnionName? customNamedUnion;
  final MyCustomEnumName? customNamedEnum;
  final TestRootCoverageTrigger? coverageTrigger;
  final CollidingEnum? collidingEnumField;
  final CollidingObject? collidingObjectField;

  const TestRoot({
    required this.name,
    this.constValue,
    required this.age,
    this.exclusiveAge,
    this.height,
    this.email,
    this.uuid,
    required this.isAwesome,
    this.class_,
    this.reader,
    this.stack,
    this.validate_,
    this.result,
    required this.address,
    this.tags,
    this.scores,
    this.unionValue,
    this.nullableUnionValue,
    this.requiredNullableUnionObject,
    this.nullableString,
    this.pet,
    this.restrictedObject,
    this.dependentObject,
    this.primitiveArrayWithValidation,
    this.restrictedArray,
    this.deprecatedField,
    this.deprecatedRef,
    this.defaultString = 'default value',
    this.defaultBackslash = 'foo\\sbar',
    this.nestedArray,
    this.singleQuoteKey,
    this.mixedEnum,
    this.defaultInt = 42,
    this.defaultBool = true,
    this.defaultList = const <String>['a', 'b'],
    this.defaultObject = const Address(city: 'Default City'),
    this.defaultNullableString = null,
    this.mergedValue,
    this.tupleArray,
    this.tupleObjectArray,
    this.ipv6Value,
    this.hostnameValue,
    this.timeValue,
    this.uriReferenceValue,
    this.additionalPropertiesObject,
    this.strictObject,
    this.notObject,
    this.anyOfValue,
    this.mergedAllOfObject,
    this.complexMerged,
    this.myEnumField,
    this.unionContainsArray,
    this.objectContainsArray,
    this.enumContainsArray,
    this.booleanContainsArray,
    this.nullContainsArray,
    this.anyContainsArray,
    this.stringContainsArray,
    this.numberContainsArray,
    this.dynamicProps,
    this.dateTimeField,
    this.dateField,
    this.ipv4Field,
    this.uriField,
    this.defaultEmptyList = const <String>[],
    this.defaultEmptyObject = const MapObject(),
    this.unionWithArrayOption,
    this.impossibleField,
    this.tupleSameTypeArray,
    this.arrayWithAllOfItems,
    this.unionWithAllOfOption,
    this.deprecatedFieldWithMessage,
    this.customNamedObject,
    this.customNamedUnion,
    this.customNamedEnum,
    this.coverageTrigger,
    this.collidingEnumField,
    this.collidingObjectField,
  });

  factory TestRoot.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as TestRoot;

  /// Creates an instance of [TestRoot] from a JSON Map.
  factory TestRoot.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      TestRoot.fromJson(JsonReader.fromObject(map), validate: validate);

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

  TestRoot copyWith({
    String? name,
    TestRootConstValue? constValue,
    int? age,
    int? exclusiveAge,
    num? height,
    String? email,
    String? uuid,
    bool? isAwesome,
    String? class_,
    String? reader,
    String? stack,
    String? validate_,
    String? result,
    Address? address,
    List<String>? tags,
    List<Score>? scores,
    TestRootUnionValue? unionValue,
    TestRootNullableUnionValue? nullableUnionValue,
    RequiredNullableUnionObject? requiredNullableUnionObject,
    String? nullableString,
    Pet? pet,
    RestrictedObject? restrictedObject,
    DependentObject? dependentObject,
    List<String>? primitiveArrayWithValidation,
    List<int>? restrictedArray,
    String? deprecatedField,
    DeprecatedObject? deprecatedRef,
    String? defaultString,
    String? defaultBackslash,
    List<List<Address>>? nestedArray,
    String? singleQuoteKey,
    TestRootMixedEnum? mixedEnum,
    int? defaultInt,
    bool? defaultBool,
    List<String>? defaultList,
    Address? defaultObject,
    String? defaultNullableString,
    Merged? mergedValue,
    List<dynamic>? tupleArray,
    List<dynamic>? tupleObjectArray,
    String? ipv6Value,
    String? hostnameValue,
    String? timeValue,
    String? uriReferenceValue,
    MapObject? additionalPropertiesObject,
    StrictObject? strictObject,
    NotObject? notObject,
    TestRootAnyOfValue? anyOfValue,
    MergedAllOfObject? mergedAllOfObject,
    ComplexMergedObject? complexMerged,
    MyEnum? myEnumField,
    List<Object?>? unionContainsArray,
    List<Object?>? objectContainsArray,
    List<Object?>? enumContainsArray,
    List<Object?>? booleanContainsArray,
    List<Object?>? nullContainsArray,
    List<Object?>? anyContainsArray,
    List<Object?>? stringContainsArray,
    List<Object?>? numberContainsArray,
    ObjectWithDynamicProps? dynamicProps,
    String? dateTimeField,
    String? dateField,
    String? ipv4Field,
    String? uriField,
    List<String>? defaultEmptyList,
    MapObject? defaultEmptyObject,
    TestRootUnionWithArrayOption? unionWithArrayOption,
    Never? impossibleField,
    List<String>? tupleSameTypeArray,
    List<TestRootArrayWithAllOfItemsItem>? arrayWithAllOfItems,
    TestRootUnionWithAllOfOption? unionWithAllOfOption,
    String? deprecatedFieldWithMessage,
    MyCustomClassName? customNamedObject,
    MyCustomUnionName? customNamedUnion,
    MyCustomEnumName? customNamedEnum,
    TestRootCoverageTrigger? coverageTrigger,
    CollidingEnum? collidingEnumField,
    CollidingObject? collidingObjectField,
  }) => TestRoot(
    name: name ?? this.name,
    constValue: constValue ?? this.constValue,
    age: age ?? this.age,
    exclusiveAge: exclusiveAge ?? this.exclusiveAge,
    height: height ?? this.height,
    email: email ?? this.email,
    uuid: uuid ?? this.uuid,
    isAwesome: isAwesome ?? this.isAwesome,
    class_: class_ ?? this.class_,
    reader: reader ?? this.reader,
    stack: stack ?? this.stack,
    validate_: validate_ ?? this.validate_,
    result: result ?? this.result,
    address: address ?? this.address,
    tags: tags ?? this.tags,
    scores: scores ?? this.scores,
    unionValue: unionValue ?? this.unionValue,
    nullableUnionValue: nullableUnionValue ?? this.nullableUnionValue,
    requiredNullableUnionObject:
        requiredNullableUnionObject ?? this.requiredNullableUnionObject,
    nullableString: nullableString ?? this.nullableString,
    pet: pet ?? this.pet,
    restrictedObject: restrictedObject ?? this.restrictedObject,
    dependentObject: dependentObject ?? this.dependentObject,
    primitiveArrayWithValidation:
        primitiveArrayWithValidation ?? this.primitiveArrayWithValidation,
    restrictedArray: restrictedArray ?? this.restrictedArray,
    deprecatedField: deprecatedField ?? this.deprecatedField,
    deprecatedRef: deprecatedRef ?? this.deprecatedRef,
    defaultString: defaultString ?? this.defaultString,
    defaultBackslash: defaultBackslash ?? this.defaultBackslash,
    nestedArray: nestedArray ?? this.nestedArray,
    singleQuoteKey: singleQuoteKey ?? this.singleQuoteKey,
    mixedEnum: mixedEnum ?? this.mixedEnum,
    defaultInt: defaultInt ?? this.defaultInt,
    defaultBool: defaultBool ?? this.defaultBool,
    defaultList: defaultList ?? this.defaultList,
    defaultObject: defaultObject ?? this.defaultObject,
    defaultNullableString: defaultNullableString ?? this.defaultNullableString,
    mergedValue: mergedValue ?? this.mergedValue,
    tupleArray: tupleArray ?? this.tupleArray,
    tupleObjectArray: tupleObjectArray ?? this.tupleObjectArray,
    ipv6Value: ipv6Value ?? this.ipv6Value,
    hostnameValue: hostnameValue ?? this.hostnameValue,
    timeValue: timeValue ?? this.timeValue,
    uriReferenceValue: uriReferenceValue ?? this.uriReferenceValue,
    additionalPropertiesObject:
        additionalPropertiesObject ?? this.additionalPropertiesObject,
    strictObject: strictObject ?? this.strictObject,
    notObject: notObject ?? this.notObject,
    anyOfValue: anyOfValue ?? this.anyOfValue,
    mergedAllOfObject: mergedAllOfObject ?? this.mergedAllOfObject,
    complexMerged: complexMerged ?? this.complexMerged,
    myEnumField: myEnumField ?? this.myEnumField,
    unionContainsArray: unionContainsArray ?? this.unionContainsArray,
    objectContainsArray: objectContainsArray ?? this.objectContainsArray,
    enumContainsArray: enumContainsArray ?? this.enumContainsArray,
    booleanContainsArray: booleanContainsArray ?? this.booleanContainsArray,
    nullContainsArray: nullContainsArray ?? this.nullContainsArray,
    anyContainsArray: anyContainsArray ?? this.anyContainsArray,
    stringContainsArray: stringContainsArray ?? this.stringContainsArray,
    numberContainsArray: numberContainsArray ?? this.numberContainsArray,
    dynamicProps: dynamicProps ?? this.dynamicProps,
    dateTimeField: dateTimeField ?? this.dateTimeField,
    dateField: dateField ?? this.dateField,
    ipv4Field: ipv4Field ?? this.ipv4Field,
    uriField: uriField ?? this.uriField,
    defaultEmptyList: defaultEmptyList ?? this.defaultEmptyList,
    defaultEmptyObject: defaultEmptyObject ?? this.defaultEmptyObject,
    unionWithArrayOption: unionWithArrayOption ?? this.unionWithArrayOption,
    impossibleField: impossibleField ?? this.impossibleField,
    tupleSameTypeArray: tupleSameTypeArray ?? this.tupleSameTypeArray,
    arrayWithAllOfItems: arrayWithAllOfItems ?? this.arrayWithAllOfItems,
    unionWithAllOfOption: unionWithAllOfOption ?? this.unionWithAllOfOption,
    deprecatedFieldWithMessage:
        deprecatedFieldWithMessage ?? this.deprecatedFieldWithMessage,
    customNamedObject: customNamedObject ?? this.customNamedObject,
    customNamedUnion: customNamedUnion ?? this.customNamedUnion,
    customNamedEnum: customNamedEnum ?? this.customNamedEnum,
    coverageTrigger: coverageTrigger ?? this.coverageTrigger,
    collidingEnumField: collidingEnumField ?? this.collidingEnumField,
    collidingObjectField: collidingObjectField ?? this.collidingObjectField,
  );

  void validate() {
    if (name.length < 2) {
      throw JsonValidationException('Property "name" length must be >= 2', [
        'name',
      ]);
    }
    final val_constValue = constValue;
    if (val_constValue != null) {
      if (!const [
        TestRootConstValue.alwaysThisValue,
      ].any((v) => const DeepCollectionEquality().equals(v, val_constValue))) {
        throw JsonValidationException(
          'Property "constValue" must be one of [always-this-value]',
          ['constValue'],
        );
      }
    }
    if (age < 0) {
      throw JsonValidationException('Property "age" must be >= 0', ['age']);
    }
    if (age % 5 != 0) {
      throw JsonValidationException('Property "age" must be a multiple of 5', [
        'age',
      ]);
    }
    final val_exclusiveAge = exclusiveAge;
    if (val_exclusiveAge != null) {
      if (val_exclusiveAge <= 0) {
        throw JsonValidationException('Property "exclusiveAge" must be > 0', [
          'exclusiveAge',
        ]);
      }
      if (val_exclusiveAge >= 100) {
        throw JsonValidationException('Property "exclusiveAge" must be < 100', [
          'exclusiveAge',
        ]);
      }
    }
    final val_height = height;
    final val_email = email;
    if (val_email != null) {
      if (!RegExp('^[a-zA-Z0-9.]+@[a-zA-Z0-9.]+\$').hasMatch(val_email)) {
        throw JsonValidationException(
          'Property "email" must match pattern "^[a-zA-Z0-9.]+@[a-zA-Z0-9.]+\$"',
          ['email'],
        );
      }
    }
    final val_uuid = uuid;
    if (val_uuid != null) {
      if (!RegExp(
        r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
      ).hasMatch(val_uuid)) {
        throw JsonValidationException('Property "uuid" must be a valid UUID', [
          'uuid',
        ]);
      }
    }
    final val_class_ = class_;
    final val_reader = reader;
    final val_stack = stack;
    final val_validate_ = validate_;
    final val_result = result;
    try {
      address.validate();
    } on JsonValidationException catch (e) {
      throw JsonValidationException(e.message, ['address', ...e.path]);
    }
    final val_tags = tags;
    if (val_tags != null) {
      if (val_tags.length < 1) {
        throw JsonValidationException('Property "tags" must have >= 1 items', [
          'tags',
        ]);
      }
      if (val_tags.length !=
          (LinkedHashSet<dynamic>(
            equals: const DeepCollectionEquality().equals,
            hashCode: const DeepCollectionEquality().hash,
          )..addAll(val_tags)).length) {
        throw JsonValidationException('Property "tags" items must be unique', [
          'tags',
        ]);
      }
    }
    final val_scores = scores;
    if (val_scores != null) {
      for (var i = 0; i < val_scores.length; i++) {
        try {
          val_scores[i].validate();
        } on JsonValidationException catch (e) {
          throw JsonValidationException(e.message, [
            'scores',
            '[$i]',
            ...e.path,
          ]);
        }
      }
    }
    final val_unionValue = unionValue;
    if (val_unionValue != null) {
      try {
        val_unionValue.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['unionValue', ...e.path]);
      }
    }
    final val_nullableUnionValue = nullableUnionValue;
    if (val_nullableUnionValue != null) {
      try {
        val_nullableUnionValue.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [
          'nullableUnionValue',
          ...e.path,
        ]);
      }
    }
    final val_requiredNullableUnionObject = requiredNullableUnionObject;
    if (val_requiredNullableUnionObject != null) {
      try {
        val_requiredNullableUnionObject.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [
          'requiredNullableUnionObject',
          ...e.path,
        ]);
      }
    }
    final val_nullableString = nullableString;
    final val_pet = pet;
    if (val_pet != null) {
      try {
        val_pet.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['pet', ...e.path]);
      }
    }
    final val_restrictedObject = restrictedObject;
    if (val_restrictedObject != null) {
      try {
        val_restrictedObject.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [
          'restrictedObject',
          ...e.path,
        ]);
      }
    }
    final val_dependentObject = dependentObject;
    if (val_dependentObject != null) {
      try {
        val_dependentObject.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [
          'dependentObject',
          ...e.path,
        ]);
      }
    }
    final val_primitiveArrayWithValidation = primitiveArrayWithValidation;
    if (val_primitiveArrayWithValidation != null) {
      for (var i = 0; i < val_primitiveArrayWithValidation.length; i++) {
        if (val_primitiveArrayWithValidation[i] is! String) {
          throw JsonValidationException(
            'Property "primitiveArrayWithValidation" must be a string',
            ['primitiveArrayWithValidation', '[$i]'],
          );
        }
        if (val_primitiveArrayWithValidation[i].length < 3) {
          throw JsonValidationException(
            'Property "primitiveArrayWithValidation" length must be >= 3',
            ['primitiveArrayWithValidation', '[$i]'],
          );
        }
      }
    }
    final val_restrictedArray = restrictedArray;
    if (val_restrictedArray != null) {
      var containsCount = 0;
      for (final dynamic item in val_restrictedArray) {
        bool matches = false;
        if (item is int) {
          matches = true;
          if (item < 5) matches = false;
          if (item % 3 != 0) matches = false;
        }
        if (matches) containsCount++;
      }
      if (containsCount < 1) {
        throw JsonValidationException(
          'Property "restrictedArray" must contain at least 1 items matching contains schema, but has $containsCount',
          ['restrictedArray'],
        );
      }
      if (containsCount > 2) {
        throw JsonValidationException(
          'Property "restrictedArray" must contain at most 2 items matching contains schema, but has $containsCount',
          ['restrictedArray'],
        );
      }
    }
    final val_deprecatedField = deprecatedField;
    final val_deprecatedRef = deprecatedRef;
    if (val_deprecatedRef != null) {
      try {
        val_deprecatedRef.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['deprecatedRef', ...e.path]);
      }
    }
    final val_nestedArray = nestedArray;
    if (val_nestedArray != null) {
      for (var i = 0; i < val_nestedArray.length; i++) {
        for (var i0 = 0; i0 < val_nestedArray[i].length; i0++) {
          final item0 = val_nestedArray[i][i0];
          try {
            item0.validate();
          } on JsonValidationException catch (e) {
            throw JsonValidationException(e.message, [
              'nestedArray',
              '[$i]',
              '[$i0]',
              ...e.path,
            ]);
          }
        }
      }
    }
    final val_singleQuoteKey = singleQuoteKey;
    final val_mixedEnum = mixedEnum;
    if (val_mixedEnum != null) {
      if (!const [
        TestRootMixedEnum.foo,
        TestRootMixedEnum.value42,
        TestRootMixedEnum.bar,
        TestRootMixedEnum.value100,
      ].any((v) => const DeepCollectionEquality().equals(v, val_mixedEnum))) {
        throw JsonValidationException(
          'Property "mixedEnum" must be one of [foo, 42, bar, 100]',
          ['mixedEnum'],
        );
      }
    }
    try {
      defaultObject.validate();
    } on JsonValidationException catch (e) {
      throw JsonValidationException(e.message, ['defaultObject', ...e.path]);
    }
    final val_defaultNullableString = defaultNullableString;
    final val_mergedValue = mergedValue;
    if (val_mergedValue != null) {
      try {
        val_mergedValue.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['mergedValue', ...e.path]);
      }
    }
    final val_tupleArray = tupleArray;
    final val_tupleObjectArray = tupleObjectArray;
    if (val_tupleObjectArray != null) {
      if (val_tupleObjectArray.length > 0) {
        try {
          val_tupleObjectArray[0].validate();
        } on JsonValidationException catch (e) {
          throw JsonValidationException(e.message, [
            'tupleObjectArray',
            '[0]',
            ...e.path,
          ]);
        }
      }
      if (val_tupleObjectArray.length > 1) {
        try {
          val_tupleObjectArray[1].validate();
        } on JsonValidationException catch (e) {
          throw JsonValidationException(e.message, [
            'tupleObjectArray',
            '[1]',
            ...e.path,
          ]);
        }
      }
    }
    final val_ipv6Value = ipv6Value;
    if (val_ipv6Value != null) {
      if (!isValidIPv6(val_ipv6Value)) {
        throw JsonValidationException(
          'Property "ipv6Value" must be a valid IPv6 address',
          ['ipv6Value'],
        );
      }
    }
    final val_hostnameValue = hostnameValue;
    if (val_hostnameValue != null) {
      if (!isValidHostname(val_hostnameValue)) {
        throw JsonValidationException(
          'Property "hostnameValue" must be a valid hostname',
          ['hostnameValue'],
        );
      }
    }
    final val_timeValue = timeValue;
    if (val_timeValue != null) {
      if (!isValidTime(val_timeValue)) {
        throw JsonValidationException(
          'Property "timeValue" must be a valid time string',
          ['timeValue'],
        );
      }
    }
    final val_uriReferenceValue = uriReferenceValue;
    if (val_uriReferenceValue != null) {
      if (!isValidUriReference(val_uriReferenceValue)) {
        throw JsonValidationException(
          'Property "uriReferenceValue" must be a valid URI reference',
          ['uriReferenceValue'],
        );
      }
    }
    final val_additionalPropertiesObject = additionalPropertiesObject;
    if (val_additionalPropertiesObject != null) {
      try {
        val_additionalPropertiesObject.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [
          'additionalPropertiesObject',
          ...e.path,
        ]);
      }
    }
    final val_strictObject = strictObject;
    if (val_strictObject != null) {
      try {
        val_strictObject.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['strictObject', ...e.path]);
      }
    }
    final val_notObject = notObject;
    if (val_notObject != null) {
      try {
        val_notObject.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['notObject', ...e.path]);
      }
    }
    final val_anyOfValue = anyOfValue;
    if (val_anyOfValue != null) {
      try {
        val_anyOfValue.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['anyOfValue', ...e.path]);
      }
    }
    final val_mergedAllOfObject = mergedAllOfObject;
    if (val_mergedAllOfObject != null) {
      try {
        val_mergedAllOfObject.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [
          'mergedAllOfObject',
          ...e.path,
        ]);
      }
    }
    final val_complexMerged = complexMerged;
    if (val_complexMerged != null) {
      try {
        val_complexMerged.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['complexMerged', ...e.path]);
      }
    }
    final val_myEnumField = myEnumField;
    if (val_myEnumField != null) {
      if (!const [
        MyEnum.alpha,
        MyEnum.beta,
        MyEnum.gamma,
      ].any((v) => const DeepCollectionEquality().equals(v, val_myEnumField))) {
        throw JsonValidationException(
          'Property "myEnumField" must be one of [alpha, beta, gamma]',
          ['myEnumField'],
        );
      }
    }
    final val_unionContainsArray = unionContainsArray;
    if (val_unionContainsArray != null) {
      var containsCount = 0;
      for (final dynamic item in val_unionContainsArray) {
        bool matches = false;
        if (item is TestRootUnionContainsArrayContains) {
          matches = true;
          try {
            item.validate();
          } on JsonValidationException catch (_) {
            matches = false;
          }
        } else {
          try {
            TestRootUnionContainsArrayContains.fromJson(
              JsonReader.fromObject(item),
            );
            matches = true;
          } catch (_) {}
        }
        if (matches) containsCount++;
      }
      if (containsCount < 1) {
        throw JsonValidationException(
          'Property "unionContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
          ['unionContainsArray'],
        );
      }
    }
    final val_objectContainsArray = objectContainsArray;
    if (val_objectContainsArray != null) {
      var containsCount = 0;
      for (final dynamic item in val_objectContainsArray) {
        bool matches = false;
        if (item is Address) {
          matches = true;
          try {
            item.validate();
          } on JsonValidationException catch (_) {
            matches = false;
          }
        } else if (item is Map<String, dynamic>) {
          try {
            final parsed = Address.fromJson(JsonReader.fromObject(item));
            matches = true;
          } catch (_) {}
        }
        if (matches) containsCount++;
      }
      if (containsCount < 1) {
        throw JsonValidationException(
          'Property "objectContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
          ['objectContainsArray'],
        );
      }
    }
    final val_enumContainsArray = enumContainsArray;
    if (val_enumContainsArray != null) {
      var containsCount = 0;
      for (final dynamic item in val_enumContainsArray) {
        bool matches = false;
        if (item is MyEnum) {
          matches = true;
        } else {
          try {
            MyEnum.fromValue(item as String);
            matches = true;
          } catch (_) {}
        }
        if (matches) containsCount++;
      }
      if (containsCount < 1) {
        throw JsonValidationException(
          'Property "enumContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
          ['enumContainsArray'],
        );
      }
    }
    final val_booleanContainsArray = booleanContainsArray;
    if (val_booleanContainsArray != null) {
      var containsCount = 0;
      for (final dynamic item in val_booleanContainsArray) {
        bool matches = false;
        if (item is bool) matches = true;
        if (matches) containsCount++;
      }
      if (containsCount < 1) {
        throw JsonValidationException(
          'Property "booleanContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
          ['booleanContainsArray'],
        );
      }
    }
    final val_nullContainsArray = nullContainsArray;
    if (val_nullContainsArray != null) {
      var containsCount = 0;
      for (final dynamic item in val_nullContainsArray) {
        bool matches = false;
        if (item == null) matches = true;
        if (matches) containsCount++;
      }
      if (containsCount < 1) {
        throw JsonValidationException(
          'Property "nullContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
          ['nullContainsArray'],
        );
      }
    }
    final val_anyContainsArray = anyContainsArray;
    if (val_anyContainsArray != null) {
      var containsCount = 0;
      for (final dynamic item in val_anyContainsArray) {
        bool matches = false;
        matches = true;
        if (matches) containsCount++;
      }
      if (containsCount < 1) {
        throw JsonValidationException(
          'Property "anyContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
          ['anyContainsArray'],
        );
      }
    }
    final val_stringContainsArray = stringContainsArray;
    if (val_stringContainsArray != null) {
      var containsCount = 0;
      for (final dynamic item in val_stringContainsArray) {
        bool matches = false;
        if (item is String) {
          matches = true;
          if (item.length < 3) matches = false;
          if (item.length > 10) matches = false;
          if (!RegExp('^a').hasMatch(item)) matches = false;
          try {
            if (!RegExp(r'^[^@]+@[^@]+$').hasMatch(item)) {
              throw JsonValidationException(
                'Property "item" must be a valid email address',
                ['item'],
              );
            }
          } on JsonValidationException catch (_) {
            matches = false;
          }
        }
        if (matches) containsCount++;
      }
      if (containsCount < 1) {
        throw JsonValidationException(
          'Property "stringContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
          ['stringContainsArray'],
        );
      }
    }
    final val_numberContainsArray = numberContainsArray;
    if (val_numberContainsArray != null) {
      var containsCount = 0;
      for (final dynamic item in val_numberContainsArray) {
        bool matches = false;
        if (item is num) {
          matches = true;
          if (item < 5.0) matches = false;
          if (item > 10.0) matches = false;
          if (item <= 4.5) matches = false;
          if (item >= 10.5) matches = false;
          if ((item / 0.5 - (item / 0.5).round()).abs() > 1e-9) matches = false;
        }
        if (matches) containsCount++;
      }
      if (containsCount < 1) {
        throw JsonValidationException(
          'Property "numberContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
          ['numberContainsArray'],
        );
      }
    }
    final val_dynamicProps = dynamicProps;
    if (val_dynamicProps != null) {
      try {
        val_dynamicProps.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['dynamicProps', ...e.path]);
      }
    }
    final val_dateTimeField = dateTimeField;
    if (val_dateTimeField != null) {
      if (DateTime.tryParse(val_dateTimeField) == null) {
        throw JsonValidationException(
          'Property "dateTimeField" must be a valid RFC 3339 date-time string',
          ['dateTimeField'],
        );
      }
    }
    final val_dateField = dateField;
    if (val_dateField != null) {
      if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(val_dateField)) {
        throw JsonValidationException(
          'Property "dateField" must be a valid date string (YYYY-MM-DD)',
          ['dateField'],
        );
      }
    }
    final val_ipv4Field = ipv4Field;
    if (val_ipv4Field != null) {
      if (!RegExp(
        r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
      ).hasMatch(val_ipv4Field)) {
        throw JsonValidationException(
          'Property "ipv4Field" must be a valid IPv4 address',
          ['ipv4Field'],
        );
      }
    }
    final val_uriField = uriField;
    if (val_uriField != null) {
      if (!isValidUri(val_uriField)) {
        throw JsonValidationException(
          'Property "uriField" must be a valid absolute URI',
          ['uriField'],
        );
      }
    }
    try {
      defaultEmptyObject.validate();
    } on JsonValidationException catch (e) {
      throw JsonValidationException(e.message, [
        'defaultEmptyObject',
        ...e.path,
      ]);
    }
    final val_unionWithArrayOption = unionWithArrayOption;
    if (val_unionWithArrayOption != null) {
      try {
        val_unionWithArrayOption.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [
          'unionWithArrayOption',
          ...e.path,
        ]);
      }
    }
    final val_impossibleField = impossibleField;
    if (val_impossibleField != null) {
      throw JsonValidationException(
        'Property "impossibleField" matches nothing',
        ['impossibleField'],
      );
    }
    final val_tupleSameTypeArray = tupleSameTypeArray;
    if (val_tupleSameTypeArray != null) {
      if (val_tupleSameTypeArray.length > 0) {
        if (val_tupleSameTypeArray[0] is! String) {
          throw JsonValidationException(
            'Property "tupleSameTypeArray" must be a string',
            ['tupleSameTypeArray', '[0]'],
          );
        }
        if (val_tupleSameTypeArray[0].length < 1) {
          throw JsonValidationException(
            'Property "tupleSameTypeArray" length must be >= 1',
            ['tupleSameTypeArray', '[0]'],
          );
        }
      }
      if (val_tupleSameTypeArray.length > 1) {
        if (val_tupleSameTypeArray[1] is! String) {
          throw JsonValidationException(
            'Property "tupleSameTypeArray" must be a string',
            ['tupleSameTypeArray', '[1]'],
          );
        }
        if (val_tupleSameTypeArray[1].length > 5) {
          throw JsonValidationException(
            'Property "tupleSameTypeArray" length must be <= 5',
            ['tupleSameTypeArray', '[1]'],
          );
        }
      }
    }
    final val_arrayWithAllOfItems = arrayWithAllOfItems;
    if (val_arrayWithAllOfItems != null) {
      for (var i = 0; i < val_arrayWithAllOfItems.length; i++) {
        try {
          val_arrayWithAllOfItems[i].validate();
        } on JsonValidationException catch (e) {
          throw JsonValidationException(e.message, [
            'arrayWithAllOfItems',
            '[$i]',
            ...e.path,
          ]);
        }
      }
    }
    final val_unionWithAllOfOption = unionWithAllOfOption;
    if (val_unionWithAllOfOption != null) {
      try {
        val_unionWithAllOfOption.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [
          'unionWithAllOfOption',
          ...e.path,
        ]);
      }
    }
    final val_deprecatedFieldWithMessage = deprecatedFieldWithMessage;
    final val_customNamedObject = customNamedObject;
    if (val_customNamedObject != null) {
      try {
        val_customNamedObject.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [
          'customNamedObject',
          ...e.path,
        ]);
      }
    }
    final val_customNamedUnion = customNamedUnion;
    if (val_customNamedUnion != null) {
      try {
        val_customNamedUnion.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [
          'customNamedUnion',
          ...e.path,
        ]);
      }
    }
    final val_customNamedEnum = customNamedEnum;
    if (val_customNamedEnum != null) {
      if (!const [MyCustomEnumName.one, MyCustomEnumName.two].any(
        (v) => const DeepCollectionEquality().equals(v, val_customNamedEnum),
      )) {
        throw JsonValidationException(
          'Property "customNamedEnum" must be one of [one, two]',
          ['customNamedEnum'],
        );
      }
    }
    final val_coverageTrigger = coverageTrigger;
    if (val_coverageTrigger != null) {
      try {
        val_coverageTrigger.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [
          'coverageTrigger',
          ...e.path,
        ]);
      }
    }
    final val_collidingEnumField = collidingEnumField;
    if (val_collidingEnumField != null) {
      if (!const [
        CollidingEnum.values_1,
        CollidingEnum.value_1,
        CollidingEnum.fromValue_1,
        CollidingEnum.descriptor_,
        CollidingEnum.fooBar,
        CollidingEnum.fooBar_1,
        CollidingEnum.a1,
        CollidingEnum.a1_1,
      ].any(
        (v) => const DeepCollectionEquality().equals(v, val_collidingEnumField),
      )) {
        throw JsonValidationException(
          'Property "collidingEnumField" must be one of [values, value, fromValue, descriptor, foo-bar, foo_bar, {a: 1}, {a: 1}]',
          ['collidingEnumField'],
        );
      }
    }
    final val_collidingObjectField = collidingObjectField;
    if (val_collidingObjectField != null) {
      try {
        val_collidingObjectField.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [
          'collidingObjectField',
          ...e.path,
        ]);
      }
    }
  }

  static final descriptor = ObjectDescriptor<TestRoot>(
    title: 'TestRoot',
    matches: (instance) => instance is TestRoot,
    instantiate: (fields) => TestRoot(
      name: fields['name'] as String,
      constValue: fields['constValue'] as TestRootConstValue?,
      age: fields['age'] as int,
      exclusiveAge: fields['exclusiveAge'] as int?,
      height: fields['height'] as num?,
      email: fields['email'] as String?,
      uuid: fields['uuid'] as String?,
      isAwesome: fields['isAwesome'] as bool,
      class_: fields['class'] as String?,
      reader: fields['reader'] as String?,
      stack: fields['stack'] as String?,
      validate_: fields['validate'] as String?,
      result: fields['result'] as String?,
      address: fields['address'] as Address,
      tags: fields['tags'] as List<String>?,
      scores: fields['scores'] as List<Score>?,
      unionValue: fields['unionValue'] as TestRootUnionValue?,
      nullableUnionValue:
          fields['nullableUnionValue'] as TestRootNullableUnionValue?,
      requiredNullableUnionObject:
          fields['requiredNullableUnionObject'] as RequiredNullableUnionObject?,
      nullableString: fields['nullableString'] as String?,
      pet: fields['pet'] as Pet?,
      restrictedObject: fields['restrictedObject'] as RestrictedObject?,
      dependentObject: fields['dependentObject'] as DependentObject?,
      primitiveArrayWithValidation:
          fields['primitiveArrayWithValidation'] as List<String>?,
      restrictedArray: fields['restrictedArray'] as List<int>?,
      deprecatedField: fields['deprecatedField'] as String?,
      deprecatedRef: fields['deprecatedRef'] as DeprecatedObject?,
      defaultString: fields.containsKey('defaultString')
          ? fields['defaultString'] as String
          : 'default value',
      defaultBackslash: fields.containsKey('defaultBackslash')
          ? fields['defaultBackslash'] as String
          : 'foo\\sbar',
      nestedArray: fields['nestedArray'] as List<List<Address>>?,
      singleQuoteKey: fields['single\'quote\'key'] as String?,
      mixedEnum: fields['mixedEnum'] as TestRootMixedEnum?,
      defaultInt: fields.containsKey('defaultInt')
          ? fields['defaultInt'] as int
          : 42,
      defaultBool: fields.containsKey('defaultBool')
          ? fields['defaultBool'] as bool
          : true,
      defaultList: fields.containsKey('defaultList')
          ? fields['defaultList'] as List<String>
          : const <String>['a', 'b'],
      defaultObject: fields.containsKey('defaultObject')
          ? fields['defaultObject'] as Address
          : const Address(city: 'Default City'),
      defaultNullableString: fields.containsKey('defaultNullableString')
          ? fields['defaultNullableString'] as String?
          : null,
      mergedValue: fields['mergedValue'] as Merged?,
      tupleArray: fields['tupleArray'] as List<dynamic>?,
      tupleObjectArray: fields['tupleObjectArray'] as List<dynamic>?,
      ipv6Value: fields['ipv6Value'] as String?,
      hostnameValue: fields['hostnameValue'] as String?,
      timeValue: fields['timeValue'] as String?,
      uriReferenceValue: fields['uriReferenceValue'] as String?,
      additionalPropertiesObject:
          fields['additionalPropertiesObject'] as MapObject?,
      strictObject: fields['strictObject'] as StrictObject?,
      notObject: fields['notObject'] as NotObject?,
      anyOfValue: fields['anyOfValue'] as TestRootAnyOfValue?,
      mergedAllOfObject: fields['mergedAllOfObject'] as MergedAllOfObject?,
      complexMerged: fields['complexMerged'] as ComplexMergedObject?,
      myEnumField: fields['myEnumField'] as MyEnum?,
      unionContainsArray: fields['unionContainsArray'] as List<Object?>?,
      objectContainsArray: fields['objectContainsArray'] as List<Object?>?,
      enumContainsArray: fields['enumContainsArray'] as List<Object?>?,
      booleanContainsArray: fields['booleanContainsArray'] as List<Object?>?,
      nullContainsArray: fields['nullContainsArray'] as List<Object?>?,
      anyContainsArray: fields['anyContainsArray'] as List<Object?>?,
      stringContainsArray: fields['stringContainsArray'] as List<Object?>?,
      numberContainsArray: fields['numberContainsArray'] as List<Object?>?,
      dynamicProps: fields['dynamicProps'] as ObjectWithDynamicProps?,
      dateTimeField: fields['dateTimeField'] as String?,
      dateField: fields['dateField'] as String?,
      ipv4Field: fields['ipv4Field'] as String?,
      uriField: fields['uriField'] as String?,
      defaultEmptyList: fields.containsKey('defaultEmptyList')
          ? fields['defaultEmptyList'] as List<String>
          : const <String>[],
      defaultEmptyObject: fields.containsKey('defaultEmptyObject')
          ? fields['defaultEmptyObject'] as MapObject
          : const MapObject(),
      unionWithArrayOption:
          fields['unionWithArrayOption'] as TestRootUnionWithArrayOption?,
      impossibleField: fields['impossibleField'] as Never?,
      tupleSameTypeArray: fields['tupleSameTypeArray'] as List<String>?,
      arrayWithAllOfItems:
          fields['arrayWithAllOfItems']
              as List<TestRootArrayWithAllOfItemsItem>?,
      unionWithAllOfOption:
          fields['unionWithAllOfOption'] as TestRootUnionWithAllOfOption?,
      deprecatedFieldWithMessage:
          fields['deprecatedFieldWithMessage'] as String?,
      customNamedObject: fields['customNamedObject'] as MyCustomClassName?,
      customNamedUnion: fields['customNamedUnion'] as MyCustomUnionName?,
      customNamedEnum: fields['customNamedEnum'] as MyCustomEnumName?,
      coverageTrigger: fields['coverageTrigger'] as TestRootCoverageTrigger?,
      collidingEnumField: fields['collidingEnumField'] as CollidingEnum?,
      collidingObjectField: fields['collidingObjectField'] as CollidingObject?,
    ),
    getFields: (instance) {
      final typedInstance = instance as TestRoot;
      return {
        'name': typedInstance.name,
        'constValue': typedInstance.constValue,
        'age': typedInstance.age,
        'exclusiveAge': typedInstance.exclusiveAge,
        'height': typedInstance.height,
        'email': typedInstance.email,
        'uuid': typedInstance.uuid,
        'isAwesome': typedInstance.isAwesome,
        'class': typedInstance.class_,
        'reader': typedInstance.reader,
        'stack': typedInstance.stack,
        'validate': typedInstance.validate_,
        'result': typedInstance.result,
        'address': typedInstance.address,
        'tags': typedInstance.tags,
        'scores': typedInstance.scores,
        'unionValue': typedInstance.unionValue,
        'nullableUnionValue': typedInstance.nullableUnionValue,
        'requiredNullableUnionObject':
            typedInstance.requiredNullableUnionObject,
        'nullableString': typedInstance.nullableString,
        'pet': typedInstance.pet,
        'restrictedObject': typedInstance.restrictedObject,
        'dependentObject': typedInstance.dependentObject,
        'primitiveArrayWithValidation':
            typedInstance.primitiveArrayWithValidation,
        'restrictedArray': typedInstance.restrictedArray,
        'deprecatedField': typedInstance.deprecatedField,
        'deprecatedRef': typedInstance.deprecatedRef,
        'defaultString': typedInstance.defaultString,
        'defaultBackslash': typedInstance.defaultBackslash,
        'nestedArray': typedInstance.nestedArray,
        'single\'quote\'key': typedInstance.singleQuoteKey,
        'mixedEnum': typedInstance.mixedEnum,
        'defaultInt': typedInstance.defaultInt,
        'defaultBool': typedInstance.defaultBool,
        'defaultList': typedInstance.defaultList,
        'defaultObject': typedInstance.defaultObject,
        'defaultNullableString': typedInstance.defaultNullableString,
        'mergedValue': typedInstance.mergedValue,
        'tupleArray': typedInstance.tupleArray,
        'tupleObjectArray': typedInstance.tupleObjectArray,
        'ipv6Value': typedInstance.ipv6Value,
        'hostnameValue': typedInstance.hostnameValue,
        'timeValue': typedInstance.timeValue,
        'uriReferenceValue': typedInstance.uriReferenceValue,
        'additionalPropertiesObject': typedInstance.additionalPropertiesObject,
        'strictObject': typedInstance.strictObject,
        'notObject': typedInstance.notObject,
        'anyOfValue': typedInstance.anyOfValue,
        'mergedAllOfObject': typedInstance.mergedAllOfObject,
        'complexMerged': typedInstance.complexMerged,
        'myEnumField': typedInstance.myEnumField,
        'unionContainsArray': typedInstance.unionContainsArray,
        'objectContainsArray': typedInstance.objectContainsArray,
        'enumContainsArray': typedInstance.enumContainsArray,
        'booleanContainsArray': typedInstance.booleanContainsArray,
        'nullContainsArray': typedInstance.nullContainsArray,
        'anyContainsArray': typedInstance.anyContainsArray,
        'stringContainsArray': typedInstance.stringContainsArray,
        'numberContainsArray': typedInstance.numberContainsArray,
        'dynamicProps': typedInstance.dynamicProps,
        'dateTimeField': typedInstance.dateTimeField,
        'dateField': typedInstance.dateField,
        'ipv4Field': typedInstance.ipv4Field,
        'uriField': typedInstance.uriField,
        'defaultEmptyList': typedInstance.defaultEmptyList,
        'defaultEmptyObject': typedInstance.defaultEmptyObject,
        'unionWithArrayOption': typedInstance.unionWithArrayOption,
        'impossibleField': typedInstance.impossibleField,
        'tupleSameTypeArray': typedInstance.tupleSameTypeArray,
        'arrayWithAllOfItems': typedInstance.arrayWithAllOfItems,
        'unionWithAllOfOption': typedInstance.unionWithAllOfOption,
        'deprecatedFieldWithMessage': typedInstance.deprecatedFieldWithMessage,
        'customNamedObject': typedInstance.customNamedObject,
        'customNamedUnion': typedInstance.customNamedUnion,
        'customNamedEnum': typedInstance.customNamedEnum,
        'coverageTrigger': typedInstance.coverageTrigger,
        'collidingEnumField': typedInstance.collidingEnumField,
        'collidingObjectField': typedInstance.collidingObjectField,
      };
    },
    properties: {
      'name': PropertyDescriptor(
        name: 'name',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
      'constValue': PropertyDescriptor(
        name: 'constValue',
        isRequired: false,
        schema: TestRootConstValue.descriptor,
      ),
      'age': PropertyDescriptor(
        name: 'age',
        isRequired: true,
        schema: const IntDescriptor(),
      ),
      'exclusiveAge': PropertyDescriptor(
        name: 'exclusiveAge',
        isRequired: false,
        schema: const IntDescriptor(),
      ),
      'height': PropertyDescriptor(
        name: 'height',
        isRequired: false,
        schema: const NumDescriptor(),
      ),
      'email': PropertyDescriptor(
        name: 'email',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'uuid': PropertyDescriptor(
        name: 'uuid',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'isAwesome': PropertyDescriptor(
        name: 'isAwesome',
        isRequired: true,
        schema: const BoolDescriptor(),
      ),
      'class': PropertyDescriptor(
        name: 'class',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'reader': PropertyDescriptor(
        name: 'reader',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'stack': PropertyDescriptor(
        name: 'stack',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'validate': PropertyDescriptor(
        name: 'validate',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'result': PropertyDescriptor(
        name: 'result',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'address': PropertyDescriptor(
        name: 'address',
        isRequired: true,
        schema: Address.descriptor,
      ),
      'tags': PropertyDescriptor(
        name: 'tags',
        isRequired: false,
        schema: ArrayDescriptor<String>(const StringDescriptor()),
      ),
      'scores': PropertyDescriptor(
        name: 'scores',
        isRequired: false,
        schema: ArrayDescriptor<Score>(Score.descriptor),
      ),
      'unionValue': PropertyDescriptor(
        name: 'unionValue',
        isRequired: false,
        schema: TestRootUnionValue.descriptor,
      ),
      'nullableUnionValue': PropertyDescriptor(
        name: 'nullableUnionValue',
        isRequired: false,
        schema: NullableDescriptor(TestRootNullableUnionValue.descriptor),
      ),
      'requiredNullableUnionObject': PropertyDescriptor(
        name: 'requiredNullableUnionObject',
        isRequired: false,
        schema: RequiredNullableUnionObject.descriptor,
      ),
      'nullableString': PropertyDescriptor(
        name: 'nullableString',
        isRequired: false,
        schema: NullableDescriptor(const StringDescriptor()),
      ),
      'pet': PropertyDescriptor(
        name: 'pet',
        isRequired: false,
        schema: Pet.descriptor,
      ),
      'restrictedObject': PropertyDescriptor(
        name: 'restrictedObject',
        isRequired: false,
        schema: RestrictedObject.descriptor,
      ),
      'dependentObject': PropertyDescriptor(
        name: 'dependentObject',
        isRequired: false,
        schema: DependentObject.descriptor,
      ),
      'primitiveArrayWithValidation': PropertyDescriptor(
        name: 'primitiveArrayWithValidation',
        isRequired: false,
        schema: ArrayDescriptor<String>(const StringDescriptor()),
      ),
      'restrictedArray': PropertyDescriptor(
        name: 'restrictedArray',
        isRequired: false,
        schema: ArrayDescriptor<int>(const IntDescriptor()),
      ),
      'deprecatedField': PropertyDescriptor(
        name: 'deprecatedField',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'deprecatedRef': PropertyDescriptor(
        name: 'deprecatedRef',
        isRequired: false,
        schema: DeprecatedObject.descriptor,
      ),
      'defaultString': PropertyDescriptor(
        name: 'defaultString',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'defaultBackslash': PropertyDescriptor(
        name: 'defaultBackslash',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'nestedArray': PropertyDescriptor(
        name: 'nestedArray',
        isRequired: false,
        schema: ArrayDescriptor<List<Address>>(
          ArrayDescriptor<Address>(Address.descriptor),
        ),
      ),
      'single\'quote\'key': PropertyDescriptor(
        name: 'single\'quote\'key',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'mixedEnum': PropertyDescriptor(
        name: 'mixedEnum',
        isRequired: false,
        schema: TestRootMixedEnum.descriptor,
      ),
      'defaultInt': PropertyDescriptor(
        name: 'defaultInt',
        isRequired: false,
        schema: const IntDescriptor(),
      ),
      'defaultBool': PropertyDescriptor(
        name: 'defaultBool',
        isRequired: false,
        schema: const BoolDescriptor(),
      ),
      'defaultList': PropertyDescriptor(
        name: 'defaultList',
        isRequired: false,
        schema: ArrayDescriptor<String>(const StringDescriptor()),
      ),
      'defaultObject': PropertyDescriptor(
        name: 'defaultObject',
        isRequired: false,
        schema: Address.descriptor,
      ),
      'defaultNullableString': PropertyDescriptor(
        name: 'defaultNullableString',
        isRequired: false,
        schema: NullableDescriptor(const StringDescriptor()),
      ),
      'mergedValue': PropertyDescriptor(
        name: 'mergedValue',
        isRequired: false,
        schema: Merged.descriptor,
      ),
      'tupleArray': PropertyDescriptor(
        name: 'tupleArray',
        isRequired: false,
        schema: ArrayDescriptor<dynamic>(
          const BoolDescriptor(),
          prefixItems: [const StringDescriptor(), const IntDescriptor()],
        ),
      ),
      'tupleObjectArray': PropertyDescriptor(
        name: 'tupleObjectArray',
        isRequired: false,
        schema: ArrayDescriptor<dynamic>(
          const AnythingDescriptor(),
          prefixItems: [Address.descriptor, Cat.descriptor],
        ),
      ),
      'ipv6Value': PropertyDescriptor(
        name: 'ipv6Value',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'hostnameValue': PropertyDescriptor(
        name: 'hostnameValue',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'timeValue': PropertyDescriptor(
        name: 'timeValue',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'uriReferenceValue': PropertyDescriptor(
        name: 'uriReferenceValue',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'additionalPropertiesObject': PropertyDescriptor(
        name: 'additionalPropertiesObject',
        isRequired: false,
        schema: MapObject.descriptor,
      ),
      'strictObject': PropertyDescriptor(
        name: 'strictObject',
        isRequired: false,
        schema: StrictObject.descriptor,
      ),
      'notObject': PropertyDescriptor(
        name: 'notObject',
        isRequired: false,
        schema: NotObject.descriptor,
      ),
      'anyOfValue': PropertyDescriptor(
        name: 'anyOfValue',
        isRequired: false,
        schema: TestRootAnyOfValue.descriptor,
      ),
      'mergedAllOfObject': PropertyDescriptor(
        name: 'mergedAllOfObject',
        isRequired: false,
        schema: MergedAllOfObject.descriptor,
      ),
      'complexMerged': PropertyDescriptor(
        name: 'complexMerged',
        isRequired: false,
        schema: ComplexMergedObject.descriptor,
      ),
      'myEnumField': PropertyDescriptor(
        name: 'myEnumField',
        isRequired: false,
        schema: MyEnum.descriptor,
      ),
      'unionContainsArray': PropertyDescriptor(
        name: 'unionContainsArray',
        isRequired: false,
        schema: ArrayDescriptor<Object?>(const AnythingDescriptor()),
      ),
      'objectContainsArray': PropertyDescriptor(
        name: 'objectContainsArray',
        isRequired: false,
        schema: ArrayDescriptor<Object?>(const AnythingDescriptor()),
      ),
      'enumContainsArray': PropertyDescriptor(
        name: 'enumContainsArray',
        isRequired: false,
        schema: ArrayDescriptor<Object?>(const AnythingDescriptor()),
      ),
      'booleanContainsArray': PropertyDescriptor(
        name: 'booleanContainsArray',
        isRequired: false,
        schema: ArrayDescriptor<Object?>(const AnythingDescriptor()),
      ),
      'nullContainsArray': PropertyDescriptor(
        name: 'nullContainsArray',
        isRequired: false,
        schema: ArrayDescriptor<Object?>(const AnythingDescriptor()),
      ),
      'anyContainsArray': PropertyDescriptor(
        name: 'anyContainsArray',
        isRequired: false,
        schema: ArrayDescriptor<Object?>(const AnythingDescriptor()),
      ),
      'stringContainsArray': PropertyDescriptor(
        name: 'stringContainsArray',
        isRequired: false,
        schema: ArrayDescriptor<Object?>(const AnythingDescriptor()),
      ),
      'numberContainsArray': PropertyDescriptor(
        name: 'numberContainsArray',
        isRequired: false,
        schema: ArrayDescriptor<Object?>(const AnythingDescriptor()),
      ),
      'dynamicProps': PropertyDescriptor(
        name: 'dynamicProps',
        isRequired: false,
        schema: ObjectWithDynamicProps.descriptor,
      ),
      'dateTimeField': PropertyDescriptor(
        name: 'dateTimeField',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'dateField': PropertyDescriptor(
        name: 'dateField',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'ipv4Field': PropertyDescriptor(
        name: 'ipv4Field',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'uriField': PropertyDescriptor(
        name: 'uriField',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'defaultEmptyList': PropertyDescriptor(
        name: 'defaultEmptyList',
        isRequired: false,
        schema: ArrayDescriptor<String>(const StringDescriptor()),
      ),
      'defaultEmptyObject': PropertyDescriptor(
        name: 'defaultEmptyObject',
        isRequired: false,
        schema: MapObject.descriptor,
      ),
      'unionWithArrayOption': PropertyDescriptor(
        name: 'unionWithArrayOption',
        isRequired: false,
        schema: TestRootUnionWithArrayOption.descriptor,
      ),
      'impossibleField': PropertyDescriptor(
        name: 'impossibleField',
        isRequired: false,
        schema: const NeverDescriptor(),
      ),
      'tupleSameTypeArray': PropertyDescriptor(
        name: 'tupleSameTypeArray',
        isRequired: false,
        schema: ArrayDescriptor<String>(
          const StringDescriptor(),
          prefixItems: [const StringDescriptor(), const StringDescriptor()],
        ),
      ),
      'arrayWithAllOfItems': PropertyDescriptor(
        name: 'arrayWithAllOfItems',
        isRequired: false,
        schema: ArrayDescriptor<TestRootArrayWithAllOfItemsItem>(
          TestRootArrayWithAllOfItemsItem.descriptor,
        ),
      ),
      'unionWithAllOfOption': PropertyDescriptor(
        name: 'unionWithAllOfOption',
        isRequired: false,
        schema: TestRootUnionWithAllOfOption.descriptor,
      ),
      'deprecatedFieldWithMessage': PropertyDescriptor(
        name: 'deprecatedFieldWithMessage',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'customNamedObject': PropertyDescriptor(
        name: 'customNamedObject',
        isRequired: false,
        schema: MyCustomClassName.descriptor,
      ),
      'customNamedUnion': PropertyDescriptor(
        name: 'customNamedUnion',
        isRequired: false,
        schema: MyCustomUnionName.descriptor,
      ),
      'customNamedEnum': PropertyDescriptor(
        name: 'customNamedEnum',
        isRequired: false,
        schema: MyCustomEnumName.descriptor,
      ),
      'coverageTrigger': PropertyDescriptor(
        name: 'coverageTrigger',
        isRequired: false,
        schema: TestRootCoverageTrigger.descriptor,
      ),
      'collidingEnumField': PropertyDescriptor(
        name: 'collidingEnumField',
        isRequired: false,
        schema: CollidingEnum.descriptor,
      ),
      'collidingObjectField': PropertyDescriptor(
        name: 'collidingObjectField',
        isRequired: false,
        schema: CollidingObject.descriptor,
      ),
    },
    required: const ['name', 'age', 'isAwesome', 'address'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRoot &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          constValue == other.constValue &&
          age == other.age &&
          exclusiveAge == other.exclusiveAge &&
          height == other.height &&
          email == other.email &&
          uuid == other.uuid &&
          isAwesome == other.isAwesome &&
          class_ == other.class_ &&
          reader == other.reader &&
          stack == other.stack &&
          validate_ == other.validate_ &&
          result == other.result &&
          address == other.address &&
          const DeepCollectionEquality().equals(tags, other.tags) &&
          const DeepCollectionEquality().equals(scores, other.scores) &&
          unionValue == other.unionValue &&
          nullableUnionValue == other.nullableUnionValue &&
          requiredNullableUnionObject == other.requiredNullableUnionObject &&
          nullableString == other.nullableString &&
          pet == other.pet &&
          restrictedObject == other.restrictedObject &&
          dependentObject == other.dependentObject &&
          const DeepCollectionEquality().equals(
            primitiveArrayWithValidation,
            other.primitiveArrayWithValidation,
          ) &&
          const DeepCollectionEquality().equals(
            restrictedArray,
            other.restrictedArray,
          ) &&
          deprecatedField == other.deprecatedField &&
          deprecatedRef == other.deprecatedRef &&
          defaultString == other.defaultString &&
          defaultBackslash == other.defaultBackslash &&
          const DeepCollectionEquality().equals(
            nestedArray,
            other.nestedArray,
          ) &&
          singleQuoteKey == other.singleQuoteKey &&
          mixedEnum == other.mixedEnum &&
          defaultInt == other.defaultInt &&
          defaultBool == other.defaultBool &&
          const DeepCollectionEquality().equals(
            defaultList,
            other.defaultList,
          ) &&
          defaultObject == other.defaultObject &&
          defaultNullableString == other.defaultNullableString &&
          mergedValue == other.mergedValue &&
          const DeepCollectionEquality().equals(tupleArray, other.tupleArray) &&
          const DeepCollectionEquality().equals(
            tupleObjectArray,
            other.tupleObjectArray,
          ) &&
          ipv6Value == other.ipv6Value &&
          hostnameValue == other.hostnameValue &&
          timeValue == other.timeValue &&
          uriReferenceValue == other.uriReferenceValue &&
          const DeepCollectionEquality().equals(
            additionalPropertiesObject,
            other.additionalPropertiesObject,
          ) &&
          strictObject == other.strictObject &&
          notObject == other.notObject &&
          anyOfValue == other.anyOfValue &&
          mergedAllOfObject == other.mergedAllOfObject &&
          complexMerged == other.complexMerged &&
          myEnumField == other.myEnumField &&
          const DeepCollectionEquality().equals(
            unionContainsArray,
            other.unionContainsArray,
          ) &&
          const DeepCollectionEquality().equals(
            objectContainsArray,
            other.objectContainsArray,
          ) &&
          const DeepCollectionEquality().equals(
            enumContainsArray,
            other.enumContainsArray,
          ) &&
          const DeepCollectionEquality().equals(
            booleanContainsArray,
            other.booleanContainsArray,
          ) &&
          const DeepCollectionEquality().equals(
            nullContainsArray,
            other.nullContainsArray,
          ) &&
          const DeepCollectionEquality().equals(
            anyContainsArray,
            other.anyContainsArray,
          ) &&
          const DeepCollectionEquality().equals(
            stringContainsArray,
            other.stringContainsArray,
          ) &&
          const DeepCollectionEquality().equals(
            numberContainsArray,
            other.numberContainsArray,
          ) &&
          dynamicProps == other.dynamicProps &&
          dateTimeField == other.dateTimeField &&
          dateField == other.dateField &&
          ipv4Field == other.ipv4Field &&
          uriField == other.uriField &&
          const DeepCollectionEquality().equals(
            defaultEmptyList,
            other.defaultEmptyList,
          ) &&
          const DeepCollectionEquality().equals(
            defaultEmptyObject,
            other.defaultEmptyObject,
          ) &&
          unionWithArrayOption == other.unionWithArrayOption &&
          impossibleField == other.impossibleField &&
          const DeepCollectionEquality().equals(
            tupleSameTypeArray,
            other.tupleSameTypeArray,
          ) &&
          const DeepCollectionEquality().equals(
            arrayWithAllOfItems,
            other.arrayWithAllOfItems,
          ) &&
          unionWithAllOfOption == other.unionWithAllOfOption &&
          deprecatedFieldWithMessage == other.deprecatedFieldWithMessage &&
          customNamedObject == other.customNamedObject &&
          customNamedUnion == other.customNamedUnion &&
          customNamedEnum == other.customNamedEnum &&
          coverageTrigger == other.coverageTrigger &&
          collidingEnumField == other.collidingEnumField &&
          collidingObjectField == other.collidingObjectField;

  @override
  int get hashCode => Object.hashAll([
    name,
    constValue,
    age,
    exclusiveAge,
    height,
    email,
    uuid,
    isAwesome,
    class_,
    reader,
    stack,
    validate_,
    result,
    address,
    const DeepCollectionEquality().hash(tags),
    const DeepCollectionEquality().hash(scores),
    unionValue,
    nullableUnionValue,
    requiredNullableUnionObject,
    nullableString,
    pet,
    restrictedObject,
    dependentObject,
    const DeepCollectionEquality().hash(primitiveArrayWithValidation),
    const DeepCollectionEquality().hash(restrictedArray),
    deprecatedField,
    deprecatedRef,
    defaultString,
    defaultBackslash,
    const DeepCollectionEquality().hash(nestedArray),
    singleQuoteKey,
    mixedEnum,
    defaultInt,
    defaultBool,
    const DeepCollectionEquality().hash(defaultList),
    defaultObject,
    defaultNullableString,
    mergedValue,
    const DeepCollectionEquality().hash(tupleArray),
    const DeepCollectionEquality().hash(tupleObjectArray),
    ipv6Value,
    hostnameValue,
    timeValue,
    uriReferenceValue,
    const DeepCollectionEquality().hash(additionalPropertiesObject),
    strictObject,
    notObject,
    anyOfValue,
    mergedAllOfObject,
    complexMerged,
    myEnumField,
    const DeepCollectionEquality().hash(unionContainsArray),
    const DeepCollectionEquality().hash(objectContainsArray),
    const DeepCollectionEquality().hash(enumContainsArray),
    const DeepCollectionEquality().hash(booleanContainsArray),
    const DeepCollectionEquality().hash(nullContainsArray),
    const DeepCollectionEquality().hash(anyContainsArray),
    const DeepCollectionEquality().hash(stringContainsArray),
    const DeepCollectionEquality().hash(numberContainsArray),
    dynamicProps,
    dateTimeField,
    dateField,
    ipv4Field,
    uriField,
    const DeepCollectionEquality().hash(defaultEmptyList),
    const DeepCollectionEquality().hash(defaultEmptyObject),
    unionWithArrayOption,
    impossibleField,
    const DeepCollectionEquality().hash(tupleSameTypeArray),
    const DeepCollectionEquality().hash(arrayWithAllOfItems),
    unionWithAllOfOption,
    deprecatedFieldWithMessage,
    customNamedObject,
    customNamedUnion,
    customNamedEnum,
    coverageTrigger,
    collidingEnumField,
    collidingObjectField,
  ]);

  @override
  String toString() =>
      'TestRoot(name: ${name}, constValue: ${constValue}, age: ${age}, exclusiveAge: ${exclusiveAge}, height: ${height}, email: ${email}, uuid: ${uuid}, isAwesome: ${isAwesome}, class_: ${class_}, reader: ${reader}, stack: ${stack}, validate_: ${validate_}, result: ${result}, address: ${address}, tags: ${tags}, scores: ${scores}, unionValue: ${unionValue}, nullableUnionValue: ${nullableUnionValue}, requiredNullableUnionObject: ${requiredNullableUnionObject}, nullableString: ${nullableString}, pet: ${pet}, restrictedObject: ${restrictedObject}, dependentObject: ${dependentObject}, primitiveArrayWithValidation: ${primitiveArrayWithValidation}, restrictedArray: ${restrictedArray}, deprecatedField: ${deprecatedField}, deprecatedRef: ${deprecatedRef}, defaultString: ${defaultString}, defaultBackslash: ${defaultBackslash}, nestedArray: ${nestedArray}, singleQuoteKey: ${singleQuoteKey}, mixedEnum: ${mixedEnum}, defaultInt: ${defaultInt}, defaultBool: ${defaultBool}, defaultList: ${defaultList}, defaultObject: ${defaultObject}, defaultNullableString: ${defaultNullableString}, mergedValue: ${mergedValue}, tupleArray: ${tupleArray}, tupleObjectArray: ${tupleObjectArray}, ipv6Value: ${ipv6Value}, hostnameValue: ${hostnameValue}, timeValue: ${timeValue}, uriReferenceValue: ${uriReferenceValue}, additionalPropertiesObject: ${additionalPropertiesObject}, strictObject: ${strictObject}, notObject: ${notObject}, anyOfValue: ${anyOfValue}, mergedAllOfObject: ${mergedAllOfObject}, complexMerged: ${complexMerged}, myEnumField: ${myEnumField}, unionContainsArray: ${unionContainsArray}, objectContainsArray: ${objectContainsArray}, enumContainsArray: ${enumContainsArray}, booleanContainsArray: ${booleanContainsArray}, nullContainsArray: ${nullContainsArray}, anyContainsArray: ${anyContainsArray}, stringContainsArray: ${stringContainsArray}, numberContainsArray: ${numberContainsArray}, dynamicProps: ${dynamicProps}, dateTimeField: ${dateTimeField}, dateField: ${dateField}, ipv4Field: ${ipv4Field}, uriField: ${uriField}, defaultEmptyList: ${defaultEmptyList}, defaultEmptyObject: ${defaultEmptyObject}, unionWithArrayOption: ${unionWithArrayOption}, impossibleField: ${impossibleField}, tupleSameTypeArray: ${tupleSameTypeArray}, arrayWithAllOfItems: ${arrayWithAllOfItems}, unionWithAllOfOption: ${unionWithAllOfOption}, deprecatedFieldWithMessage: ${deprecatedFieldWithMessage}, customNamedObject: ${customNamedObject}, customNamedUnion: ${customNamedUnion}, customNamedEnum: ${customNamedEnum}, coverageTrigger: ${coverageTrigger}, collidingEnumField: ${collidingEnumField}, collidingObjectField: ${collidingObjectField})';
}

enum TestRootConstValue {
  alwaysThisValue('always-this-value');

  final String value;
  const TestRootConstValue(this.value);
  static TestRootConstValue fromValue(String val) =>
      values.firstWhere((e) => e.value == val);
  static final descriptor = EnumDescriptor<TestRootConstValue>(
    values: values,
    fromValue: (val) => fromValue(val as String),
    toValue: (e) => (e as TestRootConstValue).value,
    base: const StringDescriptor(),
  );
}

final class Address implements JsonModel {
  final String city;
  final String? street;

  const Address({required this.city, this.street});

  factory Address.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as Address;

  /// Creates an instance of [Address] from a JSON Map.
  factory Address.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      Address.fromJson(JsonReader.fromObject(map), validate: validate);

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

  Address copyWith({String? city, String? street}) =>
      Address(city: city ?? this.city, street: street ?? this.street);

  void validate() {
    if (city.length < 3) {
      throw JsonValidationException('Property "city" length must be >= 3', [
        'city',
      ]);
    }
    final val_street = street;
  }

  static final descriptor = ObjectDescriptor<Address>(
    title: 'Address',
    matches: (instance) => instance is Address,
    instantiate: (fields) => Address(
      city: fields['city'] as String,
      street: fields['street'] as String?,
    ),
    getFields: (instance) {
      final typedInstance = instance as Address;
      return {'city': typedInstance.city, 'street': typedInstance.street};
    },
    properties: {
      'city': PropertyDescriptor(
        name: 'city',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
      'street': PropertyDescriptor(
        name: 'street',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
    },
    required: const ['city'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          runtimeType == other.runtimeType &&
          city == other.city &&
          street == other.street;

  @override
  int get hashCode => Object.hashAll([city, street]);

  @override
  String toString() => 'Address(city: ${city}, street: ${street})';
}

final class Score implements JsonModel {
  final num value;

  const Score({required this.value});

  factory Score.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as Score;

  /// Creates an instance of [Score] from a JSON Map.
  factory Score.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      Score.fromJson(JsonReader.fromObject(map), validate: validate);

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

  Score copyWith({num? value}) => Score(value: value ?? this.value);

  void validate() {
    if (value < 0.0) {
      throw JsonValidationException('Property "value" must be >= 0.0', [
        'value',
      ]);
    }
  }

  static final descriptor = ObjectDescriptor<Score>(
    title: 'Score',
    matches: (instance) => instance is Score,
    instantiate: (fields) => Score(value: fields['value'] as num),
    getFields: (instance) {
      final typedInstance = instance as Score;
      return {'value': typedInstance.value};
    },
    properties: {
      'value': PropertyDescriptor(
        name: 'value',
        isRequired: true,
        schema: const NumDescriptor(),
      ),
    },
    required: const ['value'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Score &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => Object.hashAll([value]);

  @override
  String toString() => 'Score(value: ${value})';
}

sealed class TestRootUnionValue implements JsonModel {
  const TestRootUnionValue();

  factory TestRootUnionValue.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootUnionValue;

  /// Creates an instance of [TestRootUnionValue] from a JSON-compatible Dart value.
  factory TestRootUnionValue.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => TestRootUnionValue.fromJson(
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

  static final descriptor = UnionDescriptor<TestRootUnionValue>(
    title: 'TestRootUnionValue',

    activeOptions: [
      UnionOptionDescriptor<TestRootUnionValue, String>(
        const StringDescriptor(),
        (val) => TestRootUnionValueOption0(val as String),
      ),
      UnionOptionDescriptor<TestRootUnionValue, Address>(
        Address.descriptor,
        (val) => TestRootUnionValueOption1(val as Address),
      ),
    ],
  );
}

final class TestRootUnionValueOption0 extends TestRootUnionValue {
  final String value;
  const TestRootUnionValueOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const StringDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootUnionValueOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'TestRootUnionValueOption0(value: $value)';
}

final class TestRootUnionValueOption1 extends TestRootUnionValue {
  final Address value;
  const TestRootUnionValueOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, Address.descriptor);
  }

  @override
  void validate() {
    value.validate();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootUnionValueOption1 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'TestRootUnionValueOption1(value: $value)';
}

sealed class TestRootNullableUnionValue implements JsonModel {
  const TestRootNullableUnionValue();

  factory TestRootNullableUnionValue.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootNullableUnionValue;

  /// Creates an instance of [TestRootNullableUnionValue] from a JSON-compatible Dart value.
  factory TestRootNullableUnionValue.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => TestRootNullableUnionValue.fromJson(
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

  static final descriptor = UnionDescriptor<TestRootNullableUnionValue>(
    title: 'TestRootNullableUnionValue',

    activeOptions: [
      UnionOptionDescriptor<TestRootNullableUnionValue, String>(
        const StringDescriptor(),
        (val) => TestRootNullableUnionValueOption0(val as String),
      ),
      UnionOptionDescriptor<TestRootNullableUnionValue, Address>(
        Address.descriptor,
        (val) => TestRootNullableUnionValueOption1(val as Address),
      ),
    ],
  );
}

final class TestRootNullableUnionValueOption0
    extends TestRootNullableUnionValue {
  final String value;
  const TestRootNullableUnionValueOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const StringDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootNullableUnionValueOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'TestRootNullableUnionValueOption0(value: $value)';
}

final class TestRootNullableUnionValueOption1
    extends TestRootNullableUnionValue {
  final Address value;
  const TestRootNullableUnionValueOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, Address.descriptor);
  }

  @override
  void validate() {
    value.validate();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootNullableUnionValueOption1 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'TestRootNullableUnionValueOption1(value: $value)';
}

final class RequiredNullableUnionObject implements JsonModel {
  final RequiredNullableUnionObjectNullableUnion? nullableUnion;

  const RequiredNullableUnionObject({required this.nullableUnion});

  factory RequiredNullableUnionObject.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as RequiredNullableUnionObject;

  /// Creates an instance of [RequiredNullableUnionObject] from a JSON Map.
  factory RequiredNullableUnionObject.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => RequiredNullableUnionObject.fromJson(
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

  RequiredNullableUnionObject copyWith({
    RequiredNullableUnionObjectNullableUnion? nullableUnion,
  }) => RequiredNullableUnionObject(
    nullableUnion: nullableUnion ?? this.nullableUnion,
  );

  void validate() {
    final val_nullableUnion = nullableUnion;
    if (val_nullableUnion != null) {
      try {
        val_nullableUnion.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['nullableUnion', ...e.path]);
      }
    }
  }

  static final descriptor = ObjectDescriptor<RequiredNullableUnionObject>(
    title: 'RequiredNullableUnionObject',
    matches: (instance) => instance is RequiredNullableUnionObject,
    instantiate: (fields) => RequiredNullableUnionObject(
      nullableUnion:
          fields['nullableUnion'] as RequiredNullableUnionObjectNullableUnion?,
    ),
    getFields: (instance) {
      final typedInstance = instance as RequiredNullableUnionObject;
      return {'nullableUnion': typedInstance.nullableUnion};
    },
    properties: {
      'nullableUnion': PropertyDescriptor(
        name: 'nullableUnion',
        isRequired: true,
        schema: NullableDescriptor(
          RequiredNullableUnionObjectNullableUnion.descriptor,
        ),
      ),
    },
    required: const ['nullableUnion'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequiredNullableUnionObject &&
          runtimeType == other.runtimeType &&
          nullableUnion == other.nullableUnion;

  @override
  int get hashCode => Object.hashAll([nullableUnion]);

  @override
  String toString() =>
      'RequiredNullableUnionObject(nullableUnion: ${nullableUnion})';
}

sealed class RequiredNullableUnionObjectNullableUnion implements JsonModel {
  const RequiredNullableUnionObjectNullableUnion();

  factory RequiredNullableUnionObjectNullableUnion.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as RequiredNullableUnionObjectNullableUnion;

  /// Creates an instance of [RequiredNullableUnionObjectNullableUnion] from a JSON-compatible Dart value.
  factory RequiredNullableUnionObjectNullableUnion.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => RequiredNullableUnionObjectNullableUnion.fromJson(
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

  static final descriptor =
      UnionDescriptor<RequiredNullableUnionObjectNullableUnion>(
        title: 'RequiredNullableUnionObjectNullableUnion',

        activeOptions: [
          UnionOptionDescriptor<
            RequiredNullableUnionObjectNullableUnion,
            String
          >(
            const StringDescriptor(),
            (val) =>
                RequiredNullableUnionObjectNullableUnionOption0(val as String),
          ),
          UnionOptionDescriptor<RequiredNullableUnionObjectNullableUnion, int>(
            const IntDescriptor(),
            (val) =>
                RequiredNullableUnionObjectNullableUnionOption1(val as int),
          ),
        ],
      );
}

final class RequiredNullableUnionObjectNullableUnionOption0
    extends RequiredNullableUnionObjectNullableUnion {
  final String value;
  const RequiredNullableUnionObjectNullableUnionOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const StringDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequiredNullableUnionObjectNullableUnionOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      'RequiredNullableUnionObjectNullableUnionOption0(value: $value)';
}

final class RequiredNullableUnionObjectNullableUnionOption1
    extends RequiredNullableUnionObjectNullableUnion {
  final int value;
  const RequiredNullableUnionObjectNullableUnionOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const IntDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequiredNullableUnionObjectNullableUnionOption1 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      'RequiredNullableUnionObjectNullableUnionOption1(value: $value)';
}

sealed class Pet implements JsonModel {
  const Pet();

  factory Pet.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as Pet;

  /// Creates an instance of [Pet] from a JSON-compatible Dart value.
  factory Pet.fromJsonValue(Object? value, {bool validate = true}) =>
      Pet.fromJson(JsonReader.fromObject(value), validate: validate);

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

  static final descriptor = UnionDescriptor<Pet>(
    title: 'Pet',
    discriminatorProperty: 'kind',
    discriminatorMapping: {
      'cat_type': UnionOptionDescriptor<Pet, Cat>(
        Cat.descriptor,
        (val) => PetOption0(val as Cat),
      ),
      'Cat': UnionOptionDescriptor<Pet, Cat>(
        Cat.descriptor,
        (val) => PetOption0(val as Cat),
      ),
      'PetOption0': UnionOptionDescriptor<Pet, Cat>(
        Cat.descriptor,
        (val) => PetOption0(val as Cat),
      ),
      'dog_type': UnionOptionDescriptor<Pet, Dog>(
        Dog.descriptor,
        (val) => PetOption1(val as Dog),
      ),
      'Dog': UnionOptionDescriptor<Pet, Dog>(
        Dog.descriptor,
        (val) => PetOption1(val as Dog),
      ),
      'PetOption1': UnionOptionDescriptor<Pet, Dog>(
        Dog.descriptor,
        (val) => PetOption1(val as Dog),
      ),
    },
    activeOptions: [
      UnionOptionDescriptor<Pet, Cat>(
        Cat.descriptor,
        (val) => PetOption0(val as Cat),
      ),
      UnionOptionDescriptor<Pet, Dog>(
        Dog.descriptor,
        (val) => PetOption1(val as Dog),
      ),
    ],
  );
}

final class PetOption0 extends Pet {
  final Cat value;
  const PetOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, Cat.descriptor);
  }

  @override
  void validate() {
    value.validate();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'PetOption0(value: $value)';
}

final class PetOption1 extends Pet {
  final Dog value;
  const PetOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, Dog.descriptor);
  }

  @override
  void validate() {
    value.validate();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetOption1 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'PetOption1(value: $value)';
}

final class Cat implements JsonModel {
  final String kind;
  final num? meowVolume;

  const Cat({required this.kind, this.meowVolume});

  factory Cat.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as Cat;

  /// Creates an instance of [Cat] from a JSON Map.
  factory Cat.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      Cat.fromJson(JsonReader.fromObject(map), validate: validate);

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

  Cat copyWith({String? kind, num? meowVolume}) =>
      Cat(kind: kind ?? this.kind, meowVolume: meowVolume ?? this.meowVolume);

  void validate() {
    final val_meowVolume = meowVolume;
  }

  static final descriptor = ObjectDescriptor<Cat>(
    title: 'Cat',
    matches: (instance) => instance is Cat,
    instantiate: (fields) => Cat(
      kind: fields['kind'] as String,
      meowVolume: fields['meowVolume'] as num?,
    ),
    getFields: (instance) {
      final typedInstance = instance as Cat;
      return {
        'kind': typedInstance.kind,
        'meowVolume': typedInstance.meowVolume,
      };
    },
    properties: {
      'kind': PropertyDescriptor(
        name: 'kind',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
      'meowVolume': PropertyDescriptor(
        name: 'meowVolume',
        isRequired: false,
        schema: const NumDescriptor(),
      ),
    },
    required: const ['kind'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cat &&
          runtimeType == other.runtimeType &&
          kind == other.kind &&
          meowVolume == other.meowVolume;

  @override
  int get hashCode => Object.hashAll([kind, meowVolume]);

  @override
  String toString() => 'Cat(kind: ${kind}, meowVolume: ${meowVolume})';
}

final class Dog implements JsonModel {
  final String kind;
  final num? barkVolume;

  const Dog({required this.kind, this.barkVolume});

  factory Dog.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as Dog;

  /// Creates an instance of [Dog] from a JSON Map.
  factory Dog.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      Dog.fromJson(JsonReader.fromObject(map), validate: validate);

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

  Dog copyWith({String? kind, num? barkVolume}) =>
      Dog(kind: kind ?? this.kind, barkVolume: barkVolume ?? this.barkVolume);

  void validate() {
    final val_barkVolume = barkVolume;
  }

  static final descriptor = ObjectDescriptor<Dog>(
    title: 'Dog',
    matches: (instance) => instance is Dog,
    instantiate: (fields) => Dog(
      kind: fields['kind'] as String,
      barkVolume: fields['barkVolume'] as num?,
    ),
    getFields: (instance) {
      final typedInstance = instance as Dog;
      return {
        'kind': typedInstance.kind,
        'barkVolume': typedInstance.barkVolume,
      };
    },
    properties: {
      'kind': PropertyDescriptor(
        name: 'kind',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
      'barkVolume': PropertyDescriptor(
        name: 'barkVolume',
        isRequired: false,
        schema: const NumDescriptor(),
      ),
    },
    required: const ['kind'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dog &&
          runtimeType == other.runtimeType &&
          kind == other.kind &&
          barkVolume == other.barkVolume;

  @override
  int get hashCode => Object.hashAll([kind, barkVolume]);

  @override
  String toString() => 'Dog(kind: ${kind}, barkVolume: ${barkVolume})';
}

final class RestrictedObject implements JsonModel {
  final String? a;
  final String? b;
  final String? c;

  const RestrictedObject({this.a, this.b, this.c});

  factory RestrictedObject.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as RestrictedObject;

  /// Creates an instance of [RestrictedObject] from a JSON Map.
  factory RestrictedObject.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) =>
      RestrictedObject.fromJson(JsonReader.fromObject(map), validate: validate);

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

  RestrictedObject copyWith({String? a, String? b, String? c}) =>
      RestrictedObject(a: a ?? this.a, b: b ?? this.b, c: c ?? this.c);

  void validate() {
    var count = 0;
    if (a != null) count++;
    if (b != null) count++;
    if (c != null) count++;
    if (count < 1) {
      throw JsonValidationException('Object must have >= 1 properties', []);
    }
    if (count > 2) {
      throw JsonValidationException('Object must have <= 2 properties', []);
    }
    final val_a = a;
    final val_b = b;
    final val_c = c;
  }

  static final descriptor = ObjectDescriptor<RestrictedObject>(
    title: 'RestrictedObject',
    matches: (instance) => instance is RestrictedObject,
    instantiate: (fields) => RestrictedObject(
      a: fields['a'] as String?,
      b: fields['b'] as String?,
      c: fields['c'] as String?,
    ),
    getFields: (instance) {
      final typedInstance = instance as RestrictedObject;
      return {'a': typedInstance.a, 'b': typedInstance.b, 'c': typedInstance.c};
    },
    properties: {
      'a': PropertyDescriptor(
        name: 'a',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'b': PropertyDescriptor(
        name: 'b',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'c': PropertyDescriptor(
        name: 'c',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
    },
    required: const [],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestrictedObject &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b &&
          c == other.c;

  @override
  int get hashCode => Object.hashAll([a, b, c]);

  @override
  String toString() => 'RestrictedObject(a: ${a}, b: ${b}, c: ${c})';
}

final class DependentObject implements JsonModel {
  final num? creditCard;
  final String? billingAddress;

  const DependentObject({this.creditCard, this.billingAddress});

  factory DependentObject.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as DependentObject;

  /// Creates an instance of [DependentObject] from a JSON Map.
  factory DependentObject.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) =>
      DependentObject.fromJson(JsonReader.fromObject(map), validate: validate);

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

  DependentObject copyWith({num? creditCard, String? billingAddress}) =>
      DependentObject(
        creditCard: creditCard ?? this.creditCard,
        billingAddress: billingAddress ?? this.billingAddress,
      );

  void validate() {
    if (creditCard != null) {
      if (billingAddress == null) {
        throw JsonValidationException(
          'Property "billingAddress" is required because "creditCard" is present',
          ['billingAddress'],
        );
      }
    }
    final val_creditCard = creditCard;
    final val_billingAddress = billingAddress;
  }

  static final descriptor = ObjectDescriptor<DependentObject>(
    title: 'DependentObject',
    matches: (instance) => instance is DependentObject,
    instantiate: (fields) => DependentObject(
      creditCard: fields['creditCard'] as num?,
      billingAddress: fields['billingAddress'] as String?,
    ),
    getFields: (instance) {
      final typedInstance = instance as DependentObject;
      return {
        'creditCard': typedInstance.creditCard,
        'billingAddress': typedInstance.billingAddress,
      };
    },
    properties: {
      'creditCard': PropertyDescriptor(
        name: 'creditCard',
        isRequired: false,
        schema: const NumDescriptor(),
      ),
      'billingAddress': PropertyDescriptor(
        name: 'billingAddress',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
    },
    required: const [],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DependentObject &&
          runtimeType == other.runtimeType &&
          creditCard == other.creditCard &&
          billingAddress == other.billingAddress;

  @override
  int get hashCode => Object.hashAll([creditCard, billingAddress]);

  @override
  String toString() =>
      'DependentObject(creditCard: ${creditCard}, billingAddress: ${billingAddress})';
}

@deprecated
final class DeprecatedObject implements JsonModel {
  final String? value;

  const DeprecatedObject({this.value});

  factory DeprecatedObject.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as DeprecatedObject;

  /// Creates an instance of [DeprecatedObject] from a JSON Map.
  factory DeprecatedObject.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) =>
      DeprecatedObject.fromJson(JsonReader.fromObject(map), validate: validate);

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

  DeprecatedObject copyWith({String? value}) =>
      DeprecatedObject(value: value ?? this.value);

  void validate() {
    final val_value = value;
  }

  static final descriptor = ObjectDescriptor<DeprecatedObject>(
    title: 'DeprecatedObject',
    matches: (instance) => instance is DeprecatedObject,
    instantiate: (fields) =>
        DeprecatedObject(value: fields['value'] as String?),
    getFields: (instance) {
      final typedInstance = instance as DeprecatedObject;
      return {'value': typedInstance.value};
    },
    properties: {
      'value': PropertyDescriptor(
        name: 'value',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
    },
    required: const [],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeprecatedObject &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => Object.hashAll([value]);

  @override
  String toString() => 'DeprecatedObject(value: ${value})';
}

enum TestRootMixedEnum {
  foo('foo'),
  value42(42),
  bar('bar'),
  value100(100);

  final dynamic value;
  const TestRootMixedEnum(this.value);
  static TestRootMixedEnum fromValue(dynamic val) =>
      values.firstWhere((e) => e.value == val);
  static final descriptor = EnumDescriptor<TestRootMixedEnum>(
    values: values,
    fromValue: (val) => fromValue(val as dynamic),
    toValue: (e) => (e as TestRootMixedEnum).value,
    base: const AnythingDescriptor(),
  );
}

sealed class TestRootMixedEnumBase implements JsonModel {
  const TestRootMixedEnumBase();

  factory TestRootMixedEnumBase.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootMixedEnumBase;

  /// Creates an instance of [TestRootMixedEnumBase] from a JSON-compatible Dart value.
  factory TestRootMixedEnumBase.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => TestRootMixedEnumBase.fromJson(
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

  static final descriptor = UnionDescriptor<TestRootMixedEnumBase>(
    title: 'TestRootMixedEnumBase',

    activeOptions: [
      UnionOptionDescriptor<TestRootMixedEnumBase, String>(
        const StringDescriptor(),
        (val) => TestRootMixedEnumBaseOption0(val as String),
      ),
      UnionOptionDescriptor<TestRootMixedEnumBase, int>(
        const IntDescriptor(),
        (val) => TestRootMixedEnumBaseOption1(val as int),
      ),
    ],
  );
}

final class TestRootMixedEnumBaseOption0 extends TestRootMixedEnumBase {
  final String value;
  const TestRootMixedEnumBaseOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const StringDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootMixedEnumBaseOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'TestRootMixedEnumBaseOption0(value: $value)';
}

final class TestRootMixedEnumBaseOption1 extends TestRootMixedEnumBase {
  final int value;
  const TestRootMixedEnumBaseOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const IntDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootMixedEnumBaseOption1 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'TestRootMixedEnumBaseOption1(value: $value)';
}

final class Merged implements JsonModel {
  final String? a;
  final int? b;
  final bool? c;

  const Merged({this.a, this.b, this.c});

  factory Merged.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as Merged;

  /// Creates an instance of [Merged] from a JSON Map.
  factory Merged.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      Merged.fromJson(JsonReader.fromObject(map), validate: validate);

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

  Merged copyWith({String? a, int? b, bool? c}) =>
      Merged(a: a ?? this.a, b: b ?? this.b, c: c ?? this.c);

  void validate() {
    final val_a = a;
    final val_b = b;
    final val_c = c;
  }

  static final descriptor = ObjectDescriptor<Merged>(
    title: 'Merged',
    matches: (instance) => instance is Merged,
    instantiate: (fields) => Merged(
      a: fields['a'] as String?,
      b: fields['b'] as int?,
      c: fields['c'] as bool?,
    ),
    getFields: (instance) {
      final typedInstance = instance as Merged;
      return {'a': typedInstance.a, 'b': typedInstance.b, 'c': typedInstance.c};
    },
    properties: {
      'a': PropertyDescriptor(
        name: 'a',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'b': PropertyDescriptor(
        name: 'b',
        isRequired: false,
        schema: const IntDescriptor(),
      ),
      'c': PropertyDescriptor(
        name: 'c',
        isRequired: false,
        schema: const BoolDescriptor(),
      ),
    },
    required: const [],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Merged &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b &&
          c == other.c;

  @override
  int get hashCode => Object.hashAll([a, b, c]);

  @override
  String toString() => 'Merged(a: ${a}, b: ${b}, c: ${c})';
}

final class MapObject implements JsonModel {
  final String? name;
  final Map<String, String> additionalProperties;

  const MapObject({this.name, this.additionalProperties = const {}});

  factory MapObject.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as MapObject;

  /// Creates an instance of [MapObject] from a JSON Map.
  factory MapObject.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      MapObject.fromJson(JsonReader.fromObject(map), validate: validate);

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

  MapObject copyWith({
    String? name,
    Map<String, String>? additionalProperties,
  }) => MapObject(
    name: name ?? this.name,
    additionalProperties: additionalProperties ?? this.additionalProperties,
  );

  void validate() {
    final val_name = name;
  }

  static final descriptor = ObjectDescriptor<MapObject>(
    title: 'MapObject',
    matches: (instance) => instance is MapObject,
    instantiate: (fields) => MapObject(
      name: fields['name'] as String?,
      additionalProperties: fields.entries
          .where((e) => !const <String>{'name'}.contains(e.key))
          .fold<Map<String, String>>(
            {},
            (m, e) => m..[e.key] = e.value as String,
          ),
    ),
    getFields: (instance) {
      final typedInstance = instance as MapObject;
      return {
        'name': typedInstance.name,
        ...typedInstance.additionalProperties,
      };
    },
    properties: {
      'name': PropertyDescriptor(
        name: 'name',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
    },
    required: const [],
    additionalProperties: const StringDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapObject &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    name,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'MapObject(name: ${name}, additionalProperties: ${additionalProperties})';
}

final class StrictObject implements JsonModel {
  final String? name;

  const StrictObject({this.name});

  factory StrictObject.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as StrictObject;

  /// Creates an instance of [StrictObject] from a JSON Map.
  factory StrictObject.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => StrictObject.fromJson(JsonReader.fromObject(map), validate: validate);

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

  StrictObject copyWith({String? name}) =>
      StrictObject(name: name ?? this.name);

  void validate() {
    final val_name = name;
  }

  static final descriptor = ObjectDescriptor<StrictObject>(
    title: 'StrictObject',
    matches: (instance) => instance is StrictObject,
    instantiate: (fields) => StrictObject(name: fields['name'] as String?),
    getFields: (instance) {
      final typedInstance = instance as StrictObject;
      return {'name': typedInstance.name};
    },
    properties: {
      'name': PropertyDescriptor(
        name: 'name',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
    },
    required: const [],
    additionalProperties: const NeverDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StrictObject &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => Object.hashAll([name]);

  @override
  String toString() => 'StrictObject(name: ${name})';
}

final class NotObject implements JsonModel {
  final String notPatternString;
  final int notEnumInt;
  final Object? notNullValue;

  const NotObject({
    required this.notPatternString,
    required this.notEnumInt,
    required this.notNullValue,
  });

  factory NotObject.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as NotObject;

  /// Creates an instance of [NotObject] from a JSON Map.
  factory NotObject.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      NotObject.fromJson(JsonReader.fromObject(map), validate: validate);

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

  NotObject copyWith({
    String? notPatternString,
    int? notEnumInt,
    Object? notNullValue,
  }) => NotObject(
    notPatternString: notPatternString ?? this.notPatternString,
    notEnumInt: notEnumInt ?? this.notEnumInt,
    notNullValue: notNullValue ?? this.notNullValue,
  );

  void validate() {
    bool notMatches_notPatternString = true;
    try {
      if (notPatternString is! String) {
        throw JsonValidationException(
          'Property "notPatternString" must be a string',
          ['notPatternString'],
        );
      }
      if (!RegExp('forbidden').hasMatch(notPatternString)) {
        throw JsonValidationException(
          'Property "notPatternString" must match pattern "forbidden"',
          ['notPatternString'],
        );
      }
    } on JsonValidationException {
      notMatches_notPatternString = false;
    }
    if (notMatches_notPatternString) {
      throw JsonValidationException(
        'Property "notPatternString" must not match the schema',
        ['notPatternString'],
      );
    }
    bool notMatches_notEnumInt = true;
    try {
      if (!const [
        13,
        17,
      ].any((v) => const DeepCollectionEquality().equals(v, notEnumInt))) {
        throw JsonValidationException(
          'Property "notEnumInt" must be one of [13, 17]',
          ['notEnumInt'],
        );
      }
    } on JsonValidationException {
      notMatches_notEnumInt = false;
    }
    if (notMatches_notEnumInt) {
      throw JsonValidationException(
        'Property "notEnumInt" must not match the schema',
        ['notEnumInt'],
      );
    }
    final val_notNullValue = notNullValue;
    bool notMatches_notNullValue = true;
    try {
      if (val_notNullValue != null) {
        throw JsonValidationException('Property "notNullValue" must be null', [
          'notNullValue',
        ]);
      }
    } on JsonValidationException {
      notMatches_notNullValue = false;
    }
    if (notMatches_notNullValue) {
      throw JsonValidationException(
        'Property "notNullValue" must not match the schema',
        ['notNullValue'],
      );
    }
  }

  static final descriptor = ObjectDescriptor<NotObject>(
    title: 'NotObject',
    matches: (instance) => instance is NotObject,
    instantiate: (fields) => NotObject(
      notPatternString: fields['notPatternString'] as String,
      notEnumInt: fields['notEnumInt'] as int,
      notNullValue: fields['notNullValue'] as Object?,
    ),
    getFields: (instance) {
      final typedInstance = instance as NotObject;
      return {
        'notPatternString': typedInstance.notPatternString,
        'notEnumInt': typedInstance.notEnumInt,
        'notNullValue': typedInstance.notNullValue,
      };
    },
    properties: {
      'notPatternString': PropertyDescriptor(
        name: 'notPatternString',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
      'notEnumInt': PropertyDescriptor(
        name: 'notEnumInt',
        isRequired: true,
        schema: const IntDescriptor(),
      ),
      'notNullValue': PropertyDescriptor(
        name: 'notNullValue',
        isRequired: true,
        schema: const AnythingDescriptor(),
      ),
    },
    required: const ['notPatternString', 'notEnumInt', 'notNullValue'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotObject &&
          runtimeType == other.runtimeType &&
          notPatternString == other.notPatternString &&
          notEnumInt == other.notEnumInt &&
          const DeepCollectionEquality().equals(
            notNullValue,
            other.notNullValue,
          );

  @override
  int get hashCode => Object.hashAll([
    notPatternString,
    notEnumInt,
    const DeepCollectionEquality().hash(notNullValue),
  ]);

  @override
  String toString() =>
      'NotObject(notPatternString: ${notPatternString}, notEnumInt: ${notEnumInt}, notNullValue: ${notNullValue})';
}

sealed class TestRootAnyOfValue implements JsonModel {
  const TestRootAnyOfValue();

  factory TestRootAnyOfValue.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootAnyOfValue;

  /// Creates an instance of [TestRootAnyOfValue] from a JSON-compatible Dart value.
  factory TestRootAnyOfValue.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => TestRootAnyOfValue.fromJson(
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

  static final descriptor = UnionDescriptor<TestRootAnyOfValue>(
    title: 'TestRootAnyOfValue',

    activeOptions: [
      UnionOptionDescriptor<TestRootAnyOfValue, String>(
        const StringDescriptor(),
        (val) => TestRootAnyOfValueOption0(val as String),
      ),
      UnionOptionDescriptor<TestRootAnyOfValue, int>(
        const IntDescriptor(),
        (val) => TestRootAnyOfValueOption1(val as int),
      ),
    ],
  );
}

final class TestRootAnyOfValueOption0 extends TestRootAnyOfValue {
  final String value;
  const TestRootAnyOfValueOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const StringDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootAnyOfValueOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'TestRootAnyOfValueOption0(value: $value)';
}

final class TestRootAnyOfValueOption1 extends TestRootAnyOfValue {
  final int value;
  const TestRootAnyOfValueOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const IntDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootAnyOfValueOption1 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'TestRootAnyOfValueOption1(value: $value)';
}

final class MergedAllOfObject implements JsonModel {
  final String? strVal;
  final num? numVal;

  const MergedAllOfObject({this.strVal, this.numVal});

  factory MergedAllOfObject.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as MergedAllOfObject;

  /// Creates an instance of [MergedAllOfObject] from a JSON Map.
  factory MergedAllOfObject.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => MergedAllOfObject.fromJson(
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

  MergedAllOfObject copyWith({String? strVal, num? numVal}) =>
      MergedAllOfObject(
        strVal: strVal ?? this.strVal,
        numVal: numVal ?? this.numVal,
      );

  void validate() {
    if (strVal != null) {
      if (numVal == null) {
        throw JsonValidationException(
          'Property "numVal" is required because "strVal" is present',
          ['numVal'],
        );
      }
    }
    final val_strVal = strVal;
    if (val_strVal != null) {
      if (val_strVal.length < 5) {
        throw JsonValidationException('Property "strVal" length must be >= 5', [
          'strVal',
        ]);
      }
      if (val_strVal.length > 8) {
        throw JsonValidationException('Property "strVal" length must be <= 8', [
          'strVal',
        ]);
      }
      if (!RegExp('^a').hasMatch(val_strVal)) {
        throw JsonValidationException(
          'Property "strVal" must match pattern "^a"',
          ['strVal'],
        );
      }
      if (!RegExp(r'^[^@]+@[^@]+$').hasMatch(val_strVal)) {
        throw JsonValidationException(
          'Property "strVal" must be a valid email address',
          ['strVal'],
        );
      }
    }
    final val_numVal = numVal;
    if (val_numVal != null) {
      if (val_numVal < 10) {
        throw JsonValidationException('Property "numVal" must be >= 10', [
          'numVal',
        ]);
      }
      if (val_numVal > 50) {
        throw JsonValidationException('Property "numVal" must be <= 50', [
          'numVal',
        ]);
      }
      if ((val_numVal / 5 - (val_numVal / 5).round()).abs() > 1e-9) {
        throw JsonValidationException(
          'Property "numVal" must be a multiple of 5',
          ['numVal'],
        );
      }
    }
  }

  static final descriptor = ObjectDescriptor<MergedAllOfObject>(
    title: 'MergedAllOfObject',
    matches: (instance) => instance is MergedAllOfObject,
    instantiate: (fields) => MergedAllOfObject(
      strVal: fields['strVal'] as String?,
      numVal: fields['numVal'] as num?,
    ),
    getFields: (instance) {
      final typedInstance = instance as MergedAllOfObject;
      return {'strVal': typedInstance.strVal, 'numVal': typedInstance.numVal};
    },
    properties: {
      'strVal': PropertyDescriptor(
        name: 'strVal',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'numVal': PropertyDescriptor(
        name: 'numVal',
        isRequired: false,
        schema: const NumDescriptor(),
      ),
    },
    required: const [],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MergedAllOfObject &&
          runtimeType == other.runtimeType &&
          strVal == other.strVal &&
          numVal == other.numVal;

  @override
  int get hashCode => Object.hashAll([strVal, numVal]);

  @override
  String toString() =>
      'MergedAllOfObject(strVal: ${strVal}, numVal: ${numVal})';
}

final class ComplexMergedObject implements JsonModel {
  final num? numVal;
  final Map<String, String> additionalProperties;

  const ComplexMergedObject({
    this.numVal,
    this.additionalProperties = const {},
  });

  factory ComplexMergedObject.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as ComplexMergedObject;

  /// Creates an instance of [ComplexMergedObject] from a JSON Map.
  factory ComplexMergedObject.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => ComplexMergedObject.fromJson(
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

  ComplexMergedObject copyWith({
    num? numVal,
    Map<String, String>? additionalProperties,
  }) => ComplexMergedObject(
    numVal: numVal ?? this.numVal,
    additionalProperties: additionalProperties ?? this.additionalProperties,
  );

  void validate() {
    var count = 0;
    if (numVal != null) count++;
    count += additionalProperties.length;
    if (count < 2) {
      throw JsonValidationException('Object must have >= 2 properties', []);
    }
    if (count > 5) {
      throw JsonValidationException('Object must have <= 5 properties', []);
    }
    final val_numVal = numVal;
    if (val_numVal != null) {
      if (val_numVal <= 10.0) {
        throw JsonValidationException('Property "numVal" must be > 10.0', [
          'numVal',
        ]);
      }
      if (val_numVal >= 20.0) {
        throw JsonValidationException('Property "numVal" must be < 20.0', [
          'numVal',
        ]);
      }
    }
    additionalProperties.forEach((key, value) {
      if (value.length < 3) {
        throw JsonValidationException('Property "$key" length must be >= 3', [
          '$key',
        ]);
      }
    });
  }

  static final descriptor = ObjectDescriptor<ComplexMergedObject>(
    title: 'ComplexMergedObject',
    matches: (instance) => instance is ComplexMergedObject,
    instantiate: (fields) => ComplexMergedObject(
      numVal: fields['numVal'] as num?,
      additionalProperties: fields.entries
          .where((e) => !const <String>{'numVal'}.contains(e.key))
          .fold<Map<String, String>>(
            {},
            (m, e) => m..[e.key] = e.value as String,
          ),
    ),
    getFields: (instance) {
      final typedInstance = instance as ComplexMergedObject;
      return {
        'numVal': typedInstance.numVal,
        ...typedInstance.additionalProperties,
      };
    },
    properties: {
      'numVal': PropertyDescriptor(
        name: 'numVal',
        isRequired: false,
        schema: const NumDescriptor(),
      ),
    },
    required: const [],
    additionalProperties: const StringDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComplexMergedObject &&
          runtimeType == other.runtimeType &&
          numVal == other.numVal &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    numVal,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'ComplexMergedObject(numVal: ${numVal}, additionalProperties: ${additionalProperties})';
}

enum MyEnum {
  alpha('alpha'),
  beta('beta'),
  gamma('gamma');

  final String value;
  const MyEnum(this.value);
  static MyEnum fromValue(String val) =>
      values.firstWhere((e) => e.value == val);
  static final descriptor = EnumDescriptor<MyEnum>(
    values: values,
    fromValue: (val) => fromValue(val as String),
    toValue: (e) => (e as MyEnum).value,
    base: const StringDescriptor(),
  );
}

sealed class TestRootUnionContainsArrayContains implements JsonModel {
  const TestRootUnionContainsArrayContains();

  factory TestRootUnionContainsArrayContains.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootUnionContainsArrayContains;

  /// Creates an instance of [TestRootUnionContainsArrayContains] from a JSON-compatible Dart value.
  factory TestRootUnionContainsArrayContains.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => TestRootUnionContainsArrayContains.fromJson(
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

  static final descriptor = UnionDescriptor<TestRootUnionContainsArrayContains>(
    title: 'TestRootUnionContainsArrayContains',

    activeOptions: [
      UnionOptionDescriptor<TestRootUnionContainsArrayContains, String>(
        const StringDescriptor(),
        (val) => TestRootUnionContainsArrayContainsOption0(val as String),
      ),
      UnionOptionDescriptor<TestRootUnionContainsArrayContains, int>(
        const IntDescriptor(),
        (val) => TestRootUnionContainsArrayContainsOption1(val as int),
      ),
      UnionOptionDescriptor<TestRootUnionContainsArrayContains, num>(
        const NumDescriptor(),
        (val) => TestRootUnionContainsArrayContainsOption2(val as num),
      ),
    ],
  );
}

final class TestRootUnionContainsArrayContainsOption0
    extends TestRootUnionContainsArrayContains {
  final String value;
  const TestRootUnionContainsArrayContainsOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const StringDescriptor());
  }

  @override
  void validate() {
    if (value.length < 3) {
      throw JsonValidationException('Property "value" length must be >= 3', [
        'value',
      ]);
    }
    if (value.length > 10) {
      throw JsonValidationException('Property "value" length must be <= 10', [
        'value',
      ]);
    }
    if (!RegExp('^a').hasMatch(value)) {
      throw JsonValidationException(
        'Property "value" must match pattern "^a"',
        ['value'],
      );
    }
    if (!RegExp(r'^[^@]+@[^@]+$').hasMatch(value)) {
      throw JsonValidationException(
        'Property "value" must be a valid email address',
        ['value'],
      );
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootUnionContainsArrayContainsOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      'TestRootUnionContainsArrayContainsOption0(value: $value)';
}

final class TestRootUnionContainsArrayContainsOption1
    extends TestRootUnionContainsArrayContains {
  final int value;
  const TestRootUnionContainsArrayContainsOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const IntDescriptor());
  }

  @override
  void validate() {
    if (value < 5) {
      throw JsonValidationException('Property "value" must be >= 5', ['value']);
    }
    if (value > 10) {
      throw JsonValidationException('Property "value" must be <= 10', [
        'value',
      ]);
    }
    if (value % 2 != 0) {
      throw JsonValidationException(
        'Property "value" must be a multiple of 2',
        ['value'],
      );
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootUnionContainsArrayContainsOption1 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      'TestRootUnionContainsArrayContainsOption1(value: $value)';
}

final class TestRootUnionContainsArrayContainsOption2
    extends TestRootUnionContainsArrayContains {
  final num value;
  const TestRootUnionContainsArrayContainsOption2(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const NumDescriptor());
  }

  @override
  void validate() {
    if (value <= 5.0) {
      throw JsonValidationException('Property "value" must be > 5.0', [
        'value',
      ]);
    }
    if (value >= 11.0) {
      throw JsonValidationException('Property "value" must be < 11.0', [
        'value',
      ]);
    }
    if ((value / 0.5 - (value / 0.5).round()).abs() > 1e-9) {
      throw JsonValidationException(
        'Property "value" must be a multiple of 0.5',
        ['value'],
      );
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootUnionContainsArrayContainsOption2 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      'TestRootUnionContainsArrayContainsOption2(value: $value)';
}

final class ObjectWithDynamicProps implements JsonModel {
  final Object? notInt;
  final Object? notNum;

  const ObjectWithDynamicProps({this.notInt, this.notNum});

  factory ObjectWithDynamicProps.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as ObjectWithDynamicProps;

  /// Creates an instance of [ObjectWithDynamicProps] from a JSON Map.
  factory ObjectWithDynamicProps.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => ObjectWithDynamicProps.fromJson(
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

  ObjectWithDynamicProps copyWith({Object? notInt, Object? notNum}) =>
      ObjectWithDynamicProps(
        notInt: notInt ?? this.notInt,
        notNum: notNum ?? this.notNum,
      );

  void validate() {
    final val_notInt = notInt;
    bool notMatches_notInt = true;
    try {
      if (val_notInt is! int) {
        throw JsonValidationException('Property "notInt" must be an integer', [
          'notInt',
        ]);
      }
    } on JsonValidationException {
      notMatches_notInt = false;
    }
    if (notMatches_notInt) {
      throw JsonValidationException(
        'Property "notInt" must not match the schema',
        ['notInt'],
      );
    }
    final val_notNum = notNum;
    bool notMatches_notNum = true;
    try {
      if (val_notNum is! num) {
        throw JsonValidationException('Property "notNum" must be a number', [
          'notNum',
        ]);
      }
    } on JsonValidationException {
      notMatches_notNum = false;
    }
    if (notMatches_notNum) {
      throw JsonValidationException(
        'Property "notNum" must not match the schema',
        ['notNum'],
      );
    }
  }

  static final descriptor = ObjectDescriptor<ObjectWithDynamicProps>(
    title: 'ObjectWithDynamicProps',
    matches: (instance) => instance is ObjectWithDynamicProps,
    instantiate: (fields) => ObjectWithDynamicProps(
      notInt: fields['notInt'] as Object?,
      notNum: fields['notNum'] as Object?,
    ),
    getFields: (instance) {
      final typedInstance = instance as ObjectWithDynamicProps;
      return {'notInt': typedInstance.notInt, 'notNum': typedInstance.notNum};
    },
    properties: {
      'notInt': PropertyDescriptor(
        name: 'notInt',
        isRequired: false,
        schema: const AnythingDescriptor(),
      ),
      'notNum': PropertyDescriptor(
        name: 'notNum',
        isRequired: false,
        schema: const AnythingDescriptor(),
      ),
    },
    required: const [],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObjectWithDynamicProps &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(notInt, other.notInt) &&
          const DeepCollectionEquality().equals(notNum, other.notNum);

  @override
  int get hashCode => Object.hashAll([
    const DeepCollectionEquality().hash(notInt),
    const DeepCollectionEquality().hash(notNum),
  ]);

  @override
  String toString() =>
      'ObjectWithDynamicProps(notInt: ${notInt}, notNum: ${notNum})';
}

sealed class TestRootUnionWithArrayOption implements JsonModel {
  const TestRootUnionWithArrayOption();

  factory TestRootUnionWithArrayOption.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootUnionWithArrayOption;

  /// Creates an instance of [TestRootUnionWithArrayOption] from a JSON-compatible Dart value.
  factory TestRootUnionWithArrayOption.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => TestRootUnionWithArrayOption.fromJson(
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

  static final descriptor = UnionDescriptor<TestRootUnionWithArrayOption>(
    title: 'TestRootUnionWithArrayOption',

    activeOptions: [
      UnionOptionDescriptor<TestRootUnionWithArrayOption, String>(
        const StringDescriptor(),
        (val) => TestRootUnionWithArrayOptionOption0(val as String),
      ),
      UnionOptionDescriptor<TestRootUnionWithArrayOption, List<Address>>(
        ArrayDescriptor<Address>(Address.descriptor),
        (val) => TestRootUnionWithArrayOptionOption1(val as List<Address>),
      ),
    ],
  );
}

final class TestRootUnionWithArrayOptionOption0
    extends TestRootUnionWithArrayOption {
  final String value;
  const TestRootUnionWithArrayOptionOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const StringDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootUnionWithArrayOptionOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'TestRootUnionWithArrayOptionOption0(value: $value)';
}

final class TestRootUnionWithArrayOptionOption1
    extends TestRootUnionWithArrayOption {
  final List<Address> value;
  const TestRootUnionWithArrayOptionOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(
      target,
      value,
      ArrayDescriptor<Address>(Address.descriptor),
    );
  }

  @override
  void validate() {
    for (var i = 0; i < value.length; i++) {
      try {
        (value[i] as JsonModel).validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['[$i]', ...e.path]);
      }
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootUnionWithArrayOptionOption1 &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(value, other.value);

  @override
  int get hashCode => const DeepCollectionEquality().hash(value);

  @override
  String toString() => 'TestRootUnionWithArrayOptionOption1(value: $value)';
}

final class TestRootArrayWithAllOfItemsItem implements JsonModel {
  final String? a;
  final int? b;

  const TestRootArrayWithAllOfItemsItem({this.a, this.b});

  factory TestRootArrayWithAllOfItemsItem.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootArrayWithAllOfItemsItem;

  /// Creates an instance of [TestRootArrayWithAllOfItemsItem] from a JSON Map.
  factory TestRootArrayWithAllOfItemsItem.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => TestRootArrayWithAllOfItemsItem.fromJson(
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

  TestRootArrayWithAllOfItemsItem copyWith({String? a, int? b}) =>
      TestRootArrayWithAllOfItemsItem(a: a ?? this.a, b: b ?? this.b);

  void validate() {
    final val_a = a;
    final val_b = b;
  }

  static final descriptor = ObjectDescriptor<TestRootArrayWithAllOfItemsItem>(
    title: 'TestRootArrayWithAllOfItemsItem',
    matches: (instance) => instance is TestRootArrayWithAllOfItemsItem,
    instantiate: (fields) => TestRootArrayWithAllOfItemsItem(
      a: fields['a'] as String?,
      b: fields['b'] as int?,
    ),
    getFields: (instance) {
      final typedInstance = instance as TestRootArrayWithAllOfItemsItem;
      return {'a': typedInstance.a, 'b': typedInstance.b};
    },
    properties: {
      'a': PropertyDescriptor(
        name: 'a',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'b': PropertyDescriptor(
        name: 'b',
        isRequired: false,
        schema: const IntDescriptor(),
      ),
    },
    required: const [],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootArrayWithAllOfItemsItem &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b;

  @override
  int get hashCode => Object.hashAll([a, b]);

  @override
  String toString() => 'TestRootArrayWithAllOfItemsItem(a: ${a}, b: ${b})';
}

sealed class TestRootUnionWithAllOfOption implements JsonModel {
  const TestRootUnionWithAllOfOption();

  factory TestRootUnionWithAllOfOption.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootUnionWithAllOfOption;

  /// Creates an instance of [TestRootUnionWithAllOfOption] from a JSON-compatible Dart value.
  factory TestRootUnionWithAllOfOption.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => TestRootUnionWithAllOfOption.fromJson(
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

  static final descriptor = UnionDescriptor<TestRootUnionWithAllOfOption>(
    title: 'TestRootUnionWithAllOfOption',

    activeOptions: [
      UnionOptionDescriptor<TestRootUnionWithAllOfOption, String>(
        const StringDescriptor(),
        (val) => TestRootUnionWithAllOfOptionOption0(val as String),
      ),
      UnionOptionDescriptor<
        TestRootUnionWithAllOfOption,
        TestRootUnionWithAllOfOptionOptionType1
      >(
        TestRootUnionWithAllOfOptionOptionType1.descriptor,
        (val) => TestRootUnionWithAllOfOptionOption1(
          val as TestRootUnionWithAllOfOptionOptionType1,
        ),
      ),
    ],
  );
}

final class TestRootUnionWithAllOfOptionOption0
    extends TestRootUnionWithAllOfOption {
  final String value;
  const TestRootUnionWithAllOfOptionOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const StringDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootUnionWithAllOfOptionOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'TestRootUnionWithAllOfOptionOption0(value: $value)';
}

final class TestRootUnionWithAllOfOptionOption1
    extends TestRootUnionWithAllOfOption {
  final TestRootUnionWithAllOfOptionOptionType1 value;
  const TestRootUnionWithAllOfOptionOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(
      target,
      value,
      TestRootUnionWithAllOfOptionOptionType1.descriptor,
    );
  }

  @override
  void validate() {
    value.validate();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootUnionWithAllOfOptionOption1 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'TestRootUnionWithAllOfOptionOption1(value: $value)';
}

final class TestRootUnionWithAllOfOptionOptionType1 implements JsonModel {
  final String? a;
  final int? b;

  const TestRootUnionWithAllOfOptionOptionType1({this.a, this.b});

  factory TestRootUnionWithAllOfOptionOptionType1.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootUnionWithAllOfOptionOptionType1;

  /// Creates an instance of [TestRootUnionWithAllOfOptionOptionType1] from a JSON Map.
  factory TestRootUnionWithAllOfOptionOptionType1.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => TestRootUnionWithAllOfOptionOptionType1.fromJson(
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

  TestRootUnionWithAllOfOptionOptionType1 copyWith({String? a, int? b}) =>
      TestRootUnionWithAllOfOptionOptionType1(a: a ?? this.a, b: b ?? this.b);

  void validate() {
    final val_a = a;
    final val_b = b;
  }

  static final descriptor =
      ObjectDescriptor<TestRootUnionWithAllOfOptionOptionType1>(
        title: 'TestRootUnionWithAllOfOptionOptionType1',
        matches: (instance) =>
            instance is TestRootUnionWithAllOfOptionOptionType1,
        instantiate: (fields) => TestRootUnionWithAllOfOptionOptionType1(
          a: fields['a'] as String?,
          b: fields['b'] as int?,
        ),
        getFields: (instance) {
          final typedInstance =
              instance as TestRootUnionWithAllOfOptionOptionType1;
          return {'a': typedInstance.a, 'b': typedInstance.b};
        },
        properties: {
          'a': PropertyDescriptor(
            name: 'a',
            isRequired: false,
            schema: const StringDescriptor(),
          ),
          'b': PropertyDescriptor(
            name: 'b',
            isRequired: false,
            schema: const IntDescriptor(),
          ),
        },
        required: const [],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootUnionWithAllOfOptionOptionType1 &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b;

  @override
  int get hashCode => Object.hashAll([a, b]);

  @override
  String toString() =>
      'TestRootUnionWithAllOfOptionOptionType1(a: ${a}, b: ${b})';
}

final class MyCustomClassName implements JsonModel {
  final String? foo;

  const MyCustomClassName({this.foo});

  factory MyCustomClassName.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as MyCustomClassName;

  /// Creates an instance of [MyCustomClassName] from a JSON Map.
  factory MyCustomClassName.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => MyCustomClassName.fromJson(
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

  MyCustomClassName copyWith({String? foo}) =>
      MyCustomClassName(foo: foo ?? this.foo);

  void validate() {
    final val_foo = foo;
  }

  static final descriptor = ObjectDescriptor<MyCustomClassName>(
    title: 'MyCustomClassName',
    matches: (instance) => instance is MyCustomClassName,
    instantiate: (fields) => MyCustomClassName(foo: fields['foo'] as String?),
    getFields: (instance) {
      final typedInstance = instance as MyCustomClassName;
      return {'foo': typedInstance.foo};
    },
    properties: {
      'foo': PropertyDescriptor(
        name: 'foo',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
    },
    required: const [],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyCustomClassName &&
          runtimeType == other.runtimeType &&
          foo == other.foo;

  @override
  int get hashCode => Object.hashAll([foo]);

  @override
  String toString() => 'MyCustomClassName(foo: ${foo})';
}

@Deprecated('This union is deprecated, use MyCustomUnionName2')
sealed class MyCustomUnionName implements JsonModel {
  const MyCustomUnionName();

  factory MyCustomUnionName.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as MyCustomUnionName;

  /// Creates an instance of [MyCustomUnionName] from a JSON-compatible Dart value.
  factory MyCustomUnionName.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => MyCustomUnionName.fromJson(
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

  static final descriptor = UnionDescriptor<MyCustomUnionName>(
    title: 'MyCustomUnionName',

    activeOptions: [
      UnionOptionDescriptor<MyCustomUnionName, String>(
        const StringDescriptor(),
        (val) => MyCustomUnionNameOption0(val as String),
      ),
      UnionOptionDescriptor<MyCustomUnionName, int>(
        const IntDescriptor(),
        (val) => MyCustomUnionNameOption1(val as int),
      ),
    ],
  );
}

final class MyCustomUnionNameOption0 extends MyCustomUnionName {
  final String value;
  const MyCustomUnionNameOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const StringDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyCustomUnionNameOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'MyCustomUnionNameOption0(value: $value)';
}

final class MyCustomUnionNameOption1 extends MyCustomUnionName {
  final int value;
  const MyCustomUnionNameOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const IntDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyCustomUnionNameOption1 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'MyCustomUnionNameOption1(value: $value)';
}

enum MyCustomEnumName {
  one('one'),
  two('two');

  final String value;
  const MyCustomEnumName(this.value);
  static MyCustomEnumName fromValue(String val) =>
      values.firstWhere((e) => e.value == val);
  static final descriptor = EnumDescriptor<MyCustomEnumName>(
    values: values,
    fromValue: (val) => fromValue(val as String),
    toValue: (e) => (e as MyCustomEnumName).value,
    base: const StringDescriptor(),
  );
}

final class TestRootCoverageTrigger implements JsonModel {
  final List<String>? mergeArray;
  final String? mergeString;
  final num? mergeNumber;
  final bool? mergeBoolean;
  final Null mergeNull;
  final Object? mergeAnything;
  final String? mergeNever;
  final MapObject? mergeRef;
  final TestRootCoverageTriggerMergeEnum? mergeEnum;
  final TestRootCoverageTriggerMergeUnion? mergeUnion;
  final TestRootCoverageTriggerMergeObjectsWithNoAdditional?
  mergeObjectsWithNoAdditional;

  const TestRootCoverageTrigger({
    this.mergeArray,
    this.mergeString,
    this.mergeNumber,
    this.mergeBoolean,
    this.mergeNull,
    this.mergeAnything,
    this.mergeNever,
    this.mergeRef,
    this.mergeEnum,
    this.mergeUnion,
    this.mergeObjectsWithNoAdditional,
  });

  factory TestRootCoverageTrigger.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootCoverageTrigger;

  /// Creates an instance of [TestRootCoverageTrigger] from a JSON Map.
  factory TestRootCoverageTrigger.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => TestRootCoverageTrigger.fromJson(
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

  TestRootCoverageTrigger copyWith({
    List<String>? mergeArray,
    String? mergeString,
    num? mergeNumber,
    bool? mergeBoolean,
    Null mergeNull,
    Object? mergeAnything,
    String? mergeNever,
    MapObject? mergeRef,
    TestRootCoverageTriggerMergeEnum? mergeEnum,
    TestRootCoverageTriggerMergeUnion? mergeUnion,
    TestRootCoverageTriggerMergeObjectsWithNoAdditional?
    mergeObjectsWithNoAdditional,
  }) => TestRootCoverageTrigger(
    mergeArray: mergeArray ?? this.mergeArray,
    mergeString: mergeString ?? this.mergeString,
    mergeNumber: mergeNumber ?? this.mergeNumber,
    mergeBoolean: mergeBoolean ?? this.mergeBoolean,
    mergeNull: mergeNull ?? this.mergeNull,
    mergeAnything: mergeAnything ?? this.mergeAnything,
    mergeNever: mergeNever ?? this.mergeNever,
    mergeRef: mergeRef ?? this.mergeRef,
    mergeEnum: mergeEnum ?? this.mergeEnum,
    mergeUnion: mergeUnion ?? this.mergeUnion,
    mergeObjectsWithNoAdditional:
        mergeObjectsWithNoAdditional ?? this.mergeObjectsWithNoAdditional,
  );

  void validate() {
    final val_mergeArray = mergeArray;
    final val_mergeString = mergeString;
    if (val_mergeString != null) {
      if (val_mergeString.length < 2) {
        throw JsonValidationException(
          'Property "mergeString" length must be >= 2',
          ['mergeString'],
        );
      }
      if (val_mergeString.length > 10) {
        throw JsonValidationException(
          'Property "mergeString" length must be <= 10',
          ['mergeString'],
        );
      }
    }
    final val_mergeNumber = mergeNumber;
    if (val_mergeNumber != null) {
      if (val_mergeNumber < 1) {
        throw JsonValidationException('Property "mergeNumber" must be >= 1', [
          'mergeNumber',
        ]);
      }
      if (val_mergeNumber > 10) {
        throw JsonValidationException('Property "mergeNumber" must be <= 10', [
          'mergeNumber',
        ]);
      }
    }
    final val_mergeBoolean = mergeBoolean;
    final val_mergeAnything = mergeAnything;
    final val_mergeNever = mergeNever;
    final val_mergeRef = mergeRef;
    if (val_mergeRef != null) {
      try {
        val_mergeRef.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['mergeRef', ...e.path]);
      }
    }
    final val_mergeEnum = mergeEnum;
    if (val_mergeEnum != null) {
      if (!const [
        TestRootCoverageTriggerMergeEnum.a,
        TestRootCoverageTriggerMergeEnum.b,
      ].any((v) => const DeepCollectionEquality().equals(v, val_mergeEnum))) {
        throw JsonValidationException(
          'Property "mergeEnum" must be one of [a, b]',
          ['mergeEnum'],
        );
      }
    }
    final val_mergeUnion = mergeUnion;
    if (val_mergeUnion != null) {
      try {
        val_mergeUnion.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['mergeUnion', ...e.path]);
      }
    }
    final val_mergeObjectsWithNoAdditional = mergeObjectsWithNoAdditional;
    if (val_mergeObjectsWithNoAdditional != null) {
      try {
        val_mergeObjectsWithNoAdditional.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, [
          'mergeObjectsWithNoAdditional',
          ...e.path,
        ]);
      }
    }
  }

  static final descriptor = ObjectDescriptor<TestRootCoverageTrigger>(
    title: 'TestRootCoverageTrigger',
    matches: (instance) => instance is TestRootCoverageTrigger,
    instantiate: (fields) => TestRootCoverageTrigger(
      mergeArray: fields['mergeArray'] as List<String>?,
      mergeString: fields['mergeString'] as String?,
      mergeNumber: fields['mergeNumber'] as num?,
      mergeBoolean: fields['mergeBoolean'] as bool?,
      mergeNull: fields['mergeNull'] as Null,
      mergeAnything: fields['mergeAnything'] as Object?,
      mergeNever: fields['mergeNever'] as String?,
      mergeRef: fields['mergeRef'] as MapObject?,
      mergeEnum: fields['mergeEnum'] as TestRootCoverageTriggerMergeEnum?,
      mergeUnion: fields['mergeUnion'] as TestRootCoverageTriggerMergeUnion?,
      mergeObjectsWithNoAdditional:
          fields['mergeObjectsWithNoAdditional']
              as TestRootCoverageTriggerMergeObjectsWithNoAdditional?,
    ),
    getFields: (instance) {
      final typedInstance = instance as TestRootCoverageTrigger;
      return {
        'mergeArray': typedInstance.mergeArray,
        'mergeString': typedInstance.mergeString,
        'mergeNumber': typedInstance.mergeNumber,
        'mergeBoolean': typedInstance.mergeBoolean,
        'mergeNull': typedInstance.mergeNull,
        'mergeAnything': typedInstance.mergeAnything,
        'mergeNever': typedInstance.mergeNever,
        'mergeRef': typedInstance.mergeRef,
        'mergeEnum': typedInstance.mergeEnum,
        'mergeUnion': typedInstance.mergeUnion,
        'mergeObjectsWithNoAdditional':
            typedInstance.mergeObjectsWithNoAdditional,
      };
    },
    properties: {
      'mergeArray': PropertyDescriptor(
        name: 'mergeArray',
        isRequired: false,
        schema: ArrayDescriptor<String>(const StringDescriptor()),
      ),
      'mergeString': PropertyDescriptor(
        name: 'mergeString',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'mergeNumber': PropertyDescriptor(
        name: 'mergeNumber',
        isRequired: false,
        schema: const NumDescriptor(),
      ),
      'mergeBoolean': PropertyDescriptor(
        name: 'mergeBoolean',
        isRequired: false,
        schema: const BoolDescriptor(),
      ),
      'mergeNull': PropertyDescriptor(
        name: 'mergeNull',
        isRequired: false,
        schema: const NullDescriptor(),
      ),
      'mergeAnything': PropertyDescriptor(
        name: 'mergeAnything',
        isRequired: false,
        schema: const AnythingDescriptor(),
      ),
      'mergeNever': PropertyDescriptor(
        name: 'mergeNever',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'mergeRef': PropertyDescriptor(
        name: 'mergeRef',
        isRequired: false,
        schema: MapObject.descriptor,
      ),
      'mergeEnum': PropertyDescriptor(
        name: 'mergeEnum',
        isRequired: false,
        schema: TestRootCoverageTriggerMergeEnum.descriptor,
      ),
      'mergeUnion': PropertyDescriptor(
        name: 'mergeUnion',
        isRequired: false,
        schema: TestRootCoverageTriggerMergeUnion.descriptor,
      ),
      'mergeObjectsWithNoAdditional': PropertyDescriptor(
        name: 'mergeObjectsWithNoAdditional',
        isRequired: false,
        schema: TestRootCoverageTriggerMergeObjectsWithNoAdditional.descriptor,
      ),
    },
    required: const [],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootCoverageTrigger &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(mergeArray, other.mergeArray) &&
          mergeString == other.mergeString &&
          mergeNumber == other.mergeNumber &&
          mergeBoolean == other.mergeBoolean &&
          mergeNull == other.mergeNull &&
          const DeepCollectionEquality().equals(
            mergeAnything,
            other.mergeAnything,
          ) &&
          mergeNever == other.mergeNever &&
          const DeepCollectionEquality().equals(mergeRef, other.mergeRef) &&
          mergeEnum == other.mergeEnum &&
          mergeUnion == other.mergeUnion &&
          mergeObjectsWithNoAdditional == other.mergeObjectsWithNoAdditional;

  @override
  int get hashCode => Object.hashAll([
    const DeepCollectionEquality().hash(mergeArray),
    mergeString,
    mergeNumber,
    mergeBoolean,
    mergeNull,
    const DeepCollectionEquality().hash(mergeAnything),
    mergeNever,
    const DeepCollectionEquality().hash(mergeRef),
    mergeEnum,
    mergeUnion,
    mergeObjectsWithNoAdditional,
  ]);

  @override
  String toString() =>
      'TestRootCoverageTrigger(mergeArray: ${mergeArray}, mergeString: ${mergeString}, mergeNumber: ${mergeNumber}, mergeBoolean: ${mergeBoolean}, mergeNull: ${mergeNull}, mergeAnything: ${mergeAnything}, mergeNever: ${mergeNever}, mergeRef: ${mergeRef}, mergeEnum: ${mergeEnum}, mergeUnion: ${mergeUnion}, mergeObjectsWithNoAdditional: ${mergeObjectsWithNoAdditional})';
}

enum TestRootCoverageTriggerMergeEnum {
  a('a'),
  b('b');

  final String value;
  const TestRootCoverageTriggerMergeEnum(this.value);
  static TestRootCoverageTriggerMergeEnum fromValue(String val) =>
      values.firstWhere((e) => e.value == val);
  static final descriptor = EnumDescriptor<TestRootCoverageTriggerMergeEnum>(
    values: values,
    fromValue: (val) => fromValue(val as String),
    toValue: (e) => (e as TestRootCoverageTriggerMergeEnum).value,
    base: const StringDescriptor(),
  );
}

sealed class TestRootCoverageTriggerMergeUnion implements JsonModel {
  const TestRootCoverageTriggerMergeUnion();

  factory TestRootCoverageTriggerMergeUnion.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootCoverageTriggerMergeUnion;

  /// Creates an instance of [TestRootCoverageTriggerMergeUnion] from a JSON-compatible Dart value.
  factory TestRootCoverageTriggerMergeUnion.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => TestRootCoverageTriggerMergeUnion.fromJson(
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

  static final descriptor = UnionDescriptor<TestRootCoverageTriggerMergeUnion>(
    title: 'TestRootCoverageTriggerMergeUnion',

    activeOptions: [
      UnionOptionDescriptor<TestRootCoverageTriggerMergeUnion, String>(
        const StringDescriptor(),
        (val) => TestRootCoverageTriggerMergeUnionOption0(val as String),
      ),
      UnionOptionDescriptor<TestRootCoverageTriggerMergeUnion, int>(
        const IntDescriptor(),
        (val) => TestRootCoverageTriggerMergeUnionOption1(val as int),
      ),
    ],
  );
}

final class TestRootCoverageTriggerMergeUnionOption0
    extends TestRootCoverageTriggerMergeUnion {
  final String value;
  const TestRootCoverageTriggerMergeUnionOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const StringDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootCoverageTriggerMergeUnionOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      'TestRootCoverageTriggerMergeUnionOption0(value: $value)';
}

final class TestRootCoverageTriggerMergeUnionOption1
    extends TestRootCoverageTriggerMergeUnion {
  final int value;
  const TestRootCoverageTriggerMergeUnionOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(target, value, const IntDescriptor());
  }

  @override
  void validate() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootCoverageTriggerMergeUnionOption1 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      'TestRootCoverageTriggerMergeUnionOption1(value: $value)';
}

final class TestRootCoverageTriggerMergeObjectsWithNoAdditional
    implements JsonModel {
  const TestRootCoverageTriggerMergeObjectsWithNoAdditional();

  factory TestRootCoverageTriggerMergeObjectsWithNoAdditional.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootCoverageTriggerMergeObjectsWithNoAdditional;

  /// Creates an instance of [TestRootCoverageTriggerMergeObjectsWithNoAdditional] from a JSON Map.
  factory TestRootCoverageTriggerMergeObjectsWithNoAdditional.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => TestRootCoverageTriggerMergeObjectsWithNoAdditional.fromJson(
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

  TestRootCoverageTriggerMergeObjectsWithNoAdditional copyWith() =>
      TestRootCoverageTriggerMergeObjectsWithNoAdditional();

  void validate() {}

  static final descriptor =
      ObjectDescriptor<TestRootCoverageTriggerMergeObjectsWithNoAdditional>(
        title: 'TestRootCoverageTriggerMergeObjectsWithNoAdditional',
        matches: (instance) =>
            instance is TestRootCoverageTriggerMergeObjectsWithNoAdditional,
        instantiate: (fields) =>
            TestRootCoverageTriggerMergeObjectsWithNoAdditional(),
        getFields: (instance) {
          final typedInstance =
              instance as TestRootCoverageTriggerMergeObjectsWithNoAdditional;
          return {};
        },
        properties: {},
        required: const [],
        additionalProperties: const NeverDescriptor(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootCoverageTriggerMergeObjectsWithNoAdditional &&
          runtimeType == other.runtimeType &&
          true;

  @override
  int get hashCode => Object.hashAll([]);

  @override
  String toString() => 'TestRootCoverageTriggerMergeObjectsWithNoAdditional()';
}

enum CollidingEnum {
  values_1('values'),
  value_1('value'),
  fromValue_1('fromValue'),
  descriptor_('descriptor'),
  fooBar('foo-bar'),
  fooBar_1('foo_bar'),
  a1(const {'a': 1}),
  a1_1(const {'a': '1'});

  final dynamic value;
  const CollidingEnum(this.value);
  static CollidingEnum fromValue(dynamic val) =>
      values.firstWhere((e) => e.value == val);
  static final descriptor = EnumDescriptor<CollidingEnum>(
    values: values,
    fromValue: (val) => fromValue(val as dynamic),
    toValue: (e) => (e as CollidingEnum).value,
    base: const AnythingDescriptor(),
  );
}

final class CollidingObject implements JsonModel {
  final String? foo;
  final String? foo_1;
  final String? bar;
  final String? bar1;
  final String? validate_;

  const CollidingObject({
    this.foo,
    this.foo_1,
    this.bar,
    this.bar1,
    this.validate_,
  });

  factory CollidingObject.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as CollidingObject;

  /// Creates an instance of [CollidingObject] from a JSON Map.
  factory CollidingObject.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) =>
      CollidingObject.fromJson(JsonReader.fromObject(map), validate: validate);

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

  CollidingObject copyWith({
    String? foo,
    String? foo_1,
    String? bar,
    String? bar1,
    String? validate_,
  }) => CollidingObject(
    foo: foo ?? this.foo,
    foo_1: foo_1 ?? this.foo_1,
    bar: bar ?? this.bar,
    bar1: bar1 ?? this.bar1,
    validate_: validate_ ?? this.validate_,
  );

  void validate() {
    final val_foo = foo;
    final val_foo_1 = foo_1;
    final val_bar = bar;
    final val_bar1 = bar1;
    final val_validate_ = validate_;
  }

  static final descriptor = ObjectDescriptor<CollidingObject>(
    title: 'CollidingObject',
    matches: (instance) => instance is CollidingObject,
    instantiate: (fields) => CollidingObject(
      foo: fields['foo'] as String?,
      foo_1: fields['@foo'] as String?,
      bar: fields['bar'] as String?,
      bar1: fields['bar_1'] as String?,
      validate_: fields['validate'] as String?,
    ),
    getFields: (instance) {
      final typedInstance = instance as CollidingObject;
      return {
        'foo': typedInstance.foo,
        '@foo': typedInstance.foo_1,
        'bar': typedInstance.bar,
        'bar_1': typedInstance.bar1,
        'validate': typedInstance.validate_,
      };
    },
    properties: {
      'foo': PropertyDescriptor(
        name: 'foo',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      '@foo': PropertyDescriptor(
        name: '@foo',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'bar': PropertyDescriptor(
        name: 'bar',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'bar_1': PropertyDescriptor(
        name: 'bar_1',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'validate': PropertyDescriptor(
        name: 'validate',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
    },
    required: const [],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollidingObject &&
          runtimeType == other.runtimeType &&
          foo == other.foo &&
          foo_1 == other.foo_1 &&
          bar == other.bar &&
          bar1 == other.bar1 &&
          validate_ == other.validate_;

  @override
  int get hashCode => Object.hashAll([foo, foo_1, bar, bar1, validate_]);

  @override
  String toString() =>
      'CollidingObject(foo: ${foo}, foo_1: ${foo_1}, bar: ${bar}, bar1: ${bar1}, validate_: ${validate_})';
}
