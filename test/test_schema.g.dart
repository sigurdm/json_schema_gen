// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';

final class TestRoot implements JsonModel {
  final String name;
  final int age;
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

  const TestRoot({
    required this.name,
    required this.age,
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
    int? age,
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
  }) => TestRoot(
    name: name ?? this.name,
    age: age ?? this.age,
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
  }

  static final descriptor = ObjectDescriptor<TestRoot>(
    title: 'TestRoot',
    matches: (instance) => instance is TestRoot,
    instantiate: (fields) => TestRoot(
      name: fields['name'] as String,
      age: fields['age'] as int,
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
    ),
    getFields: (instance) => {
      'name': instance.name,
      'age': instance.age,
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
    },
    properties: {
      'name': PropertyDescriptor(
        name: 'name',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
      'age': PropertyDescriptor(
        name: 'age',
        isRequired: true,
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
        schema: ArrayDescriptor(const StringDescriptor()),
      ),
      'scores': PropertyDescriptor(
        name: 'scores',
        isRequired: false,
        schema: ArrayDescriptor(Score.descriptor),
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
    },
    required: const ['name', 'age', 'isAwesome', 'address'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestRoot &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          age == other.age &&
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
          pet == other.pet;

  @override
  int get hashCode => Object.hashAll([
    name,
    age,
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
  ]);

  @override
  String toString() =>
      'TestRoot(name: ${name}, age: ${age}, height: ${height}, email: ${email}, uuid: ${uuid}, isAwesome: ${isAwesome}, class_: ${class_}, reader: ${reader}, stack: ${stack}, validate_: ${validate_}, result: ${result}, address: ${address}, tags: ${tags}, scores: ${scores}, unionValue: ${unionValue}, nullableString: ${nullableString}, pet: ${pet})';
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
