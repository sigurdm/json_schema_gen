// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides, unnecessary_null_comparison
// ignore_for_file: prefer_is_empty, unnecessary_string_interpolations, avoid_init_to_null, unnecessary_const
// ignore_for_file: unnecessary_question_mark, unnecessary_cast

import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';

final class TestRoot implements JsonModel {
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

  static final ObjectDescriptor<TestRoot>
  descriptor = ObjectDescriptor<TestRoot>(
    title: 'TestRoot',
    matches: (instance) => instance is TestRoot,
    instantiate: (fields) => TestRoot(
      deprecated: (fields['deprecated'] as String?),
      idField: (fields['\$idField'] as String?),
      unionWithObjectAndBoolean:
          (fields['unionWithObjectAndBoolean']
              as TestRootUnionWithObjectAndBoolean?),
      recursiveNodeField: (fields['recursiveNodeField'] as RecursiveNode?),
      name: (fields['name'] as String),
      constValue: (fields['constValue'] as TestRootConstValue?),
      age: (fields['age'] as int),
      exclusiveAge: (fields['exclusiveAge'] as int?),
      height: (fields['height'] as num?),
      email: (fields['email'] as String?),
      uuid: (fields['uuid'] as String?),
      isAwesome: (fields['isAwesome'] as bool),
      class_: (fields['class'] as String?),
      reader: (fields['reader'] as String?),
      stack: (fields['stack'] as String?),
      validate_: (fields['validate'] as String?),
      result: (fields['result'] as String?),
      address: (fields['address'] as Address),
      tags: (fields['tags'] as List<String>?),
      scores: (fields['scores'] as List<Score>?),
      unionValue: (fields['unionValue'] as TestRootUnionValue?),
      nullableUnionValue:
          (fields['nullableUnionValue'] as TestRootNullableUnionValue?),
      requiredNullableUnionObject:
          (fields['requiredNullableUnionObject']
              as RequiredNullableUnionObject?),
      nullableString: (fields['nullableString'] as String?),
      pet: (fields['pet'] as Pet?),
      restrictedObject: (fields['restrictedObject'] as RestrictedObject?),
      dependentObject: (fields['dependentObject'] as DependentObject?),
      primitiveArrayWithValidation:
          (fields['primitiveArrayWithValidation'] as List<String>?),
      restrictedArray: (fields['restrictedArray'] as List<int>?),
      deprecatedField: (fields['deprecatedField'] as String?),
      deprecatedRef: (fields['deprecatedRef'] as DeprecatedObject?),
      defaultString: fields.containsKey('defaultString')
          ? (fields['defaultString'] as String)
          : 'default value',
      defaultBackslash: fields.containsKey('defaultBackslash')
          ? (fields['defaultBackslash'] as String)
          : 'foo\\sbar',
      nestedArray: (fields['nestedArray'] as List<List<Address>>?),
      singleQuoteKey: (fields['single\'quote\'key'] as String?),
      mixedEnum: (fields['mixedEnum'] as TestRootMixedEnum?),
      defaultInt: fields.containsKey('defaultInt')
          ? (fields['defaultInt'] as int)
          : 42,
      defaultBool: fields.containsKey('defaultBool')
          ? (fields['defaultBool'] as bool)
          : true,
      defaultList: fields.containsKey('defaultList')
          ? (fields['defaultList'] as List<String>)
          : const <String>['a', 'b'],
      defaultObject: fields.containsKey('defaultObject')
          ? (fields['defaultObject'] as Address)
          : const Address(city: 'Default City'),
      defaultNullableString: fields.containsKey('defaultNullableString')
          ? (fields['defaultNullableString'] as String?)
          : null,
      mergedValue: (fields['mergedValue'] as Merged?),
      tupleArray: (fields['tupleArray'] as List<dynamic>?),
      tupleObjectArray: (fields['tupleObjectArray'] as List<dynamic>?),
      ipv6Value: (fields['ipv6Value'] as String?),
      hostnameValue: (fields['hostnameValue'] as String?),
      timeValue: (fields['timeValue'] as String?),
      uriReferenceValue: (fields['uriReferenceValue'] as String?),
      additionalPropertiesObject:
          (fields['additionalPropertiesObject'] as MapObject?),
      strictObject: (fields['strictObject'] as StrictObject?),
      notObject: (fields['notObject'] as NotObject?),
      anyOfValue: (fields['anyOfValue'] as TestRootAnyOfValue?),
      mergedAllOfObject: (fields['mergedAllOfObject'] as MergedAllOfObject?),
      complexMerged: (fields['complexMerged'] as ComplexMergedObject?),
      myEnumField: (fields['myEnumField'] as MyEnum?),
      unionContainsArray: (fields['unionContainsArray'] as List<Object?>?),
      objectContainsArray: (fields['objectContainsArray'] as List<Object?>?),
      enumContainsArray: (fields['enumContainsArray'] as List<Object?>?),
      booleanContainsArray: (fields['booleanContainsArray'] as List<Object?>?),
      nullContainsArray: (fields['nullContainsArray'] as List<Object?>?),
      anyContainsArray: (fields['anyContainsArray'] as List<Object?>?),
      stringContainsArray: (fields['stringContainsArray'] as List<Object?>?),
      numberContainsArray: (fields['numberContainsArray'] as List<Object?>?),
      dynamicProps: (fields['dynamicProps'] as ObjectWithDynamicProps?),
      dateTimeField: (fields['dateTimeField'] as String?),
      dateField: (fields['dateField'] as String?),
      ipv4Field: (fields['ipv4Field'] as String?),
      uriField: (fields['uriField'] as String?),
      defaultEmptyList: fields.containsKey('defaultEmptyList')
          ? (fields['defaultEmptyList'] as List<String>)
          : const <String>[],
      defaultEmptyObject: fields.containsKey('defaultEmptyObject')
          ? (fields['defaultEmptyObject'] as MapObject)
          : const MapObject(),
      unionWithArrayOption:
          (fields['unionWithArrayOption'] as TestRootUnionWithArrayOption?),
      impossibleField: (fields['impossibleField'] as Never?),
      tupleSameTypeArray: (fields['tupleSameTypeArray'] as List<String>?),
      arrayWithAllOfItems:
          (fields['arrayWithAllOfItems']
              as List<TestRootArrayWithAllOfItemsItem>?),
      unionWithAllOfOption:
          (fields['unionWithAllOfOption'] as TestRootUnionWithAllOfOption?),
      patternPropsField:
          (fields['patternPropsField'] as PatternPropertiesObject?),
      overlappingUnion: (fields['overlappingUnion'] as OverlappingUnion?),
      deprecatedFieldWithMessage:
          (fields['deprecatedFieldWithMessage'] as String?),
      customNamedObject: (fields['customNamedObject'] as MyCustomClassName?),
      customNamedUnion: (fields['customNamedUnion'] as MyCustomUnionName?),
      customNamedEnum: (fields['customNamedEnum'] as MyCustomEnumName?),
      coverageTrigger: (fields['coverageTrigger'] as TestRootCoverageTrigger?),
      collidingEnumField: (fields['collidingEnumField'] as CollidingEnum?),
      collidingObjectField:
          (fields['collidingObjectField'] as CollidingObject?),
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
      final typedInstance = (instance as TestRoot);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  TestRoot copyWith({
    String? deprecated,
    String? idField,
    TestRootUnionWithObjectAndBoolean? unionWithObjectAndBoolean,
    RecursiveNode? recursiveNodeField,
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
    PatternPropertiesObject? patternPropsField,
    OverlappingUnion? overlappingUnion,
    String? deprecatedFieldWithMessage,
    MyCustomClassName? customNamedObject,
    MyCustomUnionName? customNamedUnion,
    MyCustomEnumName? customNamedEnum,
    TestRootCoverageTrigger? coverageTrigger,
    CollidingEnum? collidingEnumField,
    CollidingObject? collidingObjectField,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (deprecated != null) {
      nextKeys?.add('deprecated');
    }
    if (idField != null) {
      nextKeys?.add('\$idField');
    }
    if (unionWithObjectAndBoolean != null) {
      nextKeys?.add('unionWithObjectAndBoolean');
    }
    if (recursiveNodeField != null) {
      nextKeys?.add('recursiveNodeField');
    }
    if (name != null) {
      nextKeys?.add('name');
    }
    if (constValue != null) {
      nextKeys?.add('constValue');
    }
    if (age != null) {
      nextKeys?.add('age');
    }
    if (exclusiveAge != null) {
      nextKeys?.add('exclusiveAge');
    }
    if (height != null) {
      nextKeys?.add('height');
    }
    if (email != null) {
      nextKeys?.add('email');
    }
    if (uuid != null) {
      nextKeys?.add('uuid');
    }
    if (isAwesome != null) {
      nextKeys?.add('isAwesome');
    }
    if (class_ != null) {
      nextKeys?.add('class');
    }
    if (reader != null) {
      nextKeys?.add('reader');
    }
    if (stack != null) {
      nextKeys?.add('stack');
    }
    if (validate_ != null) {
      nextKeys?.add('validate');
    }
    if (result != null) {
      nextKeys?.add('result');
    }
    if (address != null) {
      nextKeys?.add('address');
    }
    if (tags != null) {
      nextKeys?.add('tags');
    }
    if (scores != null) {
      nextKeys?.add('scores');
    }
    if (unionValue != null) {
      nextKeys?.add('unionValue');
    }
    if (nullableUnionValue != null) {
      nextKeys?.add('nullableUnionValue');
    }
    if (requiredNullableUnionObject != null) {
      nextKeys?.add('requiredNullableUnionObject');
    }
    if (nullableString != null) {
      nextKeys?.add('nullableString');
    }
    if (pet != null) {
      nextKeys?.add('pet');
    }
    if (restrictedObject != null) {
      nextKeys?.add('restrictedObject');
    }
    if (dependentObject != null) {
      nextKeys?.add('dependentObject');
    }
    if (primitiveArrayWithValidation != null) {
      nextKeys?.add('primitiveArrayWithValidation');
    }
    if (restrictedArray != null) {
      nextKeys?.add('restrictedArray');
    }
    if (deprecatedField != null) {
      nextKeys?.add('deprecatedField');
    }
    if (deprecatedRef != null) {
      nextKeys?.add('deprecatedRef');
    }
    if (defaultString != null) {
      nextKeys?.add('defaultString');
    }
    if (defaultBackslash != null) {
      nextKeys?.add('defaultBackslash');
    }
    if (nestedArray != null) {
      nextKeys?.add('nestedArray');
    }
    if (singleQuoteKey != null) {
      nextKeys?.add('single\'quote\'key');
    }
    if (mixedEnum != null) {
      nextKeys?.add('mixedEnum');
    }
    if (defaultInt != null) {
      nextKeys?.add('defaultInt');
    }
    if (defaultBool != null) {
      nextKeys?.add('defaultBool');
    }
    if (defaultList != null) {
      nextKeys?.add('defaultList');
    }
    if (defaultObject != null) {
      nextKeys?.add('defaultObject');
    }
    if (defaultNullableString != null) {
      nextKeys?.add('defaultNullableString');
    }
    if (mergedValue != null) {
      nextKeys?.add('mergedValue');
    }
    if (tupleArray != null) {
      nextKeys?.add('tupleArray');
    }
    if (tupleObjectArray != null) {
      nextKeys?.add('tupleObjectArray');
    }
    if (ipv6Value != null) {
      nextKeys?.add('ipv6Value');
    }
    if (hostnameValue != null) {
      nextKeys?.add('hostnameValue');
    }
    if (timeValue != null) {
      nextKeys?.add('timeValue');
    }
    if (uriReferenceValue != null) {
      nextKeys?.add('uriReferenceValue');
    }
    if (additionalPropertiesObject != null) {
      nextKeys?.add('additionalPropertiesObject');
    }
    if (strictObject != null) {
      nextKeys?.add('strictObject');
    }
    if (notObject != null) {
      nextKeys?.add('notObject');
    }
    if (anyOfValue != null) {
      nextKeys?.add('anyOfValue');
    }
    if (mergedAllOfObject != null) {
      nextKeys?.add('mergedAllOfObject');
    }
    if (complexMerged != null) {
      nextKeys?.add('complexMerged');
    }
    if (myEnumField != null) {
      nextKeys?.add('myEnumField');
    }
    if (unionContainsArray != null) {
      nextKeys?.add('unionContainsArray');
    }
    if (objectContainsArray != null) {
      nextKeys?.add('objectContainsArray');
    }
    if (enumContainsArray != null) {
      nextKeys?.add('enumContainsArray');
    }
    if (booleanContainsArray != null) {
      nextKeys?.add('booleanContainsArray');
    }
    if (nullContainsArray != null) {
      nextKeys?.add('nullContainsArray');
    }
    if (anyContainsArray != null) {
      nextKeys?.add('anyContainsArray');
    }
    if (stringContainsArray != null) {
      nextKeys?.add('stringContainsArray');
    }
    if (numberContainsArray != null) {
      nextKeys?.add('numberContainsArray');
    }
    if (dynamicProps != null) {
      nextKeys?.add('dynamicProps');
    }
    if (dateTimeField != null) {
      nextKeys?.add('dateTimeField');
    }
    if (dateField != null) {
      nextKeys?.add('dateField');
    }
    if (ipv4Field != null) {
      nextKeys?.add('ipv4Field');
    }
    if (uriField != null) {
      nextKeys?.add('uriField');
    }
    if (defaultEmptyList != null) {
      nextKeys?.add('defaultEmptyList');
    }
    if (defaultEmptyObject != null) {
      nextKeys?.add('defaultEmptyObject');
    }
    if (unionWithArrayOption != null) {
      nextKeys?.add('unionWithArrayOption');
    }
    if (impossibleField != null) {
      nextKeys?.add('impossibleField');
    }
    if (tupleSameTypeArray != null) {
      nextKeys?.add('tupleSameTypeArray');
    }
    if (arrayWithAllOfItems != null) {
      nextKeys?.add('arrayWithAllOfItems');
    }
    if (unionWithAllOfOption != null) {
      nextKeys?.add('unionWithAllOfOption');
    }
    if (patternPropsField != null) {
      nextKeys?.add('patternPropsField');
    }
    if (overlappingUnion != null) {
      nextKeys?.add('overlappingUnion');
    }
    if (deprecatedFieldWithMessage != null) {
      nextKeys?.add('deprecatedFieldWithMessage');
    }
    if (customNamedObject != null) {
      nextKeys?.add('customNamedObject');
    }
    if (customNamedUnion != null) {
      nextKeys?.add('customNamedUnion');
    }
    if (customNamedEnum != null) {
      nextKeys?.add('customNamedEnum');
    }
    if (coverageTrigger != null) {
      nextKeys?.add('coverageTrigger');
    }
    if (collidingEnumField != null) {
      nextKeys?.add('collidingEnumField');
    }
    if (collidingObjectField != null) {
      nextKeys?.add('collidingObjectField');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return TestRoot(
      deprecated: deprecated ?? this.deprecated,
      idField: idField ?? this.idField,
      unionWithObjectAndBoolean:
          unionWithObjectAndBoolean ?? this.unionWithObjectAndBoolean,
      recursiveNodeField: recursiveNodeField ?? this.recursiveNodeField,
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
      defaultNullableString:
          defaultNullableString ?? this.defaultNullableString,
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
      patternPropsField: patternPropsField ?? this.patternPropsField,
      overlappingUnion: overlappingUnion ?? this.overlappingUnion,
      deprecatedFieldWithMessage:
          deprecatedFieldWithMessage ?? this.deprecatedFieldWithMessage,
      customNamedObject: customNamedObject ?? this.customNamedObject,
      customNamedUnion: customNamedUnion ?? this.customNamedUnion,
      customNamedEnum: customNamedEnum ?? this.customNamedEnum,
      coverageTrigger: coverageTrigger ?? this.coverageTrigger,
      collidingEnumField: collidingEnumField ?? this.collidingEnumField,
      collidingObjectField: collidingObjectField ?? this.collidingObjectField,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_deprecated = deprecated;
    final val_idField = idField;
    final val_unionWithObjectAndBoolean = unionWithObjectAndBoolean;
    if (val_unionWithObjectAndBoolean != null) {
      errors.addAll(
        (val_unionWithObjectAndBoolean as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['unionWithObjectAndBoolean', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
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
              (val as TestRootUnionWithObjectAndBooleanOptionType0),
            ),
          ),
          UnionOptionDescriptor<TestRootUnionWithObjectAndBoolean, bool>(
            const BoolDescriptor(),
            (val) => TestRootUnionWithObjectAndBooleanOption1((val as bool)),
          ),
        ],
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
}

final class TestRootUnionWithObjectAndBooleanOption0
    extends TestRootUnionWithObjectAndBoolean {
  const TestRootUnionWithObjectAndBooleanOption0(this.value);

  final TestRootUnionWithObjectAndBooleanOptionType0 value;

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
  const TestRootUnionWithObjectAndBooleanOption1(this.value);

  final bool value;

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

  final String? foo;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<TestRootUnionWithObjectAndBooleanOptionType0>
  descriptor = ObjectDescriptor<TestRootUnionWithObjectAndBooleanOptionType0>(
    title: 'TestRootUnionWithObjectAndBooleanOptionType0',
    matches: (instance) =>
        instance is TestRootUnionWithObjectAndBooleanOptionType0,
    instantiate: (fields) => TestRootUnionWithObjectAndBooleanOptionType0(
      foo: (fields['foo'] as String?),
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
          (instance as TestRootUnionWithObjectAndBooleanOptionType0);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  TestRootUnionWithObjectAndBooleanOptionType0 copyWith({
    String? foo,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (foo != null) {
      nextKeys?.add('foo');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return TestRootUnionWithObjectAndBooleanOptionType0(
      foo: foo ?? this.foo,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  final String? name;

  final RecursiveNode? parent;

  final List<RecursiveNode>? children;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<RecursiveNode>
  descriptor = ObjectDescriptor<RecursiveNode>(
    title: 'RecursiveNode',
    matches: (instance) => instance is RecursiveNode,
    instantiate: (fields) => RecursiveNode(
      name: (fields['name'] as String?),
      parent: (fields['parent'] as RecursiveNode?),
      children: (fields['children'] as List<RecursiveNode>?),
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
      final typedInstance = (instance as RecursiveNode);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  RecursiveNode copyWith({
    String? name,
    RecursiveNode? parent,
    List<RecursiveNode>? children,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (name != null) {
      nextKeys?.add('name');
    }
    if (parent != null) {
      nextKeys?.add('parent');
    }
    if (children != null) {
      nextKeys?.add('children');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return RecursiveNode(
      name: name ?? this.name,
      parent: parent ?? this.parent,
      children: children ?? this.children,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  const TestRootConstValue(this.value);

  final String value;

  static final EnumDescriptor<TestRootConstValue> descriptor =
      EnumDescriptor<TestRootConstValue>(
        values: values,
        fromValue: (val) => fromValue((val as String)),
        toValue: (e) => (e as TestRootConstValue).value,
        base: const StringDescriptor(),
      );

  static TestRootConstValue fromValue(String val) =>
      values.firstWhere((e) => e.value == val);
}

final class Address implements JsonModel {
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

  final String city;

  final String? street;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<Address> descriptor = ObjectDescriptor<Address>(
    title: 'Address',
    matches: (instance) => instance is Address,
    instantiate: (fields) => Address(
      city: (fields['city'] as String),
      street: (fields['street'] as String?),
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
      final typedInstance = (instance as Address);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  Address copyWith({
    String? city,
    String? street,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (city != null) {
      nextKeys?.add('city');
    }
    if (street != null) {
      nextKeys?.add('street');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return Address(
      city: city ?? this.city,
      street: street ?? this.street,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  final num value;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<Score> descriptor = ObjectDescriptor<Score>(
    title: 'Score',
    matches: (instance) => instance is Score,
    instantiate: (fields) => Score(
      value: (fields['value'] as num),
      additionalProperties: fields.entries
          .where((e) => !const <String>{'value'}.contains(e.key) && true)
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = (instance as Score);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  Score copyWith({num? value, Map<String, Object?>? additionalProperties}) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (value != null) {
      nextKeys?.add('value');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return Score(
      value: value ?? this.value,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  static final UnionDescriptor<TestRootUnionValue> descriptor =
      UnionDescriptor<TestRootUnionValue>(
        title: 'TestRootUnionValue',
        activeOptions: [
          UnionOptionDescriptor<TestRootUnionValue, String>(
            const StringDescriptor(),
            (val) => TestRootUnionValueOption0((val as String)),
          ),
          UnionOptionDescriptor<TestRootUnionValue, Address>(
            RefDescriptor<Address>(() => Address.descriptor),
            (val) => TestRootUnionValueOption1((val as Address)),
          ),
        ],
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
}

final class TestRootUnionValueOption0 extends TestRootUnionValue {
  const TestRootUnionValueOption0(this.value);

  final String value;

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
  const TestRootUnionValueOption1(this.value);

  final Address value;

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

  static final UnionDescriptor<TestRootNullableUnionValue> descriptor =
      UnionDescriptor<TestRootNullableUnionValue>(
        title: 'TestRootNullableUnionValue',
        activeOptions: [
          UnionOptionDescriptor<TestRootNullableUnionValue, String>(
            const StringDescriptor(),
            (val) => TestRootNullableUnionValueOption0((val as String)),
          ),
          UnionOptionDescriptor<TestRootNullableUnionValue, Address>(
            RefDescriptor<Address>(() => Address.descriptor),
            (val) => TestRootNullableUnionValueOption1((val as Address)),
          ),
        ],
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
}

final class TestRootNullableUnionValueOption0
    extends TestRootNullableUnionValue {
  const TestRootNullableUnionValueOption0(this.value);

  final String value;

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
  const TestRootNullableUnionValueOption1(this.value);

  final Address value;

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

  final RequiredNullableUnionObjectNullableUnion? nullableUnion;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<RequiredNullableUnionObject> descriptor =
      ObjectDescriptor<RequiredNullableUnionObject>(
        title: 'RequiredNullableUnionObject',
        matches: (instance) => instance is RequiredNullableUnionObject,
        instantiate: (fields) => RequiredNullableUnionObject(
          nullableUnion:
              (fields['nullableUnion']
                  as RequiredNullableUnionObjectNullableUnion?),
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
          final typedInstance = (instance as RequiredNullableUnionObject);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  RequiredNullableUnionObject copyWith({
    RequiredNullableUnionObjectNullableUnion? nullableUnion,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (nullableUnion != null) {
      nextKeys?.add('nullableUnion');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return RequiredNullableUnionObject(
      nullableUnion: nullableUnion ?? this.nullableUnion,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  static final UnionDescriptor<RequiredNullableUnionObjectNullableUnion>
  descriptor = UnionDescriptor<RequiredNullableUnionObjectNullableUnion>(
    title: 'RequiredNullableUnionObjectNullableUnion',
    activeOptions: [
      UnionOptionDescriptor<RequiredNullableUnionObjectNullableUnion, String>(
        const StringDescriptor(),
        (val) =>
            RequiredNullableUnionObjectNullableUnionOption0((val as String)),
      ),
      UnionOptionDescriptor<RequiredNullableUnionObjectNullableUnion, int>(
        const IntDescriptor(),
        (val) => RequiredNullableUnionObjectNullableUnionOption1((val as int)),
      ),
    ],
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
}

final class RequiredNullableUnionObjectNullableUnionOption0
    extends RequiredNullableUnionObjectNullableUnion {
  const RequiredNullableUnionObjectNullableUnionOption0(this.value);

  final String value;

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
  const RequiredNullableUnionObjectNullableUnionOption1(this.value);

  final int value;

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

  static final UnionDescriptor<Pet> descriptor = UnionDescriptor<Pet>(
    title: 'Pet',
    discriminatorProperty: 'kind',
    discriminatorMapping: {
      'cat_type': UnionOptionDescriptor<Pet, Cat>(
        RefDescriptor<Cat>(() => Cat.descriptor),
        (val) => PetOption0((val as Cat)),
      ),
      'Cat': UnionOptionDescriptor<Pet, Cat>(
        RefDescriptor<Cat>(() => Cat.descriptor),
        (val) => PetOption0((val as Cat)),
      ),
      'PetOption0': UnionOptionDescriptor<Pet, Cat>(
        RefDescriptor<Cat>(() => Cat.descriptor),
        (val) => PetOption0((val as Cat)),
      ),
      'dog_type': UnionOptionDescriptor<Pet, Dog>(
        RefDescriptor<Dog>(() => Dog.descriptor),
        (val) => PetOption1((val as Dog)),
      ),
      'Dog': UnionOptionDescriptor<Pet, Dog>(
        RefDescriptor<Dog>(() => Dog.descriptor),
        (val) => PetOption1((val as Dog)),
      ),
      'PetOption1': UnionOptionDescriptor<Pet, Dog>(
        RefDescriptor<Dog>(() => Dog.descriptor),
        (val) => PetOption1((val as Dog)),
      ),
    },
    activeOptions: [
      UnionOptionDescriptor<Pet, Cat>(
        RefDescriptor<Cat>(() => Cat.descriptor),
        (val) => PetOption0((val as Cat)),
      ),
      UnionOptionDescriptor<Pet, Dog>(
        RefDescriptor<Dog>(() => Dog.descriptor),
        (val) => PetOption1((val as Dog)),
      ),
    ],
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
}

final class PetOption0 extends Pet {
  const PetOption0(this.value);

  final Cat value;

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
  const PetOption1(this.value);

  final Dog value;

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

  final String kind;

  final num? meowVolume;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<Cat> descriptor = ObjectDescriptor<Cat>(
    title: 'Cat',
    matches: (instance) => instance is Cat,
    instantiate: (fields) => Cat(
      kind: (fields['kind'] as String),
      meowVolume: (fields['meowVolume'] as num?),
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
      final typedInstance = (instance as Cat);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  Cat copyWith({
    String? kind,
    num? meowVolume,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (kind != null) {
      nextKeys?.add('kind');
    }
    if (meowVolume != null) {
      nextKeys?.add('meowVolume');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return Cat(
      kind: kind ?? this.kind,
      meowVolume: meowVolume ?? this.meowVolume,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  final String kind;

  final num? barkVolume;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<Dog> descriptor = ObjectDescriptor<Dog>(
    title: 'Dog',
    matches: (instance) => instance is Dog,
    instantiate: (fields) => Dog(
      kind: (fields['kind'] as String),
      barkVolume: (fields['barkVolume'] as num?),
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
      final typedInstance = (instance as Dog);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  Dog copyWith({
    String? kind,
    num? barkVolume,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (kind != null) {
      nextKeys?.add('kind');
    }
    if (barkVolume != null) {
      nextKeys?.add('barkVolume');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return Dog(
      kind: kind ?? this.kind,
      barkVolume: barkVolume ?? this.barkVolume,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  final String? a;

  final String? b;

  final String? c;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<RestrictedObject> descriptor =
      ObjectDescriptor<RestrictedObject>(
        title: 'RestrictedObject',
        matches: (instance) => instance is RestrictedObject,
        instantiate: (fields) => RestrictedObject(
          a: (fields['a'] as String?),
          b: (fields['b'] as String?),
          c: (fields['c'] as String?),
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
          final typedInstance = (instance as RestrictedObject);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  RestrictedObject copyWith({
    String? a,
    String? b,
    String? c,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (a != null) {
      nextKeys?.add('a');
    }
    if (b != null) {
      nextKeys?.add('b');
    }
    if (c != null) {
      nextKeys?.add('c');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return RestrictedObject(
      a: a ?? this.a,
      b: b ?? this.b,
      c: c ?? this.c,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  final num? creditCard;

  final String? billingAddress;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<DependentObject> descriptor =
      ObjectDescriptor<DependentObject>(
        title: 'DependentObject',
        matches: (instance) => instance is DependentObject,
        instantiate: (fields) => DependentObject(
          creditCard: (fields['creditCard'] as num?),
          billingAddress: (fields['billingAddress'] as String?),
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
          final typedInstance = (instance as DependentObject);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  DependentObject copyWith({
    num? creditCard,
    String? billingAddress,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (creditCard != null) {
      nextKeys?.add('creditCard');
    }
    if (billingAddress != null) {
      nextKeys?.add('billingAddress');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return DependentObject(
      creditCard: creditCard ?? this.creditCard,
      billingAddress: billingAddress ?? this.billingAddress,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (creditCard != null) {
      if (!(billingAddress != null)) {
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

  final String? value;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<DeprecatedObject> descriptor =
      ObjectDescriptor<DeprecatedObject>(
        title: 'DeprecatedObject',
        matches: (instance) => instance is DeprecatedObject,
        instantiate: (fields) => DeprecatedObject(
          value: (fields['value'] as String?),
          additionalProperties: fields.entries
              .where((e) => !const <String>{'value'}.contains(e.key) && true)
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = (instance as DeprecatedObject);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  DeprecatedObject copyWith({
    String? value,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (value != null) {
      nextKeys?.add('value');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return DeprecatedObject(
      value: value ?? this.value,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  const TestRootMixedEnum(this.value);

  final dynamic value;

  static final EnumDescriptor<TestRootMixedEnum> descriptor =
      EnumDescriptor<TestRootMixedEnum>(
        values: values,
        fromValue: (val) => fromValue((val as dynamic)),
        toValue: (e) => (e as TestRootMixedEnum).value,
        base: const AnythingDescriptor(),
      );

  static TestRootMixedEnum fromValue(dynamic val) =>
      values.firstWhere((e) => e.value == val);
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

  static final UnionDescriptor<TestRootMixedEnumBase> descriptor =
      UnionDescriptor<TestRootMixedEnumBase>(
        title: 'TestRootMixedEnumBase',
        activeOptions: [
          UnionOptionDescriptor<TestRootMixedEnumBase, String>(
            const StringDescriptor(),
            (val) => TestRootMixedEnumBaseOption0((val as String)),
          ),
          UnionOptionDescriptor<TestRootMixedEnumBase, int>(
            const IntDescriptor(),
            (val) => TestRootMixedEnumBaseOption1((val as int)),
          ),
        ],
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
}

final class TestRootMixedEnumBaseOption0 extends TestRootMixedEnumBase {
  const TestRootMixedEnumBaseOption0(this.value);

  final String value;

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
  const TestRootMixedEnumBaseOption1(this.value);

  final int value;

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

  final String? a;

  final int? b;

  final bool? c;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<Merged> descriptor = ObjectDescriptor<Merged>(
    title: 'Merged',
    matches: (instance) => instance is Merged,
    instantiate: (fields) => Merged(
      a: (fields['a'] as String?),
      b: (fields['b'] as int?),
      c: (fields['c'] as bool?),
      additionalProperties: fields.entries
          .where((e) => !const <String>{'a', 'b', 'c'}.contains(e.key) && true)
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = (instance as Merged);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  Merged copyWith({
    String? a,
    int? b,
    bool? c,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (a != null) {
      nextKeys?.add('a');
    }
    if (b != null) {
      nextKeys?.add('b');
    }
    if (c != null) {
      nextKeys?.add('c');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return Merged(
      a: a ?? this.a,
      b: b ?? this.b,
      c: c ?? this.c,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  final String? name;

  final Map<String, String> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<MapObject> descriptor =
      ObjectDescriptor<MapObject>(
        title: 'MapObject',
        matches: (instance) => instance is MapObject,
        instantiate: (fields) => MapObject(
          name: (fields['name'] as String?),
          additionalProperties: fields.entries
              .where((e) => !const <String>{'name'}.contains(e.key) && true)
              .fold<Map<String, String>>(
                {},
                (m, e) => m..[e.key] = e.value as String,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = (instance as MapObject);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  MapObject copyWith({
    String? name,
    Map<String, String>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (name != null) {
      nextKeys?.add('name');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return MapObject(
      name: name ?? this.name,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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
            path: ['$key'],
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

  final String? name;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<StrictObject> descriptor =
      ObjectDescriptor<StrictObject>(
        title: 'StrictObject',
        matches: (instance) => instance is StrictObject,
        instantiate: (fields) => StrictObject(
          name: (fields['name'] as String?),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = (instance as StrictObject);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  StrictObject copyWith({String? name}) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (name != null) {
      nextKeys?.add('name');
    }
    return StrictObject(name: name ?? this.name, explicitKeys: nextKeys);
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

  final String notPatternString;

  final int notEnumInt;

  final dynamic notNullValue;

  final dynamic notObjectValue;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<NotObject> descriptor =
      ObjectDescriptor<NotObject>(
        title: 'NotObject',
        matches: (instance) => instance is NotObject,
        instantiate: (fields) => NotObject(
          notPatternString: (fields['notPatternString'] as String),
          notEnumInt: (fields['notEnumInt'] as int),
          notNullValue: (fields['notNullValue'] as dynamic),
          notObjectValue: (fields['notObjectValue'] as dynamic),
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
          final typedInstance = (instance as NotObject);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  NotObject copyWith({
    String? notPatternString,
    int? notEnumInt,
    dynamic? notNullValue,
    dynamic? notObjectValue,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (notPatternString != null) {
      nextKeys?.add('notPatternString');
    }
    if (notEnumInt != null) {
      nextKeys?.add('notEnumInt');
    }
    if (notNullValue != null) {
      nextKeys?.add('notNullValue');
    }
    if (notObjectValue != null) {
      nextKeys?.add('notObjectValue');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return NotObject(
      notPatternString: notPatternString ?? this.notPatternString,
      notEnumInt: notEnumInt ?? this.notEnumInt,
      notNullValue: notNullValue ?? this.notNullValue,
      notObjectValue: notObjectValue ?? this.notObjectValue,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  const NotObjectNotEnumIntNot(this.value);

  final int value;

  static final EnumDescriptor<NotObjectNotEnumIntNot> descriptor =
      EnumDescriptor<NotObjectNotEnumIntNot>(
        values: values,
        fromValue: (val) => fromValue((val as int)),
        toValue: (e) => (e as NotObjectNotEnumIntNot).value,
        base: const IntDescriptor(),
      );

  static NotObjectNotEnumIntNot fromValue(int val) =>
      values.firstWhere((e) => e.value == val);
}

final class NotObjectNotObjectValueNot implements JsonModel {
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

  final String forbiddenProp;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<NotObjectNotObjectValueNot> descriptor =
      ObjectDescriptor<NotObjectNotObjectValueNot>(
        title: 'NotObjectNotObjectValueNot',
        matches: (instance) => instance is NotObjectNotObjectValueNot,
        instantiate: (fields) => NotObjectNotObjectValueNot(
          forbiddenProp: (fields['forbiddenProp'] as String),
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
          final typedInstance = (instance as NotObjectNotObjectValueNot);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  NotObjectNotObjectValueNot copyWith({
    String? forbiddenProp,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (forbiddenProp != null) {
      nextKeys?.add('forbiddenProp');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return NotObjectNotObjectValueNot(
      forbiddenProp: forbiddenProp ?? this.forbiddenProp,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  static final UnionDescriptor<TestRootAnyOfValue> descriptor =
      UnionDescriptor<TestRootAnyOfValue>(
        title: 'TestRootAnyOfValue',
        activeOptions: [
          UnionOptionDescriptor<TestRootAnyOfValue, String>(
            const StringDescriptor(),
            (val) => TestRootAnyOfValueOption0((val as String)),
          ),
          UnionOptionDescriptor<TestRootAnyOfValue, int>(
            const IntDescriptor(),
            (val) => TestRootAnyOfValueOption1((val as int)),
          ),
        ],
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
}

final class TestRootAnyOfValueOption0 extends TestRootAnyOfValue {
  const TestRootAnyOfValueOption0(this.value);

  final String value;

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
  const TestRootAnyOfValueOption1(this.value);

  final int value;

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

  final String? strVal;

  final num? numVal;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<MergedAllOfObject> descriptor =
      ObjectDescriptor<MergedAllOfObject>(
        title: 'MergedAllOfObject',
        matches: (instance) => instance is MergedAllOfObject,
        instantiate: (fields) => MergedAllOfObject(
          strVal: (fields['strVal'] as String?),
          numVal: (fields['numVal'] as num?),
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
          final typedInstance = (instance as MergedAllOfObject);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  MergedAllOfObject copyWith({
    String? strVal,
    num? numVal,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (strVal != null) {
      nextKeys?.add('strVal');
    }
    if (numVal != null) {
      nextKeys?.add('numVal');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return MergedAllOfObject(
      strVal: strVal ?? this.strVal,
      numVal: numVal ?? this.numVal,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (strVal != null) {
      if (!(numVal != null)) {
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

  final num? numVal;

  final Map<String, String> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<ComplexMergedObject> descriptor =
      ObjectDescriptor<ComplexMergedObject>(
        title: 'ComplexMergedObject',
        matches: (instance) => instance is ComplexMergedObject,
        instantiate: (fields) => ComplexMergedObject(
          numVal: (fields['numVal'] as num?),
          additionalProperties: fields.entries
              .where((e) => !const <String>{'numVal'}.contains(e.key) && true)
              .fold<Map<String, String>>(
                {},
                (m, e) => m..[e.key] = e.value as String,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = (instance as ComplexMergedObject);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  ComplexMergedObject copyWith({
    num? numVal,
    Map<String, String>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (numVal != null) {
      nextKeys?.add('numVal');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return ComplexMergedObject(
      numVal: numVal ?? this.numVal,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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
            path: ['$key'],
            keyword: 'type',
          ),
        );
      } else {
        if (value.runes.length < 3) {
          errors.add(
            ValidationError(
              message: 'Property "$key" length must be >= 3',
              path: ['$key'],
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

  const MyEnum(this.value);

  final String value;

  static final EnumDescriptor<MyEnum> descriptor = EnumDescriptor<MyEnum>(
    values: values,
    fromValue: (val) => fromValue((val as String)),
    toValue: (e) => (e as MyEnum).value,
    base: const StringDescriptor(),
  );

  static MyEnum fromValue(String val) =>
      values.firstWhere((e) => e.value == val);
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

  static final UnionDescriptor<TestRootUnionContainsArrayContains> descriptor =
      UnionDescriptor<TestRootUnionContainsArrayContains>(
        title: 'TestRootUnionContainsArrayContains',
        activeOptions: [
          UnionOptionDescriptor<TestRootUnionContainsArrayContains, String>(
            const StringDescriptor(),
            (val) => TestRootUnionContainsArrayContainsOption0((val as String)),
          ),
          UnionOptionDescriptor<TestRootUnionContainsArrayContains, int>(
            const IntDescriptor(),
            (val) => TestRootUnionContainsArrayContainsOption1((val as int)),
          ),
          UnionOptionDescriptor<TestRootUnionContainsArrayContains, num>(
            const NumDescriptor(),
            (val) => TestRootUnionContainsArrayContainsOption2((val as num)),
          ),
        ],
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
}

final class TestRootUnionContainsArrayContainsOption0
    extends TestRootUnionContainsArrayContains {
  const TestRootUnionContainsArrayContainsOption0(this.value);

  final String value;

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
  const TestRootUnionContainsArrayContainsOption1(this.value);

  final int value;

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
  const TestRootUnionContainsArrayContainsOption2(this.value);

  final num value;

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

  final dynamic notInt;

  final dynamic notNum;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<ObjectWithDynamicProps> descriptor =
      ObjectDescriptor<ObjectWithDynamicProps>(
        title: 'ObjectWithDynamicProps',
        matches: (instance) => instance is ObjectWithDynamicProps,
        instantiate: (fields) => ObjectWithDynamicProps(
          notInt: (fields['notInt'] as dynamic),
          notNum: (fields['notNum'] as dynamic),
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
          final typedInstance = (instance as ObjectWithDynamicProps);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  ObjectWithDynamicProps copyWith({
    dynamic? notInt,
    dynamic? notNum,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (notInt != null) {
      nextKeys?.add('notInt');
    }
    if (notNum != null) {
      nextKeys?.add('notNum');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return ObjectWithDynamicProps(
      notInt: notInt ?? this.notInt,
      notNum: notNum ?? this.notNum,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  static final UnionDescriptor<TestRootUnionWithArrayOption> descriptor =
      UnionDescriptor<TestRootUnionWithArrayOption>(
        title: 'TestRootUnionWithArrayOption',
        activeOptions: [
          UnionOptionDescriptor<TestRootUnionWithArrayOption, String>(
            const StringDescriptor(),
            (val) => TestRootUnionWithArrayOptionOption0((val as String)),
          ),
          UnionOptionDescriptor<TestRootUnionWithArrayOption, List<Address>>(
            ArrayDescriptor<Address>(
              RefDescriptor<Address>(() => Address.descriptor),
            ),
            (val) =>
                TestRootUnionWithArrayOptionOption1((val as List<Address>)),
          ),
        ],
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
}

final class TestRootUnionWithArrayOptionOption0
    extends TestRootUnionWithArrayOption {
  const TestRootUnionWithArrayOptionOption0(this.value);

  final String value;

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
  const TestRootUnionWithArrayOptionOption1(this.value);

  final List<Address> value;

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

  final String? a;

  final int? b;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<TestRootArrayWithAllOfItemsItem> descriptor =
      ObjectDescriptor<TestRootArrayWithAllOfItemsItem>(
        title: 'TestRootArrayWithAllOfItemsItem',
        matches: (instance) => instance is TestRootArrayWithAllOfItemsItem,
        instantiate: (fields) => TestRootArrayWithAllOfItemsItem(
          a: (fields['a'] as String?),
          b: (fields['b'] as int?),
          additionalProperties: fields.entries
              .where((e) => !const <String>{'a', 'b'}.contains(e.key) && true)
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = (instance as TestRootArrayWithAllOfItemsItem);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  TestRootArrayWithAllOfItemsItem copyWith({
    String? a,
    int? b,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (a != null) {
      nextKeys?.add('a');
    }
    if (b != null) {
      nextKeys?.add('b');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return TestRootArrayWithAllOfItemsItem(
      a: a ?? this.a,
      b: b ?? this.b,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  static final UnionDescriptor<TestRootUnionWithAllOfOption> descriptor =
      UnionDescriptor<TestRootUnionWithAllOfOption>(
        title: 'TestRootUnionWithAllOfOption',
        activeOptions: [
          UnionOptionDescriptor<TestRootUnionWithAllOfOption, String>(
            const StringDescriptor(),
            (val) => TestRootUnionWithAllOfOptionOption0((val as String)),
          ),
          UnionOptionDescriptor<
            TestRootUnionWithAllOfOption,
            TestRootUnionWithAllOfOptionOptionType1
          >(
            RefDescriptor<TestRootUnionWithAllOfOptionOptionType1>(
              () => TestRootUnionWithAllOfOptionOptionType1.descriptor,
            ),
            (val) => TestRootUnionWithAllOfOptionOption1(
              (val as TestRootUnionWithAllOfOptionOptionType1),
            ),
          ),
        ],
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
}

final class TestRootUnionWithAllOfOptionOption0
    extends TestRootUnionWithAllOfOption {
  const TestRootUnionWithAllOfOptionOption0(this.value);

  final String value;

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
  const TestRootUnionWithAllOfOptionOption1(this.value);

  final TestRootUnionWithAllOfOptionOptionType1 value;

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

  final String? a;

  final int? b;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<TestRootUnionWithAllOfOptionOptionType1>
  descriptor = ObjectDescriptor<TestRootUnionWithAllOfOptionOptionType1>(
    title: 'TestRootUnionWithAllOfOptionOptionType1',
    matches: (instance) => instance is TestRootUnionWithAllOfOptionOptionType1,
    instantiate: (fields) => TestRootUnionWithAllOfOptionOptionType1(
      a: (fields['a'] as String?),
      b: (fields['b'] as int?),
      additionalProperties: fields.entries
          .where((e) => !const <String>{'a', 'b'}.contains(e.key) && true)
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance =
          (instance as TestRootUnionWithAllOfOptionOptionType1);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  TestRootUnionWithAllOfOptionOptionType1 copyWith({
    String? a,
    int? b,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (a != null) {
      nextKeys?.add('a');
    }
    if (b != null) {
      nextKeys?.add('b');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return TestRootUnionWithAllOfOptionOptionType1(
      a: a ?? this.a,
      b: b ?? this.b,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  final String? name;

  static final _patternRegex0 = RegExp('^S_');

  static final _patternRegex1 = RegExp('^I_');

  static final _patternRegex2 = RegExp('^O_');

  final Map<String, dynamic> patternProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<PatternPropertiesObject> descriptor =
      ObjectDescriptor<PatternPropertiesObject>(
        title: 'PatternPropertiesObject',
        matches: (instance) => instance is PatternPropertiesObject,
        instantiate: (fields) => PatternPropertiesObject(
          name: (fields['name'] as String?),
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
          final typedInstance = (instance as PatternPropertiesObject);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  PatternPropertiesObject copyWith({
    String? name,
    Map<String, dynamic>? patternProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (name != null) {
      nextKeys?.add('name');
    }
    return PatternPropertiesObject(
      name: name ?? this.name,
      patternProperties: patternProperties ?? this.patternProperties,
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
              path: ['$key'],
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
              path: ['$key'],
              keyword: 'type',
            ),
          );
        } else {
          if (value < 0) {
            errors.add(
              ValidationError(
                message: 'Property "$key" must be >= 0',
                path: ['$key'],
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
              path: ['$key'],
              keyword: 'type',
            ),
          );
        } else {
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

  static final UnionDescriptor<OverlappingUnion> descriptor =
      UnionDescriptor<OverlappingUnion>(
        title: 'OverlappingUnion',
        activeOptions: [
          UnionOptionDescriptor<OverlappingUnion, OptionA>(
            RefDescriptor<OptionA>(() => OptionA.descriptor),
            (val) => OverlappingUnionOption0((val as OptionA)),
          ),
          UnionOptionDescriptor<OverlappingUnion, OptionB>(
            RefDescriptor<OptionB>(() => OptionB.descriptor),
            (val) => OverlappingUnionOption1((val as OptionB)),
          ),
        ],
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
}

final class OverlappingUnionOption0 extends OverlappingUnion {
  const OverlappingUnionOption0(this.value);

  final OptionA value;

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
  const OverlappingUnionOption1(this.value);

  final OptionB value;

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

  final String value;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<OptionA> descriptor = ObjectDescriptor<OptionA>(
    title: 'OptionA',
    matches: (instance) => instance is OptionA,
    instantiate: (fields) => OptionA(
      value: (fields['value'] as String),
      additionalProperties: fields.entries
          .where((e) => !const <String>{'value'}.contains(e.key) && true)
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = (instance as OptionA);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  OptionA copyWith({
    String? value,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (value != null) {
      nextKeys?.add('value');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return OptionA(
      value: value ?? this.value,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  final String value;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<OptionB> descriptor = ObjectDescriptor<OptionB>(
    title: 'OptionB',
    matches: (instance) => instance is OptionB,
    instantiate: (fields) => OptionB(
      value: (fields['value'] as String),
      additionalProperties: fields.entries
          .where((e) => !const <String>{'value'}.contains(e.key) && true)
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = (instance as OptionB);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  OptionB copyWith({
    String? value,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (value != null) {
      nextKeys?.add('value');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return OptionB(
      value: value ?? this.value,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  final String? foo;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<MyCustomClassName> descriptor =
      ObjectDescriptor<MyCustomClassName>(
        title: 'MyCustomClassName',
        matches: (instance) => instance is MyCustomClassName,
        instantiate: (fields) => MyCustomClassName(
          foo: (fields['foo'] as String?),
          additionalProperties: fields.entries
              .where((e) => !const <String>{'foo'}.contains(e.key) && true)
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = (instance as MyCustomClassName);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  MyCustomClassName copyWith({
    String? foo,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (foo != null) {
      nextKeys?.add('foo');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return MyCustomClassName(
      foo: foo ?? this.foo,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  static final UnionDescriptor<MyCustomUnionName> descriptor =
      UnionDescriptor<MyCustomUnionName>(
        title: 'MyCustomUnionName',
        activeOptions: [
          UnionOptionDescriptor<MyCustomUnionName, String>(
            const StringDescriptor(),
            (val) => MyCustomUnionNameOption0((val as String)),
          ),
          UnionOptionDescriptor<MyCustomUnionName, int>(
            const IntDescriptor(),
            (val) => MyCustomUnionNameOption1((val as int)),
          ),
        ],
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
}

final class MyCustomUnionNameOption0 extends MyCustomUnionName {
  const MyCustomUnionNameOption0(this.value);

  final String value;

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
  const MyCustomUnionNameOption1(this.value);

  final int value;

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

  const MyCustomEnumName(this.value);

  final String value;

  static final EnumDescriptor<MyCustomEnumName> descriptor =
      EnumDescriptor<MyCustomEnumName>(
        values: values,
        fromValue: (val) => fromValue((val as String)),
        toValue: (e) => (e as MyCustomEnumName).value,
        base: const StringDescriptor(),
      );

  static MyCustomEnumName fromValue(String val) =>
      values.firstWhere((e) => e.value == val);
}

final class TestRootCoverageTrigger implements JsonModel {
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

  static final ObjectDescriptor<TestRootCoverageTrigger>
  descriptor = ObjectDescriptor<TestRootCoverageTrigger>(
    title: 'TestRootCoverageTrigger',
    matches: (instance) => instance is TestRootCoverageTrigger,
    instantiate: (fields) => TestRootCoverageTrigger(
      mergeArray: (fields['mergeArray'] as List<String>?),
      mergeObject:
          (fields['mergeObject'] as TestRootCoverageTriggerMergeObject?),
      mergeString: (fields['mergeString'] as String?),
      mergeNumber: (fields['mergeNumber'] as Never?),
      mergeBoolean: (fields['mergeBoolean'] as bool?),
      mergeNull: (fields['mergeNull'] as Null),
      mergeAnything: (fields['mergeAnything'] as Object?),
      mergeNever: (fields['mergeNever'] as TestRootCoverageTriggerMergeNever?),
      mergeRef: (fields['mergeRef'] as MapObject1?),
      mergeEnum: (fields['mergeEnum'] as TestRootCoverageTriggerMergeEnum?),
      mergeUnion: (fields['mergeUnion'] as TestRootCoverageTriggerMergeUnion?),
      mergeObjectsWithNoAdditional:
          (fields['mergeObjectsWithNoAdditional']
              as TestRootCoverageTriggerMergeObjectsWithNoAdditional?),
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
      final typedInstance = (instance as TestRootCoverageTrigger);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  TestRootCoverageTrigger copyWith({
    List<String>? mergeArray,
    TestRootCoverageTriggerMergeObject? mergeObject,
    String? mergeString,
    Never? mergeNumber,
    bool? mergeBoolean,
    Null? mergeNull,
    Object? mergeAnything,
    TestRootCoverageTriggerMergeNever? mergeNever,
    MapObject1? mergeRef,
    TestRootCoverageTriggerMergeEnum? mergeEnum,
    TestRootCoverageTriggerMergeUnion? mergeUnion,
    TestRootCoverageTriggerMergeObjectsWithNoAdditional?
    mergeObjectsWithNoAdditional,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (mergeArray != null) {
      nextKeys?.add('mergeArray');
    }
    if (mergeObject != null) {
      nextKeys?.add('mergeObject');
    }
    if (mergeString != null) {
      nextKeys?.add('mergeString');
    }
    if (mergeNumber != null) {
      nextKeys?.add('mergeNumber');
    }
    if (mergeBoolean != null) {
      nextKeys?.add('mergeBoolean');
    }
    if (mergeNull != null) {
      nextKeys?.add('mergeNull');
    }
    if (mergeAnything != null) {
      nextKeys?.add('mergeAnything');
    }
    if (mergeNever != null) {
      nextKeys?.add('mergeNever');
    }
    if (mergeRef != null) {
      nextKeys?.add('mergeRef');
    }
    if (mergeEnum != null) {
      nextKeys?.add('mergeEnum');
    }
    if (mergeUnion != null) {
      nextKeys?.add('mergeUnion');
    }
    if (mergeObjectsWithNoAdditional != null) {
      nextKeys?.add('mergeObjectsWithNoAdditional');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return TestRootCoverageTrigger(
      mergeArray: mergeArray ?? this.mergeArray,
      mergeObject: mergeObject ?? this.mergeObject,
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
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  final String? a;

  final int? b;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<TestRootCoverageTriggerMergeObject> descriptor =
      ObjectDescriptor<TestRootCoverageTriggerMergeObject>(
        title: 'TestRootCoverageTriggerMergeObject',
        matches: (instance) => instance is TestRootCoverageTriggerMergeObject,
        instantiate: (fields) => TestRootCoverageTriggerMergeObject(
          a: (fields['a'] as String?),
          b: (fields['b'] as int?),
          additionalProperties: fields.entries
              .where((e) => !const <String>{'a', 'b'}.contains(e.key) && true)
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance =
              (instance as TestRootCoverageTriggerMergeObject);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  TestRootCoverageTriggerMergeObject copyWith({
    String? a,
    int? b,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (a != null) {
      nextKeys?.add('a');
    }
    if (b != null) {
      nextKeys?.add('b');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return TestRootCoverageTriggerMergeObject(
      a: a ?? this.a,
      b: b ?? this.b,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<TestRootCoverageTriggerMergeNever> descriptor =
      ObjectDescriptor<TestRootCoverageTriggerMergeNever>(
        title: 'TestRootCoverageTriggerMergeNever',
        matches: (instance) => instance is TestRootCoverageTriggerMergeNever,
        instantiate: (fields) => TestRootCoverageTriggerMergeNever(
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = (instance as TestRootCoverageTriggerMergeNever);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootCoverageTriggerMergeNever &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => Object.hashAll([]);

  @override
  String toString() => 'TestRootCoverageTriggerMergeNever()';
}

final class MapObject1 implements JsonModel {
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

  final String? name;

  final Map<String, String> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<MapObject1> descriptor =
      ObjectDescriptor<MapObject1>(
        title: 'MapObject1',
        matches: (instance) => instance is MapObject1,
        instantiate: (fields) => MapObject1(
          name: (fields['name'] as String?),
          additionalProperties: fields.entries
              .where((e) => !const <String>{'name'}.contains(e.key) && true)
              .fold<Map<String, String>>(
                {},
                (m, e) => m..[e.key] = e.value as String,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = (instance as MapObject1);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  MapObject1 copyWith({
    String? name,
    Map<String, String>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (name != null) {
      nextKeys?.add('name');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return MapObject1(
      name: name ?? this.name,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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
            path: ['$key'],
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

  const TestRootCoverageTriggerMergeEnum(this.value);

  final String value;

  static final EnumDescriptor<TestRootCoverageTriggerMergeEnum> descriptor =
      EnumDescriptor<TestRootCoverageTriggerMergeEnum>(
        values: values,
        fromValue: (val) => fromValue((val as String)),
        toValue: (e) => (e as TestRootCoverageTriggerMergeEnum).value,
        base: const StringDescriptor(),
      );

  static TestRootCoverageTriggerMergeEnum fromValue(String val) =>
      values.firstWhere((e) => e.value == val);
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

  static final UnionDescriptor<TestRootCoverageTriggerMergeUnion> descriptor =
      UnionDescriptor<TestRootCoverageTriggerMergeUnion>(
        title: 'TestRootCoverageTriggerMergeUnion',
        activeOptions: [
          UnionOptionDescriptor<TestRootCoverageTriggerMergeUnion, String>(
            const StringDescriptor(),
            (val) => TestRootCoverageTriggerMergeUnionOption0((val as String)),
          ),
          UnionOptionDescriptor<TestRootCoverageTriggerMergeUnion, int>(
            const IntDescriptor(),
            (val) => TestRootCoverageTriggerMergeUnionOption1((val as int)),
          ),
        ],
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
}

final class TestRootCoverageTriggerMergeUnionOption0
    extends TestRootCoverageTriggerMergeUnion {
  const TestRootCoverageTriggerMergeUnionOption0(this.value);

  final String value;

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
  const TestRootCoverageTriggerMergeUnionOption1(this.value);

  final int value;

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

  final Set<String>? _$explicitKeys;

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
              (instance as TestRootCoverageTriggerMergeObjectsWithNoAdditional);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRootCoverageTriggerMergeObjectsWithNoAdditional &&
          runtimeType == other.runtimeType;

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

  const CollidingEnum(this.value);

  final dynamic value;

  static final EnumDescriptor<CollidingEnum> descriptor =
      EnumDescriptor<CollidingEnum>(
        values: values,
        fromValue: (val) => fromValue((val as dynamic)),
        toValue: (e) => (e as CollidingEnum).value,
        base: const AnythingDescriptor(),
      );

  static CollidingEnum fromValue(dynamic val) =>
      values.firstWhere((e) => e.value == val);
}

final class CollidingObject implements JsonModel {
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

  final String? foo;

  final String? foo_1;

  final String? bar;

  final String? bar1;

  final String? validate_;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<CollidingObject> descriptor =
      ObjectDescriptor<CollidingObject>(
        title: 'CollidingObject',
        matches: (instance) => instance is CollidingObject,
        instantiate: (fields) => CollidingObject(
          foo: (fields['foo'] as String?),
          foo_1: (fields['@foo'] as String?),
          bar: (fields['bar'] as String?),
          bar1: (fields['bar_1'] as String?),
          validate_: (fields['validate'] as String?),
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
          final typedInstance = (instance as CollidingObject);
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
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  CollidingObject copyWith({
    String? foo,
    String? foo_1,
    String? bar,
    String? bar1,
    String? validate_,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (foo != null) {
      nextKeys?.add('foo');
    }
    if (foo_1 != null) {
      nextKeys?.add('@foo');
    }
    if (bar != null) {
      nextKeys?.add('bar');
    }
    if (bar1 != null) {
      nextKeys?.add('bar_1');
    }
    if (validate_ != null) {
      nextKeys?.add('validate');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return CollidingObject(
      foo: foo ?? this.foo,
      foo_1: foo_1 ?? this.foo_1,
      bar: bar ?? this.bar,
      bar1: bar1 ?? this.bar1,
      validate_: validate_ ?? this.validate_,
      additionalProperties: additionalProperties ?? this.additionalProperties,
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
