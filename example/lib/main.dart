import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';
import 'user.g.dart';

void main() {
  // 1. Define a JSON payload representing a user with all features.
  final validJson = '''
  {
    "id": 42,
    "name": "John Doe",
    "email": "john.doe@example.com",
    "age": 30,
    "role": "admin",
    "profile": {
      "avatarUrl": "https://example.com/avatar.png",
      "bio": "Software Engineer working on Dart toolchains"
    },
    "address": {
      "street": "123 Main St",
      "city": "Metropolis",
      "zipCode": "12345"
    },
    "tags": ["dart", "json", "schema"],
    "preferences": {
      "theme": "dark",
      "fontSize": "14"
    },
    "createdAt": "2026-06-08T12:00:00Z"
  }
  ''';

  print('--- Parsing Valid JSON ---');
  final user = User.fromJson(JsonReader.fromString(validJson));
  print('Successfully parsed User:');
  print('  ID: ${user.id}');
  print('  Name: ${user.name}');
  print('  Email: ${user.email}');
  print('  Age: ${user.age}');
  print('  Role: ${user.role}');
  print('  Bio: ${user.profile?.bio}');
  print('  Avatar URL: ${user.profile?.avatarUrl}');
  print('  Address: ${user.address?.street}, ${user.address?.city}, ${user.address?.zipCode}');
  print('  Tags: ${user.tags}');
  print('  Preferences: ${user.preferences?.additionalProperties}');
  print('  Created At: ${user.createdAt}');

  print('\n--- Serializing User back to JSON ---');
  final serialized = user.toJson();
  print('Serialized output:');
  print(serialized);

  print('\n--- Parsing JSON with default values ---');
  final jsonWithDefaults = '''
  {
    "id": 43,
    "name": "Jane Doe",
    "email": "jane.doe@example.com"
  }
  ''';
  final userWithDefaults = User.fromJson(JsonReader.fromString(jsonWithDefaults));
  print('Successfully parsed User with defaults:');
  print('  Role (default): ${userWithDefaults.role}'); // Should be UserRole.user

  print('\n--- Parsing Invalid JSON (Triggering Constraint Validation) ---');

  void tryParseInvalid(String label, String json) {
    print('\nTesting: $label');
    try {
      User.fromJson(JsonReader.fromString(json));
      print('  ERROR: Parsed successfully but should have failed!');
    } on JsonValidationException catch (e) {
      print('  Validation failed as expected:');
      print('    Path: ${e.path}');
      print('    Error: ${e.message}');
    }
  }

  tryParseInvalid(
    'Short name',
    '{"id": 44, "name": "A", "email": "a@example.com"}',
  );

  tryParseInvalid(
    'Invalid email',
    '{"id": 44, "name": "Alice", "email": "invalid-email"}',
  );

  tryParseInvalid(
    'Negative age',
    '{"id": 44, "name": "Alice", "email": "alice@example.com", "age": -1}',
  );

  tryParseInvalid(
    'Invalid avatar URL',
    '{"id": 44, "name": "Alice", "email": "alice@example.com", "profile": {"avatarUrl": "not-a-uri"}}',
  );

  tryParseInvalid(
    'Invalid zip code',
    '{"id": 44, "name": "Alice", "email": "alice@example.com", "address": {"city": "New York", "zipCode": "1234"}}',
  );

  tryParseInvalid(
    'Duplicate tags',
    '{"id": 44, "name": "Alice", "email": "alice@example.com", "tags": ["a", "a"]}',
  );

  tryParseInvalid(
    'Invalid createdAt date-time',
    '{"id": 44, "name": "Alice", "email": "alice@example.com", "createdAt": "not-a-date"}',
  );
}

