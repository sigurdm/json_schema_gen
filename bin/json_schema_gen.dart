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
import 'package:args/args.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:json_schema_gen/src/generator.dart' show toPascalCase;

/// Standard Sysexits exit codes.
abstract final class ExitCode {
  static const ok = 0;
  static const usage = 64; // EX_USAGE
  static const dataError = 65; // EX_DATAERR
  static const noInput = 66; // EX_NOINPUT
  static const software = 70; // EX_SOFTWARE
}

ArgParser buildParser() {
  return ArgParser()
    ..addOption(
      'input',
      abbr: 'i',
      help: 'Path to the input JSON Schema file.',
      valueHelp: 'path',
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'Path to the output Dart file, or "-" for stdout.',
      valueHelp: 'path',
    )
    ..addOption(
      'root-name',
      abbr: 'r',
      help: 'Root Dart class name for the generated model.',
      valueHelp: 'name',
    )
    ..addFlag(
      'format',
      defaultsTo: true,
      help: 'Format the generated code with dart_style.',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Display usage instructions.',
    );
}

void main(List<String> args) async {
  final code = await run(args);
  if (code != 0) {
    exit(code);
  }
}

Future<int> run(
  List<String> args, {
  StringSink? stdoutSink,
  StringSink? stderrSink,
}) async {
  final out = stdoutSink ?? stdout;
  final err = stderrSink ?? stderr;
  final parser = buildParser();

  ArgResults results;
  try {
    results = parser.parse(args);
  } on FormatException catch (e) {
    err.writeln('Error: ${e.message}');
    err.writeln();
    err.writeln('Usage: json_schema_gen [options]');
    err.writeln(parser.usage);
    return ExitCode.usage;
  }

  if (results['help'] as bool) {
    out.writeln('A JSON Schema code generator for Dart.');
    out.writeln();
    out.writeln('Usage: json_schema_gen [options]');
    out.writeln();
    out.writeln(parser.usage);
    return ExitCode.ok;
  }

  if (results.rest.isNotEmpty) {
    err.writeln('Error: Unexpected arguments: ${results.rest.join(' ')}');
    err.writeln();
    err.writeln('Usage: json_schema_gen [options]');
    err.writeln(parser.usage);
    return ExitCode.usage;
  }

  final inputPath = results['input'] as String?;
  if (inputPath == null || inputPath.trim().isEmpty) {
    err.writeln('Error: Missing required option "-i, --input".');
    err.writeln();
    err.writeln('Usage: json_schema_gen [options]');
    err.writeln(parser.usage);
    return ExitCode.usage;
  }

  final inputFile = File(inputPath);
  if (!inputFile.existsSync()) {
    err.writeln('Error: Input file not found: $inputPath');
    return ExitCode.noInput;
  }

  final String content;
  try {
    content = await inputFile.readAsString();
  } catch (e) {
    err.writeln('Error reading input file: $e');
    return ExitCode.noInput;
  }

  final dynamic decoded;
  try {
    decoded = jsonDecode(content);
  } on FormatException catch (e) {
    err.writeln('Error parsing JSON: ${e.message}');
    return ExitCode.dataError;
  }

  if (decoded is! Map<String, dynamic>) {
    err.writeln('Error: Schema must be a JSON object.');
    return ExitCode.dataError;
  }

  final canonicalInputPath = p.canonicalize(inputFile.path);
  final inputDir = Directory(p.dirname(canonicalInputPath));
  final baseUri = Uri.file(canonicalInputPath).toString();

  Future<List<int>> uriResolver(Uri uri) async {
    if (uri.scheme == 'file' || uri.scheme.isEmpty) {
      return ioFileResolver(
        uri,
        rootDirectory: inputDir,
        restrictToRoot: false,
      );
    }
    final fallbackFile = File(p.join(inputDir.path, p.basename(uri.path)));
    if (await fallbackFile.exists()) {
      return fallbackFile.readAsBytes();
    }
    return ioFileResolver(uri, rootDirectory: inputDir, restrictToRoot: false);
  }

  final schemaParser = SchemaParser(
    decoded,
    baseUri: baseUri,
    uriResolver: uriResolver,
    onWarning: (message) => err.writeln('Warning: $message'),
  );

  Schema rootSchema;
  try {
    rootSchema = await schemaParser.parse();
  } catch (e) {
    err.writeln('Error parsing schema: $e');
    return ExitCode.dataError;
  }

  final rawRootName = results['root-name'] as String?;
  if (rawRootName != null && rawRootName.trim().isEmpty) {
    err.writeln('Error: Root name must not be empty.');
    return ExitCode.usage;
  }

  var rootName = rawRootName?.trim();
  if (rootName != null) {
    rootName = toPascalCase(rootName);
    if (rootName.isEmpty) {
      err.writeln('Error: Root name must contain valid identifier characters.');
      return ExitCode.usage;
    }
    rootSchema = rootSchema.copyWith(dartName: rootName);
    if (rootSchema.resolvedRef != null) {
      rootSchema.resolvedRef = rootSchema.resolvedRef!.copyWith(
        dartName: rootName,
      );
    }
  } else {
    final real = rootSchema.realSchema;
    final schemaName =
        real.dartName ?? rootSchema.dartName ?? real.title ?? rootSchema.title;
    if (schemaName != null && schemaName.trim().isNotEmpty) {
      rootName = toPascalCase(schemaName.trim());
    } else {
      final base = p.basenameWithoutExtension(canonicalInputPath);
      final cleanedBase = base.endsWith('.schema')
          ? p.basenameWithoutExtension(base)
          : base;
      final pascal = toPascalCase(cleanedBase);
      rootName = pascal.isNotEmpty ? pascal : 'Model';
    }
  }

  String generatedCode;
  try {
    generatedCode = generateCode(rootSchema, rootName);
  } catch (e, stack) {
    err.writeln('Error generating code: $e\n$stack');
    return ExitCode.software;
  }

  final format = results['format'] as bool;
  if (format) {
    try {
      generatedCode = DartFormatter(
        languageVersion: Version(3, 12, 0),
      ).format(generatedCode);
    } catch (e) {
      err.writeln('Error formatting generated code: $e');
      return ExitCode.software;
    }
  }

  final rawOutput = results['output'] as String?;
  if (rawOutput != null && rawOutput.trim().isEmpty) {
    err.writeln('Error: Output path must not be empty.');
    return ExitCode.usage;
  }

  final outputPath = rawOutput?.trim();
  if (outputPath == '-') {
    out.write(generatedCode);
    return ExitCode.ok;
  }

  final targetOutputPath = outputPath ?? _defaultOutputPath(canonicalInputPath);
  try {
    final outputFile = File(targetOutputPath);
    await outputFile.parent.create(recursive: true);
    await outputFile.writeAsString(generatedCode);
  } catch (e) {
    err.writeln('Error writing output file: $e');
    return ExitCode.software;
  }

  return ExitCode.ok;
}

String _defaultOutputPath(String canonicalInputPath) {
  final base = p.basenameWithoutExtension(canonicalInputPath);
  final schemaName = base.endsWith('.schema')
      ? p.basenameWithoutExtension(base)
      : base;
  return p.join(p.dirname(canonicalInputPath), '$schemaName.g.dart');
}
