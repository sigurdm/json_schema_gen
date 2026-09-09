import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:json_schema_gen/json_schema.dart' hide ioFileResolver;
import 'package:json_schema_gen/src/parser.dart' show ioFileResolver;

void main() {
  group('Schema and Parser metadata preservation', () {
    test(
      'Schema.copyWith preserves and updates defs, definitions, dartInline, documentUri, definitionKey',
      () {
        final original = Schema(
          defs: {
            'A': Schema(type: ['string']),
          },
          definitions: {
            'B': Schema(type: ['integer']),
          },
          dartInline: true,
          documentUri: 'file:///project/schema.schema.json',
          definitionKey: 'MyDef',
        );

        final copySame = original.copyWith();
        expect(copySame.defs, equals(original.defs));
        expect(copySame.definitions, equals(original.definitions));
        expect(copySame.dartInline, isTrue);
        expect(
          copySame.documentUri,
          equals('file:///project/schema.schema.json'),
        );
        expect(copySame.definitionKey, equals('MyDef'));

        final copyUpdated = original.copyWith(
          defs: {
            'C': Schema(type: ['boolean']),
          },
          definitions: {
            'D': Schema(type: ['number']),
          },
          dartInline: false,
          documentUri: 'file:///project/other.schema.json',
          definitionKey: 'NewDef',
        );
        expect(copyUpdated.defs?.containsKey('C'), isTrue);
        expect(copyUpdated.definitions?.containsKey('D'), isTrue);
        expect(copyUpdated.dartInline, isFalse);
        expect(
          copyUpdated.documentUri,
          equals('file:///project/other.schema.json'),
        );
        expect(copyUpdated.definitionKey, equals('NewDef'));
      },
    );

    test(
      'parse and flatten preserve defs, definitions, dartInline, documentUri, definitionKey',
      () async {
        final schemaJson = {
          'title': 'RootContainer',
          'type': 'object',
          r'$defs': {
            'InlinedDef': {
              'x-dart-inline': true,
              'type': 'object',
              'allOf': [
                {
                  'properties': {
                    'name': {'type': 'string'},
                  },
                },
                {
                  'properties': {
                    'extra': {'type': 'string'},
                  },
                },
              ],
            },
          },
          'definitions': {
            'LegacyDef': {
              'type': 'object',
              'allOf': [
                {
                  'properties': {
                    'code': {'type': 'integer'},
                  },
                },
              ],
            },
          },
          'properties': {
            'inlined': {r'$ref': r'#/$defs/InlinedDef'},
            'legacy': {r'$ref': r'#/definitions/LegacyDef'},
          },
        };

        final parser = SchemaParser(schemaJson, baseUri: 'schema.schema.json');
        final root = await parser.parse();

        expect(root.defs, isNotNull);
        expect(root.definitions, isNotNull);
        expect(root.documentUri, equals('schema.schema.json'));

        final inlinedDef = root.defs!['InlinedDef']!;
        expect(inlinedDef.dartInline, isTrue);
        expect(inlinedDef.definitionKey, equals('InlinedDef'));
        expect(inlinedDef.documentUri, equals('schema.schema.json'));
        // After flattening allOf, properties from both branches should be present
        expect(inlinedDef.properties?.containsKey('name'), isTrue);
        expect(inlinedDef.properties?.containsKey('extra'), isTrue);

        final legacyDef = root.definitions!['LegacyDef']!;
        expect(legacyDef.definitionKey, equals('LegacyDef'));
        expect(legacyDef.documentUri, equals('schema.schema.json'));
        expect(legacyDef.properties?.containsKey('code'), isTrue);
      },
    );
  });

  group('ioFileResolver', () {
    test('throws ArgumentError on non-file URIs', () async {
      expect(
        () => ioFileResolver(Uri.parse('http://example.com/schema.json')),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('Only file URIs are supported'),
          ),
        ),
      );

      expect(
        () => ioFileResolver(Uri.parse('https://example.com/schema.json')),
        throwsA(isA<ArgumentError>()),
      );

      expect(
        () => ioFileResolver(Uri.parse('package:pkg/schema.json')),
        throwsA(isA<ArgumentError>()),
      );
    });

    test(
      'throws ArgumentError when file is outside restricted root directory',
      () async {
        final tempDir = await Directory.systemTemp.createTemp(
          'resolver_test_root',
        );
        try {
          final outsideUri = Uri.file('/etc/passwd');
          expect(
            () => ioFileResolver(
              outsideUri,
              rootDirectory: tempDir,
              restrictToRoot: true,
            ),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains('outside the restricted root directory'),
              ),
            ),
          );
        } finally {
          await tempDir.delete(recursive: true);
        }
      },
    );

    test('throws FileSystemException when file does not exist', () async {
      final nonExistent = Uri.file('/tmp/non_existent_schema_123456789.json');
      expect(
        () => ioFileResolver(nonExistent, restrictToRoot: false),
        throwsA(isA<FileSystemException>()),
      );
    });

    test('reads file bytes successfully when file exists', () async {
      final tempDir = await Directory.systemTemp.createTemp(
        'resolver_test_success',
      );
      try {
        final testFile = File(p.join(tempDir.path, 'test.schema.json'));
        await testFile.writeAsString('{"test": true}');

        final bytes = await ioFileResolver(
          testFile.uri,
          rootDirectory: tempDir,
          restrictToRoot: true,
        );
        expect(utf8.decode(bytes), equals('{"test": true}'));
      } finally {
        await tempDir.delete(recursive: true);
      }
    });
  });

  group('realSchema resolution', () {
    test('throws StateError on cyclic reference chains', () {
      final a = Schema(ref: '#/a');
      final b = Schema(ref: '#/b');
      final c = Schema(ref: '#/c');
      a.resolvedRef = b;
      b.resolvedRef = c;
      c.resolvedRef = a;

      expect(
        () => a.realSchema,
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('Cyclic reference detected'),
          ),
        ),
      );
    });

    test('throws StateError when ref is unresolved', () {
      final unresolvedRef = Schema(ref: 'external.schema.json#/Missing');
      expect(
        () => unresolvedRef.realSchema,
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('Ref has not been resolved'),
          ),
        ),
      );

      final unresolvedDynRef = Schema(dynamicRef: '#/MissingDyn');
      expect(
        () => unresolvedDynRef.realSchema,
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('Ref has not been resolved'),
          ),
        ),
      );
    });

    test('resolves multi-hop reference to realSchema', () {
      final target = Schema(type: ['string'], minLength: 5);
      final hop2 = Schema(ref: '#/target')..resolvedRef = target;
      final hop1 = Schema(ref: '#/hop2')..resolvedRef = hop2;

      expect(hop1.realSchema, equals(target));
      expect(hop1.realSchema.minLength, equals(5));
    });
  });

  group('Discriminator', () {
    test('is final, immutable, and preserves propertyName and mapping', () {
      final catSchema = Schema(title: 'Cat', type: ['object']);
      final dogSchema = Schema(title: 'Dog', type: ['object']);
      final disc = Discriminator(
        propertyName: 'animalType',
        mapping: {'cat': catSchema, 'dog': dogSchema},
      );

      expect(disc.propertyName, equals('animalType'));
      expect(disc.mapping?['cat'], equals(catSchema));
      expect(disc.mapping?['dog'], equals(dogSchema));
    });
  });

  group('UnionAnalysis', () {
    test('analyzes anyOf with null schema correctly', () {
      final anyOfWithNull = Schema(
        anyOf: [
          Schema(type: ['string']),
          Schema(type: ['null']),
        ],
      );
      final analysis = UnionAnalysis.analyze(anyOfWithNull);
      expect(analysis.isNullable, isTrue);
      expect(analysis.nonNullSchema, isNotNull);
      expect(analysis.activeSchemas.length, equals(1));
      expect(analysis.activeSchemas.first.type, equals(['string']));
    });

    test('analyzes anyOf with multiple active schemas and null', () {
      final anyOfMulti = Schema(
        anyOf: [
          Schema(type: ['string']),
          Schema(type: ['integer']),
          Schema(type: ['null']),
        ],
      );
      final analysis = UnionAnalysis.analyze(anyOfMulti);
      expect(analysis.isNullable, isTrue);
      expect(analysis.nonNullSchema, isNull);
      expect(analysis.activeSchemas.length, equals(2));
    });

    test('analyzes multi-type unions with and without null', () {
      final multiTypeNullable = Schema(type: ['string', 'null']);
      final analysis = UnionAnalysis.analyze(multiTypeNullable);
      expect(analysis.isNullable, isTrue);
      expect(analysis.nonNullSchema, isNotNull);
      expect(analysis.activeSchemas.length, equals(1));
      expect(analysis.activeSchemas.first.type, equals(['string']));

      final multiTypeNonNullable = Schema(type: ['string', 'integer']);
      final analysis2 = UnionAnalysis.analyze(multiTypeNonNullable);
      expect(analysis2.isNullable, isFalse);
      expect(analysis2.nonNullSchema, isNull);
      expect(analysis2.activeSchemas.length, equals(2));
    });

    test('analyzes oneOf with null schema', () {
      final oneOfNullable = Schema(
        oneOf: [
          Schema(type: ['string']),
          Schema(type: ['null']),
        ],
      );
      final analysis = UnionAnalysis.analyze(oneOfNullable);
      expect(analysis.isNullable, isTrue);
      expect(analysis.nonNullSchema, isNotNull);
      expect(analysis.activeSchemas.length, equals(1));

      final oneOfMulti = Schema(
        oneOf: [
          Schema(type: ['string']),
          Schema(type: ['integer']),
          Schema(type: ['null']),
        ],
      );
      final analysis2 = UnionAnalysis.analyze(oneOfMulti);
      expect(analysis2.isNullable, isTrue);
      expect(analysis2.nonNullSchema, isNull);
      expect(analysis2.activeSchemas.length, equals(2));
    });
  });

  group('SchemaParser allOf merging', () {
    test(
      'merges allOf combinators including patternProperties, prefixItems, and constraints',
      () async {
        final parser = SchemaParser({
          'allOf': [
            {
              'patternProperties': {
                r'^a.*': {'type': 'string'},
                r'^b.*': {'type': 'integer'},
              },
              'dependentRequired': {
                'prop1': ['dep1'],
              },
              'dependentSchemas': {
                'prop1': {'type': 'object'},
              },
              'prefixItems': [
                {'type': 'string'},
              ],
              'contains': {'type': 'string'},
              'unevaluatedProperties': {'type': 'boolean'},
              'unevaluatedItems': {'type': 'number'},
              'pattern': r'^[a-z]+$',
              'multipleOf': 5,
              'enum': ['x', 'y', 'z'],
              'required': ['a'],
            },
            {
              'patternProperties': {
                r'^a.*': {'minLength': 2},
                r'^c.*': {'type': 'boolean'},
              },
              'dependentRequired': {
                'prop1': ['dep2'],
                'prop2': ['dep3'],
              },
              'dependentSchemas': {
                'prop1': {'minProperties': 1},
                'prop2': {'type': 'string'},
              },
              'prefixItems': [
                {'maxLength': 10},
                {'type': 'integer'},
              ],
              'contains': {'minLength': 3},
              'unevaluatedProperties': {'type': 'boolean'},
              'unevaluatedItems': {'type': 'number'},
              'pattern': r'^[a-z]+$',
              'multipleOf': 5,
              'enum': ['y', 'z', 'w'],
              'required': ['b'],
            },
          ],
        });

        final merged = await parser.parse();
        expect(merged.patternProperties?.length, equals(3));
        expect(
          merged.dependentRequired?['prop1'],
          containsAll(['dep1', 'dep2']),
        );
        expect(merged.dependentRequired?['prop2'], contains('dep3'));
        expect(merged.dependentSchemas?.length, equals(2));
        expect(merged.prefixItems?.length, equals(2));
        expect(merged.pattern, equals(r'^[a-z]+$'));
        expect(merged.multipleOf, equals(5));
        expect(merged.enumValues, equals(['y', 'z']));
        expect(merged.required, containsAll(['a', 'b']));
      },
    );

    test(
      'handles allOf with empty enum intersection resulting in isNever',
      () async {
        final parser = SchemaParser({
          'allOf': [
            {
              'enum': ['a', 'b'],
            },
            {
              'enum': ['c', 'd'],
            },
          ],
        });

        final merged = await parser.parse();
        expect(merged.isNever, isTrue);
      },
    );

    test(
      'handles allOf with distinct multipleOf and distinct patterns by calculating LCM and combining lookaheads',
      () async {
        final parser = SchemaParser({
          'allOf': [
            {'multipleOf': 3, 'pattern': '^foo'},
            {'multipleOf': 5, 'pattern': '^bar'},
          ],
        });

        final merged = await parser.parse();
        expect(merged.pattern, equals('(?=^foo)(?=^bar)'));
        expect(merged.multipleOf, equals(15));
      },
    );
  });
}
