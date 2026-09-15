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

/// Shared plumbing for running the official JSON Schema Test Suite.
///
/// Both the `package:test` harness (`json_schema_suite_test.dart`) and the
/// standalone reporter (`tool/run_json_schema_tests.dart`) drive the same
/// vendored suite, so the directory walking, remote resolution and
/// known-failure bookkeeping live here rather than being duplicated — the two
/// copies had already drifted apart once.
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

/// Root of the vendored Draft 2020-12 test suite.
Directory suiteRoot([String? packageRoot]) => Directory(
  p.join(
    packageRoot ?? Directory.current.path,
    'third_party',
    'JSON-Schema-Test-Suite',
    'tests',
    'draft2020-12',
  ),
);

/// Every `.json` suite file under [root], including the `optional/` subtree.
///
/// The previous implementation used a non-recursive `listSync()`, which
/// silently skipped `optional/` — roughly 800 assertions, and precisely the
/// ones most likely to catch a regression.
List<File> suiteFiles(Directory root) {
  final files = root
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.json'))
      .toList();
  files.sort((a, b) => a.path.compareTo(b.path));
  return files;
}

/// The suite-relative path of [file], using `/` separators on every platform.
String suiteRelativePath(Directory root, File file) =>
    p.url.joinAll(p.split(p.relative(file.path, from: root.path)));

/// Whether `format` should be asserted for the suite in [relativePath].
///
/// `format` is an annotation by default, so the `optional/format/**` suites —
/// and only those — expect it to be enforced.
bool assertsFormats(String relativePath) =>
    relativePath.startsWith('optional/format/');

/// Stable identifier for one assertion in the suite.
String testKey(String relativePath, String suiteDesc, String testDesc) =>
    '$relativePath :: $suiteDesc :: $testDesc';

/// File holding the known-failure allow-list.
File knownFailuresFile([String? packageRoot]) => File(
  p.join(
    packageRoot ?? Directory.current.path,
    'test',
    'json_schema_suite_known_failures.txt',
  ),
);

/// Assertions that are known not to pass yet, keyed by [testKey].
///
/// The allow-list exists so the conformance number can only ever improve: a
/// listed assertion that starts passing is reported as an error telling you to
/// remove the line, and an unlisted assertion that fails is a plain failure.
/// Without it, "we pass the suite" degrades silently the moment anyone widens
/// the set of files being run.
Set<String> loadKnownFailures([String? packageRoot]) {
  final file = knownFailuresFile(packageRoot);
  if (!file.existsSync()) return <String>{};
  return file
      .readAsLinesSync()
      .map((l) => l.trim())
      .where((l) => l.isNotEmpty && !l.startsWith('#'))
      .toSet();
}

/// Resolves the remote references used by the suite against vendored files.
Future<List<int>> uriResolver(Uri uri) async {
  if (uri.host == 'json-schema.org' && uri.path.startsWith('/draft/2020-12/')) {
    final relativePath = uri.path.replaceFirst('/draft/2020-12/', '');
    // The metaschema is not part of the test suite; it is vendored into this
    // repository under tool/metaschema so that the suite can be run against a
    // pristine checkout of JSON-Schema-Test-Suite.
    final vendored = File(
      p.join(
        Directory.current.path,
        'tool',
        'metaschema',
        '$relativePath.json',
      ),
    );
    if (await vendored.exists()) {
      return vendored.readAsBytes();
    }
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

/// One `description` / `schema` / `tests` group from a suite file.
class SuiteGroup {
  SuiteGroup(this.description, this.schema, this.cases);

  final String description;
  final Object? schema;
  final List<SuiteCase> cases;
}

/// One assertion within a [SuiteGroup].
class SuiteCase {
  SuiteCase(this.description, this.data, this.valid);

  final String description;
  final Object? data;
  final bool valid;
}

/// Decodes the groups in [file].
List<SuiteGroup> readSuiteGroups(File file) {
  final decoded = jsonDecode(file.readAsStringSync()) as List<dynamic>;
  return [
    for (final group in decoded.cast<Map<String, dynamic>>())
      SuiteGroup(group['description'] as String, group['schema'], [
        for (final c in (group['tests'] as List).cast<Map<String, dynamic>>())
          SuiteCase(c['description'] as String, c['data'], c['valid'] as bool),
      ]),
  ];
}
