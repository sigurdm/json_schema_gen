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
import 'package:test/test.dart';

import 'test_schema.g.dart';

void main() {
  group('ValidationError', () {
    test('JSON Pointer (instancePath) and JSONPath formatting', () {
      final errRoot = ValidationError(message: 'Root error');
      expect(errRoot.instancePath, '');
      expect(errRoot.jsonPath, r'$');

      final errNested = ValidationError(
        message: 'Nested error',
        path: ['users', '0', 'name'],
        keyword: 'minLength',
      );
      expect(errNested.instancePath, '/users/0/name');
      expect(errNested.jsonPath, r'$.users.0.name');
      expect(
        errNested.toString(),
        'ValidationError at \$.users.0.name (minLength): Nested error',
      );

      // RFC 6901 escaping
      final errEscaped = ValidationError(
        message: 'Escaped error',
        path: ['a/b', 'm~n'],
      );
      expect(errEscaped.instancePath, '/a~1b/m~0n');
    });

    test('equality and hashCode', () {
      final err1 = ValidationError(
        message: 'Invalid type',
        path: ['a', 'b'],
        keyword: 'type',
      );
      final err2 = ValidationError(
        message: 'Invalid type',
        path: ['a', 'b'],
        keyword: 'type',
      );
      final err3 = ValidationError(
        message: 'Different message',
        path: ['a', 'b'],
        keyword: 'type',
      );

      expect(err1, equals(err2));
      expect(err1.hashCode, equals(err2.hashCode));
      expect(err1, isNot(equals(err3)));

      final withNested1 = ValidationError(
        message: 'anyOf failed',
        nestedErrors: [err1],
      );
      final withNested2 = ValidationError(
        message: 'anyOf failed',
        nestedErrors: [err2],
      );
      final withNested3 = ValidationError(
        message: 'anyOf failed',
        nestedErrors: [err3],
      );
      expect(withNested1, equals(withNested2));
      expect(withNested1.hashCode, equals(withNested2.hashCode));
      expect(withNested1, isNot(equals(withNested3)));
    });
  });

  group('JsonValidationException', () {
    test('single-error formatting', () {
      final ex = JsonValidationException.single(
        'Something went wrong',
        path: ['data', 'value'],
      );
      expect(ex.message, 'Something went wrong');
      expect(ex.path, ['data', 'value']);
      expect(ex.errors.length, 1);
      expect(ex.errors.first.message, 'Something went wrong');
      expect(ex.errors.first.path, ['data', 'value']);
      expect(
        ex.toString(),
        'JsonValidationException at \$.data.value: Something went wrong',
      );
    });

    test('multi-error formatting', () {
      final err1 = ValidationError(message: 'Error 1', path: ['a']);
      final err2 = ValidationError(message: 'Error 2', path: ['b']);
      final ex = JsonValidationException([err1, err2]);

      expect(ex.errors.length, 2);
      expect(ex.path, ['a']);
      expect(ex.message, contains('2 validation errors'));
      final str = ex.toString();
      expect(str, contains('2 validation error(s):'));
      expect(str, contains('1. ValidationError at \$.a: Error 1'));
      expect(str, contains('2. ValidationError at \$.b: Error 2'));
    });
  });

  group('Object Error Accumulation', () {
    late Schema schema;

    setUp(() async {
      final parser = SchemaParser({
        r'$schema': 'https://json-schema.org/draft/2020-12/schema',
        'type': 'object',
        'required': ['id', 'username', 'email'],
        'properties': {
          'id': {'type': 'integer', 'minimum': 1},
          'username': {'type': 'string', 'minLength': 3},
          'email': {'type': 'string', 'pattern': r'^[^@]+@[^@]+\.[^@]+$'},
          'age': {'type': 'integer', 'minimum': 0, 'maximum': 120},
        },
        'additionalProperties': false,
      });
      schema = await parser.parse();
    });

    test('collects errors across multiple invalid fields in a single pass', () {
      final invalidData = {
        // missing 'id'
        'username': 'ab', // minLength violation
        'email': 'not-an-email', // pattern violation
        'age': -5, // minimum violation
        'extraField': 123, // additionalProperties violation
      };

      final errors = schema.collectErrors(invalidData);

      // Expected 5 distinct errors:
      // 1. Missing required 'id'
      // 2. username minLength
      // 3. email pattern
      // 4. age minimum
      // 5. extraField additionalProperties false
      expect(errors.length, 5);

      final keywords = errors.map((e) => e.keyword).toSet();
      expect(
        keywords,
        containsAll(['required', 'minLength', 'pattern', 'minimum', 'false']),
      );

      final paths = errors.map((e) => e.instancePath).toList();
      expect(
        paths,
        containsAll(['/id', '/username', '/email', '/age', '/extraField']),
      );
    });

    test('validate defaults to accumulating all errors (failFast: false)', () {
      final invalidData = {'username': 'a', 'email': 'bad'};

      try {
        schema.validate(invalidData);
        fail('Expected JsonValidationException');
      } on JsonValidationException catch (e) {
        expect(e.errors.length, greaterThanOrEqualTo(2));
        expect(e.errors.any((err) => err.path.contains('username')), isTrue);
        expect(e.errors.any((err) => err.path.contains('email')), isTrue);
      }
    });

    test('validate with failFast: true stops at first error', () {
      final invalidData = {'username': 'a', 'email': 'bad'};

      try {
        schema.validate(invalidData, failFast: true);
        fail('Expected JsonValidationException');
      } on JsonValidationException catch (e) {
        expect(e.errors.length, 1);
      }
    });
  });

  group('Array Error Accumulation', () {
    late Schema schema;

    setUp(() async {
      final parser = SchemaParser({
        r'$schema': 'https://json-schema.org/draft/2020-12/schema',
        'type': 'array',
        'minItems': 3,
        'items': {'type': 'integer', 'minimum': 10},
      });
      schema = await parser.parse();
    });

    test('collects errors across multiple invalid array items', () {
      final data = [5, 'wrong-type', 20, 3];
      final errors = schema.collectErrors(data);

      // index 0: minimum violation (5 < 10)
      // index 1: type violation (string instead of integer)
      // index 2: valid (20 >= 10)
      // index 3: minimum violation (3 < 10)
      expect(errors.length, 3);
      expect(errors.map((e) => e.instancePath), equals(['/0', '/1', '/3']));
    });

    test('uniqueItems emits error and avoids quadratic spam', () {
      final uniqueSchema = Schema(uniqueItems: true);
      final data = [1, 1, 1, 1, 1];
      final errors = uniqueSchema.collectErrors(data);
      expect(errors.length, 1);
      expect(errors.first.keyword, 'uniqueItems');
    });
  });

  group('Speculative Combinators Isolation', () {
    test('anyOf collects nested errors when all branches fail', () async {
      final parser = SchemaParser({
        r'$schema': 'https://json-schema.org/draft/2020-12/schema',
        'anyOf': [
          {'type': 'string', 'maxLength': 3},
          {'type': 'integer', 'minimum': 100},
        ],
      });
      final schema = await parser.parse();

      // Passes second branch
      expect(schema.collectErrors(150), isEmpty);

      // Fails both branches
      final errors = schema.collectErrors(42);
      expect(errors.length, 1);
      expect(errors.first.keyword, 'anyOf');
      expect(errors.first.nestedErrors.length, 2);
      expect(errors.first.nestedErrors[0].keyword, 'type'); // 42 is not string
      expect(errors.first.nestedErrors[1].keyword, 'minimum'); // 42 < 100
    });

    test('oneOf reports error when 0 or multiple branches match', () async {
      final parser = SchemaParser({
        r'$schema': 'https://json-schema.org/draft/2020-12/schema',
        'oneOf': [
          {'type': 'integer', 'multipleOf': 3},
          {'type': 'integer', 'multipleOf': 5},
        ],
      });
      final schema = await parser.parse();

      // Exactly one matches: valid
      expect(schema.collectErrors(9), isEmpty); // div by 3 only
      expect(schema.collectErrors(10), isEmpty); // div by 5 only

      // Both match (15): invalid
      final bothMatchErrors = schema.collectErrors(15);
      expect(bothMatchErrors.length, 1);
      expect(bothMatchErrors.first.keyword, 'oneOf');

      // Neither matches (7): invalid with nested errors
      final neitherMatchErrors = schema.collectErrors(7);
      expect(neitherMatchErrors.length, 1);
      expect(neitherMatchErrors.first.keyword, 'oneOf');
      expect(neitherMatchErrors.first.nestedErrors.length, 2);
    });

    test('if/then/else does not leak speculative if errors', () async {
      final parser = SchemaParser({
        r'$schema': 'https://json-schema.org/draft/2020-12/schema',
        'if': {
          'properties': {
            'kind': {'const': 'admin'},
          },
          'required': ['kind'],
        },
        'then': {
          'properties': {
            'token': {'type': 'string'},
          },
          'required': ['token'],
        },
        'else': {
          'properties': {
            'guestId': {'type': 'integer'},
          },
          'required': ['guestId'],
        },
      });
      final schema = await parser.parse();

      // When kind != 'admin', 'if' fails, so 'else' executes.
      // Missing 'guestId' should be reported; speculative 'if' failure should NOT be reported!
      final guestData = {'kind': 'user'};
      final errors = schema.collectErrors(guestData);
      expect(errors.length, 1);
      expect(errors.first.instancePath, '/guestId');
      expect(errors.first.keyword, 'required');
    });

    test('contains does not leak non-matching item errors', () async {
      final parser = SchemaParser({
        r'$schema': 'https://json-schema.org/draft/2020-12/schema',
        'contains': {'type': 'integer', 'minimum': 10},
        'minContains': 1,
      });
      final schema = await parser.parse();

      // Array with some non-matching and one matching
      expect(schema.collectErrors(['hello', 3, 15, 'world']), isEmpty);

      // Array with no matching items: should report 1 minContains error, not 3 child errors
      final errors = schema.collectErrors(['hello', 3, 'world']);
      expect(errors.length, 1);
      expect(errors.first.keyword, 'minContains');

      // Without explicit minContains, keyword is 'contains'
      final defaultContainsParser = SchemaParser({
        r'$schema': 'https://json-schema.org/draft/2020-12/schema',
        'contains': {'type': 'integer', 'minimum': 10},
      });
      final defaultContainsSchema = await defaultContainsParser.parse();
      final defaultErrors = defaultContainsSchema.collectErrors([
        'hello',
        3,
        'world',
      ]);
      expect(defaultErrors.length, 1);
      expect(defaultErrors.first.keyword, 'contains');
    });
  });

  group('Draft 2020-12 unevaluatedProperties interaction', () {
    test(
      'invalid property tested by properties is not flagged as unevaluated',
      () async {
        final parser = SchemaParser({
          r'$schema': 'https://json-schema.org/draft/2020-12/schema',
          'properties': {
            'count': {'type': 'integer'},
          },
          'unevaluatedProperties': false,
        });
        final schema = await parser.parse();

        final data = {'count': 'not-an-int'};
        final errors = schema.collectErrors(data);

        // Under §10.3.1.2, 'count' was evaluated by 'properties'.
        // It should ONLY report the type error on 'count', NOT an additional unevaluatedProperties error!
        expect(errors.length, 1);
        expect(errors.first.instancePath, '/count');
        expect(errors.first.keyword, 'type');
      },
    );
  });

  group('createErrorCollector', () {
    test('returns function that collects errors without throwing', () async {
      final collector = await createErrorCollector({
        r'$schema': 'https://json-schema.org/draft/2020-12/schema',
        'type': 'object',
        'required': ['a', 'b'],
        'properties': {
          'a': {'type': 'string'},
          'b': {'type': 'number'},
        },
      });

      final validErrors = collector({'a': 'hello', 'b': 42});
      expect(validErrors, isEmpty);

      final invalidErrors = collector({'a': 123});
      expect(invalidErrors.length, 2); // missing 'b', 'a' is not string
    });
  });

  group('Generated Model Error Accumulation', () {
    test('Address collectErrors returns all validation errors', () {
      const address = Address(city: 'NY'); // city.runes.length < 3
      final errors = address.collectErrors();
      expect(errors.length, 1);
      expect(errors.first.path, ['city']);
      expect(errors.first.keyword, 'minLength');
    });

    test('Address validate throws JsonValidationException with all errors', () {
      const address = Address(city: 'NY');
      expect(
        () => address.validate(),
        throwsA(
          isA<JsonValidationException>().having(
            (e) => e.errors,
            'errors',
            hasLength(1),
          ),
        ),
      );
    });

    test('TestRoot accumulates errors across fields and nested objects', () {
      const invalidRoot = TestRoot(
        name: '', // minLength: 1
        age: -5, // minimum: 0
        isAwesome: true,
        email: 'invalid-email', // pattern
        ipv4Field: 'invalid-ip', // format: ipv4
        tags: ['tag1', 'tag1'], // uniqueItems
        address: Address(city: 'NY'), // nested city minLength: 3
      );

      final errors = invalidRoot.collectErrors();
      expect(errors.length, 6);

      final keywords = errors.map((e) => e.keyword).toSet();
      expect(
        keywords,
        containsAll([
          'minLength',
          'minimum',
          'pattern',
          'format',
          'uniqueItems',
        ]),
      );

      final paths = errors.map((e) => e.path.join('.')).toList();
      expect(paths, contains('name'));
      expect(paths, contains('age'));
      expect(paths, contains('email'));
      expect(paths, contains('ipv4Field'));
      expect(paths, contains('tags'));
      expect(paths, contains('address.city'));

      try {
        invalidRoot.validate();
        fail('Expected JsonValidationException');
      } on JsonValidationException catch (e) {
        expect(e.errors.length, 6);
      }
    });
  });
}
