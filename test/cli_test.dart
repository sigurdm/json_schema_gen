// Copyright 2024 Google LLC
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
import '../bin/json_schema_gen.dart' as cli;

void main() {
  group('CLI in-process integration tests', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('cli_test_');
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('--help displays usage and returns code 0', () async {
      final out = StringBuffer();
      final err = StringBuffer();
      final exitCode = await cli.run(
        ['--help'],
        stdoutSink: out,
        stderrSink: err,
      );

      expect(exitCode, equals(cli.ExitCode.ok));
      expect(
        out.toString(),
        contains('A JSON Schema code generator for Dart.'),
      );
      expect(out.toString(), contains('-i, --input'));
      expect(out.toString(), contains('-o, --output'));
      expect(out.toString(), contains('-r, --root-name'));
      expect(out.toString(), contains('--[no-]format'));
      expect(err.toString(), isEmpty);
    });

    test('missing --input returns code 64 (EX_USAGE)', () async {
      final out = StringBuffer();
      final err = StringBuffer();
      final exitCode = await cli.run([], stdoutSink: out, stderrSink: err);

      expect(exitCode, equals(cli.ExitCode.usage));
      expect(err.toString(), contains('Missing required option "-i, --input"'));
    });

    test('invalid option syntax returns code 64 (EX_USAGE)', () async {
      final out = StringBuffer();
      final err = StringBuffer();
      final exitCode = await cli.run(
        ['--unknown-flag'],
        stdoutSink: out,
        stderrSink: err,
      );

      expect(exitCode, equals(cli.ExitCode.usage));
      expect(err.toString(), contains('Could not find an option'));
    });

    test(
      'unexpected positional arguments returns code 64 (EX_USAGE)',
      () async {
        final out = StringBuffer();
        final err = StringBuffer();
        final exitCode = await cli.run(
          ['-i', 'some_file.json', 'extra_arg'],
          stdoutSink: out,
          stderrSink: err,
        );

        expect(exitCode, equals(cli.ExitCode.usage));
        expect(err.toString(), contains('Unexpected arguments: extra_arg'));
      },
    );

    test('nonexistent input file returns code 66 (EX_NOINPUT)', () async {
      final out = StringBuffer();
      final err = StringBuffer();
      final missingPath = p.join(tempDir.path, 'does_not_exist.json');
      final exitCode = await cli.run(
        ['-i', missingPath],
        stdoutSink: out,
        stderrSink: err,
      );

      expect(exitCode, equals(cli.ExitCode.noInput));
      expect(err.toString(), contains('Input file not found'));
    });

    test('malformed JSON returns code 65 (EX_DATAERR)', () async {
      final schemaFile = File(p.join(tempDir.path, 'invalid.json'));
      await schemaFile.writeAsString('{not valid json');

      final out = StringBuffer();
      final err = StringBuffer();
      final exitCode = await cli.run(
        ['-i', schemaFile.path],
        stdoutSink: out,
        stderrSink: err,
      );

      expect(exitCode, equals(cli.ExitCode.dataError));
      expect(err.toString(), contains('Error parsing JSON'));
    });

    test('non-object schema returns code 65 (EX_DATAERR)', () async {
      final schemaFile = File(p.join(tempDir.path, 'array_schema.json'));
      await schemaFile.writeAsString('[1, 2, 3]');

      final out = StringBuffer();
      final err = StringBuffer();
      final exitCode = await cli.run(
        ['-i', schemaFile.path],
        stdoutSink: out,
        stderrSink: err,
      );

      expect(exitCode, equals(cli.ExitCode.dataError));
      expect(err.toString(), contains('Schema must be a JSON object'));
    });

    test('empty -o option returns code 64 (EX_USAGE)', () async {
      final schemaFile = File(p.join(tempDir.path, 'valid.schema.json'));
      await schemaFile.writeAsString('{"type": "object"}');

      final out = StringBuffer();
      final err = StringBuffer();
      final exitCode = await cli.run(
        ['-i', schemaFile.path, '-o', '   '],
        stdoutSink: out,
        stderrSink: err,
      );

      expect(exitCode, equals(cli.ExitCode.usage));
      expect(err.toString(), contains('Output path must not be empty'));
    });

    test('empty -r option returns code 64 (EX_USAGE)', () async {
      final schemaFile = File(p.join(tempDir.path, 'valid.schema.json'));
      await schemaFile.writeAsString('{"type": "object"}');

      final out = StringBuffer();
      final err = StringBuffer();
      final exitCode = await cli.run(
        ['-i', schemaFile.path, '-r', '   '],
        stdoutSink: out,
        stderrSink: err,
      );

      expect(exitCode, equals(cli.ExitCode.usage));
      expect(err.toString(), contains('Root name must not be empty'));
    });

    test('writing to directory returns code 70 (EX_SOFTWARE)', () async {
      final schemaFile = File(p.join(tempDir.path, 'valid.schema.json'));
      await schemaFile.writeAsString('{"type": "object"}');

      final conflictDir = Directory(p.join(tempDir.path, 'conflict_dir'));
      await conflictDir.create();

      final out = StringBuffer();
      final err = StringBuffer();
      final exitCode = await cli.run(
        ['-i', schemaFile.path, '-o', conflictDir.path],
        stdoutSink: out,
        stderrSink: err,
      );

      expect(exitCode, equals(cli.ExitCode.software));
      expect(err.toString(), contains('Error writing output file'));
    });

    test('valid schema generates formatted code to -o output path', () async {
      final schemaFile = File(p.join(tempDir.path, 'user.schema.json'));
      await schemaFile.writeAsString(
        jsonEncode({
          '\$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'User',
          'type': 'object',
          'properties': {
            'name': {'type': 'string'},
            'age': {'type': 'integer'},
          },
          'required': ['name'],
        }),
      );

      final outputFile = File(p.join(tempDir.path, 'generated', 'user.g.dart'));
      final out = StringBuffer();
      final err = StringBuffer();

      final exitCode = await cli.run(
        ['-i', schemaFile.path, '-o', outputFile.path],
        stdoutSink: out,
        stderrSink: err,
      );

      expect(exitCode, equals(cli.ExitCode.ok));
      expect(err.toString(), isEmpty);
      expect(await outputFile.exists(), isTrue);

      final code = await outputFile.readAsString();
      expect(code, contains('final class User implements JsonModel {'));
      expect(code, contains('final String name;'));
      expect(code, contains('final int? age;'));
    });

    test(
      'valid schema generates to default <dir>/<name>.g.dart path when -o is omitted',
      () async {
        final schemaFile = File(p.join(tempDir.path, 'product.schema.json'));
        await schemaFile.writeAsString(
          jsonEncode({
            '\$schema': 'https://json-schema.org/draft/2020-12/schema',
            'title': 'Product',
            'type': 'object',
            'properties': {
              'sku': {'type': 'string'},
            },
          }),
        );

        final out = StringBuffer();
        final err = StringBuffer();

        final exitCode = await cli.run(
          ['-i', schemaFile.path],
          stdoutSink: out,
          stderrSink: err,
        );

        expect(exitCode, equals(cli.ExitCode.ok));
        final defaultOutput = File(p.join(tempDir.path, 'product.g.dart'));
        expect(await defaultOutput.exists(), isTrue);

        final code = await defaultOutput.readAsString();
        expect(code, contains('final class Product implements JsonModel {'));
      },
    );

    test('valid schema writes code to stdout when -o - is specified', () async {
      final schemaFile = File(p.join(tempDir.path, 'item.json'));
      await schemaFile.writeAsString(
        jsonEncode({
          'title': 'Item',
          'type': 'object',
          'properties': {
            'id': {'type': 'string'},
          },
        }),
      );

      final out = StringBuffer();
      final err = StringBuffer();

      final exitCode = await cli.run(
        ['-i', schemaFile.path, '-o', '-'],
        stdoutSink: out,
        stderrSink: err,
      );

      expect(exitCode, equals(cli.ExitCode.ok));
      expect(err.toString(), isEmpty);
      expect(
        out.toString(),
        contains('final class Item implements JsonModel {'),
      );
    });

    test('custom -r/--root-name overrides schema title', () async {
      final schemaFile = File(p.join(tempDir.path, 'data.json'));
      await schemaFile.writeAsString(
        jsonEncode({
          'title': 'OriginalTitle',
          'type': 'object',
          'properties': {
            'val': {'type': 'string'},
          },
        }),
      );

      final out = StringBuffer();
      final err = StringBuffer();

      final exitCode = await cli.run(
        ['-i', schemaFile.path, '-r', 'CustomRootModel', '-o', '-'],
        stdoutSink: out,
        stderrSink: err,
      );

      expect(exitCode, equals(cli.ExitCode.ok));
      expect(
        out.toString(),
        contains('final class CustomRootModel implements JsonModel {'),
      );
      expect(out.toString(), isNot(contains('final class OriginalTitle')));
    });

    test('--no-format preserves raw unformatted output', () async {
      final schemaFile = File(p.join(tempDir.path, 'raw.json'));
      await schemaFile.writeAsString(
        jsonEncode({
          'title': 'RawModel',
          'type': 'object',
          'properties': {
            'x': {'type': 'string'},
          },
        }),
      );

      final outFormatted = StringBuffer();
      await cli.run([
        '-i',
        schemaFile.path,
        '-o',
        '-',
      ], stdoutSink: outFormatted);

      final outRaw = StringBuffer();
      await cli.run([
        '-i',
        schemaFile.path,
        '-o',
        '-',
        '--no-format',
      ], stdoutSink: outRaw);

      expect(
        outRaw.toString(),
        contains('final class RawModel implements JsonModel {'),
      );
      expect(outRaw.toString().isNotEmpty, isTrue);
    });

    test(r'resolves relative $ref against input schema directory', () async {
      final addressFile = File(p.join(tempDir.path, 'address.schema.json'));
      await addressFile.writeAsString(
        jsonEncode({
          '\$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'Address',
          'type': 'object',
          'properties': {
            'street': {'type': 'string'},
            'city': {'type': 'string'},
          },
          'required': ['street', 'city'],
        }),
      );

      final personFile = File(p.join(tempDir.path, 'person.schema.json'));
      await personFile.writeAsString(
        jsonEncode({
          '\$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'Person',
          'type': 'object',
          'properties': {
            'name': {'type': 'string'},
            'homeAddress': {'\$ref': 'address.schema.json'},
          },
          'required': ['name'],
        }),
      );

      final out = StringBuffer();
      final err = StringBuffer();
      final exitCode = await cli.run(
        ['-i', personFile.path, '-o', '-'],
        stdoutSink: out,
        stderrSink: err,
      );

      expect(exitCode, equals(cli.ExitCode.ok));
      expect(err.toString(), isEmpty);
      expect(
        out.toString(),
        contains('final class Person implements JsonModel {'),
      );
      expect(
        out.toString(),
        contains('final class Address implements JsonModel {'),
      );
      expect(out.toString(), contains('final Address? homeAddress;'));
    });
  });

  group('CLI process execution tests', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('cli_process_test_');
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test(
      'invoking bin/json_schema_gen.dart with --help exits with 0',
      () async {
        final result = await Process.run(Platform.resolvedExecutable, [
          'run',
          'bin/json_schema_gen.dart',
          '--help',
        ]);
        expect(result.exitCode, equals(0));
        expect(result.stdout, contains('Usage: json_schema_gen [options]'));
      },
    );

    test(
      'invoking bin/json_schema_gen.dart with missing args exits with 64',
      () async {
        final result = await Process.run(Platform.resolvedExecutable, [
          'run',
          'bin/json_schema_gen.dart',
        ]);
        expect(result.exitCode, equals(64));
        expect(
          result.stderr,
          contains('Missing required option "-i, --input"'),
        );
      },
    );

    test(
      'invoking bin/json_schema_gen.dart with nonexistent file exits with 66',
      () async {
        final result = await Process.run(Platform.resolvedExecutable, [
          'run',
          'bin/json_schema_gen.dart',
          '-i',
          p.join(tempDir.path, 'missing.json'),
        ]);
        expect(result.exitCode, equals(66));
        expect(result.stderr, contains('Input file not found'));
      },
    );

    test(
      'invoking bin/json_schema_gen.dart generating file exits with 0 and compiles',
      () async {
        final schemaFile = File(p.join(tempDir.path, 'account.schema.json'));
        await schemaFile.writeAsString(
          jsonEncode({
            'title': 'Account',
            'type': 'object',
            'properties': {
              'id': {'type': 'string'},
              'balance': {'type': 'number'},
            },
            'required': ['id'],
          }),
        );

        final outputFile = File(p.join(tempDir.path, 'account.g.dart'));
        final result = await Process.run(Platform.resolvedExecutable, [
          'run',
          'bin/json_schema_gen.dart',
          '-i',
          schemaFile.path,
          '-o',
          outputFile.path,
        ]);

        expect(result.exitCode, equals(0));
        expect(await outputFile.exists(), isTrue);
        final generated = await outputFile.readAsString();
        expect(
          generated,
          contains('final class Account implements JsonModel {'),
        );
      },
    );

    test(
      'invoking bin/json_schema_gen.dart with invalid output directory exits with 70',
      () async {
        final schemaFile = File(p.join(tempDir.path, 'conflict.schema.json'));
        await schemaFile.writeAsString(
          jsonEncode({
            'title': 'Conflict',
            'type': 'object',
            'properties': {
              'id': {'type': 'string'},
            },
          }),
        );

        final conflictDir = Directory(p.join(tempDir.path, 'conflict_dir'));
        await conflictDir.create();

        final result = await Process.run(Platform.resolvedExecutable, [
          'run',
          'bin/json_schema_gen.dart',
          '-i',
          schemaFile.path,
          '-o',
          conflictDir.path,
        ]);

        expect(result.exitCode, equals(70));
        expect(result.stderr, contains('Error writing output file'));
      },
    );
  });
}
