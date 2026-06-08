import 'package:jsontool/jsontool.dart';
import 'package:test/test.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'test_schema.g.dart';

void main() {
  group('Generated JSON Schema Models', () {
    test('Valid parsing and serialization', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'height': 1.85,
        'address': {'city': 'London', 'street': 'Main Street'},
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

      expect(model.name, 'John');
      expect(model.age, 35);
      expect(model.isAwesome, true);
      expect(model.height, 1.85);
      expect(model.address.city, 'London');
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
      expect(decoded['name'], 'John');
      expect(decoded['age'], 35);
      expect(decoded['isAwesome'], true);
      expect(decoded['height'], 1.85);
      expect(decoded['address']['city'], 'London');
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
        'address': {'city': 'London'},
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

    test('TestRoot ignores unknown properties', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'unknownTopLevelProp': 'should_be_ignored',
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.name, 'John');
    });

    test('Required field validation', () {
      final missingName = {
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
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
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {
          'city': 'London',
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
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
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
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
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
      final a1 = Address(city: 'London', street: 'Street');
      final a2 = Address(city: 'London', street: 'Street');
      final a3 = Address(city: 'London', street: 'Other');

      expect(a1, equals(a2));
      expect(a1.hashCode, equals(a2.hashCode));
      expect(a1, isNot(equals(a3)));

      final updated = a1.copyWith(street: 'New Street');
      expect(updated.city, 'London');
      expect(updated.street, 'New Street');
    });

    test('Constraint validation - success', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'tags': ['dart'],
      };
      // Parsing with default validation should succeed
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.name, 'John');
    });

    test('Constraint validation - throw on parse', () {
      final jsonObject = {
        'name': 'S', // Invalid (minLength: 2)
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
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
        'name': 'John',
        'age': 35,
        'email': 'john.doe@google.com',
        'isAwesome': true,
        'address': {'city': 'London'},
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.email, 'john.doe@google.com');
    });

    test('Constraint validation - pattern match throw', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'email': 'not-an-email',
        'isAwesome': true,
        'address': {'city': 'London'},
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
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.age, 35);
    });

    test('Constraint validation - multipleOf throw', () {
      final jsonObject = {
        'name': 'John',
        'age': 33,
        'isAwesome': true,
        'address': {'city': 'London'},
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
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'tags': ['dart', 'json'],
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.tags, ['dart', 'json']);
    });

    test('Constraint validation - uniqueItems throw', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
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
        'name': 'John',
        'age': 35,
        'uuid': '123e4567-e89b-12d3-a456-426614174000',
        'isAwesome': true,
        'address': {'city': 'London'},
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.uuid, '123e4567-e89b-12d3-a456-426614174000');
    });

    test('Constraint validation - format uuid throw', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'uuid': 'not-a-uuid',
        'isAwesome': true,
        'address': {'city': 'London'},
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
        'address': {'city': 'London'},
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
        'name': 'John',
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
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
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
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
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
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
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
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
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
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
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
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
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

    test('Const validation - success', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'constValue': 'always-this-value',
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.constValue, TestRootConstValue.alwaysThisValue);
    });

    test('Const validation - failure', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'constValue': 'wrong-value',
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(isA<FormatException>()),
      );
    });

    test('Exclusive limits validation - success', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'exclusiveAge': 50,
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.exclusiveAge, 50);
    });

    test('Exclusive limits validation - failure (equal to min)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'exclusiveAge': 0,
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                'Property "exclusiveAge" must be > 0',
              )
              .having((e) => e.path, 'path', ['exclusiveAge']),
        ),
      );
    });

    test('Exclusive limits validation - failure (equal to max)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'exclusiveAge': 100,
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                'Property "exclusiveAge" must be < 100',
              )
              .having((e) => e.path, 'path', ['exclusiveAge']),
        ),
      );
    });

    test('minProperties / maxProperties validation - success (1 prop)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'restrictedObject': {'a': 'value'},
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.restrictedObject!.a, 'value');
      expect(model.restrictedObject!.b, isNull);
    });

    test('minProperties / maxProperties validation - success (2 props)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'restrictedObject': {'a': 'value', 'b': 'another'},
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.restrictedObject!.a, 'value');
      expect(model.restrictedObject!.b, 'another');
    });

    test('minProperties / maxProperties validation - failure (too few)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'restrictedObject': <String, dynamic>{},
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                'Object must have >= 1 properties',
              )
              .having((e) => e.path, 'path', ['restrictedObject']),
        ),
      );
    });

    test('minProperties / maxProperties validation - failure (too many)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'restrictedObject': {'a': '1', 'b': '2', 'c': '3'},
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                'Object must have <= 2 properties',
              )
              .having((e) => e.path, 'path', ['restrictedObject']),
        ),
      );
    });
    test('dependentRequired validation - success (neither)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'dependentObject': <String, dynamic>{},
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.dependentObject!.creditCard, isNull);
      expect(model.dependentObject!.billingAddress, isNull);
    });

    test('dependentRequired validation - success (both)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'dependentObject': {
          'creditCard': 123456789,
          'billingAddress': '123 Lane',
        },
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.dependentObject!.creditCard, 123456789);
      expect(model.dependentObject!.billingAddress, '123 Lane');
    });

    test('dependentRequired validation - success (only target)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'dependentObject': {'billingAddress': '123 Lane'},
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.dependentObject!.creditCard, isNull);
      expect(model.dependentObject!.billingAddress, '123 Lane');
    });

    test('dependentRequired validation - failure (missing dependency)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'dependentObject': {'creditCard': 123456789},
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                'Property "billingAddress" is required because "creditCard" is present',
              )
              .having((e) => e.path, 'path', [
                'dependentObject',
                'billingAddress',
              ]),
        ),
      );
    });
    test('contains validation - success (1 match)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'restrictedArray': [1, 2, 6],
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.restrictedArray, [1, 2, 6]);
    });

    test('contains validation - success (2 matches)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'restrictedArray': [6, 9],
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.restrictedArray, [6, 9]);
    });

    test('contains validation - failure (too few)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'restrictedArray': [1, 2, 4],
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                'Property "restrictedArray" must contain at least 1 items matching contains schema, but has 0',
              )
              .having((e) => e.path, 'path', ['restrictedArray']),
        ),
      );
    });

    test('contains validation - failure (too many)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'restrictedArray': [6, 9, 12],
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                'Property "restrictedArray" must contain at most 2 items matching contains schema, but has 3',
              )
              .having((e) => e.path, 'path', ['restrictedArray']),
        ),
      );
    });
    test('deprecated fields serialization and parsing', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'deprecatedField': 'old value',
        'deprecatedRef': {'value': 'nested old value'},
      };
      // ignore: deprecated_member_use_from_same_package, deprecated_member_use
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      // ignore: deprecated_member_use_from_same_package, deprecated_member_use
      expect(model.deprecatedField, 'old value');
      // ignore: deprecated_member_use_from_same_package, deprecated_member_use
      expect(model.deprecatedRef!.value, 'nested old value');

      // ignore: deprecated_member_use_from_same_package, deprecated_member_use
      final serialized = model.toJson();
      expect(serialized, contains('"deprecatedField":"old value"'));
      expect(
        serialized,
        contains('"deprecatedRef":{"value":"nested old value"}'),
      );
    });
    test('default values - populated when missing in JSON', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.defaultString, 'default value');
      expect(model.defaultInt, 42);
      expect(model.defaultBool, isTrue);
      expect(model.defaultList, ['a', 'b']);
      expect(model.defaultObject.city, 'Default City');
      expect(model.defaultNullableString, isNull);
    });

    test('default values - overridden by explicit values in JSON', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'defaultString': 'custom value',
        'defaultInt': 100,
        'defaultBool': false,
        'defaultList': ['x', 'y'],
        'defaultObject': {'city': 'Custom City'},
        'defaultNullableString': 'not null',
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.defaultString, 'custom value');
      expect(model.defaultInt, 100);
      expect(model.defaultBool, isFalse);
      expect(model.defaultList, ['x', 'y']);
      expect(model.defaultObject.city, 'Custom City');
      expect(model.defaultNullableString, 'not null');
    });

    test('default values - constructor defaults', () {
      const model = TestRoot(
        name: 'John',
        age: 35,
        isAwesome: true,
        address: Address(city: 'London'),
      );
      expect(model.defaultString, 'default value');
      expect(model.defaultInt, 42);
      expect(model.defaultBool, isTrue);
      expect(model.defaultList, ['a', 'b']);
      expect(model.defaultObject.city, 'Default City');
      expect(model.defaultNullableString, isNull);
    });
    test('allOf merging - parsing and serialization', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'mergedValue': {'a': 'value A', 'b': 42, 'c': true},
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.mergedValue!.a, 'value A');
      expect(model.mergedValue!.b, 42);
      expect(model.mergedValue!.c, isTrue);

      final serialized = model.toJson();
      expect(
        serialized,
        contains('"mergedValue":{"a":"value A","b":42,"c":true}'),
      );
    });
    test('prefixItems - parsing and serialization success', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'tupleArray': ['hello', 42, true, false],
        'tupleObjectArray': [
          {'city': 'London'},
          {'kind': 'tabby', 'meowVolume': 11.0},
        ],
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.tupleArray, ['hello', 42, true, false]);
      expect(model.tupleObjectArray![0], isA<Address>());
      expect((model.tupleObjectArray![0] as Address).city, 'London');
      expect(model.tupleObjectArray![1], isA<Cat>());
      expect((model.tupleObjectArray![1] as Cat).kind, 'tabby');

      final serialized = model.toJson();
      expect(serialized, contains('"tupleArray":["hello",42,true,false]'));
      expect(
        serialized,
        contains(
          '"tupleObjectArray":[{"city":"London"},{"kind":"tabby","meowVolume":11.0}]',
        ),
      );
    });

    test('prefixItems - parsing failure (invalid prefix type)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'tupleArray': [42, 42, true], // 42 instead of 'hello'
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonParseException>().having((e) => e.path, 'path', [
            'tupleArray',
            '[0]',
          ]),
        ),
      );
    });

    test('prefixItems - validation failure (nested object)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'tupleObjectArray': [
          {'city': 'X'}, // Too short (minLength: 3)
          {'kind': 'tabby'},
        ],
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having((e) => e.message, 'message', contains('must be >= 3'))
              .having((e) => e.path, 'path', [
                'tupleObjectArray',
                '[0]',
                'city',
              ]),
        ),
      );
    });
    test('format validation - success', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'ipv6Value': '::1',
        'hostnameValue': 'example.com',
        'timeValue': '12:00:00Z',
        'uriReferenceValue': 'a/b?c=d#e',
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.ipv6Value, '::1');
      expect(model.hostnameValue, 'example.com');
      expect(model.timeValue, '12:00:00Z');
      expect(model.uriReferenceValue, 'a/b?c=d#e');
    });

    test('format validation - ipv6 failure', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'ipv6Value': 'invalid-ipv6',
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                contains('must be a valid IPv6 address'),
              )
              .having((e) => e.path, 'path', ['ipv6Value']),
        ),
      );
    });

    test('format validation - hostname failure', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'hostnameValue': '-invalid-host',
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                contains('must be a valid hostname'),
              )
              .having((e) => e.path, 'path', ['hostnameValue']),
        ),
      );
    });

    test('format validation - time failure', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'timeValue': '25:00:00Z',
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                contains('must be a valid time string'),
              )
              .having((e) => e.path, 'path', ['timeValue']),
        ),
      );
    });

    test('format validation - uri-reference failure', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'uriReferenceValue': 'a b', // space is invalid
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                contains('must be a valid URI reference'),
              )
              .having((e) => e.path, 'path', ['uriReferenceValue']),
        ),
      );
    });
    test('additionalProperties - parse and serialize success', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'additionalPropertiesObject': {
          'name': 'Defined Name',
          'extraKey1': 'extraValue1',
          'extraKey2': 'extraValue2',
        },
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      final mapObj = model.additionalPropertiesObject!;
      expect(mapObj.name, 'Defined Name');
      expect(mapObj.additionalProperties, {
        'extraKey1': 'extraValue1',
        'extraKey2': 'extraValue2',
      });

      final serialized = model.toJson();
      expect(
        serialized,
        contains(
          '"additionalPropertiesObject":{"name":"Defined Name","extraKey1":"extraValue1","extraKey2":"extraValue2"}',
        ),
      );
    });

    test(
      'additionalProperties - validation failure (invalid additional property type)',
      () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'additionalPropertiesObject': {
            'name': 'Defined Name',
            'extraKey1': 42, // should be string
          },
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonParseException>().having((e) => e.path, 'path', [
              'additionalPropertiesObject',
              'extraKey1',
            ]),
          ),
        );
      },
    );

    test(
      'additionalProperties: false - success when no additional properties',
      () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'strictObject': {'name': 'Strict Name'},
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.strictObject!.name, 'Strict Name');
      },
    );

    test(
      'additionalProperties: false - failure when additional properties present',
      () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'strictObject': {'name': 'Strict Name', 'extraKey': 'value'},
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonParseException>()
                .having(
                  (e) => e.message,
                  'message',
                  contains('Value is not allowed here'),
                )
                .having((e) => e.path, 'path', ['strictObject', 'extraKey']),
          ),
        );
      },
    );
    test('not validation - success', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'notObject': {
          'notPatternString': 'allowed string', // does not contain "forbidden"
          'notEnumInt': 10, // not 13 or 17
          'notNullValue': 42, // not null
        },
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.notObject!.notPatternString, 'allowed string');
      expect(model.notObject!.notEnumInt, 10);
      expect(model.notObject!.notNullValue, 42);
    });

    test('not validation - failure (pattern matches)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'notObject': {
          'notPatternString': 'this is forbidden text', // matches "forbidden"
          'notEnumInt': 10,
          'notNullValue': 42,
        },
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                contains('must not match the schema'),
              )
              .having((e) => e.path, 'path', ['notObject', 'notPatternString']),
        ),
      );
    });

    test('not validation - failure (enum value matches)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'notObject': {
          'notPatternString': 'allowed string',
          'notEnumInt': 13, // forbidden value
          'notNullValue': 42,
        },
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                contains('must not match the schema'),
              )
              .having((e) => e.path, 'path', ['notObject', 'notEnumInt']),
        ),
      );
    });

    test('not validation - failure (value is null)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'notObject': {
          'notPatternString': 'allowed string',
          'notEnumInt': 10,
          'notNullValue': null, // forbidden null
        },
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonValidationException>()
              .having(
                (e) => e.message,
                'message',
                contains('must not match the schema'),
              )
              .having((e) => e.path, 'path', ['notObject', 'notNullValue']),
        ),
      );
    });
    test('anyOfValue - success (string)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'anyOfValue': 'hello',
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.anyOfValue, isA<TestRootAnyOfValueOption0>());
      expect((model.anyOfValue as TestRootAnyOfValueOption0).value, 'hello');
    });

    test('anyOfValue - success (integer)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'anyOfValue': 42,
      };
      final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
      expect(model.anyOfValue, isA<TestRootAnyOfValueOption1>());
      expect((model.anyOfValue as TestRootAnyOfValueOption1).value, 42);
    });

    test('anyOfValue - failure (invalid type)', () {
      final jsonObject = {
        'name': 'John',
        'age': 35,
        'isAwesome': true,
        'address': {'city': 'London'},
        'anyOfValue': true,
      };
      expect(
        () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
        throwsA(
          isA<JsonParseException>().having(
            (e) => e.message,
            'message',
            contains('Failed to parse TestRootAnyOfValue union'),
          ),
        ),
      );
    });

    group('MergedAllOfObject validation', () {
      test('success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'mergedAllOfObject': {
            'strVal': 'a@b.com', // starts with 'a', length 7, email
            'numVal': 15, // >= 10, <= 50, multiple of 5
          },
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.mergedAllOfObject!.strVal, 'a@b.com');
        expect(model.mergedAllOfObject!.numVal, 15);
      });

      test('success (empty optional)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'mergedAllOfObject': <String, dynamic>{},
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.mergedAllOfObject!.strVal, isNull);
        expect(model.mergedAllOfObject!.numVal, isNull);
      });

      test('failure (dependent required missing numVal)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'mergedAllOfObject': {'strVal': 'a@b.com'},
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>()
                .having(
                  (e) => e.message,
                  'message',
                  contains('required because "strVal" is present'),
                )
                .having((e) => e.path, 'path', ['mergedAllOfObject', 'numVal']),
          ),
        );
      });

      test('failure (strVal minLength)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'mergedAllOfObject': {
            'strVal': 'a@b', // length 3 < 5
            'numVal': 15,
          },
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>()
                .having(
                  (e) => e.message,
                  'message',
                  contains('length must be >= 5'),
                )
                .having((e) => e.path, 'path', ['mergedAllOfObject', 'strVal']),
          ),
        );
      });

      test('failure (strVal maxLength)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'mergedAllOfObject': {
            'strVal': 'aaaa@b.com', // length 10 > 8
            'numVal': 15,
          },
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>()
                .having(
                  (e) => e.message,
                  'message',
                  contains('length must be <= 8'),
                )
                .having((e) => e.path, 'path', ['mergedAllOfObject', 'strVal']),
          ),
        );
      });

      test('failure (strVal pattern)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'mergedAllOfObject': {
            'strVal': 'x@y.com', // does not start with 'a'
            'numVal': 15,
          },
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>()
                .having(
                  (e) => e.message,
                  'message',
                  contains('must match pattern'),
                )
                .having((e) => e.path, 'path', ['mergedAllOfObject', 'strVal']),
          ),
        );
      });

      test('failure (strVal format)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'mergedAllOfObject': {
            'strVal': 'a_no_at', // no '@'
            'numVal': 15,
          },
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>()
                .having(
                  (e) => e.message,
                  'message',
                  contains('must be a valid email address'),
                )
                .having((e) => e.path, 'path', ['mergedAllOfObject', 'strVal']),
          ),
        );
      });

      test('failure (numVal minimum)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'mergedAllOfObject': {
            'strVal': 'a@b.com',
            'numVal': 5, // < 10
          },
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>()
                .having((e) => e.message, 'message', contains('must be >= 10'))
                .having((e) => e.path, 'path', ['mergedAllOfObject', 'numVal']),
          ),
        );
      });

      test('failure (numVal maximum)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'mergedAllOfObject': {
            'strVal': 'a@b.com',
            'numVal': 55, // > 50
          },
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>()
                .having((e) => e.message, 'message', contains('must be <= 50'))
                .having((e) => e.path, 'path', ['mergedAllOfObject', 'numVal']),
          ),
        );
      });

      test('failure (numVal multipleOf)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'mergedAllOfObject': {
            'strVal': 'a@b.com',
            'numVal': 12, // not multiple of 5
          },
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>()
                .having(
                  (e) => e.message,
                  'message',
                  contains('must be a multiple of 5'),
                )
                .having((e) => e.path, 'path', ['mergedAllOfObject', 'numVal']),
          ),
        );
      });
    });

    group('StrictObject validation', () {
      test('success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'strictObject': {'name': 'valueA'},
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.strictObject!.name, 'valueA');
      });

      test('failure with unknown property (not allowed)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'strictObject': {'name': 'valueA', 'unknownProp': 123},
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonParseException>().having(
              (e) => e.message,
              'message',
              contains('Value is not allowed here'),
            ),
          ),
        );
      });
    });
    group('ComplexMergedObject validation', () {
      test('success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'complexMerged': {
            'numVal': 15.0,
            'additionalProp1': 'val1',
            'additionalProp2': 'val2',
          },
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.complexMerged!.numVal, 15.0);
        expect(
          model.complexMerged!.additionalProperties['additionalProp1'],
          'val1',
        );
      });

      test('failure (exclusiveMinimum)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'complexMerged': {'numVal': 10.0, 'additionalProp1': 'val1'},
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains('must be > 10.0'),
            ),
          ),
        );
      });

      test('failure (exclusiveMaximum)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'complexMerged': {'numVal': 20.0, 'additionalProp1': 'val1'},
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains('must be < 20.0'),
            ),
          ),
        );
      });

      test('failure (additionalProperties minLength)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'complexMerged': {'numVal': 15.0, 'additionalProp1': 'ab'},
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains('length must be >= 3'),
            ),
          ),
        );
      });

      test('failure (minProperties)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'complexMerged': <String, dynamic>{'numVal': 15.0},
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains('Object must have >= 2 properties'),
            ),
          ),
        );
      });

      test('failure (maxProperties)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'complexMerged': {
            'numVal': 15.0,
            'p1': 'val1',
            'p2': 'val2',
            'p3': 'val3',
            'p4': 'val4',
            'p5': 'val5',
          },
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains('Object must have <= 5 properties'),
            ),
          ),
        );
      });
    });

    group('MyEnum validation', () {
      test('success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'myEnumField': 'beta',
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.myEnumField, MyEnum.beta);
      });

      test('failure (invalid enum value)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'myEnumField': 'delta',
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonParseException>().having(
              (e) => e.message,
              'message',
              contains('Invalid enum value: delta'),
            ),
          ),
        );
      });
    });

    group('Contains validations', () {
      test('unionContainsArray success (string)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'unionContainsArray': [1, 'a@b.co', true],
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.unionContainsArray, isNotNull);
      });

      test('unionContainsArray success (int)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'unionContainsArray': [1, 6, true],
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.unionContainsArray, isNotNull);
      });

      test('unionContainsArray success (double)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'unionContainsArray': [1, 7.5, true],
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.unionContainsArray, isNotNull);
      });

      test('unionContainsArray failure (no match)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'unionContainsArray': [1, 'ab', 4, 7.3, true],
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains(
                'must contain at least 1 items matching contains schema',
              ),
            ),
          ),
        );
      });

      test('objectContainsArray success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'objectContainsArray': [
            {'city': 'Paris'},
          ],
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.objectContainsArray, isNotNull);
      });

      test('enumContainsArray success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'enumContainsArray': ['alpha'],
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.enumContainsArray, isNotNull);
      });

      test('booleanContainsArray success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'booleanContainsArray': [true],
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.booleanContainsArray, isNotNull);
      });

      test('nullContainsArray success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'nullContainsArray': [null],
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.nullContainsArray, isNotNull);
      });

      test('anyContainsArray success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'anyContainsArray': [123],
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.anyContainsArray, isNotNull);
      });
      test('stringContainsArray success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'stringContainsArray': ['a@b.co'],
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.stringContainsArray, isNotNull);
      });

      test('stringContainsArray failure (no match)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'stringContainsArray': ['ab', 'a@b.corporation', 'b@c.co'],
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains(
                'must contain at least 1 items matching contains schema',
              ),
            ),
          ),
        );
      });

      test('numberContainsArray success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'numberContainsArray': [5.5],
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.numberContainsArray, isNotNull);
      });

      test('numberContainsArray failure (no match)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'numberContainsArray': [4.0, 11.0, 4.5, 10.5, 5.3],
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains(
                'must contain at least 1 items matching contains schema',
              ),
            ),
          ),
        );
      });
    });

    group('ObjectWithDynamicProps validation', () {
      test('success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'dynamicProps': {
            'notInt': 'string is not int',
            'notNum': 'string is not num',
          },
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.dynamicProps, isNotNull);
      });

      test('failure (notInt matches int)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'dynamicProps': {'notInt': 42, 'notNum': 'string'},
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains('Property "notInt" must not match the schema'),
            ),
          ),
        );
      });

      test('failure (notNum matches num)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'dynamicProps': {'notInt': 'string', 'notNum': 3.14},
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains('Property "notNum" must not match the schema'),
            ),
          ),
        );
      });
    });

    group('Missing formats validation', () {
      test('success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'dateTimeField': '2026-06-08T12:00:00Z',
          'dateField': '2026-06-08',
          'ipv4Field': '192.168.1.1',
          'uriField': 'https://google.com',
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.dateTimeField, '2026-06-08T12:00:00Z');
        expect(model.dateField, '2026-06-08');
        expect(model.ipv4Field, '192.168.1.1');
        expect(model.uriField, 'https://google.com');
      });

      test('dateTimeField failure', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'dateTimeField': 'not-a-date-time',
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains('must be a valid RFC 3339 date-time string'),
            ),
          ),
        );
      });

      test('dateField failure', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'dateField': '08-06-2026',
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains('must be a valid date string'),
            ),
          ),
        );
      });

      test('ipv4Field failure', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'ipv4Field': '256.0.0.1',
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains('must be a valid IPv4 address'),
            ),
          ),
        );
      });

      test('uriField failure', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'uriField': 'not-a-uri',
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonValidationException>().having(
              (e) => e.message,
              'message',
              contains('must be a valid absolute URI'),
            ),
          ),
        );
      });
    });

    group('Empty defaults validation', () {
      test('should use empty list and empty map defaults', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.defaultEmptyList, const <String>[]);
        expect(model.defaultEmptyObject, const MapObject());
      });
    });

    group('Union with array option validation', () {
      test('success (string)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'unionWithArrayOption': 'just a string',
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(
          model.unionWithArrayOption,
          isA<TestRootUnionWithArrayOptionOption0>(),
        );
      });

      test('success (array of Address)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'unionWithArrayOption': [
            {'city': 'London', 'street': 'Baker St'},
            {'city': 'Paris'},
          ],
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(
          model.unionWithArrayOption,
          isA<TestRootUnionWithArrayOptionOption1>(),
        );
      });

      test('failure (invalid item in array)', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'unionWithArrayOption': [
            {'city': 'London'},
            {'street': 'Baker St'},
          ],
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonParseException>().having(
              (e) => e.message,
              'message',
              contains('Missing required property: city'),
            ),
          ),
        );
      });
    });

    group('ImpossibleField validation', () {
      test('always fails when populated', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'impossibleField': 'cannot match string and int',
        };
        expect(
          () => TestRoot.fromJson(JsonReader.fromObject(jsonObject)),
          throwsA(
            isA<JsonParseException>().having(
              (e) => e.message,
              'message',
              contains('Value is not allowed here'),
            ),
          ),
        );
      });
    });

    group('TupleSameTypeArray validation', () {
      test('success', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'tupleSameTypeArray': ['a', 'bbbb', 'ccc'],
        };
        final model = TestRoot.fromJson(JsonReader.fromObject(jsonObject));
        expect(model.tupleSameTypeArray, ['a', 'bbbb', 'ccc']);
      });
    });

    group('Map and Value Conversion', () {
      test('TestRoot toMap and fromMap success', () {
        final jsonMap = {
          'name': 'John',
          'age': 30,
          'isAwesome': true,
          'address': {'city': 'London', 'street': 'Baker St'},
          'tags': ['a', 'b'],
          'tupleArray': ['hello', 42, true],
        };

        // Parse from Map
        final model = TestRoot.fromMap(jsonMap);
        expect(model.name, 'John');
        expect(model.age, 30);
        expect(model.isAwesome, true);
        expect(model.address.city, 'London');
        expect(model.address.street, 'Baker St');
        expect(model.tags, ['a', 'b']);
        expect(model.tupleArray, ['hello', 42, true]);

        // Convert back to Map
        final map = model.toMap();
        expect(map['name'], 'John');
        expect(map['age'], 30);
        expect(map['isAwesome'], true);
        expect(map['address'], {'city': 'London', 'street': 'Baker St'});
        expect(map['tags'], ['a', 'b']);
        expect(map['tupleArray'], ['hello', 42, true]);
        // Default values should be present
        expect(map['defaultString'], 'default value');
      });

      test('TestRoot.fromMap failure (validation)', () {
        final invalidMap = {
          'name': 'J', // too short, minLength: 2
          'age': 30,
          'isAwesome': true,
          'address': {'city': 'London'},
        };
        expect(
          () => TestRoot.fromMap(invalidMap),
          throwsA(isA<JsonValidationException>()),
        );
      });

      test('Union fromJsonValue and toJsonValue', () {
        // Union containing primitive (String)
        final unionVal1 = TestRootUnionValue.fromJsonValue('hello');
        expect(unionVal1, isA<TestRootUnionValueOption0>());
        expect((unionVal1 as TestRootUnionValueOption0).value, 'hello');
        expect(unionVal1.toJsonValue(), 'hello');

        // Union containing object (Address)
        final addressMap = {'city': 'Paris'};
        final unionVal2 = TestRootUnionValue.fromJsonValue(addressMap);
        expect(unionVal2, isA<TestRootUnionValueOption1>());
        expect((unionVal2 as TestRootUnionValueOption1).value.city, 'Paris');
        expect(unionVal2.toJsonValue(), {'city': 'Paris'});
      });
    });

    group('Custom Naming (x-dart-name)', () {
      test('success parsing custom named object, union, and enum', () {
        final jsonObject = {
          'name': 'John',
          'age': 35,
          'isAwesome': true,
          'address': {'city': 'London'},
          'customNamedObject': {'foo': 'bar'},
          'customNamedUnion': 'hello union',
          'customNamedEnum': 'one',
        };

        final model = TestRoot.fromMap(jsonObject);

        // Verify types of custom named fields
        expect(model.customNamedObject, isA<MyCustomClassName>());
        expect(model.customNamedObject?.foo, 'bar');

        expect(model.customNamedUnion, isA<MyCustomUnionName>());
        expect(model.customNamedUnion, isA<MyCustomUnionNameOption0>());
        expect(
          (model.customNamedUnion as MyCustomUnionNameOption0).value,
          'hello union',
        );

        expect(model.customNamedEnum, isA<MyCustomEnumName>());
        expect(model.customNamedEnum, MyCustomEnumName.one);
      });
    });
  });
}
