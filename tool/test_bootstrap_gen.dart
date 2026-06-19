import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:json_schema_gen/json_schema.dart';

Future<List<int>> uriResolver(Uri uri) async {
  if (uri.host == 'json-schema.org' && uri.path.startsWith('/draft/2020-12/')) {
    final relativePath = uri.path.replaceFirst('/draft/2020-12/', '');
    final localPath = p.join(
      Directory.current.path,
      'third_party',
      'JSON-Schema-Test-Suite',
      'remotes',
      'draft2020-12',
      relativePath,
    );
    final file = File(localPath);
    if (await file.exists()) {
      return file.readAsBytes();
    }
  }
  throw ArgumentError('Cannot resolve URI: $uri');
}

void main() async {
  final schemaFile = File(
    'third_party/JSON-Schema-Test-Suite/remotes/draft2020-12/schema',
  );
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
  final outputFile = File('lib/src/generated/schema_202012.g.dart');
  outputFile.parent.createSync(recursive: true);
  outputFile.writeAsStringSync(generatedCode);
  print('Wrote to lib/src/generated/schema_202012.g.dart');
}
