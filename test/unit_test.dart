import 'package:test/test.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';
import 'test_schema.g.dart';

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
