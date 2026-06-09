import 'dart:convert';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:path/path.dart' as p;

/// A [Builder] that compiles JSON Schema files (.schema.json) to Dart models.
final class JsonSchemaBuilder implements Builder {
  /// Default constructor.
  const JsonSchemaBuilder();

  @override
  Map<String, List<String>> get buildExtensions => const {
    '.schema.json': ['.g.dart'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;

    // Read the schema JSON string
    final jsonStr = await buildStep.readAsString(inputId);
    final decoded = json.decode(jsonStr);
    if (decoded is! Map<String, dynamic>) {
      throw ArgumentError('Schema in $inputId must be a JSON object.');
    }

    // Parse the JSON Schema into our AST
    final parser = SchemaParser(
      decoded,
      baseUri: inputId.pathSegments.last,
      uriResolver: (uri) async {
        final resolvedId = AssetId(
          inputId.package,
          p.normalize(p.join(p.dirname(inputId.path), uri)),
        );
        final content = await buildStep.readAsString(resolvedId);
        return json.decode(content) as Map<String, dynamic>;
      },
    );
    final rootSchema = await parser.parse(disallowExternalRefs: false);

    // Determine the root name based on the schema title or the file name
    final baseName = inputId.pathSegments.last.replaceAll('.schema.json', '');
    final rootName = decoded['title'] as String? ?? baseName;

    // Generate the Dart code
    final generatedCode = generateCode(rootSchema, rootName);

    // Format the generated code using dart_style for clean output
    String formattedCode;
    try {
      formattedCode = DartFormatter(
        languageVersion: Version(3, 12, 0),
      ).format(generatedCode);
    } catch (e) {
      // In case formatting fails (e.g. syntax error in generated code),
      // write the raw code to aid debugging.
      log.warning('Could not format generated code for $inputId: $e');
      formattedCode = generatedCode;
    }

    final outputId = buildStep.allowedOutputs.single;
    await buildStep.writeAsString(outputId, formattedCode);
  }
}

/// Factory function to construct the builder for build_runner.
Builder jsonSchemaBuilder(BuilderOptions options) => const JsonSchemaBuilder();
