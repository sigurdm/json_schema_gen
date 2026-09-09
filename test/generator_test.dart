import 'dart:convert';
import 'dart:io';
import 'package:dart_style/dart_style.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';
import 'package:json_schema_gen/json_schema.dart';

void main() {
  test('Generator output is stable and matches test_schema.g.dart', () async {
    final schemaFile = File('test/test_schema.schema.json');
    expect(schemaFile.existsSync(), isTrue);

    final jsonStr = schemaFile.readAsStringSync();
    final decoded = json.decode(jsonStr) as Map<String, dynamic>;

    final parser = SchemaParser(decoded);
    final rootSchema = await parser.parse();

    final rootName = decoded['title'] as String? ?? 'TestRoot';
    final generatedCode = generateCode(rootSchema, rootName);

    final formattedCode = DartFormatter(
      languageVersion: Version(3, 12, 0),
    ).format(generatedCode);

    final expectedFile = File('test/test_schema.g.dart');
    expect(expectedFile.existsSync(), isTrue);
    final expectedCode = expectedFile.readAsStringSync();

    // Normalize line endings to avoid OS-specific failures
    final normalizedExpected = expectedCode.replaceAll('\r\n', '\n');
    final normalizedGenerated = formattedCode.replaceAll('\r\n', '\n');

    expect(
      normalizedGenerated,
      normalizedExpected,
      reason:
          'Generated code does not match test_schema.g.dart. '
          'Run build_runner to update it.',
    );
  });

  group('generateCode with DartImportResolver', () {
    test(
      'allocates prefixes _i1, _i2 and uses them for external types',
      () async {
        final bSchemaJson = json.encode({
          r'$defs': {
            'Address': {
              'type': 'object',
              'properties': {
                'city': {'type': 'string'},
              },
            },
          },
        });

        final cSchemaJson = json.encode({
          r'$defs': {
            'Order': {
              'type': 'object',
              'properties': {
                'id': {'type': 'string'},
              },
            },
          },
        });

        final aSchemaJson = json.encode({
          'title': 'User',
          'type': 'object',
          'properties': {
            'address': {r'$ref': r'b.schema.json#/$defs/Address'},
            'order': {r'$ref': r'c.schema.json#/$defs/Order'},
          },
        });

        final parser = SchemaParser(
          json.decode(aSchemaJson) as Map<String, dynamic>,
          baseUri: 'a.schema.json',
          uriResolver: (uri) async {
            if (uri.path == 'b.schema.json') {
              return utf8.encode(bSchemaJson);
            }
            if (uri.path == 'c.schema.json') {
              return utf8.encode(cSchemaJson);
            }
            throw ArgumentError('Unknown uri: $uri');
          },
        );

        final rootSchema = await parser.parse();
        final code = generateCode(
          rootSchema,
          'User',
          dartImportResolver: (uri) {
            if (uri.path == 'b.schema.json') return 'b.g.dart';
            if (uri.path == 'c.schema.json') return 'c.g.dart';
            return null;
          },
        );

        expect(code, contains("import 'b.g.dart' as _i1;"));
        expect(code, contains("import 'c.g.dart' as _i2;"));
        expect(code, contains('final _i1.Address? address;'));
        expect(code, contains('final _i2.Order? order;'));
        expect(
          code,
          contains('RefDescriptor<_i1.Address>(() => _i1.Address.descriptor)'),
        );
        expect(
          code,
          contains('RefDescriptor<_i2.Order>(() => _i2.Order.descriptor)'),
        );
        expect(code, isNot(contains('final class Address')));
        expect(code, isNot(contains('final class Order')));
      },
    );

    test('falls back to inlining if dartImportResolver returns null', () async {
      final bSchemaJson = json.encode({
        r'$defs': {
          'Address': {
            'type': 'object',
            'properties': {
              'city': {'type': 'string'},
            },
          },
        },
      });

      final aSchemaJson = json.encode({
        'title': 'User',
        'type': 'object',
        'properties': {
          'address': {r'$ref': r'b.schema.json#/$defs/Address'},
        },
      });

      final parser = SchemaParser(
        json.decode(aSchemaJson) as Map<String, dynamic>,
        baseUri: 'a.schema.json',
        uriResolver: (uri) async {
          if (uri.path == 'b.schema.json') {
            return utf8.encode(bSchemaJson);
          }
          throw ArgumentError('Unknown uri: $uri');
        },
      );

      final rootSchema = await parser.parse();
      final code = generateCode(
        rootSchema,
        'User',
        dartImportResolver: (uri) => null, // Resolver returns null -> inline
      );

      expect(code, isNot(contains("import 'b.g.dart'")));
      expect(code, contains('final Address? address;'));
      expect(code, contains('final class Address implements JsonModel'));
    });
  });
}
