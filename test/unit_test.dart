import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:json_schema_gen/src/generator.dart';
import 'package:jsontool/jsontool.dart';

void main() {
  group('SchemaExtensions', () {
    test('realSchema throws on unresolved reference', () {
      final refSchema = Schema(ref: r'#/$defs/NonExistent');
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
      final refA = Schema(ref: r'#/$defs/A');
      final refB = Schema(ref: r'#/$defs/B');
      refA.resolvedRef = refB;
      refB.resolvedRef = refA;

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

    test('UnionDescriptor matching (primitive and complex types)', () {
      final unionDesc = UnionDescriptor(
        title: 'TestUnion',
        activeOptions: [
          UnionOptionDescriptor(const NullDescriptor(), (v) => v),
          UnionOptionDescriptor(const BoolDescriptor(), (v) => v),
          UnionOptionDescriptor(const StringDescriptor(), (v) => v),
          UnionOptionDescriptor(const IntDescriptor(), (v) => v),
          UnionOptionDescriptor(const NumDescriptor(), (v) => v),
          UnionOptionDescriptor(
            const ArrayDescriptor(StringDescriptor()),
            (v) => v,
          ),
          UnionOptionDescriptor(
            ObjectDescriptor<Map>(
              title: 'EmptyObj',
              matches: (v) => v is Map && v.isEmpty,
              instantiate: (f) => f,
              getFields: (v) => (v as Map).cast<String, Object?>(),
              properties: {},
              required: [],
            ),
            (v) => v,
          ),
          UnionOptionDescriptor(_testEnumDescriptor, (v) => v),
          UnionOptionDescriptor(const NeverDescriptor(), (v) => v),
        ],
      );

      expect(serialize(null, unionDesc), 'null');
      expect(serialize(true, unionDesc), 'true');
      expect(serialize('hello', unionDesc), '"hello"');
      expect(serialize(42, unionDesc), '42');
      expect(serialize(42.5, unionDesc), '42.5');
      expect(serialize(['a', 'b'], unionDesc), '["a","b"]');
      expect(serialize({}, unionDesc), '{}');
      expect(serialize(_TestEnum.value1, unionDesc), '"value1"');

      // Failure case (no match)
      expect(() => serialize({'not': 'empty'}, unionDesc), throwsArgumentError);

      // Union with AnythingDescriptor
      final unionWithAnythingDesc = UnionDescriptor(
        title: 'TestUnionWithAnything',
        activeOptions: [
          UnionOptionDescriptor(const IntDescriptor(), (v) => v),
          UnionOptionDescriptor(const AnythingDescriptor(), (v) => v),
        ],
      );
      expect(serialize(42, unionWithAnythingDesc), '42');
      expect(serialize('string', unionWithAnythingDesc), '"string"');
    });
  });

  group('Validation Edge Cases', () {
    test('uniqueItems with nested collections', () {
      final schema = Schema(
        type: ['array'],
        items: Schema.anything,
        uniqueItems: true,
      );
      final list1 = [1, 2];
      final list2 = [1, 2];
      expect(
        () => schema.validate([list1, list2]),
        throwsA(isA<JsonValidationException>()),
      );
      expect(
        () => schema.validate([
          list1,
          [1, 3],
        ]),
        returnsNormally,
      );
    });

    test('EnumSchema with collection values', () {
      final schema = Schema(
        enumValues: const [
          [1, 2],
          [3, 4],
        ],
      );
      expect(() => schema.validate([1, 2]), returnsNormally);
      expect(
        () => schema.validate([1, 3]),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('SchemaParser handles recursive schema (nested cycle)', () async {
      final jsonSchema = {
        'definitions': {
          'A': {
            'type': 'object',
            'properties': {
              'b': {r'$ref': '#/definitions/B'},
            },
          },
          'B': {
            'type': 'object',
            'properties': {
              'a': {r'$ref': '#/definitions/A'},
            },
          },
        },
        r'$ref': '#/definitions/A',
      };
      final parser = SchemaParser(jsonSchema);
      final schema = await parser.parse();
      expect(schema, isNotNull);
      final objectSchema = schema.realSchema;
      final propB = objectSchema.properties!['b']!;
      final bSchema = propB.realSchema;
      final propA = bSchema.properties!['a']!;
      expect(propA.realSchema.isObject, isTrue);
    });

    test(
      'SchemaParser handles direct cyclic reference and realSchema throws',
      () async {
        final jsonSchema = {
          'definitions': {
            'A': {r'$ref': '#/definitions/B'},
            'B': {r'$ref': '#/definitions/A'},
          },
          r'$ref': '#/definitions/A',
        };
        final parser = SchemaParser(jsonSchema);
        final schema = await parser.parse();
        expect(schema, isNotNull);
        expect(() => schema.realSchema, throwsStateError);
      },
    );
  });

  group('Formatting Helpers', () {
    test('toPascalCase', () {
      expect(toPascalCase('some-name'), 'SomeName');
      expect(toPascalCase('some_name'), 'SomeName');
      expect(toPascalCase('some name'), 'SomeName');
      expect(toPascalCase('1-name'), 'Schema1Name');
      expect(toPascalCase('123name'), 'Schema123name');
      expect(toPascalCase(''), '');
      expect(toPascalCase('!@#'), '');
    });

    test('toCamelCase', () {
      expect(toCamelCase('some-name'), 'someName');
      expect(toCamelCase('some_name'), 'someName');
      expect(toCamelCase('some name'), 'someName');
      expect(toCamelCase('PascalCase'), 'pascalCase');
      expect(toCamelCase('class'), 'class_'); // keyword
      expect(toCamelCase('hashCode'), 'hashCode_'); // reserved member
      expect(toCamelCase('1-name'), 'value1Name');
      expect(toCamelCase('123name'), 'value123name');
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
      expect(parser.parse(), throwsArgumentError);
    });

    test('root ref with definitions', () async {
      final jsonSchema = {
        'definitions': {
          'A': {'type': 'string'},
        },
        r'$ref': '#/definitions/A',
      };
      final parser = SchemaParser(jsonSchema);
      final schema = await parser.parse();
      print('Parsed schema: $schema');
    });

    test(
      'handles recursive schema with flattening changes without duplicating classes',
      () async {
        final jsonSchema = {
          'definitions': {
            'Node': {
              'type': 'object',
              'properties': {
                'child': {r'$ref': '#/definitions/Node'},
                'foo': {
                  'allOf': [
                    {'type': 'string', 'minLength': 3},
                    {'type': 'string', 'maxLength': 5},
                  ],
                },
              },
            },
          },
          r'$ref': '#/definitions/Node',
        };
        final parser = SchemaParser(jsonSchema);
        final schema = await parser.parse();

        final rootRef = schema;
        final node1 = rootRef.resolvedRef!;

        final childRef = node1.properties!['child']!;
        final node2 = childRef.resolvedRef!;

        expect(identical(node1, node2), isTrue);
      },
    );

    test('parses boolean schema false as NeverSchema', () async {
      final jsonSchema = {
        'type': 'object',
        'properties': {'blocked': false, 'allowed': true},
      };
      final parser = SchemaParser(jsonSchema);
      final schema = await parser.parse();
      expect(schema.properties!['blocked']!.realSchema.isNever, isTrue);
      expect(schema.properties!['allowed']!.realSchema.isAnything, isTrue);
    });

    test('resolves relative external refs when allowed', () async {
      final mainSchema = {
        'type': 'object',
        'properties': {
          'externalRef': {r'$ref': 'other.json#/definitions/External'},
        },
      };
      final otherSchema = {
        'definitions': {
          'External': {'type': 'string'},
        },
      };

      final parser = SchemaParser(
        mainSchema,
        baseUri: 'main.json',
        uriResolver: (uri) async {
          if (uri.path == 'other.json') {
            return utf8.encode(json.encode(otherSchema));
          }
          throw ArgumentError('Unexpected URI: $uri');
        },
      );

      final schema = await parser.parse();
      final extRef = schema.properties!['externalRef']!;
      expect(extRef.resolvedRef, isNotNull);
      expect(extRef.resolvedRef!.realSchema.isString, isTrue);
    });

    test('throws by default on external refs', () async {
      final mainSchema = {
        'type': 'object',
        'properties': {
          'externalRef': {r'$ref': 'other.json#/definitions/External'},
        },
      };
      final parser = SchemaParser(mainSchema, baseUri: 'main.json');
      expect(parser.parse(), throwsArgumentError);
    });

    test('throws when disallowExternalRefs is true', () async {
      final mainSchema = {
        'type': 'object',
        'properties': {
          'externalRef': {r'$ref': 'other.json#/definitions/External'},
        },
      };
      final parser = SchemaParser(
        mainSchema,
        baseUri: 'main.json',
        disallowExternalRefs: true,
      );
      expect(parser.parse(), throwsArgumentError);
    });

    test('ioFileResolver resolves local files', () async {
      final tempDir = Directory.systemTemp.createTempSync('json_schema_test');
      try {
        final mainUri = tempDir.uri.resolve('main.json');
        final otherUri = tempDir.uri.resolve('other.json');
        final mainFile = File.fromUri(mainUri);
        final otherFile = File.fromUri(otherUri);

        mainFile.writeAsStringSync(
          json.encode({
            'type': 'object',
            'properties': {
              'externalRef': {r'$ref': 'other.json#/definitions/External'},
            },
          }),
        );

        otherFile.writeAsStringSync(
          json.encode({
            'definitions': {
              'External': {'type': 'string'},
            },
          }),
        );

        final parser = SchemaParser(
          json.decode(mainFile.readAsStringSync()) as Map<String, dynamic>,
          baseUri: mainUri.toString(),
          uriResolver: (uri) => ioFileResolver(uri, rootDirectory: tempDir),
        );

        final schema = await parser.parse();
        final extRef = schema.properties!['externalRef']!;
        expect(extRef.resolvedRef, isNotNull);
        expect(extRef.resolvedRef!.realSchema.isString, isTrue);
      } finally {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('ioFileResolver throws ArgumentError on path traversal', () async {
      final tempDir = Directory.systemTemp.createTempSync('json_schema_test');
      try {
        final mainUri = tempDir.uri.resolve('main.json');
        final mainFile = File.fromUri(mainUri);

        mainFile.writeAsStringSync(
          json.encode({
            'type': 'object',
            'properties': {
              'externalRef': {r'$ref': '../unsafe.json#/definitions/External'},
            },
          }),
        );

        final parser = SchemaParser(
          json.decode(mainFile.readAsStringSync()) as Map<String, dynamic>,
          baseUri: mainUri.toString(),
          uriResolver: (uri) => ioFileResolver(uri, rootDirectory: tempDir),
        );

        expect(
          () => parser.parse(),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('Access denied'),
            ),
          ),
        );
      } finally {
        tempDir.deleteSync(recursive: true);
      }
    });
  });

  group('Runtime Validation', () {
    test('AnythingSchema', () {
      final schema = Schema.anything;
      expect(() => schema.validate(1), returnsNormally);
      expect(() => schema.validate('string'), returnsNormally);
      expect(() => schema.validate(null), returnsNormally);
    });

    test('NeverSchema', () {
      final schema = Schema.never;
      expect(() => schema.validate(1), throwsA(isA<JsonValidationException>()));
    });

    test('NullSchema', () {
      final schema = Schema(type: ['null']);
      expect(() => schema.validate(null), returnsNormally);
      expect(() => schema.validate(1), throwsA(isA<JsonValidationException>()));
    });

    test('BooleanSchema', () {
      final schema = Schema(type: ['boolean']);
      expect(() => schema.validate(true), returnsNormally);
      expect(() => schema.validate(1), throwsA(isA<JsonValidationException>()));
    });

    test('NumberSchema', () {
      final schema = Schema(type: ['number'], minimum: 5, maximum: 10);
      expect(() => schema.validate(7), returnsNormally);
      expect(
        () => schema.validate(4.9),
        throwsA(isA<JsonValidationException>()),
      );
      expect(
        () => schema.validate(10.1),
        throwsA(isA<JsonValidationException>()),
      );

      final intSchema = Schema(type: ['integer']);
      expect(() => intSchema.validate(5), returnsNormally);
      expect(
        () => intSchema.validate(5.5),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('StringSchema', () {
      final schema = Schema(
        type: ['string'],
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
      final schema = Schema(
        type: ['array'],
        items: Schema(type: ['string']),
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
      final schema = Schema(
        type: ['object'],
        properties: {
          'name': Schema(type: ['string']),
          'age': Schema(type: ['integer']),
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

    test('patternProperties', () {
      final schema = Schema(
        type: ['object'],
        properties: {
          'name': Schema(type: ['string']),
        },
        patternProperties: {
          RegExp(r'^S_'): Schema(type: ['string']),
          RegExp(r'^I_'): Schema(type: ['integer']),
        },
        required: {'name'},
        additionalProperties: Schema(booleanValue: false),
      );

      expect(
        () => schema.validate({'name': 'Alice', 'S_foo': 'bar', 'I_bar': 42}),
        returnsNormally,
      );

      expect(
        () => schema.validate({'name': 'Alice', 'S_foo': 42}),
        throwsA(isA<JsonValidationException>()),
      );

      expect(
        () => schema.validate({'name': 'Alice', 'I_bar': 'not-an-int'}),
        throwsA(isA<JsonValidationException>()),
      );

      expect(
        () => schema.validate({'name': 'Alice', 'invalid_extra': 'value'}),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('patternProperties multi-match', () {
      final schema = Schema(
        type: ['object'],
        properties: const {},
        required: const {},
        patternProperties: {
          RegExp(r'a'): Schema(type: ['string'], minLength: 3),
          RegExp(r'b'): Schema(type: ['string'], pattern: r'^x'),
        },
        additionalProperties: Schema(booleanValue: false),
      );

      expect(() => schema.validate({'a': 'abc'}), returnsNormally);
      expect(
        () => schema.validate({'a': 'ab'}),
        throwsA(isA<JsonValidationException>()),
      );

      expect(() => schema.validate({'b': 'xyz'}), returnsNormally);
      expect(
        () => schema.validate({'b': 'yz'}),
        throwsA(isA<JsonValidationException>()),
      );

      expect(() => schema.validate({'ab': 'xyz'}), returnsNormally);
      expect(
        () => schema.validate({'ab': 'xy'}),
        throwsA(isA<JsonValidationException>()),
      );
      expect(
        () => schema.validate({'ab': 'yz'}),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('AllOfSchema', () {
      final schema = Schema(
        allOf: [
          Schema(type: ['string'], minLength: 3),
          Schema(type: ['string'], maxLength: 5),
        ],
      );
      expect(() => schema.validate('abcd'), returnsNormally);
      expect(
        () => schema.validate('ab'),
        throwsA(isA<JsonValidationException>()),
      );
      expect(
        () => schema.validate('abcdef'),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('UnionSchema', () {
      final schema = Schema(
        anyOf: [
          Schema(type: ['string']),
          Schema(type: ['integer']),
        ],
      );
      expect(() => schema.validate('hello'), returnsNormally);
      expect(() => schema.validate(42), returnsNormally);
      expect(
        () => schema.validate(true),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('EnumSchema', () {
      final schema = Schema(
        type: ['string'],
        enumValues: ['red', 'green', 'blue'],
      );
      expect(() => schema.validate('red'), returnsNormally);
      expect(
        () => schema.validate('yellow'),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('not constraint', () {
      final schema = Schema(
        type: ['string'],
        not: Schema(type: ['string'], pattern: r'^forbidden'),
      );
      expect(() => schema.validate('allowed'), returnsNormally);
      expect(
        () => schema.validate('forbidden_word'),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('createValidator', () async {
      final schemaJson = {
        'type': 'object',
        'properties': {
          'name': {'type': 'string'},
        },
        'required': ['name'],
      };
      final validator = await createValidator(schemaJson);
      expect(() => validator({'name': 'Alice'}), returnsNormally);
      expect(() => validator({}), throwsA(isA<JsonValidationException>()));
    });

    test('Complex Schema Validation', () async {
      final schemaFile = File('test/test_schema.schema.json');
      final jsonStr = schemaFile.readAsStringSync();
      final decoded = json.decode(jsonStr) as Map<String, dynamic>;
      final validator = await createValidator(decoded, validateFormats: true);

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
        'dateTimeField': '2026-06-08T12:00:00Z',
        'dateField': '2026-06-08',
        'ipv4Field': '192.168.1.1',
        'uriField': 'https://example.com',
        'tupleArray': ['hello', 42, true],
        'mergedAllOfObject': {'numVal': 15.0, 'strVal': 'a@b.com'},
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

      // Invalid object (not validation failure - pattern matches)
      expect(
        () => validator({
          ...validObject,
          'notObject': {
            'notPatternString': 'forbidden',
            'notEnumInt': 42,
            'notNullValue': 'not-null',
          },
        }),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (not validation failure - enum matches)
      expect(
        () => validator({
          ...validObject,
          'notObject': {
            'notPatternString': 'allowed_string',
            'notEnumInt': 13,
            'notNullValue': 'not-null',
          },
        }),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (minProperties failure)
      expect(
        () => validator({...validObject, 'restrictedObject': {}}),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (maxProperties failure)
      expect(
        () => validator({
          ...validObject,
          'restrictedObject': {'a': 'valA', 'b': 'valB', 'c': 'valC'},
        }),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (dependentRequired failure)
      expect(
        () => validator({
          ...validObject,
          'dependentObject': {'creditCard': 1234567890},
        }),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (contains failure)
      expect(
        () => validator({
          ...validObject,
          'restrictedArray': [1, 2, 4, 5],
        }),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (format failure - ipv6)
      expect(
        () => validator({...validObject, 'ipv6Value': 'invalid-ipv6'}),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (format failure - hostname)
      expect(
        () => validator({...validObject, 'hostnameValue': '-invalid-host'}),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (format failure - time)
      expect(
        () => validator({...validObject, 'timeValue': '25:00:00Z'}),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (format failure - uri-reference)
      expect(
        () => validator({
          ...validObject,
          'uriReferenceValue': 'http://example.com/ space',
        }),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (additionalProperties: false failure)
      expect(
        () => validator({
          ...validObject,
          'strictObject': {'name': 'StrictName', 'extra': 'not-allowed'},
        }),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (format failure - date-time)
      expect(
        () => validator({...validObject, 'dateTimeField': 'invalid-date-time'}),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (format failure - date)
      expect(
        () => validator({...validObject, 'dateField': 'invalid-date'}),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (format failure - ipv4)
      expect(
        () => validator({...validObject, 'ipv4Field': '256.1.1.1'}),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (format failure - uri)
      expect(
        () => validator({...validObject, 'uriField': 'invalid-uri'}),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (tupleArray first item failure)
      expect(
        () => validator({
          ...validObject,
          'tupleArray': [123, 42],
        }),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (tupleArray second item failure)
      expect(
        () => validator({
          ...validObject,
          'tupleArray': ['hello', 42.5],
        }),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (tupleArray third item failure)
      expect(
        () => validator({
          ...validObject,
          'tupleArray': ['hello', 42, 'not-bool'],
        }),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (uniqueItems failure)
      expect(
        () => validator({
          ...validObject,
          'tags': ['awesome', 'awesome'],
        }),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (multipleOf integer failure)
      expect(
        () => validator({...validObject, 'age': 7}),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (multipleOf number failure in mergedAllOfObject)
      expect(
        () => validator({
          ...validObject,
          'mergedAllOfObject': {'numVal': 7.5, 'strVal': 'a@b.com'},
        }),
        throwsA(isA<JsonValidationException>()),
      );

      // Invalid object (minLength failure in mergedAllOfObject)
      expect(
        () => validator({
          ...validObject,
          'mergedAllOfObject': {'numVal': 15.0, 'strVal': 'abc'},
        }),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('not support', () {
      final schema = Schema(not: Schema(type: ['string']));
      expect(() => schema.validate(1), returnsNormally);
      expect(
        () => schema.validate('string'),
        throwsA(isA<JsonValidationException>()),
      );
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
