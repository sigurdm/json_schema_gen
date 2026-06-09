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
}
