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

// ignore_for_file: avoid_print

import "dart:convert";
import "dart:io";
import "package:path/path.dart" as p;
import "package:json_schema_gen/json_schema.dart";

Future<List<int>> uriResolver(Uri uri) async {
  if (uri.host == "json-schema.org" && uri.path.startsWith("/draft/2020-12/")) {
    final relativePath = uri.path.replaceFirst("/draft/2020-12/", "");
    // The metaschema is not part of the test suite; it is vendored into this
    // repository under tool/metaschema so that the suite can be run against a
    // pristine checkout of JSON-Schema-Test-Suite.
    final vendored = File(
      p.join(
        Directory.current.path,
        "tool",
        "metaschema",
        "$relativePath.json",
      ),
    );
    if (await vendored.exists()) {
      return vendored.readAsBytes();
    }
    final localPath = p.join(
      Directory.current.path,
      "third_party",
      "JSON-Schema-Test-Suite",
      "remotes",
      "draft2020-12",
      relativePath,
    );
    final file = File(localPath);
    if (await file.exists()) {
      return file.readAsBytes();
    }
  }
  if (uri.host == "localhost" && uri.port == 1234) {
    final relativePath = uri.path;
    final localPath = p.join(
      Directory.current.path,
      "third_party",
      "JSON-Schema-Test-Suite",
      "remotes",
      relativePath.startsWith("/") ? relativePath.substring(1) : relativePath,
    );
    final file = File(localPath);
    if (await file.exists()) {
      return file.readAsBytes();
    }
  }
  throw ArgumentError("Cannot resolve URI: $uri");
}

void main() async {
  final testSuiteDir = Directory(
    p.join(
      Directory.current.path,
      "third_party",
      "JSON-Schema-Test-Suite",
      "tests",
      "draft2020-12",
    ),
  );
  if (!await testSuiteDir.exists()) {
    print("Test suite directory not found: ${testSuiteDir.path}");
    exit(1);
  }

  int totalTests = 0;
  int passedTests = 0;
  int failedTests = 0;
  int skippedTests = 0;

  final files = testSuiteDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith(".json"))
      .toList();
  files.sort((a, b) => p.basename(a.path).compareTo(p.basename(b.path)));

  for (final entity in files) {
    final filename = p.basename(entity.path);

    print("Running tests in: $filename");
    final content = await entity.readAsString();
    final suites = jsonDecode(content) as List<dynamic>;

    for (final suite in suites) {
      final suiteMap = suite as Map<String, dynamic>;
      final suiteDesc = suiteMap["description"] as String?;
      final schema = suiteMap["schema"];
      final tests = suiteMap["tests"] as List<dynamic>;

      // We need to parse the schema.
      dynamic validator;
      try {
        if (schema is bool) {
          validator = (dynamic value) {
            if (schema == false) {
              throw JsonValidationException.single(
                "Value not allowed by false schema",
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
          print("    UNSUPPORTED SCHEMA TYPE: ${schema.runtimeType}");
          skippedTests += tests.length;
          continue;
        }
      } catch (e) {
        print("    Failed to parse schema for suite \"$suiteDesc\": $e");
        failedTests += tests.length;
        totalTests += tests.length;
        continue;
      }

      for (final test in tests) {
        final testMap = test as Map<String, dynamic>;
        final testDesc = testMap["description"] as String?;
        final data = testMap["data"];
        final expectedValid = testMap["valid"] as bool;

        totalTests++;
        bool actualValid = true;
        String failureMessage = "";

        try {
          if (validator is void Function(dynamic)) {
            validator(data);
          } else if (validator is Future<void> Function(dynamic)) {
            await validator(data);
          } else {
            actualValid = false;
            failureMessage = "No validator or invalid validator type";
          }
        } on JsonValidationException catch (e) {
          actualValid = false;
          failureMessage = e.toString();
        } on FormatException catch (e) {
          actualValid = false;
          failureMessage = e.toString();
        } catch (e) {
          actualValid = false;
          failureMessage = "Unexpected error: $e";
        }

        if (actualValid == expectedValid) {
          passedTests++;
        } else {
          failedTests++;
          print("      FAIL: $suiteDesc -> $testDesc");
          print("        Data: $data");
          print("        Expected valid: $expectedValid, Got: $actualValid");
          if (failureMessage.isNotEmpty) {
            print("        Error: $failureMessage");
          }
        }
      }
    }
  }

  print("");
  print("Summary:");
  print("Total tests: $totalTests");
  print("Passed: $passedTests");
  print("Failed: $failedTests");
  print("Skipped: $skippedTests");

  if (failedTests > 0) {
    exit(1);
  }
}
