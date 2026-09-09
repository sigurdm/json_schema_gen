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

    test('supports arrays of external types', () async {
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
          'addresses': {
            'type': 'array',
            'items': {r'$ref': r'b.schema.json#/$defs/Address'},
          },
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
        dartImportResolver: (uri) {
          if (uri.path == 'b.schema.json') return 'b.g.dart';
          return null;
        },
      );

      expect(code, contains("import 'b.g.dart' as _i1;"));
      expect(code, contains('final List<_i1.Address>? addresses;'));
      expect(
        code,
        contains(
          'ArrayDescriptor<_i1.Address>(RefDescriptor<_i1.Address>(() => _i1.Address.descriptor))',
        ),
      );
      expect(code, isNot(contains('final class Address')));
    });

    test(
      'reuses import prefix for multiple references to the same file',
      () async {
        final bSchemaJson = json.encode({
          r'$defs': {
            'Address': {
              'type': 'object',
              'properties': {
                'city': {'type': 'string'},
              },
            },
            'Country': {
              'type': 'object',
              'properties': {
                'code': {'type': 'string'},
              },
            },
          },
        });

        final aSchemaJson = json.encode({
          'title': 'User',
          'type': 'object',
          'properties': {
            'address': {r'$ref': r'b.schema.json#/$defs/Address'},
            'shippingAddress': {r'$ref': r'b.schema.json#/$defs/Address'},
            'country': {r'$ref': r'b.schema.json#/$defs/Country'},
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
          dartImportResolver: (uri) {
            if (uri.path == 'b.schema.json') return 'b.g.dart';
            return null;
          },
        );

        // Only one import for b.g.dart should be emitted
        expect("import 'b.g.dart' as _i1;".allMatches(code).length, equals(1));
        expect(code, isNot(contains('_i2')));
        expect(code, contains('final _i1.Address? address;'));
        expect(code, contains('final _i1.Address? shippingAddress;'));
        expect(code, contains('final _i1.Country? country;'));
      },
    );

    test('generateCode throws ArgumentError when rootName is empty', () {
      final schema = Schema();
      expect(
        () => generateCode(schema, ''),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('Must not be empty'),
          ),
        ),
      );
    });

    test(
      'supports external schema types in unions (oneOf and anyOf)',
      () async {
        final bSchemaJson = json.encode({
          r'$defs': {
            'CreditCard': {
              'type': 'object',
              'properties': {
                'number': {'type': 'string'},
              },
            },
          },
        });
        final cSchemaJson = json.encode({
          r'$defs': {
            'PayPal': {
              'type': 'object',
              'properties': {
                'email': {'type': 'string'},
              },
            },
          },
        });
        final aSchemaJson = json.encode({
          'title': 'Checkout',
          'type': 'object',
          'properties': {
            'payment': {
              'oneOf': [
                {r'$ref': r'b.schema.json#/$defs/CreditCard'},
                {r'$ref': r'c.schema.json#/$defs/PayPal'},
              ],
            },
            'optionalCard': {
              'anyOf': [
                {r'$ref': r'b.schema.json#/$defs/CreditCard'},
                {'type': 'null'},
              ],
            },
          },
        });

        final parser = SchemaParser(
          json.decode(aSchemaJson) as Map<String, dynamic>,
          baseUri: 'a.schema.json',
          uriResolver: (uri) async {
            if (uri.path == 'b.schema.json') return utf8.encode(bSchemaJson);
            if (uri.path == 'c.schema.json') return utf8.encode(cSchemaJson);
            throw ArgumentError('Unknown uri: $uri');
          },
        );
        final rootSchema = await parser.parse();
        final code = generateCode(
          rootSchema,
          'Checkout',
          dartImportResolver: (uri) {
            if (uri.path == 'b.schema.json') return 'b.g.dart';
            if (uri.path == 'c.schema.json') return 'c.g.dart';
            return null;
          },
        );

        expect(code, contains("import 'b.g.dart' as _i1;"));
        expect(code, contains("import 'c.g.dart' as _i2;"));
        expect(
          code,
          contains('sealed class CheckoutPayment implements JsonModel'),
        );
        expect(code, contains('final _i1.CreditCard value;'));
        expect(code, contains('final _i2.PayPal value;'));
        expect(code, contains('final _i1.CreditCard? optionalCard;'));
        expect(code, isNot(contains('final class CreditCard')));
        expect(code, isNot(contains('final class PayPal')));
      },
    );

    test('supports external schema types in enums', () async {
      final bSchemaJson = json.encode({
        r'$defs': {
          'Status': {
            'enum': ['pending', 'completed', 'failed'],
          },
        },
      });
      final aSchemaJson = json.encode({
        'title': 'Task',
        'type': 'object',
        'properties': {
          'status': {r'$ref': r'b.schema.json#/$defs/Status'},
        },
      });

      final parser = SchemaParser(
        json.decode(aSchemaJson) as Map<String, dynamic>,
        baseUri: 'a.schema.json',
        uriResolver: (uri) async {
          if (uri.path == 'b.schema.json') return utf8.encode(bSchemaJson);
          throw ArgumentError('Unknown uri: $uri');
        },
      );
      final rootSchema = await parser.parse();
      final code = generateCode(
        rootSchema,
        'Task',
        dartImportResolver: (uri) =>
            uri.path == 'b.schema.json' ? 'b.g.dart' : null,
      );

      expect(code, contains("import 'b.g.dart' as _i1;"));
      expect(code, contains('final _i1.Status? status;'));
      expect(code, contains('_i1.Status.descriptor'));
      expect(code, isNot(contains('enum Status')));
    });

    test(
      'supports external schema types in patternProperties and additionalProperties',
      () async {
        final bSchemaJson = json.encode({
          r'$defs': {
            'ConfigItem': {
              'type': 'object',
              'properties': {
                'value': {'type': 'string'},
              },
            },
          },
        });
        final aSchemaJson = json.encode({
          'title': 'Registry',
          'type': 'object',
          'patternProperties': {
            r'^prefix_': {r'$ref': r'b.schema.json#/$defs/ConfigItem'},
          },
          'additionalProperties': {r'$ref': r'b.schema.json#/$defs/ConfigItem'},
        });

        final parser = SchemaParser(
          json.decode(aSchemaJson) as Map<String, dynamic>,
          baseUri: 'a.schema.json',
          uriResolver: (uri) async {
            if (uri.path == 'b.schema.json') return utf8.encode(bSchemaJson);
            throw ArgumentError('Unknown uri: $uri');
          },
        );
        final rootSchema = await parser.parse();
        final code = generateCode(
          rootSchema,
          'Registry',
          dartImportResolver: (uri) =>
              uri.path == 'b.schema.json' ? 'b.g.dart' : null,
        );

        expect(code, contains("import 'b.g.dart' as _i1;"));
        expect(
          code,
          contains('final Map<String, _i1.ConfigItem> additionalProperties;'),
        );
        expect(
          code,
          contains(
            "patternProperties: {_patternRegex0: RefDescriptor<_i1.ConfigItem>(() => _i1.ConfigItem.descriptor)}",
          ),
        );
        expect(code, isNot(contains('final class ConfigItem')));
      },
    );

    test('supports external references with URL-encoded fragments', () async {
      final bSchemaJson = json.encode({
        'definitions': {
          'Special Address': {
            'type': 'object',
            'properties': {
              'street': {'type': 'string'},
            },
          },
        },
      });
      final aSchemaJson = json.encode({
        'title': 'User',
        'type': 'object',
        'properties': {
          'location': {
            r'$ref': r'b.schema.json#/definitions/Special%20Address',
          },
        },
      });

      final parser = SchemaParser(
        json.decode(aSchemaJson) as Map<String, dynamic>,
        baseUri: 'a.schema.json',
        uriResolver: (uri) async {
          if (uri.path == 'b.schema.json') return utf8.encode(bSchemaJson);
          throw ArgumentError('Unknown uri: $uri');
        },
      );
      final rootSchema = await parser.parse();
      final code = generateCode(
        rootSchema,
        'User',
        dartImportResolver: (uri) =>
            uri.path == 'b.schema.json' ? 'b.g.dart' : null,
      );

      expect(code, contains("import 'b.g.dart' as _i1;"));
      expect(code, contains('final _i1.SpecialAddress? location;'));
      expect(
        code,
        contains(
          'RefDescriptor<_i1.SpecialAddress>(() => _i1.SpecialAddress.descriptor)',
        ),
      );
    });

    test(
      'supports external references without fragments pointing to root of external schema file',
      () async {
        // With title
        final bSchemaJson = json.encode({
          'title': 'ExternalRoot',
          'type': 'object',
          'properties': {
            'id': {'type': 'string'},
          },
        });
        // Without title (derives name from file basename)
        final cSchemaJson = json.encode({
          'type': 'object',
          'properties': {
            'enabled': {'type': 'boolean'},
          },
        });
        final aSchemaJson = json.encode({
          'title': 'AppConfig',
          'type': 'object',
          'properties': {
            'rootModel': {r'$ref': 'b.schema.json'},
            'customSettings': {r'$ref': 'custom_settings.schema.json'},
          },
        });

        final parser = SchemaParser(
          json.decode(aSchemaJson) as Map<String, dynamic>,
          baseUri: 'a.schema.json',
          uriResolver: (uri) async {
            if (uri.path == 'b.schema.json') return utf8.encode(bSchemaJson);
            if (uri.path == 'custom_settings.schema.json') {
              return utf8.encode(cSchemaJson);
            }
            throw ArgumentError('Unknown uri: $uri');
          },
        );
        final rootSchema = await parser.parse();
        final code = generateCode(
          rootSchema,
          'AppConfig',
          dartImportResolver: (uri) {
            if (uri.path == 'b.schema.json') return 'b.g.dart';
            if (uri.path == 'custom_settings.schema.json') {
              return 'custom_settings.g.dart';
            }
            return null;
          },
        );

        expect(code, contains("import 'b.g.dart' as _i1;"));
        expect(code, contains("import 'custom_settings.g.dart' as _i2;"));
        expect(code, contains('final _i1.ExternalRoot? rootModel;'));
        expect(code, contains('final _i2.CustomSettings? customSettings;'));
      },
    );

    test(
      'respects x-dart-inline at definition site, ref site, and multi-hop realSchema',
      () async {
        final bSchemaJson = json.encode({
          r'$defs': {
            'InlinedAtDef': {
              'x-dart-inline': true,
              'type': 'object',
              'properties': {
                'foo': {'type': 'string'},
              },
            },
            'Intermediate': {r'$ref': r'#/$defs/InlinedAtDef'},
            'ExternalNormal': {
              'type': 'object',
              'properties': {
                'bar': {'type': 'integer'},
              },
            },
          },
        });
        final aSchemaJson = json.encode({
          'title': 'Host',
          'type': 'object',
          'properties': {
            'item': {r'$ref': r'b.schema.json#/$defs/InlinedAtDef'},
            'multiHop': {r'$ref': r'b.schema.json#/$defs/Intermediate'},
            'refSiteInlined': {
              r'$ref': r'b.schema.json#/$defs/ExternalNormal',
              'x-dart-inline': true,
            },
          },
        });

        final parser = SchemaParser(
          json.decode(aSchemaJson) as Map<String, dynamic>,
          baseUri: 'a.schema.json',
          uriResolver: (uri) async {
            if (uri.path == 'b.schema.json') return utf8.encode(bSchemaJson);
            throw ArgumentError('Unknown uri: $uri');
          },
        );
        final rootSchema = await parser.parse();
        final code = generateCode(
          rootSchema,
          'Host',
          dartImportResolver: (uri) => 'b.g.dart',
        );

        expect(code, isNot(contains("import 'b.g.dart'")));
        expect(code, contains('final InlinedAtDef? item;'));
        expect(code, contains('final InlinedAtDef? multiHop;'));
        expect(code, contains('final ExternalNormal? refSiteInlined;'));
        expect(code, contains('final class InlinedAtDef implements JsonModel'));
        expect(
          code,
          contains('final class ExternalNormal implements JsonModel'),
        );
      },
    );

    test('supports schemas with both \$defs and legacy definitions', () async {
      final schemaJson = json.encode({
        'title': 'MixedDefs',
        'type': 'object',
        r'$defs': {
          'FromDefs': {
            'type': 'object',
            'properties': {
              'd': {'type': 'string'},
            },
          },
        },
        'definitions': {
          'FromLegacy': {
            'type': 'object',
            'properties': {
              'l': {'type': 'integer'},
            },
          },
        },
        'properties': {
          'd': {r'$ref': r'#/$defs/FromDefs'},
          'l': {r'$ref': r'#/definitions/FromLegacy'},
        },
      });

      final parser = SchemaParser(
        json.decode(schemaJson) as Map<String, dynamic>,
      );
      final rootSchema = await parser.parse();
      final code = generateCode(rootSchema, 'MixedDefs');

      expect(code, contains('final FromDefs? d;'));
      expect(code, contains('final FromLegacy? l;'));
      expect(code, contains('final class FromDefs implements JsonModel'));
      expect(code, contains('final class FromLegacy implements JsonModel'));
    });

    test(
      'generates standalone definition library with objects, enums, and unions',
      () async {
        final defsSchemaJson = json.encode({
          r'$defs': {
            'SimpleObject': {
              'type': 'object',
              'properties': {
                'id': {'type': 'string'},
              },
            },
            'SimpleEnum': {
              'enum': ['alpha', 'beta'],
            },
            'SimpleUnion': {
              'oneOf': [
                {
                  'type': 'object',
                  'properties': {
                    'opt1': {'type': 'string'},
                  },
                },
                {
                  'type': 'object',
                  'properties': {
                    'opt2': {'type': 'integer'},
                  },
                },
              ],
            },
          },
        });

        final parser = SchemaParser(
          json.decode(defsSchemaJson) as Map<String, dynamic>,
        );
        final rootSchema = await parser.parse();
        final code = generateCode(rootSchema, 'StandaloneDefs');

        expect(code, contains('final class SimpleObject implements JsonModel'));
        expect(code, contains('enum SimpleEnum {'));
        expect(code, contains('sealed class SimpleUnion implements JsonModel'));
      },
    );

    test(
      'handles class naming edge cases: empty names, keyword collisions, digit enum constants',
      () async {
        final schemaJson = json.encode({
          'title': 'class', // Keyword collision for model
          'type': 'object',
          'properties': {
            'enumProp': {
              'title': 'switch', // Keyword collision for enum
              'enum': ['1st', 'default', 'regular'],
            },
            'unionProp': {
              'title': 'is', // Keyword collision for union
              'oneOf': [
                {
                  'title': '---', // Empty after toPascalCase -> Model
                  'type': 'object',
                  'properties': {
                    'f': {'type': 'string'},
                  },
                },
                {
                  'title': '***', // Empty after toPascalCase -> Model
                  'type': 'object',
                  'properties': {
                    'g': {'type': 'integer'},
                  },
                },
              ],
            },
          },
        });

        final parser = SchemaParser(
          json.decode(schemaJson) as Map<String, dynamic>,
        );
        final root = await parser.parse();
        final code = generateCode(root, 'class');

        expect(code, contains('final class Class1 implements JsonModel'));
        expect(code, contains('enum Switch1 {'));
        expect(code, contains("value1st('1st')"));
        expect(code, contains("default_('default')"));
        expect(code, contains('sealed class Is1 implements JsonModel'));
        expect(code, contains('final class Model implements JsonModel'));
        expect(code, contains('final class Model1 implements JsonModel'));
      },
    );

    test('generates format validations for string formats', () async {
      final schemaJson = json.encode({
        'title': 'FormatsModel',
        'type': 'object',
        'properties': {
          'dt': {'type': 'string', 'format': 'date-time'},
          'd': {'type': 'string', 'format': 'date'},
          'em': {'type': 'string', 'format': 'email'},
          'ip4': {'type': 'string', 'format': 'ipv4'},
          'u': {'type': 'string', 'format': 'uuid'},
          'ur': {'type': 'string', 'format': 'uri'},
          'urref': {'type': 'string', 'format': 'uri-reference'},
          'ip6': {'type': 'string', 'format': 'ipv6'},
          'host': {'type': 'string', 'format': 'hostname'},
          't': {'type': 'string', 'format': 'time'},
        },
      });

      final parser = SchemaParser(
        json.decode(schemaJson) as Map<String, dynamic>,
      );
      final root = await parser.parse();
      final code = generateCode(root, 'FormatsModel');

      expect(code, contains('DateTime.tryParse(val_dt) == null'));
      expect(code, contains('must be a valid IPv4 address'));
      expect(code, contains('isValidIPv6'));
      expect(code, contains('isValidHostname'));
      expect(code, contains('isValidTime'));
      expect(code, contains('isValidUri'));
      expect(code, contains('isValidUriReference'));
    });

    test(
      'generates deprecation annotations with and without custom messages',
      () async {
        final schemaJson = json.encode({
          'title': 'DeprecationsModel',
          'type': 'object',
          'deprecated': true,
          'properties': {
            'withMsg': {
              'type': 'string',
              'deprecated': true,
              'x-deprecated-message': 'Use replacementField',
            },
            'withoutMsg': {'type': 'string', 'deprecated': true},
            'depEnum': {
              'deprecated': true,
              'x-deprecated-message': 'Enum is deprecated',
              'enum': ['a', 'b'],
            },
            'depEnumNoMsg': {
              'deprecated': true,
              'enum': ['x', 'y'],
            },
          },
        });

        final parser = SchemaParser(
          json.decode(schemaJson) as Map<String, dynamic>,
        );
        final root = await parser.parse();
        final code = generateCode(root, 'DeprecationsModel');

        expect(
          code,
          contains("@Deprecated('deprecated')\nfinal class DeprecationsModel"),
        );
        expect(
          code,
          contains(
            "@Deprecated('Use replacementField')\n  final String? withMsg;",
          ),
        );
        expect(
          code,
          contains("@Deprecated('deprecated')\n  final String? withoutMsg;"),
        );
        expect(
          code,
          contains(
            "@Deprecated('Enum is deprecated')\nenum DeprecationsModelDepEnum",
          ),
        );
        expect(
          code,
          contains(
            "@Deprecated('deprecated')\nenum DeprecationsModelDepEnumNoMsg",
          ),
        );
      },
    );

    test(
      'generates default values for null, list, map, and enum constants',
      () async {
        final schemaJson = json.encode({
          'title': 'DefaultsModel',
          'type': 'object',
          'properties': {
            'status': {
              'enum': ['active', 'inactive'],
              'default': 'active',
            },
            'tags': {
              'type': 'array',
              'items': {'type': 'string'},
              'default': ['dart', 'schema'],
            },
            'metadata': {
              'type': 'object',
              'properties': {
                'env': {'type': 'string'},
              },
              'default': {'env': 'prod'},
            },
            'emptyDef': {'type': 'string', 'default': null},
          },
        });

        final parser = SchemaParser(
          json.decode(schemaJson) as Map<String, dynamic>,
        );
        final root = await parser.parse();
        final code = generateCode(root, 'DefaultsModel');

        expect(code, contains('this.status = DefaultsModelStatus.active'));
        expect(code, contains("this.tags = const <String>['dart', 'schema']"));
        expect(
          code,
          contains("this.metadata = const DefaultsModelMetadata(env: 'prod')"),
        );
        expect(code, contains('this.emptyDef = null'));
      },
    );

    test('generates discriminator mappings in union classes', () async {
      final schemaJson = json.encode({
        'title': 'Animal',
        'oneOf': [
          {
            'title': 'Cat',
            'type': 'object',
            'properties': {
              'kind': {'const': 'cat'},
              'meow': {'type': 'boolean'},
            },
          },
          {
            'title': 'Dog',
            'type': 'object',
            'properties': {
              'kind': {'const': 'dog'},
              'bark': {'type': 'boolean'},
            },
          },
        ],
        'discriminator': {
          'propertyName': 'kind',
          'mapping': {'cat': '#/oneOf/0', 'dog': '#/oneOf/1'},
        },
      });

      final parser = SchemaParser(
        json.decode(schemaJson) as Map<String, dynamic>,
      );
      final root = await parser.parse();
      final code = generateCode(root, 'Animal');

      expect(code, contains("discriminatorProperty: 'kind'"));
      expect(code, contains('discriminatorMapping: {'));
      expect(code, contains("'cat': UnionOptionDescriptor<Animal, Cat>"));
      expect(code, contains("'dog': UnionOptionDescriptor<Animal, Dog>"));
    });

    test(
      'handles array constraints: maxItems, minItems, contains, prefixItems with validation',
      () async {
        final schemaJson = json.encode({
          'title': 'ArrayConstraints',
          'type': 'object',
          'properties': {
            'limitedList': {
              'type': 'array',
              'maxItems': 10,
              'minItems': 2,
              'contains': {'type': 'string', 'minLength': 3},
              'items': {'type': 'string'},
            },
            'tupleList': {
              'type': 'array',
              'prefixItems': [
                {
                  'type': 'object',
                  'properties': {
                    'x': {'type': 'integer'},
                  },
                },
              ],
              'items': {'type': 'string'},
            },
          },
        });

        final parser = SchemaParser(
          json.decode(schemaJson) as Map<String, dynamic>,
        );
        final root = await parser.parse();
        final code = generateCode(root, 'ArrayConstraints');

        expect(code, contains('val_limitedList.length > 10'));
        expect(code, contains('val_limitedList.length < 2'));
        expect(code, contains('var containsCount = 0;'));
        expect(code, contains('if (containsCount < 1)'));
        expect(code, contains('ArrayConstraintsTupleListPrefix0'));
      },
    );

    test('handles property not validation', () async {
      final schemaJson = json.encode({
        'title': 'NotModel',
        'type': 'object',
        'properties': {
          'disallowed': {
            'not': {'type': 'string', 'pattern': r'^bad_'},
          },
        },
      });

      final parser = SchemaParser(
        json.decode(schemaJson) as Map<String, dynamic>,
      );
      final root = await parser.parse();
      final code = generateCode(root, 'NotModel');

      expect(code, contains('if (notMatches_disallowed)'));
      expect(
        code,
        contains(
          "throw JsonValidationException('Property \"disallowed\" must not match the schema'",
        ),
      );
    });

    test('handles dynamicRef resolution across combinators', () async {
      final schemaJson = json.encode({
        r'$id': 'https://example.com/tree',
        r'$dynamicAnchor': 'node',
        'title': 'TreeNode',
        'type': 'object',
        'properties': {
          'value': {'type': 'string'},
          'left': {r'$dynamicRef': '#node'},
          'right': {r'$dynamicRef': '#node'},
        },
        'if': {
          'properties': {
            'value': {'const': 'special'},
          },
        },
        'then': {
          'properties': {
            'extra': {'type': 'string'},
          },
        },
        'else': {
          'properties': {
            'extra': {'type': 'integer'},
          },
        },
        'dependentSchemas': {
          'extra': {
            'properties': {
              'dep': {'type': 'boolean'},
            },
          },
        },
        'unevaluatedProperties': false,
        'propertyNames': {'minLength': 1},
      });

      final parser = SchemaParser(
        json.decode(schemaJson) as Map<String, dynamic>,
      );
      final root = await parser.parse();
      final code = generateCode(root, 'TreeNode');

      expect(code, contains('final class TreeNode implements JsonModel'));
      expect(code, contains('final TreeNode? left;'));
      expect(code, contains('final TreeNode? right;'));
    });
  });
}
