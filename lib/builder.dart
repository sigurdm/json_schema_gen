import 'dart:convert';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:path/path.dart' as p;

/// A [Builder] that compiles JSON Schema files (.schema.json) to Dart models.
final class JsonSchemaBuilder implements Builder {
  /// The options configured for this builder.
  final BuilderOptions options;

  /// Creates a [JsonSchemaBuilder] with the given [options].
  JsonSchemaBuilder(this.options);

  @override
  Map<String, List<String>> get buildExtensions => const {
    '.schema.json': ['.g.dart'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final allowExternalRefs =
        options.config['allow_external_refs'] as bool? ?? true;
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
        AssetId resolvedId;
        if (uri.isScheme('package')) {
          final segments = uri.pathSegments;
          resolvedId = AssetId(
            segments.first,
            p.url.joinAll(['lib', ...segments.skip(1)]),
          );
        } else {
          resolvedId = AssetId(
            inputId.package,
            p.url.normalize(p.url.join(p.url.dirname(inputId.path), uri.path)),
          );
        }
        return buildStep.readAsBytes(resolvedId);
      },
      disallowExternalRefs: !allowExternalRefs,
    );
    final rootSchema = await parser.parse();

    String? dartImportResolver(Uri schemaUri) {
      final cleanUri = schemaUri.hasFragment
          ? schemaUri.removeFragment()
          : schemaUri;
      if (cleanUri.scheme == 'http' || cleanUri.scheme == 'https') {
        return null;
      }
      AssetId resolvedId;
      if (cleanUri.isScheme('package')) {
        final segments = cleanUri.pathSegments;
        if (segments.isEmpty) return null;
        resolvedId = AssetId(
          segments.first,
          p.url.joinAll(['lib', ...segments.skip(1)]),
        );
      } else {
        final uriPath = cleanUri.path;
        if (uriPath.isEmpty) return null;
        resolvedId = AssetId(
          inputId.package,
          p.url.normalize(p.url.join(p.url.dirname(inputId.path), uriPath)),
        );
      }

      if (resolvedId == inputId) return null;
      if (!resolvedId.path.endsWith('.schema.json')) return null;

      final targetDartPath = resolvedId.path.replaceAll(
        RegExp(r'\.schema\.json$'),
        '.g.dart',
      );

      if (resolvedId.package != inputId.package ||
          !inputId.path.startsWith('lib/')) {
        if (!resolvedId.path.startsWith('lib/')) return null;
        final libPath = targetDartPath.substring('lib/'.length);
        return 'package:${resolvedId.package}/$libPath';
      }

      final inputDir = p.url.dirname(inputId.path);
      return p.url.relative(targetDartPath, from: inputDir);
    }

    // Determine the root name based on the schema title or the file name
    final baseName = inputId.pathSegments.last.replaceAll('.schema.json', '');
    final rootName = decoded['title'] as String? ?? baseName;

    // Generate the Dart code
    final generatedCode = generateCode(
      rootSchema,
      rootName,
      dartImportResolver: dartImportResolver,
    );

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
///
/// Preconditions:
/// - [options] must not be null.
Builder jsonSchemaBuilder(BuilderOptions options) => JsonSchemaBuilder(options);
