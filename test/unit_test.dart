import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';


void main() {
  group('SchemaExtensions', () {
    test('realSchema throws on unresolved reference', () {
      final refSchema = RefSchema(r'#/$defs/NonExistent');
      expect(
        () => refSchema.realSchema,
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('Ref has not been resolved'),
          ),
        ),
      );
    });

    test('realSchema throws on cyclic reference', () {
      final refA = RefSchema(r'#/$defs/A');
      final refB = RefSchema(r'#/$defs/B');
      refA.resolved = refB;
      refB.resolved = refA;

      expect(
        () => refA.realSchema,
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('Cyclic reference detected'),
          ),
        ),
      );
    });
  });

  group('wrapException', () {
    test('wraps JsonParseException with string path segment', () {
      final inner = JsonParseException('error', 'source', 10, ['inner']);
      final wrapped = wrapException(inner, 'outer');
      expect(wrapped, isA<JsonParseException>());
      final jpe = wrapped as JsonParseException;
      expect(jpe.path, ['outer', 'inner']);
    });

    test('wraps JsonParseException with list path segment', () {
      final inner = JsonParseException('error', 'source', 10, ['inner']);
      final wrapped = wrapException(inner, ['out1', 'out2']);
      expect(wrapped, isA<JsonParseException>());
      final jpe = wrapped as JsonParseException;
      expect(jpe.path, ['out1', 'out2', 'inner']);
    });

    test('wraps FormatException with string path segment', () {
      final inner = FormatException('error', 'source', 10);
      final wrapped = wrapException(inner, 'outer');
      expect(wrapped, isA<JsonParseException>());
      final jpe = wrapped as JsonParseException;
      expect(jpe.path, ['outer']);
      expect(jpe.message, 'error');
    });
  });

  group('Format Validators', () {
    test('isValidHostname', () {
      expect(isValidHostname('example.com'), isTrue);
      expect(isValidHostname('a.b.c'), isTrue);
      // Label starting with hyphen
      expect(isValidHostname('-example.com'), isFalse);
      // Label ending with hyphen
      expect(isValidHostname('example-.com'), isFalse);
      // Label too long (> 63 chars)
      final longLabel = 'a' * 64;
      expect(isValidHostname('$longLabel.com'), isFalse);
      // Hostname too long (> 253 chars)
      final longHostname = ('a' * 50 + '.') * 5 + 'com'; // 258 chars
      expect(isValidHostname(longHostname), isFalse);
    });

    test('isValidIPv6', () {
      expect(isValidIPv6('2001:db8::1'), isTrue);
      expect(isValidIPv6('invalid-ipv6'), isFalse);
    });

    test('isValidTime', () {
      expect(isValidTime('12:30:45Z'), isTrue);
      expect(isValidTime('25:00:00Z'), isFalse); // invalid hour
    });

    test('isValidUriReference', () {
      expect(isValidUriReference('/path/to/resource'), isTrue);
      expect(isValidUriReference('http://example.com'), isTrue);
      // Invalid characters
      expect(isValidUriReference('http://example.com/ space'), isFalse);
      // Invalid percent encoding
      expect(isValidUriReference('http://example.com/%zz'), isFalse);
      expect(isValidUriReference('http://example.com/%2'), isFalse);
    });

    test('isValidUri', () {
      expect(isValidUri('http://example.com'), isTrue);
      expect(
        isValidUri('/relative/path'),
        isFalse,
      ); // relative is not absolute URI
      expect(isValidUri('invalid uri with spaces'), isFalse);
    });
  });

  group('JsonValidationException', () {
    test('toString with empty path', () {
      final ex = JsonValidationException('error message');
      expect(ex.toString(), 'JsonValidationException: error message');
    });

    test('toString with path', () {
      final ex = JsonValidationException('error message', ['foo', 'bar']);
      expect(
        ex.toString(),
        r'JsonValidationException at $.foo.bar: error message',
      );
    });
  });

  group('writeAny', () {
    String serialize(dynamic value) {
      final buffer = StringBuffer();
      final sink = jsonStringWriter(buffer);
      writeAny(sink, value);
      return buffer.toString();
    }

    test('null', () {
      expect(serialize(null), 'null');
    });

    test('bool', () {
      expect(serialize(true), 'true');
      expect(serialize(false), 'false');
    });

    test('num', () {
      expect(serialize(42), '42');
      expect(serialize(3.14), '3.14');
    });

    test('string', () {
      expect(serialize('hello'), '"hello"');
    });

    test('list', () {
      expect(serialize([1, 'two', true]), '[1,"two",true]');
    });

    test('map', () {
      expect(serialize({'a': 1, 'b': 'two'}), '{"a":1,"b":"two"}');
    });

    test('JsonWritable', () {
      final writable = _TestWritable('custom-value');
      expect(serialize(writable), '"custom-value"');
    });

    test('unsupported type throws', () {
      expect(() => serialize(DateTime.now()), throwsArgumentError);
    });
  });

  group('NullDescriptor', () {
    test('read/write', () {
      final desc = const NullDescriptor();
      expect(desc.read(JsonReader.fromObject(null)), isNull);
      expect(
        () => desc.read(JsonReader.fromObject('not-null')),
        throwsFormatException,
      );

      final buffer = StringBuffer();
      desc.write(jsonStringWriter(buffer), null);
      expect(buffer.toString(), 'null');
    });
  });

  group('parseWithDescriptor extra branches', () {
    test('NullableDescriptor', () {
      final desc = const NullableDescriptor(StringDescriptor());

      // Null value
      final val1 = parseWithDescriptor(JsonReader.fromObject(null), desc);
      expect(val1, isNull);

      // Non-null value
      final val2 = parseWithDescriptor(JsonReader.fromObject('hello'), desc);
      expect(val2, 'hello');
    });

    test('PrimitiveDescriptor', () {
      final desc = const BoolDescriptor();
      final val = parseWithDescriptor(JsonReader.fromObject(true), desc);
      expect(val, isTrue);
    });

    test('AnythingDescriptor', () {
      final desc = const AnythingDescriptor();
      final val = parseWithDescriptor(
        JsonReader.fromObject({'any': 'thing'}),
        desc,
      );
      expect(val, {'any': 'thing'});
    });

    test('EnumDescriptor success', () {
      final desc = _testEnumDescriptor;
      final val = parseWithDescriptor(JsonReader.fromObject('value1'), desc);
      expect(val, _TestEnum.value1);
    });

    test('EnumDescriptor failure', () {
      final desc = _testEnumDescriptor;
      expect(
        () => parseWithDescriptor(JsonReader.fromObject('invalid-value'), desc),
        throwsFormatException,
      );
    });

    test('NotDescriptor success', () {
      final desc = const NotDescriptor(StringDescriptor());
      final val = parseWithDescriptor(JsonReader.fromObject(42), desc);
      expect(val, 42);
    });

    test('NotDescriptor failure', () {
      final desc = const NotDescriptor(StringDescriptor());
      expect(
        () => parseWithDescriptor(JsonReader.fromObject('hello'), desc),
        throwsA(isA<JsonValidationException>()),
      );
    });
  });

  group('writeWithDescriptor extra branches', () {
    String serialize(dynamic value, SchemaDescriptor desc) {
      final buffer = StringBuffer();
      writeWithDescriptor(jsonStringWriter(buffer), value, desc);
      return buffer.toString();
    }

    test('NullableDescriptor', () {
      final desc = const NullableDescriptor(StringDescriptor());
      expect(serialize(null, desc), 'null');
      expect(serialize('hello', desc), '"hello"');
    });

    test('PrimitiveDescriptor', () {
      final desc = const BoolDescriptor();
      expect(serialize(true, desc), 'true');
    });

    test('AnythingDescriptor', () {
      final desc = const AnythingDescriptor();
      expect(serialize({'any': 'thing'}, desc), '{"any":"thing"}');
    });

    test('EnumDescriptor', () {
      final desc = _testEnumDescriptor;
      expect(serialize(_TestEnum.value1, desc), '"value1"');
    });
  });

  group('SchemaParser', () {
    test('throws ArgumentError on broken ref', () {
      final jsonSchema = {
        'type': 'object',
        'properties': {
          'broken': {r'$ref': r'#/$defs/NonExistent'},
        },
      };
      final parser = SchemaParser(jsonSchema);
      expect(() => parser.parse(), throwsArgumentError);
    });
  });

  group('Runtime Validation', () {
    test('AnythingSchema', () {
      final schema = const AnythingSchema();
      expect(() => schema.validate(1), returnsNormally);
      expect(() => schema.validate('string'), returnsNormally);
      expect(() => schema.validate(null), returnsNormally);
    });

    test('NeverSchema', () {
      final schema = const NeverSchema();
      expect(() => schema.validate(1), throwsA(isA<JsonValidationException>()));
    });

    test('NullSchema', () {
      final schema = const NullSchema();
      expect(() => schema.validate(null), returnsNormally);
      expect(() => schema.validate(1), throwsA(isA<JsonValidationException>()));
    });

    test('BooleanSchema', () {
      final schema = const BooleanSchema();
      expect(() => schema.validate(true), returnsNormally);
      expect(() => schema.validate(1), throwsA(isA<JsonValidationException>()));
    });

    test('NumberSchema', () {
      final schema = const NumberSchema(
        isInteger: false,
        minimum: 5,
        maximum: 10,
      );
      expect(() => schema.validate(7), returnsNormally);
      expect(
        () => schema.validate(4.9),
        throwsA(isA<JsonValidationException>()),
      );
      expect(
        () => schema.validate(10.1),
        throwsA(isA<JsonValidationException>()),
      );

      final intSchema = const NumberSchema(isInteger: true);
      expect(() => intSchema.validate(5), returnsNormally);
      expect(
        () => intSchema.validate(5.5),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('StringSchema', () {
      final schema = const StringSchema(
        minLength: 3,
        maxLength: 5,
        pattern: r'^[a-z]+$',
      );
      expect(() => schema.validate('abc'), returnsNormally);
      expect(
        () => schema.validate('ab'),
        throwsA(isA<JsonValidationException>()),
      );
      expect(
        () => schema.validate('abcdef'),
        throwsA(isA<JsonValidationException>()),
      );
      expect(
        () => schema.validate('ab1'),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('ArraySchema', () {
      final schema = const ArraySchema(
        items: StringSchema(),
        minItems: 1,
        maxItems: 3,
      );
      expect(() => schema.validate(['a', 'b']), returnsNormally);
      expect(
        () => schema.validate([]),
        throwsA(isA<JsonValidationException>()),
      );
      expect(
        () => schema.validate(['a', 'b', 'c', 'd']),
        throwsA(isA<JsonValidationException>()),
      );
      expect(
        () => schema.validate([1]),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('ObjectSchema', () {
      final schema = const ObjectSchema(
        properties: {
          'name': StringSchema(),
          'age': NumberSchema(isInteger: true),
        },
        required: {'name'},
      );
      expect(
        () => schema.validate({'name': 'Alice', 'age': 30}),
        returnsNormally,
      );
      expect(
        () => schema.validate({'age': 30}),
        throwsA(isA<JsonValidationException>()),
      );
      expect(
        () => schema.validate({'name': 123}),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('createValidator', () {
      final schemaJson = {
        'type': 'object',
        'properties': {
          'name': {'type': 'string'},
        },
        'required': ['name'],
      };
      final validator = createValidator(schemaJson);
      expect(() => validator({'name': 'Alice'}), returnsNormally);
      expect(() => validator({}), throwsA(isA<JsonValidationException>()));
    });

    test('Complex Schema Validation', () {
      final schemaFile = File('test/test_schema.schema.json');
      final jsonStr = schemaFile.readAsStringSync();
      final decoded = json.decode(jsonStr) as Map<String, dynamic>;
      final validator = createValidator(decoded);

      // Valid object
      final validObject = {
        'name': 'Alice',
        'age': 30,
        'isAwesome': true,
        'address': {'city': 'Wonderland', 'street': 'Rabbit Hole Lane'},
        'height': 1.65,
        'email': 'alice@example.com',
        'uuid': '123e4567-e89b-12d3-a456-426614174000',
        'tags': ['awesome', 'curious'],
        'scores': [
          {'value': 9.5},
          {'value': 10.0},
        ],
        'unionValue': 'a string',
        'nullableString': null,
        'pet': {
          'kind': 'cat_type', // matches discriminator mapping to Cat
          'meowVolume': 11.0,
        },
        'restrictedObject': {'a': 'valA'},
        'dependentObject': {
          'creditCard': 1234567890,
          'billingAddress': '123 Main St',
        },
        'restrictedArray': [
          3,
          6,
          9,
        ], // contains at least one multiple of 3 >= 5 (6, 9)
        'defaultString': 'custom value',
        'ipv6Value': '2001:db8::1',
        'hostnameValue': 'example.com',
        'timeValue': '12:30:45Z',
        'uriReferenceValue': '/path/to/resource',
        'additionalPropertiesObject': {
          'name': 'MapName',
          'extra1': 'value1',
          'extra2': 'value2',
        },
        'strictObject': {'name': 'StrictName'},
        'notObject': {
          'notPatternString': 'allowed_string',
          'notEnumInt': 42,
          'notNullValue': 'not-null',
        },
        'anyOfValue': 42,
        'myEnumField': 'alpha',
      };

      expect(() => validator(validObject), returnsNormally);

      // Invalid object (missing required field)
      final invalidObject = {
        'name': 'Alice',
        'age': 30,
        'isAwesome': true,
        // 'address' is missing
      };
      expect(
        () => validator(invalidObject),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (invalid field type)
      final invalidObject2 = {
        ...validObject,
        'age': 'thirty', // should be integer
      };
      expect(
        () => validator(invalidObject2),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (violates constraint)
      final invalidObject3 = {
        ...validObject,
        'age': -5, // minimum is 0
      };
      expect(
        () => validator(invalidObject3),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (violates pattern)
      final invalidObject4 = {...validObject, 'email': 'invalid-email'};
      expect(
        () => validator(invalidObject4),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (discriminator mismatch)
      final invalidObject5 = {
        ...validObject,
        'pet': {'kind': 'unknown_type'},
      };
      expect(
        () => validator(invalidObject5),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('not support', () {
      final schema = const AnythingSchema(
        not: StringSchema(),
      );
      expect(() => schema.validate(1), returnsNormally);
      expect(() => schema.validate('string'), throwsA(isA<JsonValidationException>()));
    });
  });
}

class _TestWritable implements JsonWritable {
  final String val;
  _TestWritable(this.val);
  @override
  void writeJson(JsonSink sink) {
    sink.addString(val);
  }
}

enum _TestEnum { value1, value2 }

final _testEnumDescriptor = EnumDescriptor<_TestEnum>(
  base: const StringDescriptor(),
  values: _TestEnum.values,
  fromValue: (v) => _TestEnum.values.firstWhere((e) => e.name == v),
  toValue: (e) => (e as _TestEnum).name,
);
