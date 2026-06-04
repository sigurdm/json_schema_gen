import 'package:jsontool/jsontool.dart';
import 'package:test/test.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'test_schema.g.dart';

void main() {
  group('Generated JSON Schema Models', () {
    test('Valid parsing and serialization', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'height': 1.85,
        'address': {'city': 'Aarhus', 'street': 'Main Street'},
        'tags': ['dart', 'json'],
        'scores': [
          {'value': 95.5},
          {'value': 100},
        ],
        'unionValue': 'some-string',
        'nullableString': null,
      };

      final reader = JsonReader.fromObject(jsonObject);
      final model = TestRoot.fromJson(reader);

      expect(model.name, 'Sigurd');
      expect(model.age, 35);
      expect(model.isAwesome, true);
      expect(model.height, 1.85);
      expect(model.address.city, 'Aarhus');
      expect(model.address.street, 'Main Street');
      expect(model.tags, ['dart', 'json']);
      expect(model.scores!.length, 2);
      expect(model.scores![0].value, 95.5);
      expect(model.scores![1].value, 100.0);
      expect(model.unionValue, isA<TestRootUnionValueOption0>());
      expect(
        (model.unionValue as TestRootUnionValueOption0).value,
        'some-string',
      );
      expect(model.nullableString, isNull);

      // Verify serialization
      final serialized = model.toJson();
      final decoded = readAny(JsonReader.fromString(serialized));
      expect(decoded['name'], 'Sigurd');
      expect(decoded['age'], 35);
      expect(decoded['isAwesome'], true);
      expect(decoded['height'], 1.85);
      expect(decoded['address']['city'], 'Aarhus');
      expect(decoded['address']['street'], 'Main Street');
      expect(decoded['tags'], ['dart', 'json']);
      expect(decoded['scores'][0]['value'], 95.5);
      expect(decoded['scores'][1]['value'], 100.0);
      expect(decoded['unionValue'], 'some-string');
      expect(
        decoded.containsKey('nullableString'),
        false,
      ); // optional nullable omitted
    });

    test('Name collision avoidance - keywords and context names', () {
      final jsonObject = {
        'name': 'Collision Test',
        'age': 0,
        'isAwesome': false,
        'class': 'my-class-value',
        'reader': 'my-reader-value',
        'stack': 'my-stack-value',
        'validate': 'my-validate-value',
        'result': 'my-result-value',
        'address': {'city': 'Aarhus'},
      };

      final reader = JsonReader.fromObject(jsonObject);
      final model = TestRoot.fromJson(reader);

      expect(model.class_, 'my-class-value');
      expect(model.reader, 'my-reader-value');
      expect(model.stack, 'my-stack-value');
      expect(model.validate_, 'my-validate-value');
      expect(model.result, 'my-result-value');

      // Verify serialization preserves the original JSON keys
      final serialized = model.toJson();
      final decoded = readAny(JsonReader.fromString(serialized));
      expect(decoded['class'], 'my-class-value');
      expect(decoded['reader'], 'my-reader-value');
      expect(decoded['stack'], 'my-stack-value');
      expect(decoded['validate'], 'my-validate-value');
      expect(decoded['result'], 'my-result-value');
    });

    test('Required field validation', () {
      final missingName = {
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
      };

      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(missingName)),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('Missing required property: name'),
          ),
        ),
      );
    });

    test('Path-tracking error handling', () {
      final invalidStreet = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'address': {
          'city': 'Aarhus',
          'street': 123, // Should be String
        },
      };

      try {
        TestRoot.fromJson(JsonReader.fromObject(invalidStreet));
        fail('Should have thrown FormatException');
      } on FormatException catch (e) {
        expect(e, isA<JsonParseException>());
        final parseEx = e as JsonParseException;
        expect(parseEx.path, ['address', 'street']);
        expect(parseEx.toString(), contains('at \$.address.street'));
      }
    });

    test('Union speculative parsing alternative case', () {
      final unionAddress = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
        'unionValue': {'city': 'Copenhagen', 'street': 'Strøget'},
      };

      final model = TestRoot.fromJson(JsonReader.fromObject(unionAddress));
      expect(model.unionValue, isA<TestRootUnionValueOption1>());
      expect(
        (model.unionValue as TestRootUnionValueOption1).value.city,
        'Copenhagen',
      );
    });

    test('Union speculative parsing invalid case', () {
      final invalidUnion = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
        'unionValue': 123.45, // Not a string and not an Address object
      };

      try {
        TestRoot.fromJson(JsonReader.fromObject(invalidUnion));
        fail('Should have thrown FormatException');
      } on FormatException catch (e) {
        expect(e, isA<JsonParseException>());
        final parseEx = e as JsonParseException;
        expect(parseEx.path, ['unionValue']);
        expect(
          parseEx.message,
          contains('Failed to parse TestRootUnionValue union'),
        );
      }
    });

    test('Equality and copyWith', () {
      final a1 = Address(city: 'Aarhus', street: 'Street');
      final a2 = Address(city: 'Aarhus', street: 'Street');
      final a3 = Address(city: 'Aarhus', street: 'Other');

      expect(a1, equals(a2));
      expect(a1.hashCode, equals(a2.hashCode));
      expect(a1, isNot(equals(a3)));

      final updated = a1.copyWith(street: 'New Street');
      expect(updated.city, 'Aarhus');
      expect(updated.street, 'New Street');
    });

    test('Constraint validation - success', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
        'tags': ['dart'],
      };
      // Parsing with default validation should succeed
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.name, 'Sigurd');
    });

    test('Constraint validation - throw on parse', () {
      final jsonObject = {
        'name': 'S', // Invalid (minLength: 2)
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
        'tags': ['dart'],
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>().having(
            (e) => e.message,
            'message',
            contains('Property "name" length must be >= 2'),
          ),
        ),
      );
    });

    test('Constraint validation - pattern match success', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 35,
        'email': 'sigurdm@google.com',
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.email, 'sigurdm@google.com');
    });

    test('Constraint validation - pattern match throw', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 35,
        'email': 'not-an-email',
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having((e) => e.path, 'path', ['email'])
              .having(
                (e) => e.message,
                'message',
                contains('Property "email" must match pattern'),
              ),
        ),
      );
    });

    test('Constraint validation - multipleOf success', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.age, 35);
    });

    test('Constraint validation - multipleOf throw', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 33,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having((e) => e.path, 'path', ['age'])
              .having(
                (e) => e.message,
                'message',
                contains('Property "age" must be a multiple of 5'),
              ),
        ),
      );
    });

    test('Constraint validation - uniqueItems success', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
        'tags': ['dart', 'json'],
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.tags, ['dart', 'json']);
    });

    test('Constraint validation - uniqueItems throw', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
        'tags': ['dart', 'dart'],
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having((e) => e.path, 'path', ['tags'])
              .having(
                (e) => e.message,
                'message',
                contains('Property "tags" items must be unique'),
              ),
        ),
      );
    });

    test('Constraint validation - format uuid success', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 35,
        'uuid': '123e4567-e89b-12d3-a456-426614174000',
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.uuid, '123e4567-e89b-12d3-a456-426614174000');
    });

    test('Constraint validation - format uuid throw', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 35,
        'uuid': 'not-a-uuid',
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having((e) => e.path, 'path', ['uuid'])
              .having(
                (e) => e.message,
                'message',
                contains('Property "uuid" must be a valid UUID'),
              ),
        ),
      );
    });

    test('Constraint validation - disable validation on parse', () {
      final jsonObject = {
        'name': 'S', // Invalid (minLength: 2)
        'age': -5, // Invalid (minimum: 0)
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
        'tags': <String>[], // Invalid (minItems: 1)
      };
      // Parsing with validate: false should succeed without throwing
      final model = TestRoot.fromJson(
        JsonReader.fromObject(jsonObject),
        validate: false,
      );
      expect(model.name, 'S');
      expect(model.age, -5);
      expect(model.tags, isEmpty);

      // Now manual validate should throw
      expect(
        () => model.validate(),
        throwsA(
          isA<JsonValidationException>().having(
            (e) => e.message,
            'message',
            contains('Property "name" length must be >= 2'),
          ),
        ),
      );
    });

    test('Constraint validation - nested path tracking', () {
      final invalidAddress = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aa'}, // Invalid: minLength 3
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(invalidAddress)),
        throwsA(
          isA<JsonValidationException>()
              .having((e) => e.path, 'path', ['address', 'city'])
              .having(
                (e) => e.message,
                'message',
                contains('Property "city" length must be >= 3'),
              ),
        ),
      );

      final invalidScore = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
        'scores': [
          {'value': 95.5},
          {'value': -2.5}, // Invalid: minimum 0.0
        ],
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(invalidScore)),
        throwsA(
          isA<JsonValidationException>()
              .having((e) => e.path, 'path', ['scores', '[1]', 'value'])
              .having(
                (e) => e.message,
                'message',
                contains('Property "value" must be >= 0'),
              ),
        ),
      );
    });

    test('Discriminator-based union parsing - Cat', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
        'pet': {'kind': 'cat_type', 'meowVolume': 12.5},
      };

      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.pet, isA<PetOption0>());
      final petVal = (model.pet as PetOption0).value;
      expect(petVal, isA<Cat>());
      expect(petVal.kind, 'cat_type');
      expect(petVal.meowVolume, 12.5);
    });

    test('Discriminator-based union parsing - Dog', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
        'pet': {'kind': 'dog_type', 'barkVolume': 42.0},
      };

      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.pet, isA<PetOption1>());
      final petVal = (model.pet as PetOption1).value;
      expect(petVal, isA<Dog>());
      expect(petVal.kind, 'dog_type');
      expect(petVal.barkVolume, 42.0);
    });

    test('Discriminator-based union parsing - unknown discriminator value', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
        'pet': {'kind': 'fish_type'},
      };

      try {
        TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        fail('Should have thrown FormatException');
      } on FormatException catch (e) {
        expect(e, isA<JsonParseException>());
        final parseEx = e as JsonParseException;
        expect(parseEx.path, ['pet']);
        expect(
          parseEx.message,
          contains('Unknown discriminator value: fish_type'),
        );
      }
    });

    test(
      'Discriminator-based union parsing - missing discriminator property',
      () {
        final jsonObject = {
          'name': 'Sigurd',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'Aarhus'},
          'pet': {'meowVolume': 10.0},
        };

        try {
          TestRoot.fromJson(JsonReader.fromObject(jsonObject));
          fail('Should have thrown FormatException');
        } on FormatException catch (e) {
          expect(e, isA<JsonParseException>());
          final parseEx = e as JsonParseException;
          expect(parseEx.path, ['pet']);
          expect(
            parseEx.message,
            contains('Missing discriminator property: kind'),
          );
        }
      },
    );

    test('Discriminator-based union parsing - nested property error path', () {
      final jsonObject = {
        'name': 'Sigurd',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'Aarhus'},
        'pet': {'kind': 'cat_type', 'meowVolume': 'super loud'}, // type error
      };

      try {
        TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        fail('Should have thrown FormatException');
      } on FormatException catch (e) {
        expect(e, isA<JsonParseException>());
        final parseEx = e as JsonParseException;
        expect(parseEx.path, ['pet', 'meowVolume']);
        expect(parseEx.toString(), contains('at \$.pet.meowVolume'));
      }
    });
  });
}
