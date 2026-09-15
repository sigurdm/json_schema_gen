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

/// Runs the vendored JSON Schema Test Suite and prints a conformance report.
///
/// `dart test` already runs the same suite via
/// `test/json_schema_suite_test.dart`; this script exists to produce the
/// per-directory summary quoted in the README, and to regenerate the
/// known-failure allow-list with `--update-known-failures`.
library;

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:args/args.dart';
import 'package:json_schema_gen/json_schema.dart';

import '../test/json_schema_suite_support.dart';

Future<void> main(List<String> args) async {
  final parser = ArgParser()
    ..addFlag(
      'update-known-failures',
      negatable: false,
      help:
          'Rewrite test/json_schema_suite_known_failures.txt to match the '
          'current results instead of checking against it.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Print every failing assertion.',
    )
    ..addFlag('help', abbr: 'h', negatable: false);

  final results = parser.parse(args);
  if (results['help'] as bool) {
    print(parser.usage);
    return;
  }
  final update = results['update-known-failures'] as bool;
  final verbose = results['verbose'] as bool;

  final root = suiteRoot();
  if (!root.existsSync()) {
    print('Test suite directory not found: ${root.path}');
    exit(1);
  }

  final knownFailures = loadKnownFailures();

  final failing = <String>{};
  var total = 0;
  final byDirectory = <String, ({int total, int passed})>{};

  for (final file in suiteFiles(root)) {
    final relativePath = suiteRelativePath(root, file);
    final validateFormats = assertsFormats(relativePath);
    final directory = relativePath.contains('/')
        ? relativePath.substring(0, relativePath.lastIndexOf('/'))
        : '.';

    for (final group in readSuiteGroups(file)) {
      final schema = group.schema;
      void Function(Object?)? validator;
      Object? parseError;

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
          parseError = UnsupportedError(
            'Unsupported schema type: ${schema.runtimeType}',
          );
        }
      } catch (e) {
        parseError = e;
      }

      for (final testCase in group.cases) {
        total++;
        final key = testKey(
          relativePath,
          group.description,
          testCase.description,
        );

        String? failure;
        if (parseError != null) {
          failure = 'failed to parse schema: $parseError';
        } else {
          var actualValid = true;
          Object? error;
          try {
            validator!(testCase.data);
          } on JsonValidationException catch (e) {
            actualValid = false;
            error = e;
          } on FormatException catch (e) {
            actualValid = false;
            error = e;
          } catch (e) {
            actualValid = false;
            error = 'unexpected error: $e';
          }
          if (actualValid != testCase.valid) {
            failure =
                'expected valid: ${testCase.valid}, got: $actualValid'
                '${error == null ? '' : ' ($error)'}';
          }
        }

        final stats = byDirectory[directory] ?? (total: 0, passed: 0);
        byDirectory[directory] = (
          total: stats.total + 1,
          passed: stats.passed + (failure == null ? 1 : 0),
        );

        if (failure != null) {
          failing.add(key);
          if (verbose) {
            print('FAIL $key\n     $failure');
          }
        }
      }
    }
  }

  final passed = total - failing.length;
  print('');
  print('Summary');
  print('  Total:  $total');
  print(
    '  Passed: $passed '
    '(${(passed / total * 100).toStringAsFixed(1)}%)',
  );
  print('  Failed: ${failing.length}');
  print('');

  final directories = byDirectory.keys.toList()..sort();
  for (final directory in directories) {
    final stats = byDirectory[directory]!;
    print('  ${stats.passed}/${stats.total}  $directory');
  }
  print('');

  if (update) {
    final sorted = failing.toList()..sort();
    knownFailuresFile().writeAsStringSync(
      '$_allowListHeader${sorted.join('\n')}\n',
    );
    print('Wrote ${sorted.length} entries to ${knownFailuresFile().path}.');
    return;
  }

  final unexpectedFailures = failing.difference(knownFailures)..remove('');
  final unexpectedPasses = knownFailures.difference(failing)..remove('');

  if (unexpectedFailures.isNotEmpty) {
    print('Assertions that regressed (not in the allow-list):');
    for (final key in unexpectedFailures.toList()..sort()) {
      print('  $key');
    }
    print('');
  }
  if (unexpectedPasses.isNotEmpty) {
    print(
      'Assertions in the allow-list that now pass. Remove them so they '
      'cannot regress again:',
    );
    for (final key in unexpectedPasses.toList()..sort()) {
      print('  $key');
    }
    print('');
  }

  if (unexpectedFailures.isNotEmpty || unexpectedPasses.isNotEmpty) {
    print('Re-run with --update-known-failures to accept the current state.');
    exit(1);
  }
}

const _allowListHeader = '''
# Assertions in the vendored JSON Schema Test Suite that json_schema_gen does
# not pass yet.
#
# The list exists so the conformance number can only improve: an entry that
# starts passing is reported as an error telling you to delete the line, and a
# failure that is not listed here fails the build. Regenerate with:
#
#     dart run tool/run_json_schema_tests.dart --update-known-failures
#
# Format: <suite-relative path> :: <group description> :: <test description>

''';
