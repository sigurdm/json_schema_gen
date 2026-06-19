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
}
