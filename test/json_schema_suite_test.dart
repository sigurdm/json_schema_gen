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

@Timeout(Duration(minutes: 10))
library;

import 'package:json_schema_gen/json_schema.dart';
import 'package:test/test.dart';

import 'json_schema_suite_support.dart';

void main() {
  final root = suiteRoot();
  if (!root.existsSync()) {
    fail('Test suite directory not found: ${root.path}');
  }

  final knownFailures = loadKnownFailures();
  final allKeys = <String>{};

  group('JSON Schema Test Suite (Draft 2020-12)', () {
    for (final file in suiteFiles(root)) {
      final relativePath = suiteRelativePath(root, file);
      final validateFormats = assertsFormats(relativePath);

      group(relativePath, () {
        for (final suiteGroup in readSuiteGroups(file)) {
          group(suiteGroup.description, () {
            final schema = suiteGroup.schema;

            late void Function(Object?) validator;
            Object? parseError;

            setUpAll(() async {
              try {
                if (schema is bool) {
                  validator = (Object? value) {
                    if (!schema) {
                      throw JsonValidationException.single(
                        'Value not allowed by false schema',
                      );
                    }
                  };
                } else if (schema is Map<String, dynamic>) {
                  validator = await createValidator(
                    schema,
                    uriResolver: uriResolver,
                    disallowExternalRefs: false,
                    validateFormats: validateFormats,
                  );
                } else {
                  throw UnsupportedError(
                    'Unsupported schema type: ${schema.runtimeType}',
                  );
                }
              } catch (e) {
                parseError = e;
              }
            });

            for (final testCase in suiteGroup.cases) {
              final key = testKey(
                relativePath,
                suiteGroup.description,
                testCase.description,
              );
              allKeys.add(key);
              final isKnownFailure = knownFailures.contains(key);

              test(testCase.description, () {
                String? failure;
                if (parseError != null) {
                  failure = 'Failed to parse schema: $parseError';
                } else {
                  var actualValid = true;
                  Object? error;
                  try {
                    validator(testCase.data);
                  } on JsonValidationException catch (e) {
                    actualValid = false;
                    error = e;
                  }
                  if (actualValid != testCase.valid) {
                    failure =
                        'Expected valid: ${testCase.valid}, got: $actualValid'
                        '${error == null ? '' : ' ($error)'}';
                  }
                }

                if (isKnownFailure) {
                  expect(
                    failure,
                    isNotNull,
                    reason:
                        'This assertion is listed as a known failure but now '
                        'passes. Remove this line from '
                        '${knownFailuresFile().path}:\n  $key',
                  );
                } else {
                  expect(
                    failure,
                    isNull,
                    reason:
                        '$failure\n\nIf this is a deliberate, documented gap, '
                        'add this line to ${knownFailuresFile().path}:\n  $key',
                  );
                }
              });
            }
          });
        }
      });
    }
  });

  // Registration above is synchronous, so by the time this test body runs
  // `allKeys` holds every assertion in the suite. A stale allow-list entry
  // (from a renamed or deleted upstream case) would otherwise mask a real
  // regression forever.
  test('known-failure allow-list has no stale entries', () {
    final stale = knownFailures.difference(allKeys)..remove('');
    expect(
      stale,
      isEmpty,
      reason:
          'These allow-list entries do not match any assertion in the suite '
          '(upstream probably renamed or removed them). Remove them from '
          '${knownFailuresFile().path}:\n  ${stale.join('\n  ')}',
    );
  });
}
