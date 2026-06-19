// Copyright 2026 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
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
  if (uri.host == 'localhost' && uri.port == 1234) {
    final relativePath = uri.path;
    final localPath = p.join(
      Directory.current.path,
      'third_party',
      'JSON-Schema-Test-Suite',
      'remotes',
      relativePath.startsWith('/') ? relativePath.substring(1) : relativePath,
    );
    final file = File(localPath);
    if (await file.exists()) {
      return file.readAsBytes();
    }
  }
  throw ArgumentError('Cannot resolve URI: $uri');
}

void main() async {
  final testSuiteDir = Directory(
    p.join(
      Directory.current.path,
      'third_party',
      'JSON-Schema-Test-Suite',
      'tests',
      'draft2020-12',
    ),
  );

  if (!await testSuiteDir.exists()) {
    fail('Test suite directory not found: ${testSuiteDir.path}');
  }

  group('JSON Schema Test Suite (Draft 2020-12)', () {
    // We must list files synchronously or use a setup to load them if we want to define tests dynamically.
    // Since main can be async, we can await the file list before registering tests.
    final files = testSuiteDir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.json'))
        .toList();

    // Sort files for deterministic run order
    files.sort((a, b) => p.basename(a.path).compareTo(p.basename(b.path)));

    for (final file in files) {
      final filename = p.basename(file.path);

      group(filename, () {
        final content = file.readAsStringSync();
        final List<dynamic> suites = jsonDecode(content) as List<dynamic>;

        for (final suite in suites) {
          final suiteDesc = suite['description'] as String;
          final schema = suite['schema'];
          final tests = suite['tests'] as List;

          group(suiteDesc, () {
            // Parse schema once per suite if possible, but createValidator is async.
            // In package:test, we can use setUpAll to parse the schema.
            late void Function(dynamic) validator;
            Object? parseError;
            var parsed = false;

            setUpAll(() async {
              try {
                if (schema is bool) {
                  validator = (dynamic value) {
                    if (schema == false) {
                      throw JsonValidationException(
                        'Value not allowed by false schema',
                      );
                    }
                  };
                } else if (schema is Map<String, dynamic>) {
                  validator = await createValidator(
                    schema,
                    uriResolver: uriResolver,
                    disallowExternalRefs: false,
                  );
                } else {
                  throw UnsupportedError(
                    'Unsupported schema type: ${schema.runtimeType}',
                  );
                }
              } catch (e) {
                parseError = e;
              } finally {
                parsed = true;
              }
            });

            for (final testCase in tests) {
              final testDesc = testCase['description'] as String;
              final data = testCase['data'];
              final expectedValid = testCase['valid'] as bool;

              test(testDesc, () {
                if (!parsed) {
                  fail(
                    'Schema was not parsed (setUpAll did not run or finished after test started)',
                  );
                }
                if (parseError != null) {
                  fail('Failed to parse schema: $parseError');
                }

                bool actualValid = true;
                try {
                  validator(data);
                } on JsonValidationException {
                  actualValid = false;
                }

                expect(actualValid, expectedValid);
              });
            }
          });
        }
      });
    }
  });
}
