// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides, unnecessary_null_comparison
// ignore_for_file: prefer_is_empty, unnecessary_string_interpolations, avoid_init_to_null, unnecessary_const
// ignore_for_file: unnecessary_question_mark, unnecessary_cast

import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';

final class TestRoot implements JsonModel {
  @Deprecated('deprecated')
  final String? deprecated;
  final String? idField;
  final TestRootUnionWithObjectAndBoolean? unionWithObjectAndBoolean;
  final RecursiveNode? recursiveNodeField;
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
  @Deprecated('deprecated')
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
  final PatternPropertiesObject? patternPropsField;
  final OverlappingUnion? overlappingUnion;
  final String? deprecatedFieldWithMessage;
  final MyCustomClassName? customNamedObject;
  final MyCustomUnionName? customNamedUnion;
  final MyCustomEnumName? customNamedEnum;
  final TestRootCoverageTrigger? coverageTrigger;
  final CollidingEnum? collidingEnumField;
  final CollidingObject? collidingObjectField;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const TestRoot({
    this.deprecated,
    this.idField,
    this.unionWithObjectAndBoolean,
    this.recursiveNodeField,
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
    this.patternPropsField,
    this.overlappingUnion,
    this.deprecatedFieldWithMessage,
    this.customNamedObject,
    this.customNamedUnion,
    this.customNamedEnum,
    this.coverageTrigger,
    this.collidingEnumField,
    this.collidingObjectField,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  TestRoot copyWith({
    Object? deprecated = _undefined,
    Object? idField = _undefined,
    Object? unionWithObjectAndBoolean = _undefined,
    Object? recursiveNodeField = _undefined,
    Object? name = _undefined,
    Object? constValue = _undefined,
    Object? age = _undefined,
    Object? exclusiveAge = _undefined,
    Object? height = _undefined,
    Object? email = _undefined,
    Object? uuid = _undefined,
    Object? isAwesome = _undefined,
    Object? class_ = _undefined,
    Object? reader = _undefined,
    Object? stack = _undefined,
    Object? validate_ = _undefined,
    Object? result = _undefined,
    Object? address = _undefined,
    Object? tags = _undefined,
    Object? scores = _undefined,
    Object? unionValue = _undefined,
    Object? nullableUnionValue = _undefined,
    Object? requiredNullableUnionObject = _undefined,
    Object? nullableString = _undefined,
    Object? pet = _undefined,
    Object? restrictedObject = _undefined,
    Object? dependentObject = _undefined,
    Object? primitiveArrayWithValidation = _undefined,
    Object? restrictedArray = _undefined,
    Object? deprecatedField = _undefined,
    Object? deprecatedRef = _undefined,
    Object? defaultString = _undefined,
    Object? defaultBackslash = _undefined,
    Object? nestedArray = _undefined,
    Object? singleQuoteKey = _undefined,
    Object? mixedEnum = _undefined,
    Object? defaultInt = _undefined,
    Object? defaultBool = _undefined,
    Object? defaultList = _undefined,
    Object? defaultObject = _undefined,
    Object? defaultNullableString = _undefined,
    Object? mergedValue = _undefined,
    Object? tupleArray = _undefined,
    Object? tupleObjectArray = _undefined,
    Object? ipv6Value = _undefined,
    Object? hostnameValue = _undefined,
    Object? timeValue = _undefined,
    Object? uriReferenceValue = _undefined,
    Object? additionalPropertiesObject = _undefined,
    Object? strictObject = _undefined,
    Object? notObject = _undefined,
    Object? anyOfValue = _undefined,
    Object? mergedAllOfObject = _undefined,
    Object? complexMerged = _undefined,
    Object? myEnumField = _undefined,
    Object? unionContainsArray = _undefined,
    Object? objectContainsArray = _undefined,
    Object? enumContainsArray = _undefined,
    Object? booleanContainsArray = _undefined,
    Object? nullContainsArray = _undefined,
    Object? anyContainsArray = _undefined,
    Object? stringContainsArray = _undefined,
    Object? numberContainsArray = _undefined,
    Object? dynamicProps = _undefined,
    Object? dateTimeField = _undefined,
    Object? dateField = _undefined,
    Object? ipv4Field = _undefined,
    Object? uriField = _undefined,
    Object? defaultEmptyList = _undefined,
    Object? defaultEmptyObject = _undefined,
    Object? unionWithArrayOption = _undefined,
    Object? impossibleField = _undefined,
    Object? tupleSameTypeArray = _undefined,
    Object? arrayWithAllOfItems = _undefined,
    Object? unionWithAllOfOption = _undefined,
    Object? patternPropsField = _undefined,
    Object? overlappingUnion = _undefined,
    Object? deprecatedFieldWithMessage = _undefined,
    Object? customNamedObject = _undefined,
    Object? customNamedUnion = _undefined,
    Object? customNamedEnum = _undefined,
    Object? coverageTrigger = _undefined,
    Object? collidingEnumField = _undefined,
    Object? collidingObjectField = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(deprecated, _undefined)) {
      nextKeys.add('deprecated');
    }
    if (!identical(idField, _undefined)) {
      nextKeys.add('\$idField');
    }
    if (!identical(unionWithObjectAndBoolean, _undefined)) {
      nextKeys.add('unionWithObjectAndBoolean');
    }
    if (!identical(recursiveNodeField, _undefined)) {
      nextKeys.add('recursiveNodeField');
    }
    if (!identical(name, _undefined)) {
      nextKeys.add('name');
    }
    if (!identical(constValue, _undefined)) {
      nextKeys.add('constValue');
    }
    if (!identical(age, _undefined)) {
      nextKeys.add('age');
    }
    if (!identical(exclusiveAge, _undefined)) {
      nextKeys.add('exclusiveAge');
    }
    if (!identical(height, _undefined)) {
      nextKeys.add('height');
    }
    if (!identical(email, _undefined)) {
      nextKeys.add('email');
    }
    if (!identical(uuid, _undefined)) {
      nextKeys.add('uuid');
    }
    if (!identical(isAwesome, _undefined)) {
      nextKeys.add('isAwesome');
    }
    if (!identical(class_, _undefined)) {
      nextKeys.add('class');
    }
    if (!identical(reader, _undefined)) {
      nextKeys.add('reader');
    }
    if (!identical(stack, _undefined)) {
      nextKeys.add('stack');
    }
    if (!identical(validate_, _undefined)) {
      nextKeys.add('validate');
    }
    if (!identical(result, _undefined)) {
      nextKeys.add('result');
    }
    if (!identical(address, _undefined)) {
      nextKeys.add('address');
    }
    if (!identical(tags, _undefined)) {
      nextKeys.add('tags');
    }
    if (!identical(scores, _undefined)) {
      nextKeys.add('scores');
    }
    if (!identical(unionValue, _undefined)) {
      nextKeys.add('unionValue');
    }
    if (!identical(nullableUnionValue, _undefined)) {
      nextKeys.add('nullableUnionValue');
    }
    if (!identical(requiredNullableUnionObject, _undefined)) {
      nextKeys.add('requiredNullableUnionObject');
    }
    if (!identical(nullableString, _undefined)) {
      nextKeys.add('nullableString');
    }
    if (!identical(pet, _undefined)) {
      nextKeys.add('pet');
    }
    if (!identical(restrictedObject, _undefined)) {
      nextKeys.add('restrictedObject');
    }
    if (!identical(dependentObject, _undefined)) {
      nextKeys.add('dependentObject');
    }
    if (!identical(primitiveArrayWithValidation, _undefined)) {
      nextKeys.add('primitiveArrayWithValidation');
    }
    if (!identical(restrictedArray, _undefined)) {
      nextKeys.add('restrictedArray');
    }
    if (!identical(deprecatedField, _undefined)) {
      nextKeys.add('deprecatedField');
    }
    if (!identical(deprecatedRef, _undefined)) {
      nextKeys.add('deprecatedRef');
    }
    if (!identical(defaultString, _undefined)) {
      nextKeys.add('defaultString');
    }
    if (!identical(defaultBackslash, _undefined)) {
      nextKeys.add('defaultBackslash');
    }
    if (!identical(nestedArray, _undefined)) {
      nextKeys.add('nestedArray');
    }
    if (!identical(singleQuoteKey, _undefined)) {
      nextKeys.add('single\'quote\'key');
    }
    if (!identical(mixedEnum, _undefined)) {
      nextKeys.add('mixedEnum');
    }
    if (!identical(defaultInt, _undefined)) {
      nextKeys.add('defaultInt');
    }
    if (!identical(defaultBool, _undefined)) {
      nextKeys.add('defaultBool');
    }
    if (!identical(defaultList, _undefined)) {
      nextKeys.add('defaultList');
    }
    if (!identical(defaultObject, _undefined)) {
      nextKeys.add('defaultObject');
    }
    if (!identical(defaultNullableString, _undefined)) {
      nextKeys.add('defaultNullableString');
    }
    if (!identical(mergedValue, _undefined)) {
      nextKeys.add('mergedValue');
    }
    if (!identical(tupleArray, _undefined)) {
      nextKeys.add('tupleArray');
    }
    if (!identical(tupleObjectArray, _undefined)) {
      nextKeys.add('tupleObjectArray');
    }
    if (!identical(ipv6Value, _undefined)) {
      nextKeys.add('ipv6Value');
    }
    if (!identical(hostnameValue, _undefined)) {
      nextKeys.add('hostnameValue');
    }
    if (!identical(timeValue, _undefined)) {
      nextKeys.add('timeValue');
    }
    if (!identical(uriReferenceValue, _undefined)) {
      nextKeys.add('uriReferenceValue');
    }
    if (!identical(additionalPropertiesObject, _undefined)) {
      nextKeys.add('additionalPropertiesObject');
    }
    if (!identical(strictObject, _undefined)) {
      nextKeys.add('strictObject');
    }
    if (!identical(notObject, _undefined)) {
      nextKeys.add('notObject');
    }
    if (!identical(anyOfValue, _undefined)) {
      nextKeys.add('anyOfValue');
    }
    if (!identical(mergedAllOfObject, _undefined)) {
      nextKeys.add('mergedAllOfObject');
    }
    if (!identical(complexMerged, _undefined)) {
      nextKeys.add('complexMerged');
    }
    if (!identical(myEnumField, _undefined)) {
      nextKeys.add('myEnumField');
    }
    if (!identical(unionContainsArray, _undefined)) {
      nextKeys.add('unionContainsArray');
    }
    if (!identical(objectContainsArray, _undefined)) {
      nextKeys.add('objectContainsArray');
    }
    if (!identical(enumContainsArray, _undefined)) {
      nextKeys.add('enumContainsArray');
    }
    if (!identical(booleanContainsArray, _undefined)) {
      nextKeys.add('booleanContainsArray');
    }
    if (!identical(nullContainsArray, _undefined)) {
      nextKeys.add('nullContainsArray');
    }
    if (!identical(anyContainsArray, _undefined)) {
      nextKeys.add('anyContainsArray');
    }
    if (!identical(stringContainsArray, _undefined)) {
      nextKeys.add('stringContainsArray');
    }
    if (!identical(numberContainsArray, _undefined)) {
      nextKeys.add('numberContainsArray');
    }
    if (!identical(dynamicProps, _undefined)) {
      nextKeys.add('dynamicProps');
    }
    if (!identical(dateTimeField, _undefined)) {
      nextKeys.add('dateTimeField');
    }
    if (!identical(dateField, _undefined)) {
      nextKeys.add('dateField');
    }
    if (!identical(ipv4Field, _undefined)) {
      nextKeys.add('ipv4Field');
    }
    if (!identical(uriField, _undefined)) {
      nextKeys.add('uriField');
    }
    if (!identical(defaultEmptyList, _undefined)) {
      nextKeys.add('defaultEmptyList');
    }
    if (!identical(defaultEmptyObject, _undefined)) {
      nextKeys.add('defaultEmptyObject');
    }
    if (!identical(unionWithArrayOption, _undefined)) {
      nextKeys.add('unionWithArrayOption');
    }
    if (!identical(impossibleField, _undefined)) {
      nextKeys.add('impossibleField');
    }
    if (!identical(tupleSameTypeArray, _undefined)) {
      nextKeys.add('tupleSameTypeArray');
    }
    if (!identical(arrayWithAllOfItems, _undefined)) {
      nextKeys.add('arrayWithAllOfItems');
    }
    if (!identical(unionWithAllOfOption, _undefined)) {
      nextKeys.add('unionWithAllOfOption');
    }
    if (!identical(patternPropsField, _undefined)) {
      nextKeys.add('patternPropsField');
    }
    if (!identical(overlappingUnion, _undefined)) {
      nextKeys.add('overlappingUnion');
    }
    if (!identical(deprecatedFieldWithMessage, _undefined)) {
      nextKeys.add('deprecatedFieldWithMessage');
    }
    if (!identical(customNamedObject, _undefined)) {
      nextKeys.add('customNamedObject');
    }
    if (!identical(customNamedUnion, _undefined)) {
      nextKeys.add('customNamedUnion');
    }
    if (!identical(customNamedEnum, _undefined)) {
      nextKeys.add('customNamedEnum');
    }
    if (!identical(coverageTrigger, _undefined)) {
      nextKeys.add('coverageTrigger');
    }
    if (!identical(collidingEnumField, _undefined)) {
      nextKeys.add('collidingEnumField');
    }
    if (!identical(collidingObjectField, _undefined)) {
      nextKeys.add('collidingObjectField');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return TestRoot(
      deprecated: !identical(deprecated, _undefined)
          ? deprecated as String?
          : this.deprecated,
      idField: !identical(idField, _undefined)
          ? idField as String?
          : this.idField,
      unionWithObjectAndBoolean:
          !identical(unionWithObjectAndBoolean, _undefined)
          ? unionWithObjectAndBoolean as TestRootUnionWithObjectAndBoolean?
          : this.unionWithObjectAndBoolean,
      recursiveNodeField: !identical(recursiveNodeField, _undefined)
          ? recursiveNodeField as RecursiveNode?
          : this.recursiveNodeField,
      name: !identical(name, _undefined) ? name as String : this.name,
      constValue: !identical(constValue, _undefined)
          ? constValue as TestRootConstValue?
          : this.constValue,
      age: !identical(age, _undefined) ? age as int : this.age,
      exclusiveAge: !identical(exclusiveAge, _undefined)
          ? exclusiveAge as int?
          : this.exclusiveAge,
      height: !identical(height, _undefined) ? height as num? : this.height,
      email: !identical(email, _undefined) ? email as String? : this.email,
      uuid: !identical(uuid, _undefined) ? uuid as String? : this.uuid,
      isAwesome: !identical(isAwesome, _undefined)
          ? isAwesome as bool
          : this.isAwesome,
      class_: !identical(class_, _undefined) ? class_ as String? : this.class_,
      reader: !identical(reader, _undefined) ? reader as String? : this.reader,
      stack: !identical(stack, _undefined) ? stack as String? : this.stack,
      validate_: !identical(validate_, _undefined)
          ? validate_ as String?
          : this.validate_,
      result: !identical(result, _undefined) ? result as String? : this.result,
      address: !identical(address, _undefined)
          ? address as Address
          : this.address,
      tags: !identical(tags, _undefined) ? tags as List<String>? : this.tags,
      scores: !identical(scores, _undefined)
          ? scores as List<Score>?
          : this.scores,
      unionValue: !identical(unionValue, _undefined)
          ? unionValue as TestRootUnionValue?
          : this.unionValue,
      nullableUnionValue: !identical(nullableUnionValue, _undefined)
          ? nullableUnionValue as TestRootNullableUnionValue?
          : this.nullableUnionValue,
      requiredNullableUnionObject:
          !identical(requiredNullableUnionObject, _undefined)
          ? requiredNullableUnionObject as RequiredNullableUnionObject?
          : this.requiredNullableUnionObject,
      nullableString: !identical(nullableString, _undefined)
          ? nullableString as String?
          : this.nullableString,
      pet: !identical(pet, _undefined) ? pet as Pet? : this.pet,
      restrictedObject: !identical(restrictedObject, _undefined)
          ? restrictedObject as RestrictedObject?
          : this.restrictedObject,
      dependentObject: !identical(dependentObject, _undefined)
          ? dependentObject as DependentObject?
          : this.dependentObject,
      primitiveArrayWithValidation:
          !identical(primitiveArrayWithValidation, _undefined)
          ? primitiveArrayWithValidation as List<String>?
          : this.primitiveArrayWithValidation,
      restrictedArray: !identical(restrictedArray, _undefined)
          ? restrictedArray as List<int>?
          : this.restrictedArray,
      deprecatedField: !identical(deprecatedField, _undefined)
          ? deprecatedField as String?
          : this.deprecatedField,
      deprecatedRef: !identical(deprecatedRef, _undefined)
          ? deprecatedRef as DeprecatedObject?
          : this.deprecatedRef,
      defaultString: !identical(defaultString, _undefined)
          ? defaultString as String
          : this.defaultString,
      defaultBackslash: !identical(defaultBackslash, _undefined)
          ? defaultBackslash as String
          : this.defaultBackslash,
      nestedArray: !identical(nestedArray, _undefined)
          ? nestedArray as List<List<Address>>?
          : this.nestedArray,
      singleQuoteKey: !identical(singleQuoteKey, _undefined)
          ? singleQuoteKey as String?
          : this.singleQuoteKey,
      mixedEnum: !identical(mixedEnum, _undefined)
          ? mixedEnum as TestRootMixedEnum?
          : this.mixedEnum,
      defaultInt: !identical(defaultInt, _undefined)
          ? defaultInt as int
          : this.defaultInt,
      defaultBool: !identical(defaultBool, _undefined)
          ? defaultBool as bool
          : this.defaultBool,
      defaultList: !identical(defaultList, _undefined)
          ? defaultList as List<String>
          : this.defaultList,
      defaultObject: !identical(defaultObject, _undefined)
          ? defaultObject as Address
          : this.defaultObject,
      defaultNullableString: !identical(defaultNullableString, _undefined)
          ? defaultNullableString as String?
          : this.defaultNullableString,
      mergedValue: !identical(mergedValue, _undefined)
          ? mergedValue as Merged?
          : this.mergedValue,
      tupleArray: !identical(tupleArray, _undefined)
          ? tupleArray as List<dynamic>?
          : this.tupleArray,
      tupleObjectArray: !identical(tupleObjectArray, _undefined)
          ? tupleObjectArray as List<dynamic>?
          : this.tupleObjectArray,
      ipv6Value: !identical(ipv6Value, _undefined)
          ? ipv6Value as String?
          : this.ipv6Value,
      hostnameValue: !identical(hostnameValue, _undefined)
          ? hostnameValue as String?
          : this.hostnameValue,
      timeValue: !identical(timeValue, _undefined)
          ? timeValue as String?
          : this.timeValue,
      uriReferenceValue: !identical(uriReferenceValue, _undefined)
          ? uriReferenceValue as String?
          : this.uriReferenceValue,
      additionalPropertiesObject:
          !identical(additionalPropertiesObject, _undefined)
          ? additionalPropertiesObject as MapObject?
          : this.additionalPropertiesObject,
      strictObject: !identical(strictObject, _undefined)
          ? strictObject as StrictObject?
          : this.strictObject,
      notObject: !identical(notObject, _undefined)
          ? notObject as NotObject?
          : this.notObject,
      anyOfValue: !identical(anyOfValue, _undefined)
          ? anyOfValue as TestRootAnyOfValue?
          : this.anyOfValue,
      mergedAllOfObject: !identical(mergedAllOfObject, _undefined)
          ? mergedAllOfObject as MergedAllOfObject?
          : this.mergedAllOfObject,
      complexMerged: !identical(complexMerged, _undefined)
          ? complexMerged as ComplexMergedObject?
          : this.complexMerged,
      myEnumField: !identical(myEnumField, _undefined)
          ? myEnumField as MyEnum?
          : this.myEnumField,
      unionContainsArray: !identical(unionContainsArray, _undefined)
          ? unionContainsArray as List<Object?>?
          : this.unionContainsArray,
      objectContainsArray: !identical(objectContainsArray, _undefined)
          ? objectContainsArray as List<Object?>?
          : this.objectContainsArray,
      enumContainsArray: !identical(enumContainsArray, _undefined)
          ? enumContainsArray as List<Object?>?
          : this.enumContainsArray,
      booleanContainsArray: !identical(booleanContainsArray, _undefined)
          ? booleanContainsArray as List<Object?>?
          : this.booleanContainsArray,
      nullContainsArray: !identical(nullContainsArray, _undefined)
          ? nullContainsArray as List<Object?>?
          : this.nullContainsArray,
      anyContainsArray: !identical(anyContainsArray, _undefined)
          ? anyContainsArray as List<Object?>?
          : this.anyContainsArray,
      stringContainsArray: !identical(stringContainsArray, _undefined)
          ? stringContainsArray as List<Object?>?
          : this.stringContainsArray,
      numberContainsArray: !identical(numberContainsArray, _undefined)
          ? numberContainsArray as List<Object?>?
          : this.numberContainsArray,
      dynamicProps: !identical(dynamicProps, _undefined)
          ? dynamicProps as ObjectWithDynamicProps?
          : this.dynamicProps,
      dateTimeField: !identical(dateTimeField, _undefined)
          ? dateTimeField as String?
          : this.dateTimeField,
      dateField: !identical(dateField, _undefined)
          ? dateField as String?
          : this.dateField,
      ipv4Field: !identical(ipv4Field, _undefined)
          ? ipv4Field as String?
          : this.ipv4Field,
      uriField: !identical(uriField, _undefined)
          ? uriField as String?
          : this.uriField,
      defaultEmptyList: !identical(defaultEmptyList, _undefined)
          ? defaultEmptyList as List<String>
          : this.defaultEmptyList,
      defaultEmptyObject: !identical(defaultEmptyObject, _undefined)
          ? defaultEmptyObject as MapObject
          : this.defaultEmptyObject,
      unionWithArrayOption: !identical(unionWithArrayOption, _undefined)
          ? unionWithArrayOption as TestRootUnionWithArrayOption?
          : this.unionWithArrayOption,
      impossibleField: !identical(impossibleField, _undefined)
          ? impossibleField as Never?
          : this.impossibleField,
      tupleSameTypeArray: !identical(tupleSameTypeArray, _undefined)
          ? tupleSameTypeArray as List<String>?
          : this.tupleSameTypeArray,
      arrayWithAllOfItems: !identical(arrayWithAllOfItems, _undefined)
          ? arrayWithAllOfItems as List<TestRootArrayWithAllOfItemsItem>?
          : this.arrayWithAllOfItems,
      unionWithAllOfOption: !identical(unionWithAllOfOption, _undefined)
          ? unionWithAllOfOption as TestRootUnionWithAllOfOption?
          : this.unionWithAllOfOption,
      patternPropsField: !identical(patternPropsField, _undefined)
          ? patternPropsField as PatternPropertiesObject?
          : this.patternPropsField,
      overlappingUnion: !identical(overlappingUnion, _undefined)
          ? overlappingUnion as OverlappingUnion?
          : this.overlappingUnion,
      deprecatedFieldWithMessage:
          !identical(deprecatedFieldWithMessage, _undefined)
          ? deprecatedFieldWithMessage as String?
          : this.deprecatedFieldWithMessage,
      customNamedObject: !identical(customNamedObject, _undefined)
          ? customNamedObject as MyCustomClassName?
          : this.customNamedObject,
      customNamedUnion: !identical(customNamedUnion, _undefined)
          ? customNamedUnion as MyCustomUnionName?
          : this.customNamedUnion,
      customNamedEnum: !identical(customNamedEnum, _undefined)
          ? customNamedEnum as MyCustomEnumName?
          : this.customNamedEnum,
      coverageTrigger: !identical(coverageTrigger, _undefined)
          ? coverageTrigger as TestRootCoverageTrigger?
          : this.coverageTrigger,
      collidingEnumField: !identical(collidingEnumField, _undefined)
          ? collidingEnumField as CollidingEnum?
          : this.collidingEnumField,
      collidingObjectField: !identical(collidingObjectField, _undefined)
          ? collidingObjectField as CollidingObject?
          : this.collidingObjectField,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_deprecated = deprecated;
    final val_idField = idField;
    final val_unionWithObjectAndBoolean = unionWithObjectAndBoolean;
    final val_recursiveNodeField = recursiveNodeField;
    if (val_recursiveNodeField != null) {
      errors.addAll(
        (val_recursiveNodeField as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['recursiveNodeField', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    if (name.runes.length < 2) {
      errors.add(
        ValidationError(
          message: 'Property "name" length must be >= 2',
          path: ['name'],
          keyword: 'minLength',
        ),
      );
    }
    final val_constValue = constValue;
    if (val_constValue != null) {
      if (!const ['always-this-value'].any(
        (v) => const DeepCollectionEquality().equals(
          v,
          val_constValue is Enum
              ? (val_constValue as dynamic).value
              : val_constValue,
        ),
      )) {
        errors.add(
          ValidationError(
            message: 'Property "constValue" must be one of [always-this-value]',
            path: ['constValue'],
            keyword: 'enum',
          ),
        );
      }
    }
    if (age < 0) {
      errors.add(
        ValidationError(
          message: 'Property "age" must be >= 0',
          path: ['age'],
          keyword: 'minimum',
        ),
      );
    }
    if (age % 5 != 0) {
      errors.add(
        ValidationError(
          message: 'Property "age" must be a multiple of 5',
          path: ['age'],
          keyword: 'multipleOf',
        ),
      );
    }
    final val_exclusiveAge = exclusiveAge;
    if (val_exclusiveAge != null) {
      if (val_exclusiveAge <= 0) {
        errors.add(
          ValidationError(
            message: 'Property "exclusiveAge" must be > 0',
            path: ['exclusiveAge'],
            keyword: 'exclusiveMinimum',
          ),
        );
      }
      if (val_exclusiveAge >= 100) {
        errors.add(
          ValidationError(
            message: 'Property "exclusiveAge" must be < 100',
            path: ['exclusiveAge'],
            keyword: 'exclusiveMaximum',
          ),
        );
      }
    }
    final val_height = height;
    final val_email = email;
    if (val_email != null) {
      if (!RegExp('^[a-zA-Z0-9.]+@[a-zA-Z0-9.]+\$').hasMatch(val_email)) {
        errors.add(
          ValidationError(
            message:
                'Property "email" must match pattern "^[a-zA-Z0-9.]+@[a-zA-Z0-9.]+\$"',
            path: ['email'],
            keyword: 'pattern',
          ),
        );
      }
    }
    final val_uuid = uuid;
    if (val_uuid != null) {
      if (!(RegExp(
        r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
      ).hasMatch(val_uuid))) {
        errors.add(
          ValidationError(
            message: 'Property "uuid" must be a valid UUID',
            path: ['uuid'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_class_ = class_;
    final val_reader = reader;
    final val_stack = stack;
    final val_validate_ = validate_;
    final val_result = result;
    errors.addAll(
      (address as JsonModel).collectErrors().map(
        (ValidationError e) => ValidationError(
          message: e.message,
          path: ['address', ...e.path],
          keyword: e.keyword,
          schema: e.schema,
          value: e.value,
          nestedErrors: e.nestedErrors,
        ),
      ),
    );
    final val_tags = tags;
    if (val_tags != null) {
      if (val_tags.length < 1) {
        errors.add(
          ValidationError(
            message: 'Property "tags" must have >= 1 items',
            path: ['tags'],
            keyword: 'minItems',
          ),
        );
      }
      if (val_tags.length !=
          (LinkedHashSet<dynamic>(
            equals: const DeepCollectionEquality().equals,
            hashCode: const DeepCollectionEquality().hash,
          )..addAll(val_tags)).length) {
        errors.add(
          ValidationError(
            message: 'Property "tags" items must be unique',
            path: ['tags'],
            keyword: 'uniqueItems',
          ),
        );
      }
    }
    final val_scores = scores;
    if (val_scores != null) {
      for (var i = 0; i < val_scores.length; i++) {
        errors.addAll(
          (val_scores[i] as JsonModel).collectErrors().map(
            (ValidationError e) => ValidationError(
              message: e.message,
              path: ['scores', '[$i]', ...e.path],
              keyword: e.keyword,
              schema: e.schema,
              value: e.value,
              nestedErrors: e.nestedErrors,
            ),
          ),
        );
      }
    }
    final val_unionValue = unionValue;
    if (val_unionValue != null) {
      errors.addAll(
        (val_unionValue as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['unionValue', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_nullableUnionValue = nullableUnionValue;
    if (val_nullableUnionValue != null) {
      errors.addAll(
        (val_nullableUnionValue as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['nullableUnionValue', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_requiredNullableUnionObject = requiredNullableUnionObject;
    if (val_requiredNullableUnionObject != null) {
      errors.addAll(
        (val_requiredNullableUnionObject as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['requiredNullableUnionObject', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_nullableString = nullableString;
    final val_pet = pet;
    if (val_pet != null) {
      errors.addAll(
        (val_pet as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['pet', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_restrictedObject = restrictedObject;
    if (val_restrictedObject != null) {
      errors.addAll(
        (val_restrictedObject as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['restrictedObject', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_dependentObject = dependentObject;
    if (val_dependentObject != null) {
      errors.addAll(
        (val_dependentObject as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['dependentObject', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_primitiveArrayWithValidation = primitiveArrayWithValidation;
    if (val_primitiveArrayWithValidation != null) {
      for (var i = 0; i < val_primitiveArrayWithValidation.length; i++) {
        if (val_primitiveArrayWithValidation[i] is! String) {
          errors.add(
            ValidationError(
              message:
                  'Property "primitiveArrayWithValidation" must be a string',
              path: ['primitiveArrayWithValidation', '[$i]'],
              keyword: 'type',
            ),
          );
        } else {
          if (val_primitiveArrayWithValidation[i].runes.length < 3) {
            errors.add(
              ValidationError(
                message:
                    'Property "primitiveArrayWithValidation" length must be >= 3',
                path: ['primitiveArrayWithValidation', '[$i]'],
                keyword: 'minLength',
              ),
            );
          }
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
        errors.add(
          ValidationError(
            message:
                'Property "restrictedArray" must contain at least 1 items matching contains schema, but has $containsCount',
            path: ['restrictedArray'],
            keyword: 'minContains',
          ),
        );
      }
      if (containsCount > 2) {
        errors.add(
          ValidationError(
            message:
                'Property "restrictedArray" must contain at most 2 items matching contains schema, but has $containsCount',
            path: ['restrictedArray'],
            keyword: 'maxContains',
          ),
        );
      }
    }
    final val_deprecatedField = deprecatedField;
    final val_deprecatedRef = deprecatedRef;
    if (val_deprecatedRef != null) {
      errors.addAll(
        (val_deprecatedRef as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['deprecatedRef', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_nestedArray = nestedArray;
    if (val_nestedArray != null) {
      for (var i = 0; i < val_nestedArray.length; i++) {
        for (var i0 = 0; i0 < val_nestedArray[i].length; i0++) {
          final item0 = val_nestedArray[i][i0];
          errors.addAll(
            (item0 as JsonModel).collectErrors().map(
              (ValidationError e) => ValidationError(
                message: e.message,
                path: ['nestedArray', '[$i]', '[$i0]', ...e.path],
                keyword: e.keyword,
                schema: e.schema,
                value: e.value,
                nestedErrors: e.nestedErrors,
              ),
            ),
          );
        }
      }
    }
    final val_singleQuoteKey = singleQuoteKey;
    final val_mixedEnum = mixedEnum;
    errors.addAll(
      (defaultObject as JsonModel).collectErrors().map(
        (ValidationError e) => ValidationError(
          message: e.message,
          path: ['defaultObject', ...e.path],
          keyword: e.keyword,
          schema: e.schema,
          value: e.value,
          nestedErrors: e.nestedErrors,
        ),
      ),
    );
    final val_defaultNullableString = defaultNullableString;
    final val_mergedValue = mergedValue;
    if (val_mergedValue != null) {
      errors.addAll(
        (val_mergedValue as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['mergedValue', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_tupleArray = tupleArray;
    final val_tupleObjectArray = tupleObjectArray;
    if (val_tupleObjectArray != null) {
      if (val_tupleObjectArray.length > 0) {
        errors.addAll(
          (val_tupleObjectArray[0] as JsonModel).collectErrors().map(
            (ValidationError e) => ValidationError(
              message: e.message,
              path: ['tupleObjectArray', '[0]', ...e.path],
              keyword: e.keyword,
              schema: e.schema,
              value: e.value,
              nestedErrors: e.nestedErrors,
            ),
          ),
        );
      }
      if (val_tupleObjectArray.length > 1) {
        errors.addAll(
          (val_tupleObjectArray[1] as JsonModel).collectErrors().map(
            (ValidationError e) => ValidationError(
              message: e.message,
              path: ['tupleObjectArray', '[1]', ...e.path],
              keyword: e.keyword,
              schema: e.schema,
              value: e.value,
              nestedErrors: e.nestedErrors,
            ),
          ),
        );
      }
    }
    final val_ipv6Value = ipv6Value;
    if (val_ipv6Value != null) {
      if (!(isValidIPv6(val_ipv6Value))) {
        errors.add(
          ValidationError(
            message: 'Property "ipv6Value" must be a valid IPv6 address',
            path: ['ipv6Value'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_hostnameValue = hostnameValue;
    if (val_hostnameValue != null) {
      if (!(isValidHostname(val_hostnameValue))) {
        errors.add(
          ValidationError(
            message: 'Property "hostnameValue" must be a valid hostname',
            path: ['hostnameValue'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_timeValue = timeValue;
    if (val_timeValue != null) {
      if (!(isValidTime(val_timeValue))) {
        errors.add(
          ValidationError(
            message: 'Property "timeValue" must be a valid time string',
            path: ['timeValue'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_uriReferenceValue = uriReferenceValue;
    if (val_uriReferenceValue != null) {
      if (!(isValidUriReference(val_uriReferenceValue))) {
        errors.add(
          ValidationError(
            message:
                'Property "uriReferenceValue" must be a valid URI reference',
            path: ['uriReferenceValue'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_additionalPropertiesObject = additionalPropertiesObject;
    if (val_additionalPropertiesObject != null) {
      errors.addAll(
        (val_additionalPropertiesObject as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['additionalPropertiesObject', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_strictObject = strictObject;
    if (val_strictObject != null) {
      errors.addAll(
        (val_strictObject as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['strictObject', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_notObject = notObject;
    if (val_notObject != null) {
      errors.addAll(
        (val_notObject as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['notObject', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_anyOfValue = anyOfValue;
    if (val_anyOfValue != null) {
      errors.addAll(
        (val_anyOfValue as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['anyOfValue', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_mergedAllOfObject = mergedAllOfObject;
    if (val_mergedAllOfObject != null) {
      errors.addAll(
        (val_mergedAllOfObject as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['mergedAllOfObject', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_complexMerged = complexMerged;
    if (val_complexMerged != null) {
      errors.addAll(
        (val_complexMerged as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['complexMerged', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_myEnumField = myEnumField;
    final val_unionContainsArray = unionContainsArray;
    if (val_unionContainsArray != null) {
      var containsCount = 0;
      for (final dynamic item in val_unionContainsArray) {
        bool matches = false;
        if (item is TestRootUnionContainsArrayContains) {
          matches = item.collectErrors().isEmpty;
        } else {
          try {
            final parsed = TestRootUnionContainsArrayContains.fromJson(
              JsonReader.fromObject(item),
            );
            matches = parsed.collectErrors().isEmpty;
          } on JsonValidationException catch (_) {
          } on FormatException catch (_) {}
        }
        if (matches) containsCount++;
      }
      if (containsCount < 1) {
        errors.add(
          ValidationError(
            message:
                'Property "unionContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
            path: ['unionContainsArray'],
            keyword: 'minContains',
          ),
        );
      }
    }
    final val_objectContainsArray = objectContainsArray;
    if (val_objectContainsArray != null) {
      var containsCount = 0;
      for (final dynamic item in val_objectContainsArray) {
        bool matches = false;
        if (item is Address) {
          matches = item.collectErrors().isEmpty;
        } else if (item is Map<String, dynamic>) {
          try {
            final parsed = Address.fromJson(JsonReader.fromObject(item));
            matches = parsed.collectErrors().isEmpty;
          } on JsonValidationException catch (_) {
          } on FormatException catch (_) {}
        }
        if (matches) containsCount++;
      }
      if (containsCount < 1) {
        errors.add(
          ValidationError(
            message:
                'Property "objectContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
            path: ['objectContainsArray'],
            keyword: 'minContains',
          ),
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
            if (item is String) {
              MyEnum.fromValue(item);
              matches = true;
            }
          } on StateError catch (_) {}
        }
        if (matches) containsCount++;
      }
      if (containsCount < 1) {
        errors.add(
          ValidationError(
            message:
                'Property "enumContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
            path: ['enumContainsArray'],
            keyword: 'minContains',
          ),
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
        errors.add(
          ValidationError(
            message:
                'Property "booleanContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
            path: ['booleanContainsArray'],
            keyword: 'minContains',
          ),
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
        errors.add(
          ValidationError(
            message:
                'Property "nullContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
            path: ['nullContainsArray'],
            keyword: 'minContains',
          ),
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
        errors.add(
          ValidationError(
            message:
                'Property "anyContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
            path: ['anyContainsArray'],
            keyword: 'minContains',
          ),
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
          if (item.runes.length < 3) matches = false;
          if (item.runes.length > 10) matches = false;
          if (!RegExp('^a').hasMatch(item)) matches = false;
          if (!(RegExp(r'^[^@]+@[^@]+$').hasMatch(item))) matches = false;
        }
        if (matches) containsCount++;
      }
      if (containsCount < 1) {
        errors.add(
          ValidationError(
            message:
                'Property "stringContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
            path: ['stringContainsArray'],
            keyword: 'minContains',
          ),
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
        errors.add(
          ValidationError(
            message:
                'Property "numberContainsArray" must contain at least 1 items matching contains schema, but has $containsCount',
            path: ['numberContainsArray'],
            keyword: 'minContains',
          ),
        );
      }
    }
    final val_dynamicProps = dynamicProps;
    if (val_dynamicProps != null) {
      errors.addAll(
        (val_dynamicProps as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['dynamicProps', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_dateTimeField = dateTimeField;
    if (val_dateTimeField != null) {
      if (DateTime.tryParse(val_dateTimeField) == null) {
        errors.add(
          ValidationError(
            message:
                'Property "dateTimeField" must be a valid RFC 3339 date-time string',
            path: ['dateTimeField'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_dateField = dateField;
    if (val_dateField != null) {
      if (!(RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(val_dateField))) {
        errors.add(
          ValidationError(
            message:
                'Property "dateField" must be a valid date string (YYYY-MM-DD)',
            path: ['dateField'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_ipv4Field = ipv4Field;
    if (val_ipv4Field != null) {
      if (!(RegExp(
        r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
      ).hasMatch(val_ipv4Field))) {
        errors.add(
          ValidationError(
            message: 'Property "ipv4Field" must be a valid IPv4 address',
            path: ['ipv4Field'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_uriField = uriField;
    if (val_uriField != null) {
      if (!(isValidUri(val_uriField))) {
        errors.add(
          ValidationError(
            message: 'Property "uriField" must be a valid absolute URI',
            path: ['uriField'],
            keyword: 'format',
          ),
        );
      }
    }
    errors.addAll(
      (defaultEmptyObject as JsonModel).collectErrors().map(
        (ValidationError e) => ValidationError(
          message: e.message,
          path: ['defaultEmptyObject', ...e.path],
          keyword: e.keyword,
          schema: e.schema,
          value: e.value,
          nestedErrors: e.nestedErrors,
        ),
      ),
    );
    final val_unionWithArrayOption = unionWithArrayOption;
    if (val_unionWithArrayOption != null) {
      errors.addAll(
        (val_unionWithArrayOption as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['unionWithArrayOption', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_impossibleField = impossibleField;
    if (val_impossibleField != null) {
      errors.add(
        ValidationError(
          message: 'Property "impossibleField" matches nothing',
          path: ['impossibleField'],
          keyword: 'false',
        ),
      );
    }
    final val_tupleSameTypeArray = tupleSameTypeArray;
    if (val_tupleSameTypeArray != null) {
      if (val_tupleSameTypeArray.length > 0) {
        if (val_tupleSameTypeArray[0] is! String) {
          errors.add(
            ValidationError(
              message: 'Property "tupleSameTypeArray" must be a string',
              path: ['tupleSameTypeArray', '[0]'],
              keyword: 'type',
            ),
          );
        } else {
          if (val_tupleSameTypeArray[0].runes.length < 1) {
            errors.add(
              ValidationError(
                message: 'Property "tupleSameTypeArray" length must be >= 1',
                path: ['tupleSameTypeArray', '[0]'],
                keyword: 'minLength',
              ),
            );
          }
        }
      }
      if (val_tupleSameTypeArray.length > 1) {
        if (val_tupleSameTypeArray[1] is! String) {
          errors.add(
            ValidationError(
              message: 'Property "tupleSameTypeArray" must be a string',
              path: ['tupleSameTypeArray', '[1]'],
              keyword: 'type',
            ),
          );
        } else {
          if (val_tupleSameTypeArray[1].runes.length > 5) {
            errors.add(
              ValidationError(
                message: 'Property "tupleSameTypeArray" length must be <= 5',
                path: ['tupleSameTypeArray', '[1]'],
                keyword: 'maxLength',
              ),
            );
          }
        }
      }
    }
    final val_arrayWithAllOfItems = arrayWithAllOfItems;
    if (val_arrayWithAllOfItems != null) {
      for (var i = 0; i < val_arrayWithAllOfItems.length; i++) {
        errors.addAll(
          (val_arrayWithAllOfItems[i] as JsonModel).collectErrors().map(
            (ValidationError e) => ValidationError(
              message: e.message,
              path: ['arrayWithAllOfItems', '[$i]', ...e.path],
              keyword: e.keyword,
              schema: e.schema,
              value: e.value,
              nestedErrors: e.nestedErrors,
            ),
          ),
        );
      }
    }
    final val_unionWithAllOfOption = unionWithAllOfOption;
    if (val_unionWithAllOfOption != null) {
      errors.addAll(
        (val_unionWithAllOfOption as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['unionWithAllOfOption', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_patternPropsField = patternPropsField;
    if (val_patternPropsField != null) {
      errors.addAll(
        (val_patternPropsField as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['patternPropsField', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_overlappingUnion = overlappingUnion;
    if (val_overlappingUnion != null) {
      errors.addAll(
        (val_overlappingUnion as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['overlappingUnion', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_deprecatedFieldWithMessage = deprecatedFieldWithMessage;
    final val_customNamedObject = customNamedObject;
    if (val_customNamedObject != null) {
      errors.addAll(
        (val_customNamedObject as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['customNamedObject', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_customNamedUnion = customNamedUnion;
    if (val_customNamedUnion != null) {
      errors.addAll(
        (val_customNamedUnion as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['customNamedUnion', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_customNamedEnum = customNamedEnum;
    final val_coverageTrigger = coverageTrigger;
    if (val_coverageTrigger != null) {
      errors.addAll(
        (val_coverageTrigger as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['coverageTrigger', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_collidingEnumField = collidingEnumField;
    if (val_collidingEnumField != null) {
      if (!const [
        'values',
        'value',
        'fromValue',
        'descriptor',
        'foo-bar',
        'foo_bar',
        null,
        null,
      ].any(
        (v) => const DeepCollectionEquality().equals(
          v,
          val_collidingEnumField is Enum
              ? (val_collidingEnumField as dynamic).value
              : val_collidingEnumField,
        ),
      )) {
        errors.add(
          ValidationError(
            message:
                'Property "collidingEnumField" must be one of [values, value, fromValue, descriptor, foo-bar, foo_bar, {a: 1}, {a: 1}]',
            path: ['collidingEnumField'],
            keyword: 'enum',
          ),
        );
      }
    }
    final val_collidingObjectField = collidingObjectField;
    if (val_collidingObjectField != null) {
      errors.addAll(
        (val_collidingObjectField as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['collidingObjectField', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
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

  static final ObjectDescriptor<TestRoot>
  descriptor = ObjectDescriptor<TestRoot>(
    title: 'TestRoot',
    matches: (instance) => instance is TestRoot,
    instantiate: (fields) => TestRoot(
      deprecated: fields['deprecated'] as String?,
      idField: fields['\$idField'] as String?,
      unionWithObjectAndBoolean:
          fields['unionWithObjectAndBoolean']
              as TestRootUnionWithObjectAndBoolean?,
      recursiveNodeField: fields['recursiveNodeField'] as RecursiveNode?,
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
      patternPropsField:
          fields['patternPropsField'] as PatternPropertiesObject?,
      overlappingUnion: fields['overlappingUnion'] as OverlappingUnion?,
      deprecatedFieldWithMessage:
          fields['deprecatedFieldWithMessage'] as String?,
      customNamedObject: fields['customNamedObject'] as MyCustomClassName?,
      customNamedUnion: fields['customNamedUnion'] as MyCustomUnionName?,
      customNamedEnum: fields['customNamedEnum'] as MyCustomEnumName?,
      coverageTrigger: fields['coverageTrigger'] as TestRootCoverageTrigger?,
      collidingEnumField: fields['collidingEnumField'] as CollidingEnum?,
      collidingObjectField: fields['collidingObjectField'] as CollidingObject?,
      additionalProperties: fields.entries
          .where(
            (e) =>
                !const <String>{
                  'deprecated',
                  '\$idField',
                  'unionWithObjectAndBoolean',
                  'recursiveNodeField',
                  'name',
                  'constValue',
                  'age',
                  'exclusiveAge',
                  'height',
                  'email',
                  'uuid',
                  'isAwesome',
                  'class',
                  'reader',
                  'stack',
                  'validate',
                  'result',
                  'address',
                  'tags',
                  'scores',
                  'unionValue',
                  'nullableUnionValue',
                  'requiredNullableUnionObject',
                  'nullableString',
                  'pet',
                  'restrictedObject',
                  'dependentObject',
                  'primitiveArrayWithValidation',
                  'restrictedArray',
                  'deprecatedField',
                  'deprecatedRef',
                  'defaultString',
                  'defaultBackslash',
                  'nestedArray',
                  'single\'quote\'key',
                  'mixedEnum',
                  'defaultInt',
                  'defaultBool',
                  'defaultList',
                  'defaultObject',
                  'defaultNullableString',
                  'mergedValue',
                  'tupleArray',
                  'tupleObjectArray',
                  'ipv6Value',
                  'hostnameValue',
                  'timeValue',
                  'uriReferenceValue',
                  'additionalPropertiesObject',
                  'strictObject',
                  'notObject',
                  'anyOfValue',
                  'mergedAllOfObject',
                  'complexMerged',
                  'myEnumField',
                  'unionContainsArray',
                  'objectContainsArray',
                  'enumContainsArray',
                  'booleanContainsArray',
                  'nullContainsArray',
                  'anyContainsArray',
                  'stringContainsArray',
                  'numberContainsArray',
                  'dynamicProps',
                  'dateTimeField',
                  'dateField',
                  'ipv4Field',
                  'uriField',
                  'defaultEmptyList',
                  'defaultEmptyObject',
                  'unionWithArrayOption',
                  'impossibleField',
                  'tupleSameTypeArray',
                  'arrayWithAllOfItems',
                  'unionWithAllOfOption',
                  'patternPropsField',
                  'overlappingUnion',
                  'deprecatedFieldWithMessage',
                  'customNamedObject',
                  'customNamedUnion',
                  'customNamedEnum',
                  'coverageTrigger',
                  'collidingEnumField',
                  'collidingObjectField',
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
      final typedInstance = instance as TestRoot;
      final map = <String, dynamic>{
        'deprecated': typedInstance.deprecated,
        '\$idField': typedInstance.idField,
        'unionWithObjectAndBoolean': typedInstance.unionWithObjectAndBoolean,
        'recursiveNodeField': typedInstance.recursiveNodeField,
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
        'patternPropsField': typedInstance.patternPropsField,
        'overlappingUnion': typedInstance.overlappingUnion,
        'deprecatedFieldWithMessage': typedInstance.deprecatedFieldWithMessage,
        'customNamedObject': typedInstance.customNamedObject,
        'customNamedUnion': typedInstance.customNamedUnion,
        'customNamedEnum': typedInstance.customNamedEnum,
        'coverageTrigger': typedInstance.coverageTrigger,
        'collidingEnumField': typedInstance.collidingEnumField,
        'collidingObjectField': typedInstance.collidingObjectField,
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
      'deprecated': PropertyDescriptor(
        name: 'deprecated',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      '\$idField': PropertyDescriptor(
        name: '\$idField',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'unionWithObjectAndBoolean': PropertyDescriptor(
        name: 'unionWithObjectAndBoolean',
        isRequired: false,
        schema: RefDescriptor<TestRootUnionWithObjectAndBoolean>(
          () => TestRootUnionWithObjectAndBoolean.descriptor,
        ),
      ),
      'recursiveNodeField': PropertyDescriptor(
        name: 'recursiveNodeField',
        isRequired: false,
        schema: RefDescriptor<RecursiveNode>(() => RecursiveNode.descriptor),
      ),
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
        schema: RefDescriptor<Address>(() => Address.descriptor),
      ),
      'tags': PropertyDescriptor(
        name: 'tags',
        isRequired: false,
        schema: ArrayDescriptor<String>(const StringDescriptor()),
      ),
      'scores': PropertyDescriptor(
        name: 'scores',
        isRequired: false,
        schema: ArrayDescriptor<Score>(
          RefDescriptor<Score>(() => Score.descriptor),
        ),
      ),
      'unionValue': PropertyDescriptor(
        name: 'unionValue',
        isRequired: false,
        schema: RefDescriptor<TestRootUnionValue>(
          () => TestRootUnionValue.descriptor,
        ),
      ),
      'nullableUnionValue': PropertyDescriptor(
        name: 'nullableUnionValue',
        isRequired: false,
        schema: NullableDescriptor(
          RefDescriptor<TestRootNullableUnionValue>(
            () => TestRootNullableUnionValue.descriptor,
          ),
        ),
      ),
      'requiredNullableUnionObject': PropertyDescriptor(
        name: 'requiredNullableUnionObject',
        isRequired: false,
        schema: RefDescriptor<RequiredNullableUnionObject>(
          () => RequiredNullableUnionObject.descriptor,
        ),
      ),
      'nullableString': PropertyDescriptor(
        name: 'nullableString',
        isRequired: false,
        schema: NullableDescriptor(const StringDescriptor()),
      ),
      'pet': PropertyDescriptor(
        name: 'pet',
        isRequired: false,
        schema: RefDescriptor<Pet>(() => Pet.descriptor),
      ),
      'restrictedObject': PropertyDescriptor(
        name: 'restrictedObject',
        isRequired: false,
        schema: RefDescriptor<RestrictedObject>(
          () => RestrictedObject.descriptor,
        ),
      ),
      'dependentObject': PropertyDescriptor(
        name: 'dependentObject',
        isRequired: false,
        schema: RefDescriptor<DependentObject>(
          () => DependentObject.descriptor,
        ),
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
        schema: RefDescriptor<DeprecatedObject>(
          () => DeprecatedObject.descriptor,
        ),
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
          ArrayDescriptor<Address>(
            RefDescriptor<Address>(() => Address.descriptor),
          ),
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
        schema: RefDescriptor<TestRootMixedEnum>(
          () => TestRootMixedEnum.descriptor,
        ),
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
        schema: RefDescriptor<Address>(() => Address.descriptor),
      ),
      'defaultNullableString': PropertyDescriptor(
        name: 'defaultNullableString',
        isRequired: false,
        schema: NullableDescriptor(const StringDescriptor()),
      ),
      'mergedValue': PropertyDescriptor(
        name: 'mergedValue',
        isRequired: false,
        schema: RefDescriptor<Merged>(() => Merged.descriptor),
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
          prefixItems: [
            RefDescriptor<Address>(() => Address.descriptor),
            RefDescriptor<Cat>(() => Cat.descriptor),
          ],
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
        schema: RefDescriptor<MapObject>(() => MapObject.descriptor),
      ),
      'strictObject': PropertyDescriptor(
        name: 'strictObject',
        isRequired: false,
        schema: RefDescriptor<StrictObject>(() => StrictObject.descriptor),
      ),
      'notObject': PropertyDescriptor(
        name: 'notObject',
        isRequired: false,
        schema: RefDescriptor<NotObject>(() => NotObject.descriptor),
      ),
      'anyOfValue': PropertyDescriptor(
        name: 'anyOfValue',
        isRequired: false,
        schema: RefDescriptor<TestRootAnyOfValue>(
          () => TestRootAnyOfValue.descriptor,
        ),
      ),
      'mergedAllOfObject': PropertyDescriptor(
        name: 'mergedAllOfObject',
        isRequired: false,
        schema: RefDescriptor<MergedAllOfObject>(
          () => MergedAllOfObject.descriptor,
        ),
      ),
      'complexMerged': PropertyDescriptor(
        name: 'complexMerged',
        isRequired: false,
        schema: RefDescriptor<ComplexMergedObject>(
          () => ComplexMergedObject.descriptor,
        ),
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
        schema: RefDescriptor<ObjectWithDynamicProps>(
          () => ObjectWithDynamicProps.descriptor,
        ),
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
        schema: RefDescriptor<MapObject>(() => MapObject.descriptor),
      ),
      'unionWithArrayOption': PropertyDescriptor(
        name: 'unionWithArrayOption',
        isRequired: false,
        schema: RefDescriptor<TestRootUnionWithArrayOption>(
          () => TestRootUnionWithArrayOption.descriptor,
        ),
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
          RefDescriptor<TestRootArrayWithAllOfItemsItem>(
            () => TestRootArrayWithAllOfItemsItem.descriptor,
          ),
        ),
      ),
      'unionWithAllOfOption': PropertyDescriptor(
        name: 'unionWithAllOfOption',
        isRequired: false,
        schema: RefDescriptor<TestRootUnionWithAllOfOption>(
          () => TestRootUnionWithAllOfOption.descriptor,
        ),
      ),
      'patternPropsField': PropertyDescriptor(
        name: 'patternPropsField',
        isRequired: false,
        schema: RefDescriptor<PatternPropertiesObject>(
          () => PatternPropertiesObject.descriptor,
        ),
      ),
      'overlappingUnion': PropertyDescriptor(
        name: 'overlappingUnion',
        isRequired: false,
        schema: RefDescriptor<OverlappingUnion>(
          () => OverlappingUnion.descriptor,
        ),
      ),
      'deprecatedFieldWithMessage': PropertyDescriptor(
        name: 'deprecatedFieldWithMessage',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'customNamedObject': PropertyDescriptor(
        name: 'customNamedObject',
        isRequired: false,
        schema: RefDescriptor<MyCustomClassName>(
          () => MyCustomClassName.descriptor,
        ),
      ),
      'customNamedUnion': PropertyDescriptor(
        name: 'customNamedUnion',
        isRequired: false,
        schema: RefDescriptor<MyCustomUnionName>(
          () => MyCustomUnionName.descriptor,
        ),
      ),
      'customNamedEnum': PropertyDescriptor(
        name: 'customNamedEnum',
        isRequired: false,
        schema: MyCustomEnumName.descriptor,
      ),
      'coverageTrigger': PropertyDescriptor(
        name: 'coverageTrigger',
        isRequired: false,
        schema: RefDescriptor<TestRootCoverageTrigger>(
          () => TestRootCoverageTrigger.descriptor,
        ),
      ),
      'collidingEnumField': PropertyDescriptor(
        name: 'collidingEnumField',
        isRequired: false,
        schema: CollidingEnum.descriptor,
      ),
      'collidingObjectField': PropertyDescriptor(
        name: 'collidingObjectField',
        isRequired: false,
        schema: RefDescriptor<CollidingObject>(
          () => CollidingObject.descriptor,
        ),
      ),
    },

    required: const ['name', 'age', 'isAwesome', 'address'],
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRoot &&
          runtimeType == other.runtimeType &&
          deprecated == other.deprecated &&
          idField == other.idField &&
          unionWithObjectAndBoolean == other.unionWithObjectAndBoolean &&
          recursiveNodeField == other.recursiveNodeField &&
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
          patternPropsField == other.patternPropsField &&
          overlappingUnion == other.overlappingUnion &&
          deprecatedFieldWithMessage == other.deprecatedFieldWithMessage &&
          customNamedObject == other.customNamedObject &&
          customNamedUnion == other.customNamedUnion &&
          customNamedEnum == other.customNamedEnum &&
          coverageTrigger == other.coverageTrigger &&
          collidingEnumField == other.collidingEnumField &&
          collidingObjectField == other.collidingObjectField &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    deprecated,
    idField,
    unionWithObjectAndBoolean,
    recursiveNodeField,
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
    patternPropsField,
    overlappingUnion,
    deprecatedFieldWithMessage,
    customNamedObject,
    customNamedUnion,
    customNamedEnum,
    coverageTrigger,
    collidingEnumField,
    collidingObjectField,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'TestRoot(deprecated: ${deprecated}, idField: ${idField}, unionWithObjectAndBoolean: ${unionWithObjectAndBoolean}, recursiveNodeField: ${recursiveNodeField}, name: ${name}, constValue: ${constValue}, age: ${age}, exclusiveAge: ${exclusiveAge}, height: ${height}, email: ${email}, uuid: ${uuid}, isAwesome: ${isAwesome}, class_: ${class_}, reader: ${reader}, stack: ${stack}, validate_: ${validate_}, result: ${result}, address: ${address}, tags: ${tags}, scores: ${scores}, unionValue: ${unionValue}, nullableUnionValue: ${nullableUnionValue}, requiredNullableUnionObject: ${requiredNullableUnionObject}, nullableString: ${nullableString}, pet: ${pet}, restrictedObject: ${restrictedObject}, dependentObject: ${dependentObject}, primitiveArrayWithValidation: ${primitiveArrayWithValidation}, restrictedArray: ${restrictedArray}, deprecatedField: ${deprecatedField}, deprecatedRef: ${deprecatedRef}, defaultString: ${defaultString}, defaultBackslash: ${defaultBackslash}, nestedArray: ${nestedArray}, singleQuoteKey: ${singleQuoteKey}, mixedEnum: ${mixedEnum}, defaultInt: ${defaultInt}, defaultBool: ${defaultBool}, defaultList: ${defaultList}, defaultObject: ${defaultObject}, defaultNullableString: ${defaultNullableString}, mergedValue: ${mergedValue}, tupleArray: ${tupleArray}, tupleObjectArray: ${tupleObjectArray}, ipv6Value: ${ipv6Value}, hostnameValue: ${hostnameValue}, timeValue: ${timeValue}, uriReferenceValue: ${uriReferenceValue}, additionalPropertiesObject: ${additionalPropertiesObject}, strictObject: ${strictObject}, notObject: ${notObject}, anyOfValue: ${anyOfValue}, mergedAllOfObject: ${mergedAllOfObject}, complexMerged: ${complexMerged}, myEnumField: ${myEnumField}, unionContainsArray: ${unionContainsArray}, objectContainsArray: ${objectContainsArray}, enumContainsArray: ${enumContainsArray}, booleanContainsArray: ${booleanContainsArray}, nullContainsArray: ${nullContainsArray}, anyContainsArray: ${anyContainsArray}, stringContainsArray: ${stringContainsArray}, numberContainsArray: ${numberContainsArray}, dynamicProps: ${dynamicProps}, dateTimeField: ${dateTimeField}, dateField: ${dateField}, ipv4Field: ${ipv4Field}, uriField: ${uriField}, defaultEmptyList: ${defaultEmptyList}, defaultEmptyObject: ${defaultEmptyObject}, unionWithArrayOption: ${unionWithArrayOption}, impossibleField: ${impossibleField}, tupleSameTypeArray: ${tupleSameTypeArray}, arrayWithAllOfItems: ${arrayWithAllOfItems}, unionWithAllOfOption: ${unionWithAllOfOption}, patternPropsField: ${patternPropsField}, overlappingUnion: ${overlappingUnion}, deprecatedFieldWithMessage: ${deprecatedFieldWithMessage}, customNamedObject: ${customNamedObject}, customNamedUnion: ${customNamedUnion}, customNamedEnum: ${customNamedEnum}, coverageTrigger: ${coverageTrigger}, collidingEnumField: ${collidingEnumField}, collidingObjectField: ${collidingObjectField}, additionalProperties: ${additionalProperties})';
}

sealed class TestRootUnionWithObjectAndBoolean implements JsonModel {
  const TestRootUnionWithObjectAndBoolean();

  factory TestRootUnionWithObjectAndBoolean.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootUnionWithObjectAndBoolean;

  /// Creates an instance of [TestRootUnionWithObjectAndBoolean] from a JSON-compatible Dart value.
  factory TestRootUnionWithObjectAndBoolean.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => TestRootUnionWithObjectAndBoolean.fromJson(
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

  static final UnionDescriptor<TestRootUnionWithObjectAndBoolean> descriptor =
      UnionDescriptor<TestRootUnionWithObjectAndBoolean>(
        title: 'TestRootUnionWithObjectAndBoolean',

        activeOptions: [
          UnionOptionDescriptor<
            TestRootUnionWithObjectAndBoolean,
            TestRootUnionWithObjectAndBooleanOptionType0
          >(
            RefDescriptor<TestRootUnionWithObjectAndBooleanOptionType0>(
              () => TestRootUnionWithObjectAndBooleanOptionType0.descriptor,
            ),
            (val) => TestRootUnionWithObjectAndBooleanOption0(
              val as TestRootUnionWithObjectAndBooleanOptionType0,
            ),
          ),
          UnionOptionDescriptor<TestRootUnionWithObjectAndBoolean, bool>(
            const BoolDescriptor(),
            (val) => TestRootUnionWithObjectAndBooleanOption1(val as bool),
          ),
        ],
      );
}

final class TestRootUnionWithObjectAndBooleanOption0
    extends TestRootUnionWithObjectAndBoolean {
  final TestRootUnionWithObjectAndBooleanOptionType0 value;
  const TestRootUnionWithObjectAndBooleanOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(
      target,
      value,
      RefDescriptor<TestRootUnionWithObjectAndBooleanOptionType0>(
        () => TestRootUnionWithObjectAndBooleanOptionType0.descriptor,
      ),
    );
  }

  @override
  List<ValidationError> collectErrors() => value.collectErrors();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootUnionWithObjectAndBooleanOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      'TestRootUnionWithObjectAndBooleanOption0(value: $value)';
}

final class TestRootUnionWithObjectAndBooleanOption1
    extends TestRootUnionWithObjectAndBoolean {
  final bool value;
  const TestRootUnionWithObjectAndBooleanOption1(this.value);

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
      other is TestRootUnionWithObjectAndBooleanOption1 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      'TestRootUnionWithObjectAndBooleanOption1(value: $value)';
}

final class TestRootUnionWithObjectAndBooleanOptionType0 implements JsonModel {
  final String? foo;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const TestRootUnionWithObjectAndBooleanOptionType0({
    this.foo,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory TestRootUnionWithObjectAndBooleanOptionType0.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootUnionWithObjectAndBooleanOptionType0;

  /// Creates an instance of [TestRootUnionWithObjectAndBooleanOptionType0] from a JSON Map.
  factory TestRootUnionWithObjectAndBooleanOptionType0.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => TestRootUnionWithObjectAndBooleanOptionType0.fromJson(
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

  static const Object _undefined = Object();

  TestRootUnionWithObjectAndBooleanOptionType0 copyWith({
    Object? foo = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(foo, _undefined)) {
      nextKeys.add('foo');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return TestRootUnionWithObjectAndBooleanOptionType0(
      foo: !identical(foo, _undefined) ? foo as String? : this.foo,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_foo = foo;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<TestRootUnionWithObjectAndBooleanOptionType0>
  descriptor = ObjectDescriptor<TestRootUnionWithObjectAndBooleanOptionType0>(
    title: 'TestRootUnionWithObjectAndBooleanOptionType0',
    matches: (instance) =>
        instance is TestRootUnionWithObjectAndBooleanOptionType0,
    instantiate: (fields) => TestRootUnionWithObjectAndBooleanOptionType0(
      foo: fields['foo'] as String?,
      additionalProperties: fields.entries
          .where((e) => !const <String>{'foo'}.contains(e.key) && true)
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance =
          instance as TestRootUnionWithObjectAndBooleanOptionType0;
      final map = <String, dynamic>{
        'foo': typedInstance.foo,
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
      'foo': PropertyDescriptor(
        name: 'foo',
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
      other is TestRootUnionWithObjectAndBooleanOptionType0 &&
          runtimeType == other.runtimeType &&
          foo == other.foo &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    foo,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'TestRootUnionWithObjectAndBooleanOptionType0(foo: ${foo}, additionalProperties: ${additionalProperties})';
}

final class RecursiveNode implements JsonModel {
  final String? name;
  final RecursiveNode? parent;
  final List<RecursiveNode>? children;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const RecursiveNode({
    this.name,
    this.parent,
    this.children,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory RecursiveNode.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as RecursiveNode;

  /// Creates an instance of [RecursiveNode] from a JSON Map.
  factory RecursiveNode.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => RecursiveNode.fromJson(JsonReader.fromObject(map), validate: validate);

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

  static const Object _undefined = Object();

  RecursiveNode copyWith({
    Object? name = _undefined,
    Object? parent = _undefined,
    Object? children = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(name, _undefined)) {
      nextKeys.add('name');
    }
    if (!identical(parent, _undefined)) {
      nextKeys.add('parent');
    }
    if (!identical(children, _undefined)) {
      nextKeys.add('children');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return RecursiveNode(
      name: !identical(name, _undefined) ? name as String? : this.name,
      parent: !identical(parent, _undefined)
          ? parent as RecursiveNode?
          : this.parent,
      children: !identical(children, _undefined)
          ? children as List<RecursiveNode>?
          : this.children,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_name = name;
    final val_parent = parent;
    if (val_parent != null) {
      errors.addAll(
        (val_parent as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['parent', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_children = children;
    if (val_children != null) {
      for (var i = 0; i < val_children.length; i++) {
        errors.addAll(
          (val_children[i] as JsonModel).collectErrors().map(
            (ValidationError e) => ValidationError(
              message: e.message,
              path: ['children', '[$i]', ...e.path],
              keyword: e.keyword,
              schema: e.schema,
              value: e.value,
              nestedErrors: e.nestedErrors,
            ),
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

  static final ObjectDescriptor<RecursiveNode>
  descriptor = ObjectDescriptor<RecursiveNode>(
    title: 'RecursiveNode',
    matches: (instance) => instance is RecursiveNode,
    instantiate: (fields) => RecursiveNode(
      name: fields['name'] as String?,
      parent: fields['parent'] as RecursiveNode?,
      children: fields['children'] as List<RecursiveNode>?,
      additionalProperties: fields.entries
          .where(
            (e) =>
                !const <String>{'name', 'parent', 'children'}.contains(e.key) &&
                true,
          )
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = instance as RecursiveNode;
      final map = <String, dynamic>{
        'name': typedInstance.name,
        'parent': typedInstance.parent,
        'children': typedInstance.children,
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
      'name': PropertyDescriptor(
        name: 'name',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'parent': PropertyDescriptor(
        name: 'parent',
        isRequired: false,
        schema: RefDescriptor<RecursiveNode>(() => RecursiveNode.descriptor),
      ),
      'children': PropertyDescriptor(
        name: 'children',
        isRequired: false,
        schema: ArrayDescriptor<RecursiveNode>(
          RefDescriptor<RecursiveNode>(() => RecursiveNode.descriptor),
        ),
      ),
    },

    required: const [],
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecursiveNode &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          parent == other.parent &&
          const DeepCollectionEquality().equals(children, other.children) &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    name,
    parent,
    const DeepCollectionEquality().hash(children),
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'RecursiveNode(name: ${name}, parent: ${parent}, children: ${children}, additionalProperties: ${additionalProperties})';
}

enum TestRootConstValue {
  alwaysThisValue('always-this-value');

  final String value;
  const TestRootConstValue(this.value);
  static TestRootConstValue fromValue(String val) =>
      values.firstWhere((e) => e.value == val);
  static final EnumDescriptor<TestRootConstValue> descriptor =
      EnumDescriptor<TestRootConstValue>(
        values: values,
        fromValue: (val) => fromValue(val as String),
        toValue: (e) => (e as TestRootConstValue).value,
        base: const StringDescriptor(),
      );
}

final class Address implements JsonModel {
  final String city;
  final String? street;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const Address({
    required this.city,
    this.street,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  Address copyWith({
    Object? city = _undefined,
    Object? street = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(city, _undefined)) {
      nextKeys.add('city');
    }
    if (!identical(street, _undefined)) {
      nextKeys.add('street');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return Address(
      city: !identical(city, _undefined) ? city as String : this.city,
      street: !identical(street, _undefined) ? street as String? : this.street,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (city.runes.length < 3) {
      errors.add(
        ValidationError(
          message: 'Property "city" length must be >= 3',
          path: ['city'],
          keyword: 'minLength',
        ),
      );
    }
    final val_street = street;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<Address> descriptor = ObjectDescriptor<Address>(
    title: 'Address',
    matches: (instance) => instance is Address,
    instantiate: (fields) => Address(
      city: fields['city'] as String,
      street: fields['street'] as String?,
      additionalProperties: fields.entries
          .where(
            (e) => !const <String>{'city', 'street'}.contains(e.key) && true,
          )
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = instance as Address;
      final map = <String, dynamic>{
        'city': typedInstance.city,
        'street': typedInstance.street,
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
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          runtimeType == other.runtimeType &&
          city == other.city &&
          street == other.street &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    city,
    street,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'Address(city: ${city}, street: ${street}, additionalProperties: ${additionalProperties})';
}

final class Score implements JsonModel {
  final num value;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const Score({
    required this.value,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  Score copyWith({
    Object? value = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(value, _undefined)) {
      nextKeys.add('value');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return Score(
      value: !identical(value, _undefined) ? value as num : this.value,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (value < 0.0) {
      errors.add(
        ValidationError(
          message: 'Property "value" must be >= 0.0',
          path: ['value'],
          keyword: 'minimum',
        ),
      );
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

  static final ObjectDescriptor<Score> descriptor = ObjectDescriptor<Score>(
    title: 'Score',
    matches: (instance) => instance is Score,
    instantiate: (fields) => Score(
      value: fields['value'] as num,
      additionalProperties: fields.entries
          .where((e) => !const <String>{'value'}.contains(e.key) && true)
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = instance as Score;
      final map = <String, dynamic>{
        'value': typedInstance.value,
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
      'value': PropertyDescriptor(
        name: 'value',
        isRequired: true,
        schema: const NumDescriptor(),
      ),
    },

    required: const ['value'],
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Score &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    value,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'Score(value: ${value}, additionalProperties: ${additionalProperties})';
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

  @override
  List<ValidationError> collectErrors();

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final UnionDescriptor<TestRootUnionValue> descriptor =
      UnionDescriptor<TestRootUnionValue>(
        title: 'TestRootUnionValue',

        activeOptions: [
          UnionOptionDescriptor<TestRootUnionValue, String>(
            const StringDescriptor(),
            (val) => TestRootUnionValueOption0(val as String),
          ),
          UnionOptionDescriptor<TestRootUnionValue, Address>(
            RefDescriptor<Address>(() => Address.descriptor),
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
  List<ValidationError> collectErrors() {
    return const [];
  }

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
    writeWithDescriptor(
      target,
      value,
      RefDescriptor<Address>(() => Address.descriptor),
    );
  }

  @override
  List<ValidationError> collectErrors() => value.collectErrors();

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

  @override
  List<ValidationError> collectErrors();

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final UnionDescriptor<TestRootNullableUnionValue> descriptor =
      UnionDescriptor<TestRootNullableUnionValue>(
        title: 'TestRootNullableUnionValue',

        activeOptions: [
          UnionOptionDescriptor<TestRootNullableUnionValue, String>(
            const StringDescriptor(),
            (val) => TestRootNullableUnionValueOption0(val as String),
          ),
          UnionOptionDescriptor<TestRootNullableUnionValue, Address>(
            RefDescriptor<Address>(() => Address.descriptor),
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
  List<ValidationError> collectErrors() {
    return const [];
  }

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
    writeWithDescriptor(
      target,
      value,
      RefDescriptor<Address>(() => Address.descriptor),
    );
  }

  @override
  List<ValidationError> collectErrors() => value.collectErrors();

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
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const RequiredNullableUnionObject({
    required this.nullableUnion,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  RequiredNullableUnionObject copyWith({
    Object? nullableUnion = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(nullableUnion, _undefined)) {
      nextKeys.add('nullableUnion');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return RequiredNullableUnionObject(
      nullableUnion: !identical(nullableUnion, _undefined)
          ? nullableUnion as RequiredNullableUnionObjectNullableUnion?
          : this.nullableUnion,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_nullableUnion = nullableUnion;
    if (val_nullableUnion != null) {
      errors.addAll(
        (val_nullableUnion as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['nullableUnion', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
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

  static final ObjectDescriptor<RequiredNullableUnionObject> descriptor =
      ObjectDescriptor<RequiredNullableUnionObject>(
        title: 'RequiredNullableUnionObject',
        matches: (instance) => instance is RequiredNullableUnionObject,
        instantiate: (fields) => RequiredNullableUnionObject(
          nullableUnion:
              fields['nullableUnion']
                  as RequiredNullableUnionObjectNullableUnion?,
          additionalProperties: fields.entries
              .where(
                (e) => !const <String>{'nullableUnion'}.contains(e.key) && true,
              )
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as RequiredNullableUnionObject;
          final map = <String, dynamic>{
            'nullableUnion': typedInstance.nullableUnion,
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
          'nullableUnion': PropertyDescriptor(
            name: 'nullableUnion',
            isRequired: true,
            schema: NullableDescriptor(
              RefDescriptor<RequiredNullableUnionObjectNullableUnion>(
                () => RequiredNullableUnionObjectNullableUnion.descriptor,
              ),
            ),
          ),
        },

        required: const ['nullableUnion'],
        additionalProperties: const AnythingDescriptor(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequiredNullableUnionObject &&
          runtimeType == other.runtimeType &&
          nullableUnion == other.nullableUnion &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    nullableUnion,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'RequiredNullableUnionObject(nullableUnion: ${nullableUnion}, additionalProperties: ${additionalProperties})';
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

  @override
  List<ValidationError> collectErrors();

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final UnionDescriptor<RequiredNullableUnionObjectNullableUnion>
  descriptor = UnionDescriptor<RequiredNullableUnionObjectNullableUnion>(
    title: 'RequiredNullableUnionObjectNullableUnion',

    activeOptions: [
      UnionOptionDescriptor<RequiredNullableUnionObjectNullableUnion, String>(
        const StringDescriptor(),
        (val) => RequiredNullableUnionObjectNullableUnionOption0(val as String),
      ),
      UnionOptionDescriptor<RequiredNullableUnionObjectNullableUnion, int>(
        const IntDescriptor(),
        (val) => RequiredNullableUnionObjectNullableUnionOption1(val as int),
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
  List<ValidationError> collectErrors() {
    return const [];
  }

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
  List<ValidationError> collectErrors() {
    return const [];
  }

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

  @override
  List<ValidationError> collectErrors();

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final UnionDescriptor<Pet> descriptor = UnionDescriptor<Pet>(
    title: 'Pet',
    discriminatorProperty: 'kind',
    discriminatorMapping: {
      'cat_type': UnionOptionDescriptor<Pet, Cat>(
        RefDescriptor<Cat>(() => Cat.descriptor),
        (val) => PetOption0(val as Cat),
      ),
      'Cat': UnionOptionDescriptor<Pet, Cat>(
        RefDescriptor<Cat>(() => Cat.descriptor),
        (val) => PetOption0(val as Cat),
      ),
      'PetOption0': UnionOptionDescriptor<Pet, Cat>(
        RefDescriptor<Cat>(() => Cat.descriptor),
        (val) => PetOption0(val as Cat),
      ),
      'dog_type': UnionOptionDescriptor<Pet, Dog>(
        RefDescriptor<Dog>(() => Dog.descriptor),
        (val) => PetOption1(val as Dog),
      ),
      'Dog': UnionOptionDescriptor<Pet, Dog>(
        RefDescriptor<Dog>(() => Dog.descriptor),
        (val) => PetOption1(val as Dog),
      ),
      'PetOption1': UnionOptionDescriptor<Pet, Dog>(
        RefDescriptor<Dog>(() => Dog.descriptor),
        (val) => PetOption1(val as Dog),
      ),
    },
    activeOptions: [
      UnionOptionDescriptor<Pet, Cat>(
        RefDescriptor<Cat>(() => Cat.descriptor),
        (val) => PetOption0(val as Cat),
      ),
      UnionOptionDescriptor<Pet, Dog>(
        RefDescriptor<Dog>(() => Dog.descriptor),
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
    writeWithDescriptor(
      target,
      value,
      RefDescriptor<Cat>(() => Cat.descriptor),
    );
  }

  @override
  List<ValidationError> collectErrors() => value.collectErrors();

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
    writeWithDescriptor(
      target,
      value,
      RefDescriptor<Dog>(() => Dog.descriptor),
    );
  }

  @override
  List<ValidationError> collectErrors() => value.collectErrors();

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
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const Cat({
    required this.kind,
    this.meowVolume,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  Cat copyWith({
    Object? kind = _undefined,
    Object? meowVolume = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(kind, _undefined)) {
      nextKeys.add('kind');
    }
    if (!identical(meowVolume, _undefined)) {
      nextKeys.add('meowVolume');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return Cat(
      kind: !identical(kind, _undefined) ? kind as String : this.kind,
      meowVolume: !identical(meowVolume, _undefined)
          ? meowVolume as num?
          : this.meowVolume,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_meowVolume = meowVolume;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<Cat> descriptor = ObjectDescriptor<Cat>(
    title: 'Cat',
    matches: (instance) => instance is Cat,
    instantiate: (fields) => Cat(
      kind: fields['kind'] as String,
      meowVolume: fields['meowVolume'] as num?,
      additionalProperties: fields.entries
          .where(
            (e) =>
                !const <String>{'kind', 'meowVolume'}.contains(e.key) && true,
          )
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = instance as Cat;
      final map = <String, dynamic>{
        'kind': typedInstance.kind,
        'meowVolume': typedInstance.meowVolume,
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
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cat &&
          runtimeType == other.runtimeType &&
          kind == other.kind &&
          meowVolume == other.meowVolume &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    kind,
    meowVolume,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'Cat(kind: ${kind}, meowVolume: ${meowVolume}, additionalProperties: ${additionalProperties})';
}

final class Dog implements JsonModel {
  final String kind;
  final num? barkVolume;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const Dog({
    required this.kind,
    this.barkVolume,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  Dog copyWith({
    Object? kind = _undefined,
    Object? barkVolume = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(kind, _undefined)) {
      nextKeys.add('kind');
    }
    if (!identical(barkVolume, _undefined)) {
      nextKeys.add('barkVolume');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return Dog(
      kind: !identical(kind, _undefined) ? kind as String : this.kind,
      barkVolume: !identical(barkVolume, _undefined)
          ? barkVolume as num?
          : this.barkVolume,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_barkVolume = barkVolume;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<Dog> descriptor = ObjectDescriptor<Dog>(
    title: 'Dog',
    matches: (instance) => instance is Dog,
    instantiate: (fields) => Dog(
      kind: fields['kind'] as String,
      barkVolume: fields['barkVolume'] as num?,
      additionalProperties: fields.entries
          .where(
            (e) =>
                !const <String>{'kind', 'barkVolume'}.contains(e.key) && true,
          )
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = instance as Dog;
      final map = <String, dynamic>{
        'kind': typedInstance.kind,
        'barkVolume': typedInstance.barkVolume,
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
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dog &&
          runtimeType == other.runtimeType &&
          kind == other.kind &&
          barkVolume == other.barkVolume &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    kind,
    barkVolume,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'Dog(kind: ${kind}, barkVolume: ${barkVolume}, additionalProperties: ${additionalProperties})';
}

final class RestrictedObject implements JsonModel {
  final String? a;
  final String? b;
  final String? c;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const RestrictedObject({
    this.a,
    this.b,
    this.c,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  RestrictedObject copyWith({
    Object? a = _undefined,
    Object? b = _undefined,
    Object? c = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(a, _undefined)) {
      nextKeys.add('a');
    }
    if (!identical(b, _undefined)) {
      nextKeys.add('b');
    }
    if (!identical(c, _undefined)) {
      nextKeys.add('c');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return RestrictedObject(
      a: !identical(a, _undefined) ? a as String? : this.a,
      b: !identical(b, _undefined) ? b as String? : this.b,
      c: !identical(c, _undefined) ? c as String? : this.c,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    var count = 0;
    if (a != null) count++;
    if (b != null) count++;
    if (c != null) count++;
    count += additionalProperties.length;
    if (count < 1) {
      errors.add(
        ValidationError(
          message: 'Object must have >= 1 properties',
          keyword: 'minProperties',
        ),
      );
    }
    if (count > 2) {
      errors.add(
        ValidationError(
          message: 'Object must have <= 2 properties',
          keyword: 'maxProperties',
        ),
      );
    }
    final val_a = a;
    final val_b = b;
    final val_c = c;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<RestrictedObject> descriptor =
      ObjectDescriptor<RestrictedObject>(
        title: 'RestrictedObject',
        matches: (instance) => instance is RestrictedObject,
        instantiate: (fields) => RestrictedObject(
          a: fields['a'] as String?,
          b: fields['b'] as String?,
          c: fields['c'] as String?,
          additionalProperties: fields.entries
              .where(
                (e) => !const <String>{'a', 'b', 'c'}.contains(e.key) && true,
              )
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as RestrictedObject;
          final map = <String, dynamic>{
            'a': typedInstance.a,
            'b': typedInstance.b,
            'c': typedInstance.c,
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
        additionalProperties: const AnythingDescriptor(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestrictedObject &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b &&
          c == other.c &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    a,
    b,
    c,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'RestrictedObject(a: ${a}, b: ${b}, c: ${c}, additionalProperties: ${additionalProperties})';
}

final class DependentObject implements JsonModel {
  final num? creditCard;
  final String? billingAddress;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const DependentObject({
    this.creditCard,
    this.billingAddress,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  DependentObject copyWith({
    Object? creditCard = _undefined,
    Object? billingAddress = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(creditCard, _undefined)) {
      nextKeys.add('creditCard');
    }
    if (!identical(billingAddress, _undefined)) {
      nextKeys.add('billingAddress');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return DependentObject(
      creditCard: !identical(creditCard, _undefined)
          ? creditCard as num?
          : this.creditCard,
      billingAddress: !identical(billingAddress, _undefined)
          ? billingAddress as String?
          : this.billingAddress,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (creditCard != null) {
      if (billingAddress == null) {
        errors.add(
          ValidationError(
            message:
                'Property "billingAddress" is required because "creditCard" is present',
            path: ['billingAddress'],
            keyword: 'dependentRequired',
          ),
        );
      }
    }
    final val_creditCard = creditCard;
    final val_billingAddress = billingAddress;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<DependentObject> descriptor =
      ObjectDescriptor<DependentObject>(
        title: 'DependentObject',
        matches: (instance) => instance is DependentObject,
        instantiate: (fields) => DependentObject(
          creditCard: fields['creditCard'] as num?,
          billingAddress: fields['billingAddress'] as String?,
          additionalProperties: fields.entries
              .where(
                (e) =>
                    !const <String>{
                      'creditCard',
                      'billingAddress',
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
          final typedInstance = instance as DependentObject;
          final map = <String, dynamic>{
            'creditCard': typedInstance.creditCard,
            'billingAddress': typedInstance.billingAddress,
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
        additionalProperties: const AnythingDescriptor(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DependentObject &&
          runtimeType == other.runtimeType &&
          creditCard == other.creditCard &&
          billingAddress == other.billingAddress &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    creditCard,
    billingAddress,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'DependentObject(creditCard: ${creditCard}, billingAddress: ${billingAddress}, additionalProperties: ${additionalProperties})';
}

@Deprecated('deprecated')
final class DeprecatedObject implements JsonModel {
  final String? value;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const DeprecatedObject({
    this.value,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  DeprecatedObject copyWith({
    Object? value = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(value, _undefined)) {
      nextKeys.add('value');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return DeprecatedObject(
      value: !identical(value, _undefined) ? value as String? : this.value,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_value = value;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<DeprecatedObject> descriptor =
      ObjectDescriptor<DeprecatedObject>(
        title: 'DeprecatedObject',
        matches: (instance) => instance is DeprecatedObject,
        instantiate: (fields) => DeprecatedObject(
          value: fields['value'] as String?,
          additionalProperties: fields.entries
              .where((e) => !const <String>{'value'}.contains(e.key) && true)
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as DeprecatedObject;
          final map = <String, dynamic>{
            'value': typedInstance.value,
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
          'value': PropertyDescriptor(
            name: 'value',
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
      other is DeprecatedObject &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    value,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'DeprecatedObject(value: ${value}, additionalProperties: ${additionalProperties})';
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
  static final EnumDescriptor<TestRootMixedEnum> descriptor =
      EnumDescriptor<TestRootMixedEnum>(
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

  @override
  List<ValidationError> collectErrors();

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final UnionDescriptor<TestRootMixedEnumBase> descriptor =
      UnionDescriptor<TestRootMixedEnumBase>(
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
  List<ValidationError> collectErrors() {
    return const [];
  }

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
  List<ValidationError> collectErrors() {
    return const [];
  }

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
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const Merged({
    this.a,
    this.b,
    this.c,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  Merged copyWith({
    Object? a = _undefined,
    Object? b = _undefined,
    Object? c = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(a, _undefined)) {
      nextKeys.add('a');
    }
    if (!identical(b, _undefined)) {
      nextKeys.add('b');
    }
    if (!identical(c, _undefined)) {
      nextKeys.add('c');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return Merged(
      a: !identical(a, _undefined) ? a as String? : this.a,
      b: !identical(b, _undefined) ? b as int? : this.b,
      c: !identical(c, _undefined) ? c as bool? : this.c,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_a = a;
    final val_b = b;
    final val_c = c;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<Merged> descriptor = ObjectDescriptor<Merged>(
    title: 'Merged',
    matches: (instance) => instance is Merged,
    instantiate: (fields) => Merged(
      a: fields['a'] as String?,
      b: fields['b'] as int?,
      c: fields['c'] as bool?,
      additionalProperties: fields.entries
          .where((e) => !const <String>{'a', 'b', 'c'}.contains(e.key) && true)
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = instance as Merged;
      final map = <String, dynamic>{
        'a': typedInstance.a,
        'b': typedInstance.b,
        'c': typedInstance.c,
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
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Merged &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b &&
          c == other.c &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    a,
    b,
    c,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'Merged(a: ${a}, b: ${b}, c: ${c}, additionalProperties: ${additionalProperties})';
}

final class MapObject implements JsonModel {
  final String? name;
  final Map<String, String> additionalProperties;
  final Set<String>? _$explicitKeys;

  const MapObject({
    this.name,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  MapObject copyWith({
    Object? name = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(name, _undefined)) {
      nextKeys.add('name');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return MapObject(
      name: !identical(name, _undefined) ? name as String? : this.name,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, String>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_name = name;
    additionalProperties.forEach((key, value) {
      if (value is! String) {
        errors.add(
          ValidationError(
            message: 'Property "$key" must be a string',
            path: ['\$key'],
            keyword: 'type',
          ),
        );
      } else {}
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

  static final ObjectDescriptor<MapObject> descriptor =
      ObjectDescriptor<MapObject>(
        title: 'MapObject',
        matches: (instance) => instance is MapObject,
        instantiate: (fields) => MapObject(
          name: fields['name'] as String?,
          additionalProperties: fields.entries
              .where((e) => !const <String>{'name'}.contains(e.key) && true)
              .fold<Map<String, String>>(
                {},
                (m, e) => m..[e.key] = e.value as String,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as MapObject;
          final map = <String, dynamic>{
            'name': typedInstance.name,
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
  final Set<String>? _$explicitKeys;

  const StrictObject({this.name, Set<String>? explicitKeys})
    : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  StrictObject copyWith({Object? name = _undefined}) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(name, _undefined)) {
      nextKeys.add('name');
    }

    return StrictObject(
      name: !identical(name, _undefined) ? name as String? : this.name,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_name = name;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<StrictObject> descriptor =
      ObjectDescriptor<StrictObject>(
        title: 'StrictObject',
        matches: (instance) => instance is StrictObject,
        instantiate: (fields) => StrictObject(
          name: fields['name'] as String?,
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as StrictObject;
          final map = <String, dynamic>{'name': typedInstance.name};
          final explicit = typedInstance._$explicitKeys;
          if (explicit != null) {
            return map.entries
                .where((e) => e.value != null || explicit.contains(e.key))
                .fold<Map<String, dynamic>>({}, (m, e) => m..[e.key] = e.value);
          }
          return map..removeWhere((k, v) => v == null);
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
  final dynamic notNullValue;
  final dynamic notObjectValue;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const NotObject({
    required this.notPatternString,
    required this.notEnumInt,
    required this.notNullValue,
    this.notObjectValue,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  NotObject copyWith({
    Object? notPatternString = _undefined,
    Object? notEnumInt = _undefined,
    Object? notNullValue = _undefined,
    Object? notObjectValue = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(notPatternString, _undefined)) {
      nextKeys.add('notPatternString');
    }
    if (!identical(notEnumInt, _undefined)) {
      nextKeys.add('notEnumInt');
    }
    if (!identical(notNullValue, _undefined)) {
      nextKeys.add('notNullValue');
    }
    if (!identical(notObjectValue, _undefined)) {
      nextKeys.add('notObjectValue');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return NotObject(
      notPatternString: !identical(notPatternString, _undefined)
          ? notPatternString as String
          : this.notPatternString,
      notEnumInt: !identical(notEnumInt, _undefined)
          ? notEnumInt as int
          : this.notEnumInt,
      notNullValue: !identical(notNullValue, _undefined)
          ? notNullValue as dynamic
          : this.notNullValue,
      notObjectValue: !identical(notObjectValue, _undefined)
          ? notObjectValue as dynamic
          : this.notObjectValue,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    {
      final notErrors_notPatternString = <ValidationError>[];
      if (notPatternString is! String) {
        notErrors_notPatternString.add(
          ValidationError(
            message: 'Property "notPatternString" must be a string',
            path: ['notPatternString'],
            keyword: 'type',
          ),
        );
      } else {
        if (!RegExp('forbidden').hasMatch(notPatternString)) {
          notErrors_notPatternString.add(
            ValidationError(
              message:
                  'Property "notPatternString" must match pattern "forbidden"',
              path: ['notPatternString'],
              keyword: 'pattern',
            ),
          );
        }
      }
      if (notErrors_notPatternString.isEmpty) {
        errors.add(
          ValidationError(
            message: 'Property "notPatternString" must not match the schema',
            path: ['notPatternString'],
            keyword: 'not',
          ),
        );
      }
    }
    {
      final notErrors_notEnumInt = <ValidationError>[];
      if (!const [13, 17].any(
        (v) => const DeepCollectionEquality().equals(
          v,
          notEnumInt is Enum ? (notEnumInt as dynamic).value : notEnumInt,
        ),
      )) {
        notErrors_notEnumInt.add(
          ValidationError(
            message: 'Property "notEnumInt" must be one of [13, 17]',
            path: ['notEnumInt'],
            keyword: 'enum',
          ),
        );
      }
      if (notErrors_notEnumInt.isEmpty) {
        errors.add(
          ValidationError(
            message: 'Property "notEnumInt" must not match the schema',
            path: ['notEnumInt'],
            keyword: 'not',
          ),
        );
      }
    }
    final val_notNullValue = notNullValue;
    {
      final notErrors_notNullValue = <ValidationError>[];
      if (val_notNullValue != null) {
        notErrors_notNullValue.add(
          ValidationError(
            message: 'Property "notNullValue" must be null',
            path: ['notNullValue'],
            keyword: 'type',
          ),
        );
      }
      if (notErrors_notNullValue.isEmpty) {
        errors.add(
          ValidationError(
            message: 'Property "notNullValue" must not match the schema',
            path: ['notNullValue'],
            keyword: 'not',
          ),
        );
      }
    }
    final val_notObjectValue = notObjectValue;
    bool notMatches_notObjectValue = true;
    try {
      final rawValue = val_notObjectValue is JsonModel
          ? (val_notObjectValue as JsonModel).toJsonValue()
          : val_notObjectValue;
      parseWithDescriptor(
        JsonReader.fromObject(rawValue),
        RefDescriptor<NotObjectNotObjectValueNot>(
          () => NotObjectNotObjectValueNot.descriptor,
        ),
        validate: true,
      );
    } on JsonValidationException {
      notMatches_notObjectValue = false;
    } on FormatException {
      notMatches_notObjectValue = false;
    }
    if (notMatches_notObjectValue) {
      errors.add(
        ValidationError(
          message: 'Property "notObjectValue" must not match the schema',
          path: ['notObjectValue'],
          keyword: 'not',
        ),
      );
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

  static final ObjectDescriptor<NotObject> descriptor =
      ObjectDescriptor<NotObject>(
        title: 'NotObject',
        matches: (instance) => instance is NotObject,
        instantiate: (fields) => NotObject(
          notPatternString: fields['notPatternString'] as String,
          notEnumInt: fields['notEnumInt'] as int,
          notNullValue: fields['notNullValue'] as dynamic,
          notObjectValue: fields['notObjectValue'] as dynamic,
          additionalProperties: fields.entries
              .where(
                (e) =>
                    !const <String>{
                      'notPatternString',
                      'notEnumInt',
                      'notNullValue',
                      'notObjectValue',
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
          final typedInstance = instance as NotObject;
          final map = <String, dynamic>{
            'notPatternString': typedInstance.notPatternString,
            'notEnumInt': typedInstance.notEnumInt,
            'notNullValue': typedInstance.notNullValue,
            'notObjectValue': typedInstance.notObjectValue,
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
          'notObjectValue': PropertyDescriptor(
            name: 'notObjectValue',
            isRequired: false,
            schema: const AnythingDescriptor(),
          ),
        },

        required: const ['notPatternString', 'notEnumInt', 'notNullValue'],
        additionalProperties: const AnythingDescriptor(),
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
          ) &&
          const DeepCollectionEquality().equals(
            notObjectValue,
            other.notObjectValue,
          ) &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    notPatternString,
    notEnumInt,
    const DeepCollectionEquality().hash(notNullValue),
    const DeepCollectionEquality().hash(notObjectValue),
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'NotObject(notPatternString: ${notPatternString}, notEnumInt: ${notEnumInt}, notNullValue: ${notNullValue}, notObjectValue: ${notObjectValue}, additionalProperties: ${additionalProperties})';
}

enum NotObjectNotEnumIntNot {
  value13(13),
  value17(17);

  final int value;
  const NotObjectNotEnumIntNot(this.value);
  static NotObjectNotEnumIntNot fromValue(int val) =>
      values.firstWhere((e) => e.value == val);
  static final EnumDescriptor<NotObjectNotEnumIntNot> descriptor =
      EnumDescriptor<NotObjectNotEnumIntNot>(
        values: values,
        fromValue: (val) => fromValue(val as int),
        toValue: (e) => (e as NotObjectNotEnumIntNot).value,
        base: const IntDescriptor(),
      );
}

final class NotObjectNotObjectValueNot implements JsonModel {
  final String forbiddenProp;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const NotObjectNotObjectValueNot({
    required this.forbiddenProp,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory NotObjectNotObjectValueNot.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as NotObjectNotObjectValueNot;

  /// Creates an instance of [NotObjectNotObjectValueNot] from a JSON Map.
  factory NotObjectNotObjectValueNot.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => NotObjectNotObjectValueNot.fromJson(
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

  static const Object _undefined = Object();

  NotObjectNotObjectValueNot copyWith({
    Object? forbiddenProp = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(forbiddenProp, _undefined)) {
      nextKeys.add('forbiddenProp');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return NotObjectNotObjectValueNot(
      forbiddenProp: !identical(forbiddenProp, _undefined)
          ? forbiddenProp as String
          : this.forbiddenProp,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<NotObjectNotObjectValueNot> descriptor =
      ObjectDescriptor<NotObjectNotObjectValueNot>(
        title: 'NotObjectNotObjectValueNot',
        matches: (instance) => instance is NotObjectNotObjectValueNot,
        instantiate: (fields) => NotObjectNotObjectValueNot(
          forbiddenProp: fields['forbiddenProp'] as String,
          additionalProperties: fields.entries
              .where(
                (e) => !const <String>{'forbiddenProp'}.contains(e.key) && true,
              )
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as NotObjectNotObjectValueNot;
          final map = <String, dynamic>{
            'forbiddenProp': typedInstance.forbiddenProp,
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
          'forbiddenProp': PropertyDescriptor(
            name: 'forbiddenProp',
            isRequired: true,
            schema: const StringDescriptor(),
          ),
        },

        required: const ['forbiddenProp'],
        additionalProperties: const AnythingDescriptor(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotObjectNotObjectValueNot &&
          runtimeType == other.runtimeType &&
          forbiddenProp == other.forbiddenProp &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    forbiddenProp,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'NotObjectNotObjectValueNot(forbiddenProp: ${forbiddenProp}, additionalProperties: ${additionalProperties})';
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

  @override
  List<ValidationError> collectErrors();

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final UnionDescriptor<TestRootAnyOfValue> descriptor =
      UnionDescriptor<TestRootAnyOfValue>(
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
  List<ValidationError> collectErrors() {
    return const [];
  }

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
  List<ValidationError> collectErrors() {
    return const [];
  }

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
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const MergedAllOfObject({
    this.strVal,
    this.numVal,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  MergedAllOfObject copyWith({
    Object? strVal = _undefined,
    Object? numVal = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(strVal, _undefined)) {
      nextKeys.add('strVal');
    }
    if (!identical(numVal, _undefined)) {
      nextKeys.add('numVal');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return MergedAllOfObject(
      strVal: !identical(strVal, _undefined) ? strVal as String? : this.strVal,
      numVal: !identical(numVal, _undefined) ? numVal as num? : this.numVal,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (strVal != null) {
      if (numVal == null) {
        errors.add(
          ValidationError(
            message:
                'Property "numVal" is required because "strVal" is present',
            path: ['numVal'],
            keyword: 'dependentRequired',
          ),
        );
      }
    }
    final val_strVal = strVal;
    if (val_strVal != null) {
      if (val_strVal.runes.length < 5) {
        errors.add(
          ValidationError(
            message: 'Property "strVal" length must be >= 5',
            path: ['strVal'],
            keyword: 'minLength',
          ),
        );
      }
      if (val_strVal.runes.length > 8) {
        errors.add(
          ValidationError(
            message: 'Property "strVal" length must be <= 8',
            path: ['strVal'],
            keyword: 'maxLength',
          ),
        );
      }
      if (!RegExp('^a').hasMatch(val_strVal)) {
        errors.add(
          ValidationError(
            message: 'Property "strVal" must match pattern "^a"',
            path: ['strVal'],
            keyword: 'pattern',
          ),
        );
      }
      if (!(RegExp(r'^[^@]+@[^@]+$').hasMatch(val_strVal))) {
        errors.add(
          ValidationError(
            message: 'Property "strVal" must be a valid email address',
            path: ['strVal'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_numVal = numVal;
    if (val_numVal != null) {
      if (val_numVal < 10) {
        errors.add(
          ValidationError(
            message: 'Property "numVal" must be >= 10',
            path: ['numVal'],
            keyword: 'minimum',
          ),
        );
      }
      if (val_numVal > 50) {
        errors.add(
          ValidationError(
            message: 'Property "numVal" must be <= 50',
            path: ['numVal'],
            keyword: 'maximum',
          ),
        );
      }
      if (() {
        final div = val_numVal / 5;
        if (!div.isFinite) return true;
        final rounded = div.round();
        final absError = (div - rounded).abs();
        final relError = absError / (div.abs() > 1.0 ? div.abs() : 1.0);
        return relError > 1e-14;
      }()) {
        errors.add(
          ValidationError(
            message: 'Property "numVal" must be a multiple of 5',
            path: ['numVal'],
            keyword: 'multipleOf',
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

  static final ObjectDescriptor<MergedAllOfObject> descriptor =
      ObjectDescriptor<MergedAllOfObject>(
        title: 'MergedAllOfObject',
        matches: (instance) => instance is MergedAllOfObject,
        instantiate: (fields) => MergedAllOfObject(
          strVal: fields['strVal'] as String?,
          numVal: fields['numVal'] as num?,
          additionalProperties: fields.entries
              .where(
                (e) =>
                    !const <String>{'strVal', 'numVal'}.contains(e.key) && true,
              )
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as MergedAllOfObject;
          final map = <String, dynamic>{
            'strVal': typedInstance.strVal,
            'numVal': typedInstance.numVal,
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
        additionalProperties: const AnythingDescriptor(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MergedAllOfObject &&
          runtimeType == other.runtimeType &&
          strVal == other.strVal &&
          numVal == other.numVal &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    strVal,
    numVal,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'MergedAllOfObject(strVal: ${strVal}, numVal: ${numVal}, additionalProperties: ${additionalProperties})';
}

final class ComplexMergedObject implements JsonModel {
  final num? numVal;
  final Map<String, String> additionalProperties;
  final Set<String>? _$explicitKeys;

  const ComplexMergedObject({
    this.numVal,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  ComplexMergedObject copyWith({
    Object? numVal = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(numVal, _undefined)) {
      nextKeys.add('numVal');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return ComplexMergedObject(
      numVal: !identical(numVal, _undefined) ? numVal as num? : this.numVal,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, String>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    var count = 0;
    if (numVal != null) count++;
    count += additionalProperties.length;
    if (count < 2) {
      errors.add(
        ValidationError(
          message: 'Object must have >= 2 properties',
          keyword: 'minProperties',
        ),
      );
    }
    if (count > 5) {
      errors.add(
        ValidationError(
          message: 'Object must have <= 5 properties',
          keyword: 'maxProperties',
        ),
      );
    }
    final val_numVal = numVal;
    if (val_numVal != null) {
      if (val_numVal <= 10.0) {
        errors.add(
          ValidationError(
            message: 'Property "numVal" must be > 10.0',
            path: ['numVal'],
            keyword: 'exclusiveMinimum',
          ),
        );
      }
      if (val_numVal >= 20.0) {
        errors.add(
          ValidationError(
            message: 'Property "numVal" must be < 20.0',
            path: ['numVal'],
            keyword: 'exclusiveMaximum',
          ),
        );
      }
    }
    additionalProperties.forEach((key, value) {
      if (value is! String) {
        errors.add(
          ValidationError(
            message: 'Property "$key" must be a string',
            path: ['\$key'],
            keyword: 'type',
          ),
        );
      } else {
        if (value.runes.length < 3) {
          errors.add(
            ValidationError(
              message: 'Property "$key" length must be >= 3',
              path: ['\$key'],
              keyword: 'minLength',
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

  static final ObjectDescriptor<ComplexMergedObject> descriptor =
      ObjectDescriptor<ComplexMergedObject>(
        title: 'ComplexMergedObject',
        matches: (instance) => instance is ComplexMergedObject,
        instantiate: (fields) => ComplexMergedObject(
          numVal: fields['numVal'] as num?,
          additionalProperties: fields.entries
              .where((e) => !const <String>{'numVal'}.contains(e.key) && true)
              .fold<Map<String, String>>(
                {},
                (m, e) => m..[e.key] = e.value as String,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as ComplexMergedObject;
          final map = <String, dynamic>{
            'numVal': typedInstance.numVal,
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
  static final EnumDescriptor<MyEnum> descriptor = EnumDescriptor<MyEnum>(
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

  @override
  List<ValidationError> collectErrors();

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final UnionDescriptor<TestRootUnionContainsArrayContains> descriptor =
      UnionDescriptor<TestRootUnionContainsArrayContains>(
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
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (value.runes.length < 3) {
      errors.add(
        ValidationError(
          message: 'Property "value" length must be >= 3',
          path: ['value'],
          keyword: 'minLength',
        ),
      );
    }
    if (value.runes.length > 10) {
      errors.add(
        ValidationError(
          message: 'Property "value" length must be <= 10',
          path: ['value'],
          keyword: 'maxLength',
        ),
      );
    }
    if (!RegExp('^a').hasMatch(value)) {
      errors.add(
        ValidationError(
          message: 'Property "value" must match pattern "^a"',
          path: ['value'],
          keyword: 'pattern',
        ),
      );
    }
    if (!(RegExp(r'^[^@]+@[^@]+$').hasMatch(value))) {
      errors.add(
        ValidationError(
          message: 'Property "value" must be a valid email address',
          path: ['value'],
          keyword: 'format',
        ),
      );
    }
    return errors;
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
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (value < 5) {
      errors.add(
        ValidationError(
          message: 'Property "value" must be >= 5',
          path: ['value'],
          keyword: 'minimum',
        ),
      );
    }
    if (value > 10) {
      errors.add(
        ValidationError(
          message: 'Property "value" must be <= 10',
          path: ['value'],
          keyword: 'maximum',
        ),
      );
    }
    if (value % 2 != 0) {
      errors.add(
        ValidationError(
          message: 'Property "value" must be a multiple of 2',
          path: ['value'],
          keyword: 'multipleOf',
        ),
      );
    }
    return errors;
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
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (value <= 5.0) {
      errors.add(
        ValidationError(
          message: 'Property "value" must be > 5.0',
          path: ['value'],
          keyword: 'exclusiveMinimum',
        ),
      );
    }
    if (value >= 11.0) {
      errors.add(
        ValidationError(
          message: 'Property "value" must be < 11.0',
          path: ['value'],
          keyword: 'exclusiveMaximum',
        ),
      );
    }
    if (() {
      final div = value / 0.5;
      if (!div.isFinite) return true;
      final rounded = div.round();
      final absError = (div - rounded).abs();
      final relError = absError / (div.abs() > 1.0 ? div.abs() : 1.0);
      return relError > 1e-14;
    }()) {
      errors.add(
        ValidationError(
          message: 'Property "value" must be a multiple of 0.5',
          path: ['value'],
          keyword: 'multipleOf',
        ),
      );
    }
    return errors;
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
  final dynamic notInt;
  final dynamic notNum;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const ObjectWithDynamicProps({
    this.notInt,
    this.notNum,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  ObjectWithDynamicProps copyWith({
    Object? notInt = _undefined,
    Object? notNum = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(notInt, _undefined)) {
      nextKeys.add('notInt');
    }
    if (!identical(notNum, _undefined)) {
      nextKeys.add('notNum');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return ObjectWithDynamicProps(
      notInt: !identical(notInt, _undefined) ? notInt as dynamic : this.notInt,
      notNum: !identical(notNum, _undefined) ? notNum as dynamic : this.notNum,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_notInt = notInt;
    {
      final notErrors_notInt = <ValidationError>[];
      if (val_notInt is! int) {
        notErrors_notInt.add(
          ValidationError(
            message: 'Property "notInt" must be an integer',
            path: ['notInt'],
            keyword: 'type',
          ),
        );
      } else {}
      if (notErrors_notInt.isEmpty) {
        errors.add(
          ValidationError(
            message: 'Property "notInt" must not match the schema',
            path: ['notInt'],
            keyword: 'not',
          ),
        );
      }
    }
    final val_notNum = notNum;
    {
      final notErrors_notNum = <ValidationError>[];
      if (val_notNum is! num) {
        notErrors_notNum.add(
          ValidationError(
            message: 'Property "notNum" must be a number',
            path: ['notNum'],
            keyword: 'type',
          ),
        );
      } else {}
      if (notErrors_notNum.isEmpty) {
        errors.add(
          ValidationError(
            message: 'Property "notNum" must not match the schema',
            path: ['notNum'],
            keyword: 'not',
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

  static final ObjectDescriptor<ObjectWithDynamicProps> descriptor =
      ObjectDescriptor<ObjectWithDynamicProps>(
        title: 'ObjectWithDynamicProps',
        matches: (instance) => instance is ObjectWithDynamicProps,
        instantiate: (fields) => ObjectWithDynamicProps(
          notInt: fields['notInt'] as dynamic,
          notNum: fields['notNum'] as dynamic,
          additionalProperties: fields.entries
              .where(
                (e) =>
                    !const <String>{'notInt', 'notNum'}.contains(e.key) && true,
              )
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as ObjectWithDynamicProps;
          final map = <String, dynamic>{
            'notInt': typedInstance.notInt,
            'notNum': typedInstance.notNum,
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
        additionalProperties: const AnythingDescriptor(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObjectWithDynamicProps &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(notInt, other.notInt) &&
          const DeepCollectionEquality().equals(notNum, other.notNum) &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    const DeepCollectionEquality().hash(notInt),
    const DeepCollectionEquality().hash(notNum),
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'ObjectWithDynamicProps(notInt: ${notInt}, notNum: ${notNum}, additionalProperties: ${additionalProperties})';
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

  @override
  List<ValidationError> collectErrors();

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final UnionDescriptor<TestRootUnionWithArrayOption> descriptor =
      UnionDescriptor<TestRootUnionWithArrayOption>(
        title: 'TestRootUnionWithArrayOption',

        activeOptions: [
          UnionOptionDescriptor<TestRootUnionWithArrayOption, String>(
            const StringDescriptor(),
            (val) => TestRootUnionWithArrayOptionOption0(val as String),
          ),
          UnionOptionDescriptor<TestRootUnionWithArrayOption, List<Address>>(
            ArrayDescriptor<Address>(
              RefDescriptor<Address>(() => Address.descriptor),
            ),
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
  List<ValidationError> collectErrors() {
    return const [];
  }

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
      ArrayDescriptor<Address>(
        RefDescriptor<Address>(() => Address.descriptor),
      ),
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    for (var i = 0; i < value.length; i++) {
      errors.addAll(
        (value[i] as JsonModel).collectErrors().map(
          (e) => ValidationError(
            message: e.message,
            path: ['[$i]', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    return errors;
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
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const TestRootArrayWithAllOfItemsItem({
    this.a,
    this.b,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  TestRootArrayWithAllOfItemsItem copyWith({
    Object? a = _undefined,
    Object? b = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(a, _undefined)) {
      nextKeys.add('a');
    }
    if (!identical(b, _undefined)) {
      nextKeys.add('b');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return TestRootArrayWithAllOfItemsItem(
      a: !identical(a, _undefined) ? a as String? : this.a,
      b: !identical(b, _undefined) ? b as int? : this.b,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_a = a;
    final val_b = b;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<TestRootArrayWithAllOfItemsItem> descriptor =
      ObjectDescriptor<TestRootArrayWithAllOfItemsItem>(
        title: 'TestRootArrayWithAllOfItemsItem',
        matches: (instance) => instance is TestRootArrayWithAllOfItemsItem,
        instantiate: (fields) => TestRootArrayWithAllOfItemsItem(
          a: fields['a'] as String?,
          b: fields['b'] as int?,
          additionalProperties: fields.entries
              .where((e) => !const <String>{'a', 'b'}.contains(e.key) && true)
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as TestRootArrayWithAllOfItemsItem;
          final map = <String, dynamic>{
            'a': typedInstance.a,
            'b': typedInstance.b,
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
        additionalProperties: const AnythingDescriptor(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootArrayWithAllOfItemsItem &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    a,
    b,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'TestRootArrayWithAllOfItemsItem(a: ${a}, b: ${b}, additionalProperties: ${additionalProperties})';
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

  @override
  List<ValidationError> collectErrors();

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final UnionDescriptor<TestRootUnionWithAllOfOption> descriptor =
      UnionDescriptor<TestRootUnionWithAllOfOption>(
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
            RefDescriptor<TestRootUnionWithAllOfOptionOptionType1>(
              () => TestRootUnionWithAllOfOptionOptionType1.descriptor,
            ),
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
  List<ValidationError> collectErrors() {
    return const [];
  }

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
      RefDescriptor<TestRootUnionWithAllOfOptionOptionType1>(
        () => TestRootUnionWithAllOfOptionOptionType1.descriptor,
      ),
    );
  }

  @override
  List<ValidationError> collectErrors() => value.collectErrors();

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
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const TestRootUnionWithAllOfOptionOptionType1({
    this.a,
    this.b,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  TestRootUnionWithAllOfOptionOptionType1 copyWith({
    Object? a = _undefined,
    Object? b = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(a, _undefined)) {
      nextKeys.add('a');
    }
    if (!identical(b, _undefined)) {
      nextKeys.add('b');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return TestRootUnionWithAllOfOptionOptionType1(
      a: !identical(a, _undefined) ? a as String? : this.a,
      b: !identical(b, _undefined) ? b as int? : this.b,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_a = a;
    final val_b = b;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<TestRootUnionWithAllOfOptionOptionType1>
  descriptor = ObjectDescriptor<TestRootUnionWithAllOfOptionOptionType1>(
    title: 'TestRootUnionWithAllOfOptionOptionType1',
    matches: (instance) => instance is TestRootUnionWithAllOfOptionOptionType1,
    instantiate: (fields) => TestRootUnionWithAllOfOptionOptionType1(
      a: fields['a'] as String?,
      b: fields['b'] as int?,
      additionalProperties: fields.entries
          .where((e) => !const <String>{'a', 'b'}.contains(e.key) && true)
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = instance as TestRootUnionWithAllOfOptionOptionType1;
      final map = <String, dynamic>{
        'a': typedInstance.a,
        'b': typedInstance.b,
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
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootUnionWithAllOfOptionOptionType1 &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    a,
    b,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'TestRootUnionWithAllOfOptionOptionType1(a: ${a}, b: ${b}, additionalProperties: ${additionalProperties})';
}

final class PatternPropertiesObject implements JsonModel {
  final String? name;
  static final _patternRegex0 = RegExp('^S_');
  static final _patternRegex1 = RegExp('^I_');
  static final _patternRegex2 = RegExp('^O_');
  final Map<String, dynamic> patternProperties;
  final Set<String>? _$explicitKeys;

  const PatternPropertiesObject({
    this.name,
    this.patternProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory PatternPropertiesObject.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as PatternPropertiesObject;

  /// Creates an instance of [PatternPropertiesObject] from a JSON Map.
  factory PatternPropertiesObject.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => PatternPropertiesObject.fromJson(
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

  static const Object _undefined = Object();

  PatternPropertiesObject copyWith({
    Object? name = _undefined,
    Object? patternProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(name, _undefined)) {
      nextKeys.add('name');
    }
    if (!identical(patternProperties, _undefined)) {
      nextKeys.add('patternProperties');
    }

    return PatternPropertiesObject(
      name: !identical(name, _undefined) ? name as String? : this.name,
      patternProperties: !identical(patternProperties, _undefined)
          ? patternProperties as Map<String, dynamic>
          : this.patternProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_name = name;
    patternProperties.forEach((key, value) {
      if (_patternRegex0.hasMatch(key)) {
        if (value is! String) {
          errors.add(
            ValidationError(
              message: 'Property "$key" must be a string',
              path: ['\$key'],
              keyword: 'type',
            ),
          );
        } else {}
      }
      if (_patternRegex1.hasMatch(key)) {
        if (value is! int) {
          errors.add(
            ValidationError(
              message: 'Property "$key" must be an integer',
              path: ['\$key'],
              keyword: 'type',
            ),
          );
        } else {
          if (value < 0) {
            errors.add(
              ValidationError(
                message: 'Property "$key" must be >= 0',
                path: ['\$key'],
                keyword: 'minimum',
              ),
            );
          }
        }
      }
      if (_patternRegex2.hasMatch(key)) {
        if (value is! Address) {
          errors.add(
            ValidationError(
              message: 'Property "$key" must be a Address',
              path: ['\$key'],
              keyword: 'type',
            ),
          );
        } else {
          errors.addAll(
            (value as JsonModel).collectErrors().map(
              (ValidationError e) => ValidationError(
                message: e.message,
                path: ['\$key', ...e.path],
                keyword: e.keyword,
                schema: e.schema,
                value: e.value,
                nestedErrors: e.nestedErrors,
              ),
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

  static final ObjectDescriptor<PatternPropertiesObject> descriptor =
      ObjectDescriptor<PatternPropertiesObject>(
        title: 'PatternPropertiesObject',
        matches: (instance) => instance is PatternPropertiesObject,
        instantiate: (fields) => PatternPropertiesObject(
          name: fields['name'] as String?,
          patternProperties: fields.entries
              .where((e) {
                if (const <String>{'name'}.contains(e.key)) return false;
                return _patternRegex0.hasMatch(e.key) ||
                    _patternRegex1.hasMatch(e.key) ||
                    _patternRegex2.hasMatch(e.key);
              })
              .fold<Map<String, dynamic>>({}, (m, e) => m..[e.key] = e.value),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as PatternPropertiesObject;
          final map = <String, dynamic>{
            'name': typedInstance.name,
            ...typedInstance.patternProperties,
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
          'name': PropertyDescriptor(
            name: 'name',
            isRequired: false,
            schema: const StringDescriptor(),
          ),
        },
        patternProperties: {
          _patternRegex0: const StringDescriptor(),
          _patternRegex1: const IntDescriptor(),
          _patternRegex2: RefDescriptor<Address>(() => Address.descriptor),
        },
        required: const [],
        additionalProperties: const NeverDescriptor(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatternPropertiesObject &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          const DeepCollectionEquality().equals(
            patternProperties,
            other.patternProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    name,
    const DeepCollectionEquality().hash(patternProperties),
  ]);

  @override
  String toString() =>
      'PatternPropertiesObject(name: ${name}, patternProperties: ${patternProperties})';
}

sealed class OverlappingUnion implements JsonModel {
  const OverlappingUnion();

  factory OverlappingUnion.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as OverlappingUnion;

  /// Creates an instance of [OverlappingUnion] from a JSON-compatible Dart value.
  factory OverlappingUnion.fromJsonValue(
    Object? value, {
    bool validate = true,
  }) => OverlappingUnion.fromJson(
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

  static final UnionDescriptor<OverlappingUnion> descriptor =
      UnionDescriptor<OverlappingUnion>(
        title: 'OverlappingUnion',

        activeOptions: [
          UnionOptionDescriptor<OverlappingUnion, OptionA>(
            RefDescriptor<OptionA>(() => OptionA.descriptor),
            (val) => OverlappingUnionOption0(val as OptionA),
          ),
          UnionOptionDescriptor<OverlappingUnion, OptionB>(
            RefDescriptor<OptionB>(() => OptionB.descriptor),
            (val) => OverlappingUnionOption1(val as OptionB),
          ),
        ],
      );
}

final class OverlappingUnionOption0 extends OverlappingUnion {
  final OptionA value;
  const OverlappingUnionOption0(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(
      target,
      value,
      RefDescriptor<OptionA>(() => OptionA.descriptor),
    );
  }

  @override
  List<ValidationError> collectErrors() => value.collectErrors();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OverlappingUnionOption0 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'OverlappingUnionOption0(value: $value)';
}

final class OverlappingUnionOption1 extends OverlappingUnion {
  final OptionB value;
  const OverlappingUnionOption1(this.value);

  @override
  void writeJson(JsonSink target) {
    writeWithDescriptor(
      target,
      value,
      RefDescriptor<OptionB>(() => OptionB.descriptor),
    );
  }

  @override
  List<ValidationError> collectErrors() => value.collectErrors();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OverlappingUnionOption1 &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'OverlappingUnionOption1(value: $value)';
}

final class OptionA implements JsonModel {
  final String value;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const OptionA({
    required this.value,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory OptionA.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as OptionA;

  /// Creates an instance of [OptionA] from a JSON Map.
  factory OptionA.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      OptionA.fromJson(JsonReader.fromObject(map), validate: validate);

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

  static const Object _undefined = Object();

  OptionA copyWith({
    Object? value = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(value, _undefined)) {
      nextKeys.add('value');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return OptionA(
      value: !identical(value, _undefined) ? value as String : this.value,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (value.runes.length < 5) {
      errors.add(
        ValidationError(
          message: 'Property "value" length must be >= 5',
          path: ['value'],
          keyword: 'minLength',
        ),
      );
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

  static final ObjectDescriptor<OptionA> descriptor = ObjectDescriptor<OptionA>(
    title: 'OptionA',
    matches: (instance) => instance is OptionA,
    instantiate: (fields) => OptionA(
      value: fields['value'] as String,
      additionalProperties: fields.entries
          .where((e) => !const <String>{'value'}.contains(e.key) && true)
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = instance as OptionA;
      final map = <String, dynamic>{
        'value': typedInstance.value,
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
      'value': PropertyDescriptor(
        name: 'value',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
    },

    required: const ['value'],
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionA &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    value,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'OptionA(value: ${value}, additionalProperties: ${additionalProperties})';
}

final class OptionB implements JsonModel {
  final String value;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const OptionB({
    required this.value,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory OptionB.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as OptionB;

  /// Creates an instance of [OptionB] from a JSON Map.
  factory OptionB.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      OptionB.fromJson(JsonReader.fromObject(map), validate: validate);

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

  static const Object _undefined = Object();

  OptionB copyWith({
    Object? value = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(value, _undefined)) {
      nextKeys.add('value');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return OptionB(
      value: !identical(value, _undefined) ? value as String : this.value,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (value.runes.length < 2) {
      errors.add(
        ValidationError(
          message: 'Property "value" length must be >= 2',
          path: ['value'],
          keyword: 'minLength',
        ),
      );
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

  static final ObjectDescriptor<OptionB> descriptor = ObjectDescriptor<OptionB>(
    title: 'OptionB',
    matches: (instance) => instance is OptionB,
    instantiate: (fields) => OptionB(
      value: fields['value'] as String,
      additionalProperties: fields.entries
          .where((e) => !const <String>{'value'}.contains(e.key) && true)
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = instance as OptionB;
      final map = <String, dynamic>{
        'value': typedInstance.value,
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
      'value': PropertyDescriptor(
        name: 'value',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
    },

    required: const ['value'],
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionB &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    value,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'OptionB(value: ${value}, additionalProperties: ${additionalProperties})';
}

final class MyCustomClassName implements JsonModel {
  final String? foo;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const MyCustomClassName({
    this.foo,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  MyCustomClassName copyWith({
    Object? foo = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(foo, _undefined)) {
      nextKeys.add('foo');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return MyCustomClassName(
      foo: !identical(foo, _undefined) ? foo as String? : this.foo,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_foo = foo;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<MyCustomClassName> descriptor =
      ObjectDescriptor<MyCustomClassName>(
        title: 'MyCustomClassName',
        matches: (instance) => instance is MyCustomClassName,
        instantiate: (fields) => MyCustomClassName(
          foo: fields['foo'] as String?,
          additionalProperties: fields.entries
              .where((e) => !const <String>{'foo'}.contains(e.key) && true)
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as MyCustomClassName;
          final map = <String, dynamic>{
            'foo': typedInstance.foo,
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
          'foo': PropertyDescriptor(
            name: 'foo',
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
      other is MyCustomClassName &&
          runtimeType == other.runtimeType &&
          foo == other.foo &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    foo,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'MyCustomClassName(foo: ${foo}, additionalProperties: ${additionalProperties})';
}

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

  @override
  List<ValidationError> collectErrors();

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final UnionDescriptor<MyCustomUnionName> descriptor =
      UnionDescriptor<MyCustomUnionName>(
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
  List<ValidationError> collectErrors() {
    return const [];
  }

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
  List<ValidationError> collectErrors() {
    return const [];
  }

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
  static final EnumDescriptor<MyCustomEnumName> descriptor =
      EnumDescriptor<MyCustomEnumName>(
        values: values,
        fromValue: (val) => fromValue(val as String),
        toValue: (e) => (e as MyCustomEnumName).value,
        base: const StringDescriptor(),
      );
}

final class TestRootCoverageTrigger implements JsonModel {
  final List<String>? mergeArray;
  final TestRootCoverageTriggerMergeObject? mergeObject;
  final String? mergeString;
  final Never? mergeNumber;
  final bool? mergeBoolean;
  final Null mergeNull;
  final Object? mergeAnything;
  final TestRootCoverageTriggerMergeNever? mergeNever;
  final MapObject1? mergeRef;
  final TestRootCoverageTriggerMergeEnum? mergeEnum;
  final TestRootCoverageTriggerMergeUnion? mergeUnion;
  final TestRootCoverageTriggerMergeObjectsWithNoAdditional?
  mergeObjectsWithNoAdditional;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const TestRootCoverageTrigger({
    this.mergeArray,
    this.mergeObject,
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
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  TestRootCoverageTrigger copyWith({
    Object? mergeArray = _undefined,
    Object? mergeObject = _undefined,
    Object? mergeString = _undefined,
    Object? mergeNumber = _undefined,
    Object? mergeBoolean = _undefined,
    Object? mergeNull = _undefined,
    Object? mergeAnything = _undefined,
    Object? mergeNever = _undefined,
    Object? mergeRef = _undefined,
    Object? mergeEnum = _undefined,
    Object? mergeUnion = _undefined,
    Object? mergeObjectsWithNoAdditional = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(mergeArray, _undefined)) {
      nextKeys.add('mergeArray');
    }
    if (!identical(mergeObject, _undefined)) {
      nextKeys.add('mergeObject');
    }
    if (!identical(mergeString, _undefined)) {
      nextKeys.add('mergeString');
    }
    if (!identical(mergeNumber, _undefined)) {
      nextKeys.add('mergeNumber');
    }
    if (!identical(mergeBoolean, _undefined)) {
      nextKeys.add('mergeBoolean');
    }
    if (!identical(mergeNull, _undefined)) {
      nextKeys.add('mergeNull');
    }
    if (!identical(mergeAnything, _undefined)) {
      nextKeys.add('mergeAnything');
    }
    if (!identical(mergeNever, _undefined)) {
      nextKeys.add('mergeNever');
    }
    if (!identical(mergeRef, _undefined)) {
      nextKeys.add('mergeRef');
    }
    if (!identical(mergeEnum, _undefined)) {
      nextKeys.add('mergeEnum');
    }
    if (!identical(mergeUnion, _undefined)) {
      nextKeys.add('mergeUnion');
    }
    if (!identical(mergeObjectsWithNoAdditional, _undefined)) {
      nextKeys.add('mergeObjectsWithNoAdditional');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return TestRootCoverageTrigger(
      mergeArray: !identical(mergeArray, _undefined)
          ? mergeArray as List<String>?
          : this.mergeArray,
      mergeObject: !identical(mergeObject, _undefined)
          ? mergeObject as TestRootCoverageTriggerMergeObject?
          : this.mergeObject,
      mergeString: !identical(mergeString, _undefined)
          ? mergeString as String?
          : this.mergeString,
      mergeNumber: !identical(mergeNumber, _undefined)
          ? mergeNumber as Never?
          : this.mergeNumber,
      mergeBoolean: !identical(mergeBoolean, _undefined)
          ? mergeBoolean as bool?
          : this.mergeBoolean,
      mergeNull: !identical(mergeNull, _undefined)
          ? mergeNull as Null
          : this.mergeNull,
      mergeAnything: !identical(mergeAnything, _undefined)
          ? mergeAnything as Object?
          : this.mergeAnything,
      mergeNever: !identical(mergeNever, _undefined)
          ? mergeNever as TestRootCoverageTriggerMergeNever?
          : this.mergeNever,
      mergeRef: !identical(mergeRef, _undefined)
          ? mergeRef as MapObject1?
          : this.mergeRef,
      mergeEnum: !identical(mergeEnum, _undefined)
          ? mergeEnum as TestRootCoverageTriggerMergeEnum?
          : this.mergeEnum,
      mergeUnion: !identical(mergeUnion, _undefined)
          ? mergeUnion as TestRootCoverageTriggerMergeUnion?
          : this.mergeUnion,
      mergeObjectsWithNoAdditional:
          !identical(mergeObjectsWithNoAdditional, _undefined)
          ? mergeObjectsWithNoAdditional
                as TestRootCoverageTriggerMergeObjectsWithNoAdditional?
          : this.mergeObjectsWithNoAdditional,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_mergeArray = mergeArray;
    final val_mergeObject = mergeObject;
    if (val_mergeObject != null) {
      errors.addAll(
        (val_mergeObject as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['mergeObject', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_mergeString = mergeString;
    if (val_mergeString != null) {
      if (val_mergeString.runes.length < 5) {
        errors.add(
          ValidationError(
            message: 'Property "mergeString" length must be >= 5',
            path: ['mergeString'],
            keyword: 'minLength',
          ),
        );
      }
      if (val_mergeString.runes.length > 10) {
        errors.add(
          ValidationError(
            message: 'Property "mergeString" length must be <= 10',
            path: ['mergeString'],
            keyword: 'maxLength',
          ),
        );
      }
    }
    final val_mergeNumber = mergeNumber;
    if (val_mergeNumber != null) {
      errors.add(
        ValidationError(
          message: 'Property "mergeNumber" matches nothing',
          path: ['mergeNumber'],
          keyword: 'false',
        ),
      );
    }
    final val_mergeBoolean = mergeBoolean;
    final val_mergeAnything = mergeAnything;
    final val_mergeNever = mergeNever;
    if (val_mergeNever != null) {
      errors.addAll(
        (val_mergeNever as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['mergeNever', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_mergeRef = mergeRef;
    if (val_mergeRef != null) {
      errors.addAll(
        (val_mergeRef as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['mergeRef', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_mergeEnum = mergeEnum;
    final val_mergeUnion = mergeUnion;
    if (val_mergeUnion != null) {
      errors.addAll(
        (val_mergeUnion as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['mergeUnion', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_mergeObjectsWithNoAdditional = mergeObjectsWithNoAdditional;
    if (val_mergeObjectsWithNoAdditional != null) {
      errors.addAll(
        (val_mergeObjectsWithNoAdditional as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['mergeObjectsWithNoAdditional', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
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

  static final ObjectDescriptor<TestRootCoverageTrigger>
  descriptor = ObjectDescriptor<TestRootCoverageTrigger>(
    title: 'TestRootCoverageTrigger',
    matches: (instance) => instance is TestRootCoverageTrigger,
    instantiate: (fields) => TestRootCoverageTrigger(
      mergeArray: fields['mergeArray'] as List<String>?,
      mergeObject: fields['mergeObject'] as TestRootCoverageTriggerMergeObject?,
      mergeString: fields['mergeString'] as String?,
      mergeNumber: fields['mergeNumber'] as Never?,
      mergeBoolean: fields['mergeBoolean'] as bool?,
      mergeNull: fields['mergeNull'] as Null,
      mergeAnything: fields['mergeAnything'] as Object?,
      mergeNever: fields['mergeNever'] as TestRootCoverageTriggerMergeNever?,
      mergeRef: fields['mergeRef'] as MapObject1?,
      mergeEnum: fields['mergeEnum'] as TestRootCoverageTriggerMergeEnum?,
      mergeUnion: fields['mergeUnion'] as TestRootCoverageTriggerMergeUnion?,
      mergeObjectsWithNoAdditional:
          fields['mergeObjectsWithNoAdditional']
              as TestRootCoverageTriggerMergeObjectsWithNoAdditional?,
      additionalProperties: fields.entries
          .where(
            (e) =>
                !const <String>{
                  'mergeArray',
                  'mergeObject',
                  'mergeString',
                  'mergeNumber',
                  'mergeBoolean',
                  'mergeNull',
                  'mergeAnything',
                  'mergeNever',
                  'mergeRef',
                  'mergeEnum',
                  'mergeUnion',
                  'mergeObjectsWithNoAdditional',
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
      final typedInstance = instance as TestRootCoverageTrigger;
      final map = <String, dynamic>{
        'mergeArray': typedInstance.mergeArray,
        'mergeObject': typedInstance.mergeObject,
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
      'mergeArray': PropertyDescriptor(
        name: 'mergeArray',
        isRequired: false,
        schema: ArrayDescriptor<String>(const StringDescriptor()),
      ),
      'mergeObject': PropertyDescriptor(
        name: 'mergeObject',
        isRequired: false,
        schema: RefDescriptor<TestRootCoverageTriggerMergeObject>(
          () => TestRootCoverageTriggerMergeObject.descriptor,
        ),
      ),
      'mergeString': PropertyDescriptor(
        name: 'mergeString',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'mergeNumber': PropertyDescriptor(
        name: 'mergeNumber',
        isRequired: false,
        schema: const NeverDescriptor(),
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
        schema: RefDescriptor<TestRootCoverageTriggerMergeNever>(
          () => TestRootCoverageTriggerMergeNever.descriptor,
        ),
      ),
      'mergeRef': PropertyDescriptor(
        name: 'mergeRef',
        isRequired: false,
        schema: RefDescriptor<MapObject1>(() => MapObject1.descriptor),
      ),
      'mergeEnum': PropertyDescriptor(
        name: 'mergeEnum',
        isRequired: false,
        schema: TestRootCoverageTriggerMergeEnum.descriptor,
      ),
      'mergeUnion': PropertyDescriptor(
        name: 'mergeUnion',
        isRequired: false,
        schema: RefDescriptor<TestRootCoverageTriggerMergeUnion>(
          () => TestRootCoverageTriggerMergeUnion.descriptor,
        ),
      ),
      'mergeObjectsWithNoAdditional': PropertyDescriptor(
        name: 'mergeObjectsWithNoAdditional',
        isRequired: false,
        schema:
            RefDescriptor<TestRootCoverageTriggerMergeObjectsWithNoAdditional>(
              () => TestRootCoverageTriggerMergeObjectsWithNoAdditional
                  .descriptor,
            ),
      ),
    },

    required: const [],
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootCoverageTrigger &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(mergeArray, other.mergeArray) &&
          mergeObject == other.mergeObject &&
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
          mergeObjectsWithNoAdditional == other.mergeObjectsWithNoAdditional &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    const DeepCollectionEquality().hash(mergeArray),
    mergeObject,
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
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'TestRootCoverageTrigger(mergeArray: ${mergeArray}, mergeObject: ${mergeObject}, mergeString: ${mergeString}, mergeNumber: ${mergeNumber}, mergeBoolean: ${mergeBoolean}, mergeNull: ${mergeNull}, mergeAnything: ${mergeAnything}, mergeNever: ${mergeNever}, mergeRef: ${mergeRef}, mergeEnum: ${mergeEnum}, mergeUnion: ${mergeUnion}, mergeObjectsWithNoAdditional: ${mergeObjectsWithNoAdditional}, additionalProperties: ${additionalProperties})';
}

final class TestRootCoverageTriggerMergeObject implements JsonModel {
  final String? a;
  final int? b;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const TestRootCoverageTriggerMergeObject({
    this.a,
    this.b,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory TestRootCoverageTriggerMergeObject.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootCoverageTriggerMergeObject;

  /// Creates an instance of [TestRootCoverageTriggerMergeObject] from a JSON Map.
  factory TestRootCoverageTriggerMergeObject.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => TestRootCoverageTriggerMergeObject.fromJson(
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

  static const Object _undefined = Object();

  TestRootCoverageTriggerMergeObject copyWith({
    Object? a = _undefined,
    Object? b = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(a, _undefined)) {
      nextKeys.add('a');
    }
    if (!identical(b, _undefined)) {
      nextKeys.add('b');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return TestRootCoverageTriggerMergeObject(
      a: !identical(a, _undefined) ? a as String? : this.a,
      b: !identical(b, _undefined) ? b as int? : this.b,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_a = a;
    final val_b = b;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<TestRootCoverageTriggerMergeObject> descriptor =
      ObjectDescriptor<TestRootCoverageTriggerMergeObject>(
        title: 'TestRootCoverageTriggerMergeObject',
        matches: (instance) => instance is TestRootCoverageTriggerMergeObject,
        instantiate: (fields) => TestRootCoverageTriggerMergeObject(
          a: fields['a'] as String?,
          b: fields['b'] as int?,
          additionalProperties: fields.entries
              .where((e) => !const <String>{'a', 'b'}.contains(e.key) && true)
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as TestRootCoverageTriggerMergeObject;
          final map = <String, dynamic>{
            'a': typedInstance.a,
            'b': typedInstance.b,
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
        additionalProperties: const AnythingDescriptor(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootCoverageTriggerMergeObject &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    a,
    b,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'TestRootCoverageTriggerMergeObject(a: ${a}, b: ${b}, additionalProperties: ${additionalProperties})';
}

final class TestRootCoverageTriggerMergeNever implements JsonModel {
  final Set<String>? _$explicitKeys;

  const TestRootCoverageTriggerMergeNever({Set<String>? explicitKeys})
    : _$explicitKeys = explicitKeys;

  factory TestRootCoverageTriggerMergeNever.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as TestRootCoverageTriggerMergeNever;

  /// Creates an instance of [TestRootCoverageTriggerMergeNever] from a JSON Map.
  factory TestRootCoverageTriggerMergeNever.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => TestRootCoverageTriggerMergeNever.fromJson(
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

  TestRootCoverageTriggerMergeNever copyWith() =>
      TestRootCoverageTriggerMergeNever(explicitKeys: _$explicitKeys);

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<TestRootCoverageTriggerMergeNever> descriptor =
      ObjectDescriptor<TestRootCoverageTriggerMergeNever>(
        title: 'TestRootCoverageTriggerMergeNever',
        matches: (instance) => instance is TestRootCoverageTriggerMergeNever,
        instantiate: (fields) => TestRootCoverageTriggerMergeNever(
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as TestRootCoverageTriggerMergeNever;
          final map = <String, dynamic>{};
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
        additionalProperties: const NeverDescriptor(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootCoverageTriggerMergeNever &&
          runtimeType == other.runtimeType &&
          true;

  @override
  int get hashCode => Object.hashAll([]);

  @override
  String toString() => 'TestRootCoverageTriggerMergeNever()';
}

final class MapObject1 implements JsonModel {
  final String? name;
  final Map<String, String> additionalProperties;
  final Set<String>? _$explicitKeys;

  const MapObject1({
    this.name,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory MapObject1.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as MapObject1;

  /// Creates an instance of [MapObject1] from a JSON Map.
  factory MapObject1.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => MapObject1.fromJson(JsonReader.fromObject(map), validate: validate);

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

  static const Object _undefined = Object();

  MapObject1 copyWith({
    Object? name = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(name, _undefined)) {
      nextKeys.add('name');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return MapObject1(
      name: !identical(name, _undefined) ? name as String? : this.name,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, String>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_name = name;
    additionalProperties.forEach((key, value) {
      if (value is! String) {
        errors.add(
          ValidationError(
            message: 'Property "$key" must be a string',
            path: ['\$key'],
            keyword: 'type',
          ),
        );
      } else {}
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

  static final ObjectDescriptor<MapObject1> descriptor =
      ObjectDescriptor<MapObject1>(
        title: 'MapObject1',
        matches: (instance) => instance is MapObject1,
        instantiate: (fields) => MapObject1(
          name: fields['name'] as String?,
          additionalProperties: fields.entries
              .where((e) => !const <String>{'name'}.contains(e.key) && true)
              .fold<Map<String, String>>(
                {},
                (m, e) => m..[e.key] = e.value as String,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as MapObject1;
          final map = <String, dynamic>{
            'name': typedInstance.name,
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
      other is MapObject1 &&
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
      'MapObject1(name: ${name}, additionalProperties: ${additionalProperties})';
}

enum TestRootCoverageTriggerMergeEnum {
  a('a'),
  b('b');

  final String value;
  const TestRootCoverageTriggerMergeEnum(this.value);
  static TestRootCoverageTriggerMergeEnum fromValue(String val) =>
      values.firstWhere((e) => e.value == val);
  static final EnumDescriptor<TestRootCoverageTriggerMergeEnum> descriptor =
      EnumDescriptor<TestRootCoverageTriggerMergeEnum>(
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

  @override
  List<ValidationError> collectErrors();

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final UnionDescriptor<TestRootCoverageTriggerMergeUnion> descriptor =
      UnionDescriptor<TestRootCoverageTriggerMergeUnion>(
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
  List<ValidationError> collectErrors() {
    return const [];
  }

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
  List<ValidationError> collectErrors() {
    return const [];
  }

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
  final Set<String>? _$explicitKeys;

  const TestRootCoverageTriggerMergeObjectsWithNoAdditional({
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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
      TestRootCoverageTriggerMergeObjectsWithNoAdditional(
        explicitKeys: _$explicitKeys,
      );

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
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
    TestRootCoverageTriggerMergeObjectsWithNoAdditional
  >
  descriptor =
      ObjectDescriptor<TestRootCoverageTriggerMergeObjectsWithNoAdditional>(
        title: 'TestRootCoverageTriggerMergeObjectsWithNoAdditional',
        matches: (instance) =>
            instance is TestRootCoverageTriggerMergeObjectsWithNoAdditional,
        instantiate: (fields) =>
            TestRootCoverageTriggerMergeObjectsWithNoAdditional(
              explicitKeys: fields.keys.toSet(),
            ),
        getFields: (instance) {
          final typedInstance =
              instance as TestRootCoverageTriggerMergeObjectsWithNoAdditional;
          final map = <String, dynamic>{};
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
  static final EnumDescriptor<CollidingEnum> descriptor =
      EnumDescriptor<CollidingEnum>(
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
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const CollidingObject({
    this.foo,
    this.foo_1,
    this.bar,
    this.bar1,
    this.validate_,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

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

  static const Object _undefined = Object();

  CollidingObject copyWith({
    Object? foo = _undefined,
    Object? foo_1 = _undefined,
    Object? bar = _undefined,
    Object? bar1 = _undefined,
    Object? validate_ = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(foo, _undefined)) {
      nextKeys.add('foo');
    }
    if (!identical(foo_1, _undefined)) {
      nextKeys.add('@foo');
    }
    if (!identical(bar, _undefined)) {
      nextKeys.add('bar');
    }
    if (!identical(bar1, _undefined)) {
      nextKeys.add('bar_1');
    }
    if (!identical(validate_, _undefined)) {
      nextKeys.add('validate');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return CollidingObject(
      foo: !identical(foo, _undefined) ? foo as String? : this.foo,
      foo_1: !identical(foo_1, _undefined) ? foo_1 as String? : this.foo_1,
      bar: !identical(bar, _undefined) ? bar as String? : this.bar,
      bar1: !identical(bar1, _undefined) ? bar1 as String? : this.bar1,
      validate_: !identical(validate_, _undefined)
          ? validate_ as String?
          : this.validate_,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_foo = foo;
    final val_foo_1 = foo_1;
    final val_bar = bar;
    final val_bar1 = bar1;
    final val_validate_ = validate_;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<CollidingObject> descriptor =
      ObjectDescriptor<CollidingObject>(
        title: 'CollidingObject',
        matches: (instance) => instance is CollidingObject,
        instantiate: (fields) => CollidingObject(
          foo: fields['foo'] as String?,
          foo_1: fields['@foo'] as String?,
          bar: fields['bar'] as String?,
          bar1: fields['bar_1'] as String?,
          validate_: fields['validate'] as String?,
          additionalProperties: fields.entries
              .where(
                (e) =>
                    !const <String>{
                      'foo',
                      '@foo',
                      'bar',
                      'bar_1',
                      'validate',
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
          final typedInstance = instance as CollidingObject;
          final map = <String, dynamic>{
            'foo': typedInstance.foo,
            '@foo': typedInstance.foo_1,
            'bar': typedInstance.bar,
            'bar_1': typedInstance.bar1,
            'validate': typedInstance.validate_,
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
        additionalProperties: const AnythingDescriptor(),
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
          validate_ == other.validate_ &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    foo,
    foo_1,
    bar,
    bar1,
    validate_,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'CollidingObject(foo: ${foo}, foo_1: ${foo_1}, bar: ${bar}, bar1: ${bar1}, validate_: ${validate_}, additionalProperties: ${additionalProperties})';
}
