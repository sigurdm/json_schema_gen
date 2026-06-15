// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:json_schema_gen/json_schema.dart';

void main() {
  // 1. Define a JSON Schema as a Dart Map.
  final schemaMap = {
    '\$schema': 'https://json-schema.org/draft/2020-12/schema',
    'title': 'User',
    'type': 'object',
    'properties': {
      'name': {'type': 'string', 'minLength': 2},
      'age': {'type': 'integer', 'minimum': 0},
      'emails': {
        'type': 'array',
        'items': {'type': 'string', 'format': 'email'},
      },
    },
    'required': ['name', 'age'],
  };

  // 2. Parse the schema manually.
  final parser = SchemaParser(schemaMap);
  final schema = parser.parse();

  // Helper to validate and print results.
  void validateData(String label, Map<String, dynamic> data) {
    print('\nValidating $label:');
    try {
      schema.validate(data);
      print('  Success! Data is valid.');
    } on JsonValidationException catch (e) {
      print('  Validation Failed!');
      print('    Error: ${e.message}');
      print('    Path: ${e.path.join('.')}');
    }
  }

  // Test Case 1: Valid Data
  validateData('Valid User', {
    'name': 'Alice',
    'age': 30,
    'emails': ['alice@example.com', 'alice.work@example.com'],
  });

  // Test Case 2: Missing Required Field (age)
  validateData('Missing Age', {
    'name': 'Bob',
  });

  // Test Case 3: Invalid Type for Age
  validateData('Invalid Age Type (String)', {
    'name': 'Charlie',
    'age': 'thirty',
  });

  // Test Case 4: Constraint Violation (name minLength)
  validateData('Short Name', {
    'name': 'D',
    'age': 20,
  });

  // Test Case 5: Constraint Violation (age minimum)
  validateData('Negative Age', {
    'name': 'Eve',
    'age': -5,
  });

  // Test Case 6: Constraint Violation (email format)
  validateData('Invalid Email Format', {
    'name': 'Frank',
    'age': 25,
    'emails': ['frank@example.com', 'not-an-email'],
  });
}
