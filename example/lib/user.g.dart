// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides

import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';

final class User implements JsonModel {
  final int id;
  final String name;
  final String email;
  final int? age;
  final UserRole role;
  final UserProfile? profile;
  final Address? address;
  final List<String>? tags;
  final UserPreferences? preferences;
  final String? createdAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.age,
    this.role = UserRole.user,
    this.profile,
    this.address,
    this.tags,
    this.preferences,
    this.createdAt,
  });

  factory User.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as User;

  /// Creates an instance of [User] from a JSON Map.
  factory User.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      User.fromJson(JsonReader.fromObject(map), validate: validate);

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

  User copyWith({
    int? id,
    String? name,
    String? email,
    int? age,
    UserRole? role,
    UserProfile? profile,
    Address? address,
    List<String>? tags,
    UserPreferences? preferences,
    String? createdAt,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    age: age ?? this.age,
    role: role ?? this.role,
    profile: profile ?? this.profile,
    address: address ?? this.address,
    tags: tags ?? this.tags,
    preferences: preferences ?? this.preferences,
    createdAt: createdAt ?? this.createdAt,
  );

  void validate() {
    if (name.length < 2) {
      throw JsonValidationException('Property "name" length must be >= 2', [
        'name',
      ]);
    }
    if (!RegExp(r'^[^@]+@[^@]+$').hasMatch(email)) {
      throw JsonValidationException(
        'Property "email" must be a valid email address',
        ['email'],
      );
    }
    final val_age = age;
    if (val_age != null) {
      if (val_age < 0) {
        throw JsonValidationException('Property "age" must be >= 0', ['age']);
      }
    }
    if (!const [
      UserRole.admin,
      UserRole.editor,
      UserRole.user,
    ].any((v) => const DeepCollectionEquality().equals(v, role))) {
      throw JsonValidationException(
        'Property "role" must be one of [admin, editor, user]',
        ['role'],
      );
    }
    final val_profile = profile;
    if (val_profile != null) {
      try {
        val_profile.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['profile', ...e.path]);
      }
    }
    final val_address = address;
    if (val_address != null) {
      try {
        val_address.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['address', ...e.path]);
      }
    }
    final val_tags = tags;
    if (val_tags != null) {
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
    final val_preferences = preferences;
    if (val_preferences != null) {
      try {
        val_preferences.validate();
      } on JsonValidationException catch (e) {
        throw JsonValidationException(e.message, ['preferences', ...e.path]);
      }
    }
    final val_createdAt = createdAt;
    if (val_createdAt != null) {
      if (DateTime.tryParse(val_createdAt) == null) {
        throw JsonValidationException(
          'Property "createdAt" must be a valid RFC 3339 date-time string',
          ['createdAt'],
        );
      }
    }
  }

  static final descriptor = ObjectDescriptor<User>(
    title: 'User',
    matches: (instance) => instance is User,
    instantiate: (fields) => User(
      id: fields['id'] as int,
      name: fields['name'] as String,
      email: fields['email'] as String,
      age: fields['age'] as int?,
      role: fields.containsKey('role')
          ? fields['role'] as UserRole
          : UserRole.user,
      profile: fields['profile'] as UserProfile?,
      address: fields['address'] as Address?,
      tags: fields['tags'] as List<String>?,
      preferences: fields['preferences'] as UserPreferences?,
      createdAt: fields['createdAt'] as String?,
    ),
    getFields: (instance) {
      final typedInstance = instance as User;
      return {
        'id': typedInstance.id,
        'name': typedInstance.name,
        'email': typedInstance.email,
        'age': typedInstance.age,
        'role': typedInstance.role,
        'profile': typedInstance.profile,
        'address': typedInstance.address,
        'tags': typedInstance.tags,
        'preferences': typedInstance.preferences,
        'createdAt': typedInstance.createdAt,
      };
    },
    properties: {
      'id': PropertyDescriptor(
        name: 'id',
        isRequired: true,
        schema: const IntDescriptor(),
      ),
      'name': PropertyDescriptor(
        name: 'name',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
      'email': PropertyDescriptor(
        name: 'email',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
      'age': PropertyDescriptor(
        name: 'age',
        isRequired: false,
        schema: const IntDescriptor(),
      ),
      'role': PropertyDescriptor(
        name: 'role',
        isRequired: false,
        schema: UserRole.descriptor,
      ),
      'profile': PropertyDescriptor(
        name: 'profile',
        isRequired: false,
        schema: UserProfile.descriptor,
      ),
      'address': PropertyDescriptor(
        name: 'address',
        isRequired: false,
        schema: Address.descriptor,
      ),
      'tags': PropertyDescriptor(
        name: 'tags',
        isRequired: false,
        schema: ArrayDescriptor<String>(const StringDescriptor()),
      ),
      'preferences': PropertyDescriptor(
        name: 'preferences',
        isRequired: false,
        schema: UserPreferences.descriptor,
      ),
      'createdAt': PropertyDescriptor(
        name: 'createdAt',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
    },

    required: const ['id', 'name', 'email'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          age == other.age &&
          role == other.role &&
          profile == other.profile &&
          address == other.address &&
          const DeepCollectionEquality().equals(tags, other.tags) &&
          preferences == other.preferences &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    email,
    age,
    role,
    profile,
    address,
    const DeepCollectionEquality().hash(tags),
    preferences,
    createdAt,
  ]);

  @override
  String toString() =>
      'User(id: ${id}, name: ${name}, email: ${email}, age: ${age}, role: ${role}, profile: ${profile}, address: ${address}, tags: ${tags}, preferences: ${preferences}, createdAt: ${createdAt})';
}

enum UserRole {
  admin('admin'),
  editor('editor'),
  user('user');

  final String value;
  const UserRole(this.value);
  static UserRole fromValue(String val) =>
      values.firstWhere((e) => e.value == val);
  static final descriptor = EnumDescriptor<UserRole>(
    values: values,
    fromValue: (val) => fromValue(val as String),
    toValue: (e) => (e as UserRole).value,
    base: const StringDescriptor(),
  );
}

final class UserProfile implements JsonModel {
  final String? avatarUrl;
  final String? bio;

  const UserProfile({this.avatarUrl, this.bio});

  factory UserProfile.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as UserProfile;

  /// Creates an instance of [UserProfile] from a JSON Map.
  factory UserProfile.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => UserProfile.fromJson(JsonReader.fromObject(map), validate: validate);

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

  UserProfile copyWith({String? avatarUrl, String? bio}) =>
      UserProfile(avatarUrl: avatarUrl ?? this.avatarUrl, bio: bio ?? this.bio);

  void validate() {
    final val_avatarUrl = avatarUrl;
    if (val_avatarUrl != null) {
      if (!isValidUri(val_avatarUrl)) {
        throw JsonValidationException(
          'Property "avatarUrl" must be a valid absolute URI',
          ['avatarUrl'],
        );
      }
    }
    final val_bio = bio;
  }

  static final descriptor = ObjectDescriptor<UserProfile>(
    title: 'UserProfile',
    matches: (instance) => instance is UserProfile,
    instantiate: (fields) => UserProfile(
      avatarUrl: fields['avatarUrl'] as String?,
      bio: fields['bio'] as String?,
    ),
    getFields: (instance) {
      final typedInstance = instance as UserProfile;
      return {'avatarUrl': typedInstance.avatarUrl, 'bio': typedInstance.bio};
    },
    properties: {
      'avatarUrl': PropertyDescriptor(
        name: 'avatarUrl',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'bio': PropertyDescriptor(
        name: 'bio',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
    },

    required: const [],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          avatarUrl == other.avatarUrl &&
          bio == other.bio;

  @override
  int get hashCode => Object.hashAll([avatarUrl, bio]);

  @override
  String toString() => 'UserProfile(avatarUrl: ${avatarUrl}, bio: ${bio})';
}

final class Address implements JsonModel {
  final String? street;
  final String city;
  final String? zipCode;

  const Address({this.street, required this.city, this.zipCode});

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

  Address copyWith({String? street, String? city, String? zipCode}) => Address(
    street: street ?? this.street,
    city: city ?? this.city,
    zipCode: zipCode ?? this.zipCode,
  );

  void validate() {
    final val_street = street;
    final val_zipCode = zipCode;
    if (val_zipCode != null) {
      if (!RegExp('^[0-9]{5}\$').hasMatch(val_zipCode)) {
        throw JsonValidationException(
          'Property "zipCode" must match pattern "^[0-9]{5}\$"',
          ['zipCode'],
        );
      }
    }
  }

  static final descriptor = ObjectDescriptor<Address>(
    title: 'Address',
    matches: (instance) => instance is Address,
    instantiate: (fields) => Address(
      street: fields['street'] as String?,
      city: fields['city'] as String,
      zipCode: fields['zipCode'] as String?,
    ),
    getFields: (instance) {
      final typedInstance = instance as Address;
      return {
        'street': typedInstance.street,
        'city': typedInstance.city,
        'zipCode': typedInstance.zipCode,
      };
    },
    properties: {
      'street': PropertyDescriptor(
        name: 'street',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
      'city': PropertyDescriptor(
        name: 'city',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
      'zipCode': PropertyDescriptor(
        name: 'zipCode',
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
          street == other.street &&
          city == other.city &&
          zipCode == other.zipCode;

  @override
  int get hashCode => Object.hashAll([street, city, zipCode]);

  @override
  String toString() =>
      'Address(street: ${street}, city: ${city}, zipCode: ${zipCode})';
}

final class UserPreferences implements JsonModel {
  final Map<String, String> additionalProperties;

  const UserPreferences({this.additionalProperties = const {}});

  factory UserPreferences.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as UserPreferences;

  /// Creates an instance of [UserPreferences] from a JSON Map.
  factory UserPreferences.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) =>
      UserPreferences.fromJson(JsonReader.fromObject(map), validate: validate);

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

  UserPreferences copyWith({Map<String, String>? additionalProperties}) =>
      UserPreferences(
        additionalProperties: additionalProperties ?? this.additionalProperties,
      );

  void validate() {}

  static final descriptor = ObjectDescriptor<UserPreferences>(
    title: 'UserPreferences',
    matches: (instance) => instance is UserPreferences,
    instantiate: (fields) => UserPreferences(
      additionalProperties: fields.entries
          .where((e) {
            if (const <String>{}.contains(e.key)) return false;
            return true;
          })
          .fold<Map<String, String>>(
            {},
            (m, e) => m..[e.key] = e.value as String,
          ),
    ),
    getFields: (instance) {
      final typedInstance = instance as UserPreferences;
      return {...typedInstance.additionalProperties};
    },
    properties: {},

    required: const [],
    additionalProperties: const StringDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPreferences &&
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
      'UserPreferences(additionalProperties: ${additionalProperties})';
}
