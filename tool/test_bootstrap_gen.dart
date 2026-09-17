// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:json_schema_gen/json_schema.dart';

/// Directory holding a checked-in copy of the Draft 2020-12 metaschema.
///
/// The metaschema is deliberately vendored here rather than read out of the
/// JSON-Schema-Test-Suite checkout: that checkout is gitignored, does not ship
/// the metaschema itself, and is therefore unavailable on a fresh clone and in
/// CI. Vendoring keeps this tool runnable by anyone with just this repository.
const _metaschemaDir = 'tool/metaschema';

Future<List<int>> uriResolver(Uri uri) async {
  if (uri.host == 'json-schema.org' && uri.path.startsWith('/draft/2020-12/')) {
    final relativePath = uri.path.replaceFirst('/draft/2020-12/', '');
    final file = File(
      p.join(Directory.current.path, _metaschemaDir, '$relativePath.json'),
    );
    if (await file.exists()) {
      return file.readAsBytes();
    }
  }
  throw ArgumentError('Cannot resolve URI: $uri');
}

void main() async {
  final schemaFile = File(p.join(_metaschemaDir, 'schema.json'));
  final jsonStr = schemaFile.readAsStringSync();
  final decoded = json.decode(jsonStr) as Map<String, dynamic>;

  final parser = SchemaParser(
    decoded,
    baseUri: 'https://json-schema.org/draft/2020-12/schema',
    uriResolver: uriResolver,
  );
  final rootSchema = await parser.parse();

  final generatedCode = generateCode(
    rootSchema,
    'CoreAndValidationSpecificationsMetaSchema',
  );

  // `generateCode` returns unformatted emitter output, so format it here.
  // Without this the checked-in metaschema would be written as a single
  // near-unreadable blob, and CI's `git diff --exit-code` check would trip on
  // whatever the last person to run this tool happened to produce.
  final formattedCode = DartFormatter(
    languageVersion: Version(3, 10, 0),
  ).format(generatedCode);

  final outputFile = File('lib/src/generated/schema_202012.g.dart');
  outputFile.parent.createSync(recursive: true);
  outputFile.writeAsStringSync(formattedCode);
  print('Wrote to lib/src/generated/schema_202012.g.dart');
}
