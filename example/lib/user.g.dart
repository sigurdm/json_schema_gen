// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code

import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';

final class User implements JsonModel {
  final int id;
  final String name;
  final String email;
  final UserRole role;
  final UserProfile? profile;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.profile,
  });

  factory User.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as User;

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    UserRole? role,
    UserProfile? profile,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    role: role ?? this.role,
    profile: profile ?? this.profile,
  );

  void validate() {
    if (name.length < 2) {
      throw JsonValidationException('Property "name" length must be >= 2', [
        'name',
      ]);
    }
    if (!const [
      UserRole.admin,
      UserRole.editor,
      UserRole.user,
    ].contains(role)) {
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
  }

  static final descriptor = ObjectDescriptor<User>(
    title: 'User',
    matches: (instance) => instance is User,
    instantiate: (fields) => User(
      id: fields['id'] as int,
      name: fields['name'] as String,
      email: fields['email'] as String,
      role: fields['role'] as UserRole,
      profile: fields['profile'] as UserProfile?,
    ),
    getFields: (instance) => {
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'profile': instance.profile,
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
      'role': PropertyDescriptor(
        name: 'role',
        isRequired: true,
        schema: UserRole.descriptor,
      ),
      'profile': PropertyDescriptor(
        name: 'profile',
        isRequired: false,
        schema: UserProfile.descriptor,
      ),
    },
    required: const ['id', 'name', 'email', 'role'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          role == other.role &&
          profile == other.profile;

  @override
  int get hashCode => Object.hashAll([id, name, email, role, profile]);

  @override
  String toString() =>
      'User(id: ${id}, name: ${name}, email: ${email}, role: ${role}, profile: ${profile})';
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

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  UserProfile copyWith({String? avatarUrl, String? bio}) =>
      UserProfile(avatarUrl: avatarUrl ?? this.avatarUrl, bio: bio ?? this.bio);

  void validate() {
    final val_avatarUrl = avatarUrl;
    final val_bio = bio;
  }

  static final descriptor = ObjectDescriptor<UserProfile>(
    title: 'UserProfile',
    matches: (instance) => instance is UserProfile,
    instantiate: (fields) => UserProfile(
      avatarUrl: fields['avatarUrl'] as String?,
      bio: fields['bio'] as String?,
    ),
    getFields: (instance) => {
      'avatarUrl': instance.avatarUrl,
      'bio': instance.bio,
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
