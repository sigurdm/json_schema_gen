// GENERATED CODE - DO NOT MODIFY BY HAND

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
  final String? nullableString;
  final Pet? pet;
  final RestrictedObject? restrictedObject;
  final DependentObject? dependentObject;
  final List<int>? restrictedArray;
  @deprecated
  final String? deprecatedField;
  final DeprecatedObject? deprecatedRef;
  final String defaultString;
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
    this.nullableString,
    this.pet,
    this.restrictedObject,
    this.dependentObject,
    this.restrictedArray,
    this.deprecatedField,
    this.deprecatedRef,
    this.defaultString = 'default value',
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
  });

  factory TestRoot.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as TestRoot;

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

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
    String? nullableString,
    Pet? pet,
    RestrictedObject? restrictedObject,
    DependentObject? dependentObject,
    List<int>? restrictedArray,
    String? deprecatedField,
    DeprecatedObject? deprecatedRef,
    String? defaultString,
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
    nullableString: nullableString ?? this.nullableString,
    pet: pet ?? this.pet,
    restrictedObject: restrictedObject ?? this.restrictedObject,
    dependentObject: dependentObject ?? this.dependentObject,
    restrictedArray: restrictedArray ?? this.restrictedArray,
    deprecatedField: deprecatedField ?? this.deprecatedField,
    deprecatedRef: deprecatedRef ?? this.deprecatedRef,
    defaultString: defaultString ?? this.defaultString,
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
  );

  void validate() {
    if (name.length < 2) {
      throw JsonValidationException('Property "name" length must be >= 2', [
        'name',
      ]);
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
    final val_email = email;
    if (val_email != null) {
      if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9.]+$').hasMatch(val_email)) {
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
      if (val_tags.length != val_tags.toSet().length) {
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
    final val_restrictedArray = restrictedArray;
    if (val_restrictedArray != null) {
      var containsCount = 0;
      for (final dynamic item in val_restrictedArray) {
        bool matches = false;
        if (item is int) {
          matches = true;
          if (item < 5) matches = false;
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
    final val_deprecatedRef = deprecatedRef;
    if (val_deprecatedRef != null) {
      try {
        val_deprecatedRef.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['deprecatedRef', ...e.path]);
      }
    }
    try {
      defaultObject.validate();
    } on JsonValidationException catch (e) {
      throw JsonValidationException(e.message, ['defaultObject', ...e.path]);
    }
    final val_mergedValue = mergedValue;
    if (val_mergedValue != null) {
      try {
        val_mergedValue.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['mergedValue', ...e.path]);
      }
    }
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
      nullableString: fields['nullableString'] as String?,
      pet: fields['pet'] as Pet?,
      restrictedObject: fields['restrictedObject'] as RestrictedObject?,
      dependentObject: fields['dependentObject'] as DependentObject?,
      restrictedArray: fields['restrictedArray'] as List<int>?,
      deprecatedField: fields['deprecatedField'] as String?,
      deprecatedRef: fields['deprecatedRef'] as DeprecatedObject?,
      defaultString: fields.containsKey('defaultString')
          ? fields['defaultString'] as String
          : 'default value',
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
    ),
    getFields: (instance) => {
      'name': instance.name,
      'constValue': instance.constValue,
      'age': instance.age,
      'exclusiveAge': instance.exclusiveAge,
      'height': instance.height,
      'email': instance.email,
      'uuid': instance.uuid,
      'isAwesome': instance.isAwesome,
      'class': instance.class_,
      'reader': instance.reader,
      'stack': instance.stack,
      'validate': instance.validate_,
      'result': instance.result,
      'address': instance.address,
      'tags': instance.tags,
      'scores': instance.scores,
      'unionValue': instance.unionValue,
      'nullableString': instance.nullableString,
      'pet': instance.pet,
      'restrictedObject': instance.restrictedObject,
      'dependentObject': instance.dependentObject,
      'restrictedArray': instance.restrictedArray,
      'deprecatedField': instance.deprecatedField,
      'deprecatedRef': instance.deprecatedRef,
      'defaultString': instance.defaultString,
      'defaultInt': instance.defaultInt,
      'defaultBool': instance.defaultBool,
      'defaultList': instance.defaultList,
      'defaultObject': instance.defaultObject,
      'defaultNullableString': instance.defaultNullableString,
      'mergedValue': instance.mergedValue,
      'tupleArray': instance.tupleArray,
      'tupleObjectArray': instance.tupleObjectArray,
      'ipv6Value': instance.ipv6Value,
      'hostnameValue': instance.hostnameValue,
      'timeValue': instance.timeValue,
      'uriReferenceValue': instance.uriReferenceValue,
      'additionalPropertiesObject': instance.additionalPropertiesObject,
      'strictObject': instance.strictObject,
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
          tags == other.tags &&
          scores == other.scores &&
          unionValue == other.unionValue &&
          nullableString == other.nullableString &&
          pet == other.pet &&
          restrictedObject == other.restrictedObject &&
          dependentObject == other.dependentObject &&
          restrictedArray == other.restrictedArray &&
          deprecatedField == other.deprecatedField &&
          deprecatedRef == other.deprecatedRef &&
          defaultString == other.defaultString &&
          defaultInt == other.defaultInt &&
          defaultBool == other.defaultBool &&
          defaultList == other.defaultList &&
          defaultObject == other.defaultObject &&
          defaultNullableString == other.defaultNullableString &&
          mergedValue == other.mergedValue &&
          tupleArray == other.tupleArray &&
          tupleObjectArray == other.tupleObjectArray &&
          ipv6Value == other.ipv6Value &&
          hostnameValue == other.hostnameValue &&
          timeValue == other.timeValue &&
          uriReferenceValue == other.uriReferenceValue &&
          additionalPropertiesObject == other.additionalPropertiesObject &&
          strictObject == other.strictObject;

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
    tags,
    scores,
    unionValue,
    nullableString,
    pet,
    restrictedObject,
    dependentObject,
    restrictedArray,
    deprecatedField,
    deprecatedRef,
    defaultString,
    defaultInt,
    defaultBool,
    defaultList,
    defaultObject,
    defaultNullableString,
    mergedValue,
    tupleArray,
    tupleObjectArray,
    ipv6Value,
    hostnameValue,
    timeValue,
    uriReferenceValue,
    additionalPropertiesObject,
    strictObject,
  ]);

  @override
  String toString() =>
      'TestRoot(name: ${name}, constValue: ${constValue}, age: ${age}, exclusiveAge: ${exclusiveAge}, height: ${height}, email: ${email}, uuid: ${uuid}, isAwesome: ${isAwesome}, class_: ${class_}, reader: ${reader}, stack: ${stack}, validate_: ${validate_}, result: ${result}, address: ${address}, tags: ${tags}, scores: ${scores}, unionValue: ${unionValue}, nullableString: ${nullableString}, pet: ${pet}, restrictedObject: ${restrictedObject}, dependentObject: ${dependentObject}, restrictedArray: ${restrictedArray}, deprecatedField: ${deprecatedField}, deprecatedRef: ${deprecatedRef}, defaultString: ${defaultString}, defaultInt: ${defaultInt}, defaultBool: ${defaultBool}, defaultList: ${defaultList}, defaultObject: ${defaultObject}, defaultNullableString: ${defaultNullableString}, mergedValue: ${mergedValue}, tupleArray: ${tupleArray}, tupleObjectArray: ${tupleObjectArray}, ipv6Value: ${ipv6Value}, hostnameValue: ${hostnameValue}, timeValue: ${timeValue}, uriReferenceValue: ${uriReferenceValue}, additionalPropertiesObject: ${additionalPropertiesObject}, strictObject: ${strictObject})';
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

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  Address copyWith({String? city, String? street}) =>
      Address(city: city ?? this.city, street: street ?? this.street);

  void validate() {
    if (city.length < 3) {
      throw JsonValidationException('Property "city" length must be >= 3', [
        'city',
      ]);
    }
  }

  static final descriptor = ObjectDescriptor<Address>(
    title: 'Address',
    matches: (instance) => instance is Address,
    instantiate: (fields) => Address(
      city: fields['city'] as String,
      street: fields['street'] as String?,
    ),
    getFields: (instance) => {'city': instance.city, 'street': instance.street},
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

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

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
    getFields: (instance) => {'value': instance.value},
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

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  static final descriptor = UnionDescriptor<TestRootUnionValue>(
    title: 'TestRootUnionValue',

    activeOptions: [
      UnionOptionDescriptor<TestRootUnionValue, dynamic>(
        const StringDescriptor(),
        (val) => TestRootUnionValueOption0(val),
      ),
      UnionOptionDescriptor<TestRootUnionValue, dynamic>(
        Address.descriptor,
        (val) => TestRootUnionValueOption1(val),
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

sealed class Pet implements JsonModel {
  const Pet();

  factory Pet.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as Pet;

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  static final descriptor = UnionDescriptor<Pet>(
    title: 'Pet',
    discriminatorProperty: 'kind',
    discriminatorMapping: {
      'cat_type': UnionOptionDescriptor<Pet, dynamic>(
        Cat.descriptor,
        (val) => PetOption0(val),
      ),
      'Cat': UnionOptionDescriptor<Pet, dynamic>(
        Cat.descriptor,
        (val) => PetOption0(val),
      ),
      'PetOption0': UnionOptionDescriptor<Pet, dynamic>(
        Cat.descriptor,
        (val) => PetOption0(val),
      ),
      'dog_type': UnionOptionDescriptor<Pet, dynamic>(
        Dog.descriptor,
        (val) => PetOption1(val),
      ),
      'Dog': UnionOptionDescriptor<Pet, dynamic>(
        Dog.descriptor,
        (val) => PetOption1(val),
      ),
      'PetOption1': UnionOptionDescriptor<Pet, dynamic>(
        Dog.descriptor,
        (val) => PetOption1(val),
      ),
    },
    activeOptions: [
      UnionOptionDescriptor<Pet, dynamic>(
        Cat.descriptor,
        (val) => PetOption0(val),
      ),
      UnionOptionDescriptor<Pet, dynamic>(
        Dog.descriptor,
        (val) => PetOption1(val),
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

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  Cat copyWith({String? kind, num? meowVolume}) =>
      Cat(kind: kind ?? this.kind, meowVolume: meowVolume ?? this.meowVolume);

  void validate() {}

  static final descriptor = ObjectDescriptor<Cat>(
    title: 'Cat',
    matches: (instance) => instance is Cat,
    instantiate: (fields) => Cat(
      kind: fields['kind'] as String,
      meowVolume: fields['meowVolume'] as num?,
    ),
    getFields: (instance) => {
      'kind': instance.kind,
      'meowVolume': instance.meowVolume,
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

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  Dog copyWith({String? kind, num? barkVolume}) =>
      Dog(kind: kind ?? this.kind, barkVolume: barkVolume ?? this.barkVolume);

  void validate() {}

  static final descriptor = ObjectDescriptor<Dog>(
    title: 'Dog',
    matches: (instance) => instance is Dog,
    instantiate: (fields) => Dog(
      kind: fields['kind'] as String,
      barkVolume: fields['barkVolume'] as num?,
    ),
    getFields: (instance) => {
      'kind': instance.kind,
      'barkVolume': instance.barkVolume,
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

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

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
  }

  static final descriptor = ObjectDescriptor<RestrictedObject>(
    title: 'RestrictedObject',
    matches: (instance) => instance is RestrictedObject,
    instantiate: (fields) => RestrictedObject(
      a: fields['a'] as String?,
      b: fields['b'] as String?,
      c: fields['c'] as String?,
    ),
    getFields: (instance) => {
      'a': instance.a,
      'b': instance.b,
      'c': instance.c,
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

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

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
  }

  static final descriptor = ObjectDescriptor<DependentObject>(
    title: 'DependentObject',
    matches: (instance) => instance is DependentObject,
    instantiate: (fields) => DependentObject(
      creditCard: fields['creditCard'] as num?,
      billingAddress: fields['billingAddress'] as String?,
    ),
    getFields: (instance) => {
      'creditCard': instance.creditCard,
      'billingAddress': instance.billingAddress,
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

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  DeprecatedObject copyWith({String? value}) =>
      DeprecatedObject(value: value ?? this.value);

  void validate() {}

  static final descriptor = ObjectDescriptor<DeprecatedObject>(
    title: 'DeprecatedObject',
    matches: (instance) => instance is DeprecatedObject,
    instantiate: (fields) =>
        DeprecatedObject(value: fields['value'] as String?),
    getFields: (instance) => {'value': instance.value},
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

final class Merged implements JsonModel {
  final String? a;
  final int? b;
  final bool? c;

  const Merged({this.a, this.b, this.c});

  factory Merged.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as Merged;

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  Merged copyWith({String? a, int? b, bool? c}) =>
      Merged(a: a ?? this.a, b: b ?? this.b, c: c ?? this.c);

  void validate() {}

  static final descriptor = ObjectDescriptor<Merged>(
    title: 'Merged',
    matches: (instance) => instance is Merged,
    instantiate: (fields) => Merged(
      a: fields['a'] as String?,
      b: fields['b'] as int?,
      c: fields['c'] as bool?,
    ),
    getFields: (instance) => {
      'a': instance.a,
      'b': instance.b,
      'c': instance.c,
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

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  MapObject copyWith({
    String? name,
    Map<String, String>? additionalProperties,
  }) => MapObject(
    name: name ?? this.name,
    additionalProperties: additionalProperties ?? this.additionalProperties,
  );

  void validate() {}

  static final descriptor = ObjectDescriptor<MapObject>(
    title: 'MapObject',
    matches: (instance) => instance is MapObject,
    instantiate: (fields) => MapObject(
      name: fields['name'] as String?,
      additionalProperties: fields.entries
          .where((e) => !const {'name'}.contains(e.key))
          .fold<Map<String, String>>(
            {},
            (m, e) => m..[e.key] = e.value as String,
          ),
    ),
    getFields: (instance) => {
      'name': instance.name,
      ...instance.additionalProperties,
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
          additionalProperties.length == other.additionalProperties.length &&
          additionalProperties.keys.every(
            (k) =>
                other.additionalProperties.containsKey(k) &&
                other.additionalProperties[k] == additionalProperties[k],
          );

  @override
  int get hashCode => Object.hashAll([
    name,
    additionalProperties.entries.fold<int>(
      0,
      (sum, entry) => sum ^ Object.hash(entry.key, entry.value),
    ),
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

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  StrictObject copyWith({String? name}) =>
      StrictObject(name: name ?? this.name);

  void validate() {}

  static final descriptor = ObjectDescriptor<StrictObject>(
    title: 'StrictObject',
    matches: (instance) => instance is StrictObject,
    instantiate: (fields) => StrictObject(name: fields['name'] as String?),
    getFields: (instance) => {'name': instance.name},
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
