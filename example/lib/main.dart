import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';
import 'user.g.dart';

void main() {
  // 1. Define a JSON payload representing a user.
  final validJson = '''
  {
    "id": 42,
    "name": "John Doe",
    "email": "john.doe@google.com",
    "role": "admin",
    "profile": {
      "avatarUrl": "https://example.com/avatar.png",
      "bio": "Software Engineer working on Dart toolchains"
    }
  }
  ''';

  print('--- Parsing Valid JSON ---');
  final user = User.fromJson(JsonReader.fromString(validJson));
  print('Successfully parsed User:');
  print('  ID: ${user.id}');
  print('  Name: ${user.name}');
  print('  Role: ${user.role}');
  print('  Bio: ${user.profile?.bio}');

  print('\n--- Serializing User back to JSON ---');
  final serialized = user.toJson();
  print('Serialized output:');
  print(serialized);

  print('\n--- Parsing Invalid JSON (Triggering Constraint Validation) ---');
  final invalidJson = '''
  {
    "id": 43,
    "name": "S",
    "email": "invalid@example.com",
    "role": "user"
  }
  ''';

  try {
    User.fromJson(JsonReader.fromString(invalidJson));
  } on JsonValidationException catch (e) {
    print('Validation failed as expected:');
    print('  Path: ${e.path}');
    print('  Error: ${e.message}');
  }
}
