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

/// Runs the *generator* against the whole JSON Schema Test Suite.
///
/// The suite tests in `json_schema_suite_test.dart` only exercise the runtime
/// validator. The generator is a separate ~2,600-line code path that had no
/// broad coverage at all: everything it was asked to compile came from a
/// handful of hand-written schemas in this repository, none of which look like
/// the adversarial shapes the suite is made of.
///
/// Each group schema in the suite is generated as its own library — not
/// wrapped in a synthetic parent, because that would move the document root
/// and silently break every `#/...` pointer in the schema — and the whole
/// output directory is analyzed in a single pass. A schema that makes the
/// generator throw, or that makes it emit source the analyzer rejects, is a
/// generator bug.
@Timeout(Duration(minutes: 15))
library;

import 'dart:io';

import 'package:json_schema_gen/json_schema.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'json_schema_suite_support.dart';

/// Group schemas the generator cannot currently turn into Dart.
///
/// Keyed by `<suite-relative path> :: <group description>`, the same key shape
/// the validator allow-list uses. Kept explicit so that each entry is a
/// deliberate, reviewable statement about a known gap.
File _generatorFailuresFile() => File(
  p.join(
    Directory.current.path,
    'test',
    'generator_conformance_known_failures.txt',
  ),
);

Set<String> _loadGeneratorFailures() {
  final file = _generatorFailuresFile();
  if (!file.existsSync()) return <String>{};
  return file
      .readAsLinesSync()
      .map((l) => l.trim())
      .where((l) => l.isNotEmpty && !l.startsWith('#'))
      .toSet();
}

String _sanitize(String value) =>
    value.replaceAll(RegExp('[^A-Za-z0-9]+'), '_');

void main() {
  final root = suiteRoot();
  if (!root.existsSync()) {
    fail('Test suite directory not found: ${root.path}');
  }

  // The analyzer needs the generated files to resolve
  // `package:json_schema_gen/...`, so they have to live inside this package.
  final outputDir = Directory(
    p.join(Directory.current.path, '.dart_tool', 'generator_conformance'),
  );

  setUpAll(() {
    if (outputDir.existsSync()) outputDir.deleteSync(recursive: true);
    outputDir.createSync(recursive: true);
  });

  tearDownAll(() {
    if (outputDir.existsSync()) outputDir.deleteSync(recursive: true);
  });

  final knownFailures = _loadGeneratorFailures();
  final failures = <String, Object>{};
  var generatedCount = 0;

  test('every suite schema can be compiled to Dart', () async {
    for (final file in suiteFiles(root)) {
      final relativePath = suiteRelativePath(root, file);
      var index = 0;

      for (final group in readSuiteGroups(file)) {
        final key = '$relativePath :: ${group.description.trim()}';
        final schema = group.schema;
        index++;
        // A bare `true` / `false` schema carries no structure to generate.
        if (schema is! Map<String, dynamic>) continue;

        final rootName = 'Case$index';
        try {
          final parsed = await SchemaParser(
            schema,
            baseUri: 'https://json-schema-gen.test/$relativePath',
            uriResolver: uriResolver,
          ).parse();
          final code = generateCode(parsed, rootName);
          final name = '${_sanitize(relativePath)}_$index.dart';
          File(p.join(outputDir.path, name)).writeAsStringSync(code);
          generatedCount++;
        } catch (e) {
          failures[key] = e;
        }
      }
    }

    final unexpected = Map.of(failures)
      ..removeWhere((k, _) => knownFailures.contains(k));
    expect(
      unexpected,
      isEmpty,
      reason:
          'The generator threw on these suite schemas:\n'
          '${unexpected.entries.map((e) => '  ${e.key}\n    ${e.value}').join('\n')}\n\n'
          'If these are deliberate gaps, add the keys to '
          '${_generatorFailuresFile().path}.',
    );

    final nowGeneratable = knownFailures.difference(failures.keys.toSet());
    expect(
      nowGeneratable,
      isEmpty,
      reason:
          'These entries in ${_generatorFailuresFile().path} now generate '
          'successfully (or no longer exist upstream). Remove them:\n'
          '  ${nowGeneratable.join('\n  ')}',
    );

    expect(
      generatedCount,
      greaterThan(400),
      reason:
          'Almost nothing was generated, so this test would pass vacuously. '
          'Is the vendored suite present?',
    );
  });

  test('all generated code passes the analyzer', () {
    // Depends on the previous test having populated `outputDir`; `package:test`
    // runs the tests in a single file in declaration order.
    expect(
      outputDir.listSync().whereType<File>(),
      isNotEmpty,
      reason: 'No code was generated, so there is nothing to analyze.',
    );

    final result = Process.runSync(Platform.resolvedExecutable, [
      'analyze',
      '--no-fatal-warnings',
      outputDir.path,
    ], workingDirectory: Directory.current.path);

    final output = '${result.stdout}\n${result.stderr}';
    final errors = output
        .split('\n')
        .where((l) => l.contains('error -'))
        .toList();

    expect(
      errors,
      isEmpty,
      reason:
          'Generated code for the JSON Schema Test Suite does not compile. '
          'Each line below is a generator bug:\n${errors.join('\n')}',
    );
  });
}
