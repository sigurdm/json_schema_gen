import 'dart:async';
import 'dart:convert';
import 'package:build/build.dart';
import 'package:test/test.dart';
import 'package:json_schema_gen/builder.dart';

/// A fake implementation of [BuildStep] for testing [JsonSchemaBuilder].
final class FakeBuildStep implements BuildStep {
  @override
  final AssetId inputId;
  final Map<AssetId, String> inputs;
  final Map<AssetId, String> outputs = {};

  FakeBuildStep(this.inputId, this.inputs);

  @override
  Future<String> readAsString(AssetId id, {Encoding encoding = utf8}) async {
    if (!inputs.containsKey(id)) {
      throw StateError('Input $id not found');
    }
    return inputs[id]!;
  }

  @override
  Future<List<int>> readAsBytes(AssetId id) async {
    if (!inputs.containsKey(id)) {
      throw StateError('Input $id not found');
    }
    return utf8.encode(inputs[id]!);
  }

  @override
  List<AssetId> get allowedOutputs => [inputId.changeExtension('.g.dart')];

  @override
  Future<void> writeAsString(
    AssetId id,
    FutureOr<String> contents, {
    Encoding encoding = utf8,
  }) async {
    outputs[id] = await contents;
  }

  @override
  void noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final mainSchemaId = AssetId('my_package', 'lib/main.schema.json');
  final otherSchemaId = AssetId('my_package', 'lib/other.schema.json');

  final schemaWithExternalRef = json.encode({
    'type': 'object',
    'properties': {
      'external': {r'$ref': 'other.schema.json#/definitions/External'},
    },
  });

  final otherSchema = json.encode({
    'definitions': {
      'External': {'type': 'string'},
    },
  });

  final schemaWithoutExternalRef = json.encode({
    'type': 'object',
    'properties': {
      'internal': {'type': 'string'},
    },
  });

  group('JsonSchemaBuilder allow_external_refs', () {
    test('succeeds by default (true) when external ref is present', () async {
      final builder = jsonSchemaBuilder(BuilderOptions.empty);
      final buildStep = FakeBuildStep(mainSchemaId, {
        mainSchemaId: schemaWithExternalRef,
        otherSchemaId: otherSchema,
      });

      await builder.build(buildStep);
      expect(
        buildStep.outputs,
        contains(mainSchemaId.changeExtension('.g.dart')),
      );
    });

    test(
      'fails when allow_external_refs is false and external ref is present',
      () async {
        final builder = jsonSchemaBuilder(
          const BuilderOptions({'allow_external_refs': false}),
        );
        final buildStep = FakeBuildStep(mainSchemaId, {
          mainSchemaId: schemaWithExternalRef,
          otherSchemaId: otherSchema,
        });

        expect(
          () => builder.build(buildStep),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('External reference'),
            ),
          ),
        );
      },
    );

    test(
      'succeeds when allow_external_refs is false and no external ref is present',
      () async {
        final builder = jsonSchemaBuilder(
          const BuilderOptions({'allow_external_refs': false}),
        );
        final buildStep = FakeBuildStep(mainSchemaId, {
          mainSchemaId: schemaWithoutExternalRef,
        });

        await builder.build(buildStep);
        expect(
          buildStep.outputs,
          contains(mainSchemaId.changeExtension('.g.dart')),
        );
      },
    );
  });

  group('JsonSchemaBuilder modular shared schemas', () {
    test(
      'generates modular imports and does not inline external classes',
      () async {
        final addressSchemaId = AssetId(
          'my_package',
          'lib/address.schema.json',
        );
        final personSchemaId = AssetId('my_package', 'lib/person.schema.json');

        final addressSchemaJson = json.encode({
          r'$defs': {
            'Address': {
              'type': 'object',
              'properties': {
                'city': {'type': 'string'},
              },
            },
            'Status': {
              'enum': ['active', 'inactive'],
            },
          },
        });

        final personSchemaJson = json.encode({
          'title': 'Person',
          'type': 'object',
          'properties': {
            'name': {'type': 'string'},
            'address': {r'$ref': r'address.schema.json#/$defs/Address'},
            'status': {r'$ref': r'address.schema.json#/$defs/Status'},
          },
        });

        final builder = jsonSchemaBuilder(BuilderOptions.empty);

        // Build person.g.dart
        final personBuildStep = FakeBuildStep(personSchemaId, {
          personSchemaId: personSchemaJson,
          addressSchemaId: addressSchemaJson,
        });
        await builder.build(personBuildStep);

        final personOutput =
            personBuildStep.outputs[personSchemaId.changeExtension('.g.dart')]!;
        expect(personOutput, contains("import 'address.g.dart' as _i1;"));
        expect(personOutput, contains('final _i1.Address? address;'));
        expect(personOutput, contains('final _i1.Status? status;'));
        expect(
          personOutput,
          contains('RefDescriptor<_i1.Address>(() => _i1.Address.descriptor)'),
        );
        expect(personOutput, contains('_i1.Status.descriptor'));
        expect(personOutput, isNot(contains('final class Address')));
        expect(personOutput, isNot(contains('enum Status')));

        // Build address.g.dart
        final addressBuildStep = FakeBuildStep(addressSchemaId, {
          addressSchemaId: addressSchemaJson,
        });
        await builder.build(addressBuildStep);

        final addressOutput = addressBuildStep
            .outputs[addressSchemaId.changeExtension('.g.dart')]!;
        expect(
          addressOutput,
          contains('final class Address implements JsonModel'),
        );
        expect(addressOutput, contains('enum Status {'));
      },
    );

    test(
      'forces inlining when x-dart-inline: true is at reference site',
      () async {
        final addressSchemaId = AssetId(
          'my_package',
          'lib/address.schema.json',
        );
        final personSchemaId = AssetId('my_package', 'lib/person.schema.json');

        final addressSchemaJson = json.encode({
          r'$defs': {
            'Address': {
              'type': 'object',
              'properties': {
                'city': {'type': 'string'},
              },
            },
          },
        });

        final personSchemaJson = json.encode({
          'title': 'Person',
          'type': 'object',
          'properties': {
            'address': {
              r'$ref': r'address.schema.json#/$defs/Address',
              'x-dart-inline': true,
            },
          },
        });

        final builder = jsonSchemaBuilder(BuilderOptions.empty);
        final buildStep = FakeBuildStep(personSchemaId, {
          personSchemaId: personSchemaJson,
          addressSchemaId: addressSchemaJson,
        });
        await builder.build(buildStep);

        final personOutput =
            buildStep.outputs[personSchemaId.changeExtension('.g.dart')]!;
        expect(personOutput, isNot(contains("import 'address.g.dart'")));
        expect(personOutput, contains('final Address? address;'));
        expect(
          personOutput,
          contains('final class Address implements JsonModel'),
        );
      },
    );

    test(
      'forces inlining when x-dart-inline: true is at definition site',
      () async {
        final addressSchemaId = AssetId(
          'my_package',
          'lib/address.schema.json',
        );
        final personSchemaId = AssetId('my_package', 'lib/person.schema.json');

        final addressSchemaJson = json.encode({
          r'$defs': {
            'Address': {
              'x-dart-inline': true,
              'type': 'object',
              'properties': {
                'city': {'type': 'string'},
              },
            },
          },
        });

        final personSchemaJson = json.encode({
          'title': 'Person',
          'type': 'object',
          'properties': {
            'address': {r'$ref': r'address.schema.json#/$defs/Address'},
          },
        });

        final builder = jsonSchemaBuilder(BuilderOptions.empty);
        final buildStep = FakeBuildStep(personSchemaId, {
          personSchemaId: personSchemaJson,
          addressSchemaId: addressSchemaJson,
        });
        await builder.build(buildStep);

        final personOutput =
            buildStep.outputs[personSchemaId.changeExtension('.g.dart')]!;
        expect(personOutput, isNot(contains("import 'address.g.dart'")));
        expect(personOutput, contains('final Address? address;'));
        expect(
          personOutput,
          contains('final class Address implements JsonModel'),
        );
      },
    );

    test('generates classes for standalone definition library', () async {
      final defsSchemaId = AssetId('my_package', 'lib/defs.schema.json');
      final defsSchemaJson = json.encode({
        r'$defs': {
          'City': {
            'type': 'object',
            'properties': {
              'name': {'type': 'string'},
            },
          },
          'CountryCode': {
            'enum': ['US', 'CA', 'UK'],
          },
        },
      });

      final builder = jsonSchemaBuilder(BuilderOptions.empty);
      final buildStep = FakeBuildStep(defsSchemaId, {
        defsSchemaId: defsSchemaJson,
      });
      await builder.build(buildStep);

      final output =
          buildStep.outputs[defsSchemaId.changeExtension('.g.dart')]!;
      expect(output, contains('final class City implements JsonModel'));
      expect(output, contains('enum CountryCode {'));
    });

    test('supports cross-directory relative imports', () async {
      final orderSchemaId = AssetId(
        'my_package',
        'lib/models/order.schema.json',
      );
      final addressSchemaId = AssetId(
        'my_package',
        'lib/common/address.schema.json',
      );

      final addressSchemaJson = json.encode({
        r'$defs': {
          'Address': {
            'type': 'object',
            'properties': {
              'zip': {'type': 'string'},
            },
          },
        },
      });

      final orderSchemaJson = json.encode({
        'title': 'Order',
        'type': 'object',
        'properties': {
          'shipping': {
            r'$ref': r'../common/address.schema.json#/$defs/Address',
          },
        },
      });

      final builder = jsonSchemaBuilder(BuilderOptions.empty);
      final buildStep = FakeBuildStep(orderSchemaId, {
        orderSchemaId: orderSchemaJson,
        addressSchemaId: addressSchemaJson,
      });
      await builder.build(buildStep);

      final output =
          buildStep.outputs[orderSchemaId.changeExtension('.g.dart')]!;
      expect(output, contains("import '../common/address.g.dart' as _i1;"));
      expect(output, contains('final _i1.Address? shipping;'));
      expect(output, isNot(contains('final class Address')));
    });

    test('supports package: URI imports across packages', () async {
      final orderSchemaId = AssetId('pkg_a', 'lib/order.schema.json');
      final addressSchemaId = AssetId('pkg_b', 'lib/address.schema.json');

      final addressSchemaJson = json.encode({
        r'$defs': {
          'Address': {
            'type': 'object',
            'properties': {
              'zip': {'type': 'string'},
            },
          },
        },
      });

      final orderSchemaJson = json.encode({
        'title': 'Order',
        'type': 'object',
        'properties': {
          'shipping': {
            r'$ref': r'package:pkg_b/address.schema.json#/$defs/Address',
          },
        },
      });

      final builder = jsonSchemaBuilder(BuilderOptions.empty);
      final buildStep = FakeBuildStep(orderSchemaId, {
        orderSchemaId: orderSchemaJson,
        addressSchemaId: addressSchemaJson,
      });
      await builder.build(buildStep);

      final output =
          buildStep.outputs[orderSchemaId.changeExtension('.g.dart')]!;
      expect(output, contains("import 'package:pkg_b/address.g.dart' as _i1;"));
      expect(output, contains('final _i1.Address? shipping;'));
      expect(output, isNot(contains('final class Address')));
    });

    test(
      'emits package: URI when compiling non-lib asset referencing lib schema',
      () async {
        final testOrderSchemaId = AssetId(
          'my_package',
          'test/fixtures/order.schema.json',
        );
        final libAddressSchemaId = AssetId(
          'my_package',
          'lib/address.schema.json',
        );

        final addressSchemaJson = json.encode({
          r'$defs': {
            'Address': {
              'type': 'object',
              'properties': {
                'city': {'type': 'string'},
              },
            },
          },
        });

        final orderSchemaJson = json.encode({
          'title': 'Order',
          'type': 'object',
          'properties': {
            'shipping': {
              r'$ref': r'package:my_package/address.schema.json#/$defs/Address',
            },
          },
        });

        final builder = jsonSchemaBuilder(BuilderOptions.empty);
        final buildStep = FakeBuildStep(testOrderSchemaId, {
          testOrderSchemaId: orderSchemaJson,
          libAddressSchemaId: addressSchemaJson,
        });
        await builder.build(buildStep);

        final output =
            buildStep.outputs[testOrderSchemaId.changeExtension('.g.dart')]!;
        expect(
          output,
          contains("import 'package:my_package/address.g.dart' as _i1;"),
        );
        expect(output, contains('final _i1.Address? shipping;'));
        expect(output, isNot(contains("import '../../lib/address.g.dart'")));
      },
    );

    test('supports arrays of external types in builder', () async {
      final orderSchemaId = AssetId('my_package', 'lib/order.schema.json');
      final itemSchemaId = AssetId('my_package', 'lib/item.schema.json');

      final itemSchemaJson = json.encode({
        r'$defs': {
          'Item': {
            'type': 'object',
            'properties': {
              'name': {'type': 'string'},
            },
          },
        },
      });

      final orderSchemaJson = json.encode({
        'title': 'Order',
        'type': 'object',
        'properties': {
          'items': {
            'type': 'array',
            'items': {r'$ref': r'item.schema.json#/$defs/Item'},
          },
        },
      });

      final builder = jsonSchemaBuilder(BuilderOptions.empty);
      final buildStep = FakeBuildStep(orderSchemaId, {
        orderSchemaId: orderSchemaJson,
        itemSchemaId: itemSchemaJson,
      });
      await builder.build(buildStep);

      final output =
          buildStep.outputs[orderSchemaId.changeExtension('.g.dart')]!;
      expect(output, contains("import 'item.g.dart' as _i1;"));
      expect(output, contains('final List<_i1.Item>? items;'));
      expect(output, contains('ArrayDescriptor<_i1.Item>('));
      expect(
        output,
        contains('RefDescriptor<_i1.Item>(() => _i1.Item.descriptor)'),
      );
      expect(output, isNot(contains('final class Item')));
    });
  });
}
