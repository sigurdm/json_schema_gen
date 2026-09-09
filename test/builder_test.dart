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

    test('supports parent, sibling, and nested relative imports', () async {
      // 1. Nested: lib/root.schema.json -> lib/sub/nested.schema.json
      final rootId = AssetId('my_package', 'lib/root.schema.json');
      final nestedId = AssetId('my_package', 'lib/sub/nested.schema.json');
      final nestedJson = json.encode({
        r'$defs': {
          'NestedModel': {
            'type': 'object',
            'properties': {
              'val': {'type': 'string'},
            },
          },
        },
      });
      final rootJson = json.encode({
        'title': 'Root',
        'type': 'object',
        'properties': {
          'nested': {r'$ref': r'sub/nested.schema.json#/$defs/NestedModel'},
        },
      });

      final builder = jsonSchemaBuilder(BuilderOptions.empty);
      final step1 = FakeBuildStep(rootId, {
        rootId: rootJson,
        nestedId: nestedJson,
      });
      await builder.build(step1);
      final out1 = step1.outputs[rootId.changeExtension('.g.dart')]!;
      expect(out1, contains("import 'sub/nested.g.dart' as _i1;"));
      expect(out1, contains('final _i1.NestedModel? nested;'));

      // 2. Parent: lib/sub/child.schema.json -> lib/parent.schema.json
      final childId = AssetId('my_package', 'lib/sub/child.schema.json');
      final parentId = AssetId('my_package', 'lib/parent.schema.json');
      final parentJson = json.encode({
        r'$defs': {
          'ParentModel': {
            'type': 'object',
            'properties': {
              'id': {'type': 'integer'},
            },
          },
        },
      });
      final childJson = json.encode({
        'title': 'Child',
        'type': 'object',
        'properties': {
          'parent': {r'$ref': r'../parent.schema.json#/$defs/ParentModel'},
        },
      });
      final step2 = FakeBuildStep(childId, {
        childId: childJson,
        parentId: parentJson,
      });
      await builder.build(step2);
      final out2 = step2.outputs[childId.changeExtension('.g.dart')]!;
      expect(out2, contains("import '../parent.g.dart' as _i1;"));
      expect(out2, contains('final _i1.ParentModel? parent;'));

      // 3. Sibling: lib/sub/child.schema.json -> lib/sub/sibling.schema.json
      final siblingId = AssetId('my_package', 'lib/sub/sibling.schema.json');
      final siblingJson = json.encode({
        r'$defs': {
          'SiblingModel': {
            'type': 'object',
            'properties': {
              'flag': {'type': 'boolean'},
            },
          },
        },
      });
      final childSiblingJson = json.encode({
        'title': 'ChildSibling',
        'type': 'object',
        'properties': {
          'sibling': {r'$ref': r'sibling.schema.json#/$defs/SiblingModel'},
        },
      });
      final step3 = FakeBuildStep(childId, {
        childId: childSiblingJson,
        siblingId: siblingJson,
      });
      await builder.build(step3);
      final out3 = step3.outputs[childId.changeExtension('.g.dart')]!;
      expect(out3, contains("import 'sibling.g.dart' as _i1;"));
      expect(out3, contains('final _i1.SiblingModel? sibling;'));
    });

    test(
      'supports deep cross-package package: URI with subdirectories',
      () async {
        final inputId = AssetId('app', 'lib/views/page.schema.json');
        final extId = AssetId(
          'core_ui',
          'lib/components/buttons/button.schema.json',
        );

        final extJson = json.encode({
          r'$defs': {
            'Button': {
              'type': 'object',
              'properties': {
                'label': {'type': 'string'},
              },
            },
          },
        });
        final inputJson = json.encode({
          'title': 'Page',
          'type': 'object',
          'properties': {
            'action': {
              r'$ref':
                  r'package:core_ui/components/buttons/button.schema.json#/$defs/Button',
            },
          },
        });

        final builder = jsonSchemaBuilder(BuilderOptions.empty);
        final step = FakeBuildStep(inputId, {
          inputId: inputJson,
          extId: extJson,
        });
        await builder.build(step);

        final out = step.outputs[inputId.changeExtension('.g.dart')]!;
        expect(
          out,
          contains(
            "import 'package:core_ui/components/buttons/button.g.dart' as _i1;",
          ),
        );
        expect(out, contains('final _i1.Button? action;'));
      },
    );

    test(
      'inlines external ref when non-lib asset references non-lib asset',
      () async {
        final testAId = AssetId('my_package', 'test/fixtures/a.schema.json');
        final testBId = AssetId('my_package', 'test/fixtures/b.schema.json');

        final bJson = json.encode({
          r'$defs': {
            'Helper': {
              'type': 'object',
              'properties': {
                'info': {'type': 'string'},
              },
            },
          },
        });
        final aJson = json.encode({
          'title': 'TestA',
          'type': 'object',
          'properties': {
            'helper': {r'$ref': r'b.schema.json#/$defs/Helper'},
          },
        });

        final builder = jsonSchemaBuilder(BuilderOptions.empty);
        final step = FakeBuildStep(testAId, {testAId: aJson, testBId: bJson});
        await builder.build(step);

        final out = step.outputs[testAId.changeExtension('.g.dart')]!;
        // Should NOT generate an import since target is in test/, not lib/
        expect(out, isNot(contains("import 'b.g.dart'")));
        expect(out, isNot(contains("import 'package:my_package/")));
        expect(out, contains('final Helper? helper;'));
        expect(out, contains('final class Helper implements JsonModel'));
      },
    );

    test(
      'falls back to inlining when ref does not end with .schema.json',
      () async {
        final inputId = AssetId('my_package', 'lib/a.schema.json');
        final otherId = AssetId('my_package', 'lib/other.json');

        final otherJson = json.encode({
          'definitions': {
            'OtherType': {
              'type': 'object',
              'properties': {
                'count': {'type': 'integer'},
              },
            },
          },
        });
        final aJson = json.encode({
          'title': 'A',
          'type': 'object',
          'properties': {
            'item': {r'$ref': 'other.json#/definitions/OtherType'},
          },
        });

        final builder = jsonSchemaBuilder(BuilderOptions.empty);
        final step = FakeBuildStep(inputId, {
          inputId: aJson,
          otherId: otherJson,
        });
        await builder.build(step);

        final out = step.outputs[inputId.changeExtension('.g.dart')]!;
        expect(out, isNot(contains("import 'other.g.dart'")));
        expect(out, contains('final OtherType? item;'));
        expect(out, contains('final class OtherType implements JsonModel'));
      },
    );

    test('falls back to inlining for http and https external refs', () async {
      final inputId = AssetId('my_package', 'lib/a.schema.json');
      final httpJson = json.encode({
        r'$defs': {
          'HttpType': {
            'type': 'object',
            'properties': {
              'url': {'type': 'string'},
            },
          },
        },
      });
      final aJson = json.encode({
        'title': 'A',
        'type': 'object',
        'properties': {
          'item': {
            r'$ref': r'https://example.com/schema.schema.json#/$defs/HttpType',
          },
        },
      });

      final builder = jsonSchemaBuilder(BuilderOptions.empty);
      final step = FakeBuildStep(inputId, {
        inputId: aJson,
        AssetId('my_package', 'lib/schema.schema.json'): httpJson,
      });
      // The FakeBuildStep uriResolver will resolve normalized path
      // but dartImportResolver will see cleanUri.scheme == 'https' and return null
      await builder.build(step);

      final out = step.outputs[inputId.changeExtension('.g.dart')]!;
      expect(out, isNot(contains('import \'https:')));
      expect(out, contains('final HttpType? item;'));
      expect(out, contains('final class HttpType implements JsonModel'));
    });

    test(
      'retains unformatted code when DartFormatter throws on invalid syntax',
      () async {
        final inputId = AssetId('my_package', 'lib/broken.schema.json');
        final brokenJson = json.encode({
          'title': 'BrokenSchema',
          'type': 'object',
          'properties': {
            'badEnum': {
              'enum': [r'${invalid syntax}'],
            },
          },
        });

        final builder = jsonSchemaBuilder(BuilderOptions.empty);
        final step = FakeBuildStep(inputId, {inputId: brokenJson});

        await builder.build(step);
        final out = step.outputs[inputId.changeExtension('.g.dart')]!;
        // When formatting throws, raw unformatted code is retained
        expect(out, contains('enum BrokenSchemaBadEnum {'));
        expect(out, contains(r"${invalid syntax}"));
      },
    );

    test(
      'generates classes for standalone definition library using legacy definitions',
      () async {
        final defsSchemaId = AssetId(
          'my_package',
          'lib/legacy_defs.schema.json',
        );
        final defsSchemaJson = json.encode({
          'definitions': {
            'Product': {
              'type': 'object',
              'properties': {
                'sku': {'type': 'string'},
              },
            },
            'Rating': {
              'enum': [1, 2, 3, 4, 5],
            },
            'Discount': {
              'oneOf': [
                {
                  'type': 'object',
                  'properties': {
                    'percent': {'type': 'number'},
                  },
                },
                {
                  'type': 'object',
                  'properties': {
                    'fixed': {'type': 'number'},
                  },
                },
              ],
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
        expect(output, contains('final class Product implements JsonModel'));
        expect(output, contains('enum Rating {'));
        expect(output, contains('sealed class Discount implements JsonModel'));
        expect(
          output,
          contains('final class DiscountOptionType0 implements JsonModel'),
        );
        expect(
          output,
          contains('final class DiscountOptionType1 implements JsonModel'),
        );
      },
    );

    test(
      'does not import self when ref uses filename pointing to current file',
      () async {
        final inputId = AssetId('my_package', 'lib/self.schema.json');
        final selfJson = json.encode({
          'title': 'Self',
          'type': 'object',
          r'$defs': {
            'Sub': {
              'type': 'object',
              'properties': {
                'x': {'type': 'string'},
              },
            },
          },
          'properties': {
            'sub': {r'$ref': r'self.schema.json#/$defs/Sub'},
          },
        });

        final builder = jsonSchemaBuilder(BuilderOptions.empty);
        final step = FakeBuildStep(inputId, {inputId: selfJson});
        await builder.build(step);

        final out = step.outputs[inputId.changeExtension('.g.dart')]!;
        expect(out, isNot(contains("import 'self.g.dart'")));
        expect(out, contains('final Sub? sub;'));
        expect(out, contains('final class Sub implements JsonModel'));
      },
    );

    test(
      'does not import self when ref uses relative path pointing to current file',
      () async {
        final inputId = AssetId('my_package', 'lib/self2.schema.json');
        final selfJson = json.encode({
          'title': 'Self2',
          'type': 'object',
          r'$defs': {
            'Sub': {
              'type': 'object',
              'properties': {
                'x': {'type': 'string'},
              },
            },
          },
          'properties': {
            'sub': {r'$ref': r'./self2.schema.json#/$defs/Sub'},
          },
        });

        final builder = jsonSchemaBuilder(BuilderOptions.empty);
        final step = FakeBuildStep(inputId, {inputId: selfJson});
        await builder.build(step);

        final out = step.outputs[inputId.changeExtension('.g.dart')]!;
        expect(out, isNot(contains("import 'self2.g.dart'")));
        expect(out, contains('final Sub? sub;'));
        expect(out, contains('final class Sub implements JsonModel'));
      },
    );
  });

  group('JsonSchemaBuilder input validation and edge cases', () {
    test('buildExtensions returns correct file mapping', () {
      final builder = jsonSchemaBuilder(BuilderOptions.empty);
      expect(builder.buildExtensions, {
        '.schema.json': ['.g.dart'],
      });
    });

    test('throws ArgumentError when root schema is a JSON array', () async {
      final arrayId = AssetId('my_package', 'lib/array.schema.json');
      final builder = jsonSchemaBuilder(BuilderOptions.empty);
      final buildStep = FakeBuildStep(arrayId, {arrayId: '[1, 2, 3]'});

      expect(
        () => builder.build(buildStep),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('must be a JSON object'),
          ),
        ),
      );
    });

    test('throws ArgumentError when root schema is a JSON boolean', () async {
      final boolId = AssetId('my_package', 'lib/bool.schema.json');
      final builder = jsonSchemaBuilder(BuilderOptions.empty);
      final buildStep = FakeBuildStep(boolId, {boolId: 'true'});

      expect(
        () => builder.build(buildStep),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('must be a JSON object'),
          ),
        ),
      );
    });

    test('throws ArgumentError when root schema is a JSON number', () async {
      final numId = AssetId('my_package', 'lib/num.schema.json');
      final builder = jsonSchemaBuilder(BuilderOptions.empty);
      final buildStep = FakeBuildStep(numId, {numId: '42'});

      expect(
        () => builder.build(buildStep),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('must be a JSON object'),
          ),
        ),
      );
    });

    test(
      'disallows external ref in discriminator mapping when allow_external_refs is false',
      () async {
        final discSchemaId = AssetId('my_package', 'lib/disc.schema.json');
        final discJson = json.encode({
          'type': 'object',
          'discriminator': {
            'propertyName': 'kind',
            'mapping': {'cat': 'other.schema.json#/definitions/External'},
          },
        });

        final builder = jsonSchemaBuilder(
          const BuilderOptions({'allow_external_refs': false}),
        );
        final buildStep = FakeBuildStep(discSchemaId, {
          discSchemaId: discJson,
          otherSchemaId: otherSchema,
        });

        expect(
          () => builder.build(buildStep),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('External references are disallowed'),
            ),
          ),
        );
      },
    );

    test(
      'disallows external ref in definitions when allow_external_refs is false',
      () async {
        final defsRefSchemaId = AssetId(
          'my_package',
          'lib/defs_ref.schema.json',
        );
        final defsRefJson = json.encode({
          'type': 'object',
          r'$defs': {
            'Local': {r'$ref': 'other.schema.json#/definitions/External'},
          },
        });

        final builder = jsonSchemaBuilder(
          const BuilderOptions({'allow_external_refs': false}),
        );
        final buildStep = FakeBuildStep(defsRefSchemaId, {
          defsRefSchemaId: defsRefJson,
          otherSchemaId: otherSchema,
        });

        expect(
          () => builder.build(buildStep),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('External references are disallowed'),
            ),
          ),
        );
      },
    );

    test(
      'does not generate import if package ref resolves to same file',
      () async {
        final orderSchemaId = AssetId('my_package', 'lib/order.schema.json');
        final orderSchemaJson = json.encode({
          'title': 'Order',
          'type': 'object',
          r'$defs': {
            'Address': {
              'type': 'object',
              'properties': {
                'street': {'type': 'string'},
              },
            },
          },
          'properties': {
            'shipping': {
              r'$ref': r'package:my_package/order.schema.json#/$defs/Address',
            },
          },
        });

        final builder = jsonSchemaBuilder(BuilderOptions.empty);
        final buildStep = FakeBuildStep(orderSchemaId, {
          orderSchemaId: orderSchemaJson,
        });
        await builder.build(buildStep);

        final output =
            buildStep.outputs[orderSchemaId.changeExtension('.g.dart')]!;
        expect(
          output,
          isNot(contains("import 'package:my_package/order.g.dart'")),
        );
        expect(output, contains('final Address? shipping;'));
        expect(output, contains('final class Address implements JsonModel'));
      },
    );
  });
}
