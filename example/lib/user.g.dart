// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides, unnecessary_null_comparison
// ignore_for_file: prefer_is_empty, unnecessary_string_interpolations, avoid_init_to_null, unnecessary_const
// ignore_for_file: unnecessary_question_mark, unnecessary_cast

import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';

final class User implements JsonModel {
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
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory User.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as User;

  /// Creates an instance of [User] from a JSON Map.
  factory User.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      User.fromJson(JsonReader.fromObject(map), validate: validate);

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

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<User> descriptor = ObjectDescriptor<User>(
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
      additionalProperties: fields.entries
          .where(
            (e) =>
                !const <String>{
                  'id',
                  'name',
                  'email',
                  'age',
                  'role',
                  'profile',
                  'address',
                  'tags',
                  'preferences',
                  'createdAt',
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
      final typedInstance = instance as User;
      final map = <String, dynamic>{
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
        schema: RefDescriptor<UserProfile>(() => UserProfile.descriptor),
      ),
      'address': PropertyDescriptor(
        name: 'address',
        isRequired: false,
        schema: RefDescriptor<Address>(() => Address.descriptor),
      ),
      'tags': PropertyDescriptor(
        name: 'tags',
        isRequired: false,
        schema: ArrayDescriptor<String>(const StringDescriptor()),
      ),
      'preferences': PropertyDescriptor(
        name: 'preferences',
        isRequired: false,
        schema: RefDescriptor<UserPreferences>(
          () => UserPreferences.descriptor,
        ),
      ),
      'createdAt': PropertyDescriptor(
        name: 'createdAt',
        isRequired: false,
        schema: const StringDescriptor(),
      ),
    },

    required: const ['id', 'name', 'email'],
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
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (id != null) {
      nextKeys?.add('id');
    }
    if (name != null) {
      nextKeys?.add('name');
    }
    if (email != null) {
      nextKeys?.add('email');
    }
    if (age != null) {
      nextKeys?.add('age');
    }
    if (role != null) {
      nextKeys?.add('role');
    }
    if (profile != null) {
      nextKeys?.add('profile');
    }
    if (address != null) {
      nextKeys?.add('address');
    }
    if (tags != null) {
      nextKeys?.add('tags');
    }
    if (preferences != null) {
      nextKeys?.add('preferences');
    }
    if (createdAt != null) {
      nextKeys?.add('createdAt');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return User(
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
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (name.runes.length < 2) {
      errors.add(
        ValidationError(
          message: 'Property "name" length must be >= 2',
          path: ['name'],
          keyword: 'minLength',
        ),
      );
    }
    if (!(RegExp(r'^[^@]+@[^@]+$').hasMatch(email))) {
      errors.add(
        ValidationError(
          message: 'Property "email" must be a valid email address',
          path: ['email'],
          keyword: 'format',
        ),
      );
    }
    final val_age = age;
    if (val_age != null) {
      if (val_age < 0) {
        errors.add(
          ValidationError(
            message: 'Property "age" must be >= 0',
            path: ['age'],
            keyword: 'minimum',
          ),
        );
      }
    }
    final val_profile = profile;
    if (val_profile != null) {
      errors.addAll(
        (val_profile as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['profile', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_address = address;
    if (val_address != null) {
      errors.addAll(
        (val_address as JsonModel).collectErrors().map(
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
    }
    final val_tags = tags;
    if (val_tags != null) {
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
    final val_preferences = preferences;
    if (val_preferences != null) {
      errors.addAll(
        (val_preferences as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['preferences', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
        ),
      );
    }
    final val_createdAt = createdAt;
    if (val_createdAt != null) {
      if (DateTime.tryParse(val_createdAt) == null) {
        errors.add(
          ValidationError(
            message:
                'Property "createdAt" must be a valid RFC 3339 date-time string',
            path: ['createdAt'],
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
          createdAt == other.createdAt &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

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
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'User(id: ${id}, name: ${name}, email: ${email}, age: ${age}, role: ${role}, profile: ${profile}, address: ${address}, tags: ${tags}, preferences: ${preferences}, createdAt: ${createdAt}, additionalProperties: ${additionalProperties})';
}

enum UserRole {
  admin('admin'),
  editor('editor'),
  user('user');

  const UserRole(this.value);

  final String value;

  static final EnumDescriptor<UserRole> descriptor = EnumDescriptor<UserRole>(
    values: values,
    fromValue: (val) => fromValue(val as String),
    toValue: (e) => (e as UserRole).value,
    base: const StringDescriptor(),
  );

  static UserRole fromValue(String val) =>
      values.firstWhere((e) => e.value == val);
}

final class UserProfile implements JsonModel {
  const UserProfile({
    this.avatarUrl,
    this.bio,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory UserProfile.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as UserProfile;

  /// Creates an instance of [UserProfile] from a JSON Map.
  factory UserProfile.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => UserProfile.fromJson(JsonReader.fromObject(map), validate: validate);

  final String? avatarUrl;

  final String? bio;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<UserProfile> descriptor =
      ObjectDescriptor<UserProfile>(
        title: 'UserProfile',
        matches: (instance) => instance is UserProfile,
        instantiate: (fields) => UserProfile(
          avatarUrl: fields['avatarUrl'] as String?,
          bio: fields['bio'] as String?,
          additionalProperties: fields.entries
              .where(
                (e) =>
                    !const <String>{'avatarUrl', 'bio'}.contains(e.key) && true,
              )
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as UserProfile;
          final map = <String, dynamic>{
            'avatarUrl': typedInstance.avatarUrl,
            'bio': typedInstance.bio,
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
  Map<String, dynamic> toMap() => toJsonValue() as Map<String, dynamic>;

  UserProfile copyWith({
    String? avatarUrl,
    String? bio,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (avatarUrl != null) {
      nextKeys?.add('avatarUrl');
    }
    if (bio != null) {
      nextKeys?.add('bio');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return UserProfile(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_avatarUrl = avatarUrl;
    if (val_avatarUrl != null) {
      if (!(isValidUri(val_avatarUrl))) {
        errors.add(
          ValidationError(
            message: 'Property "avatarUrl" must be a valid absolute URI',
            path: ['avatarUrl'],
            keyword: 'format',
          ),
        );
      }
    }
    final val_bio = bio;
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
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          avatarUrl == other.avatarUrl &&
          bio == other.bio &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    avatarUrl,
    bio,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'UserProfile(avatarUrl: ${avatarUrl}, bio: ${bio}, additionalProperties: ${additionalProperties})';
}

final class Address implements JsonModel {
  const Address({
    this.street,
    required this.city,
    this.zipCode,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory Address.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as Address;

  /// Creates an instance of [Address] from a JSON Map.
  factory Address.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      Address.fromJson(JsonReader.fromObject(map), validate: validate);

  final String? street;

  final String city;

  final String? zipCode;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<Address> descriptor = ObjectDescriptor<Address>(
    title: 'Address',
    matches: (instance) => instance is Address,
    instantiate: (fields) => Address(
      street: fields['street'] as String?,
      city: fields['city'] as String,
      zipCode: fields['zipCode'] as String?,
      additionalProperties: fields.entries
          .where(
            (e) =>
                !const <String>{'street', 'city', 'zipCode'}.contains(e.key) &&
                true,
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
        'street': typedInstance.street,
        'city': typedInstance.city,
        'zipCode': typedInstance.zipCode,
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
  Map<String, dynamic> toMap() => toJsonValue() as Map<String, dynamic>;

  Address copyWith({
    String? street,
    String? city,
    String? zipCode,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (street != null) {
      nextKeys?.add('street');
    }
    if (city != null) {
      nextKeys?.add('city');
    }
    if (zipCode != null) {
      nextKeys?.add('zipCode');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return Address(
      street: street ?? this.street,
      city: city ?? this.city,
      zipCode: zipCode ?? this.zipCode,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_street = street;
    final val_zipCode = zipCode;
    if (val_zipCode != null) {
      if (!RegExp('^[0-9]{5}\$').hasMatch(val_zipCode)) {
        errors.add(
          ValidationError(
            message: 'Property "zipCode" must match pattern "^[0-9]{5}\$"',
            path: ['zipCode'],
            keyword: 'pattern',
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
      other is Address &&
          runtimeType == other.runtimeType &&
          street == other.street &&
          city == other.city &&
          zipCode == other.zipCode &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    street,
    city,
    zipCode,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'Address(street: ${street}, city: ${city}, zipCode: ${zipCode}, additionalProperties: ${additionalProperties})';
}

final class UserPreferences implements JsonModel {
  const UserPreferences({
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory UserPreferences.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as UserPreferences;

  /// Creates an instance of [UserPreferences] from a JSON Map.
  factory UserPreferences.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) =>
      UserPreferences.fromJson(JsonReader.fromObject(map), validate: validate);

  final Map<String, String> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<UserPreferences> descriptor =
      ObjectDescriptor<UserPreferences>(
        title: 'UserPreferences',
        matches: (instance) => instance is UserPreferences,
        instantiate: (fields) => UserPreferences(
          additionalProperties: fields.entries
              .where((e) => !const <String>{}.contains(e.key) && true)
              .fold<Map<String, String>>(
                {},
                (m, e) => m..[e.key] = e.value as String,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = instance as UserPreferences;
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
  Map<String, dynamic> toMap() => toJsonValue() as Map<String, dynamic>;

  UserPreferences copyWith({Map<String, String>? additionalProperties}) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return UserPreferences(
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
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
