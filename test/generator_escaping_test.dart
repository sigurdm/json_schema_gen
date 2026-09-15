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

@Timeout(Duration(minutes: 5))
library;

import 'dart:io';

import 'package:json_schema_gen/json_schema.dart';
// `dartStringLiteral` is an internal helper, deliberately not part of the
// public API, but it is the single chokepoint for escaping so it is worth
// testing directly.
import 'package:json_schema_gen/src/generator.dart'
    show dartDocComment, dartStringLiteral;
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// Generates code for [schema] and asserts that the result actually compiles.
///
/// Schema content flows into generated source in many places (error messages,
/// regex literals, annotations, doc comments). Asserting on substrings is not
/// enough: these bugs only show up when the analyzer looks at the output. Each
/// case here previously produced a file that failed to compile, or — for the
/// deprecation message — let schema content inject arbitrary Dart.
Future<void> expectGeneratesValidDart(
  Map<String, dynamic> schema,
  String rootName, {
  required Directory workDir,
}) async {
  final parser = SchemaParser(schema, baseUri: 'test.schema.json');
  final code = generateCode(await parser.parse(), rootName);

  final file = File(p.join(workDir.path, 'out_${rootName.toLowerCase()}.dart'));
  file.writeAsStringSync(code);

  final result = Process.runSync(Platform.resolvedExecutable, [
    'analyze',
    '--no-fatal-warnings',
    file.path,
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
        'Generated code for "$rootName" does not compile:\n'
        '${errors.join('\n')}\n\n--- generated ---\n$code',
  );
}

void main() {
  // The analyzer needs the file to resolve `package:json_schema_gen/...`, so
  // the scratch files have to live inside this package.
  late Directory workDir;

  setUpAll(() {
    workDir = Directory(
      p.join(Directory.current.path, '.dart_tool', 'escaping_test'),
    )..createSync(recursive: true);
  });

  tearDownAll(() {
    if (workDir.existsSync()) workDir.deleteSync(recursive: true);
  });

  group('schema content cannot break generated code', () {
    test(
      r'property name containing $ is not treated as interpolation',
      () async {
        await expectGeneratesValidDart(
          {
            r'$schema': 'https://json-schema.org/draft/2020-12/schema',
            'title': 'DollarName',
            'type': 'object',
            'properties': {
              r'foo$nonExistent': {'type': 'string', 'minLength': 1},
              'bar': {'type': 'string'},
            },
            'dependentRequired': {
              'bar': [r'foo$nonExistent'],
            },
            'required': ['bar'],
          },
          'DollarName',
          workDir: workDir,
        );
      },
    );

    test('single quote in a patternProperties regex', () async {
      await expectGeneratesValidDart(
        {
          r'$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'QuotedPattern',
          'type': 'object',
          'patternProperties': {
            r"^foo'bar$": {'type': 'string'},
          },
        },
        'QuotedPattern',
        workDir: workDir,
      );
    });

    test('backslashes and dollars in a string pattern', () async {
      await expectGeneratesValidDart(
        {
          r'$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'RegexPattern',
          'type': 'object',
          'properties': {
            'code': {'type': 'string', 'pattern': r'^\d+\$[a-z]+$'},
          },
        },
        'RegexPattern',
        workDir: workDir,
      );
    });

    test('x-deprecated-message cannot escape the annotation', () async {
      await expectGeneratesValidDart(
        {
          r'$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'DeprecatedInjection',
          'type': 'object',
          'properties': {
            'old': {
              'type': 'string',
              'deprecated': true,
              'x-deprecated-message': r"evil'); void injected() {} //",
            },
          },
        },
        'DeprecatedInjection',
        workDir: workDir,
      );
    });

    test('newlines and control characters in a deprecation message', () async {
      await expectGeneratesValidDart(
        {
          r'$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'MultilineDeprecated',
          'type': 'object',
          'properties': {
            'old': {
              'type': 'string',
              'deprecated': true,
              'x-deprecated-message': 'line one\nline two\ttabbed',
            },
          },
        },
        'MultilineDeprecated',
        workDir: workDir,
      );
    });

    test('apostrophes in titles and descriptions', () async {
      await expectGeneratesValidDart(
        {
          r'$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'Apostrophes',
          'type': 'object',
          'properties': {
            "it's": {
              'type': 'string',
              'description': "The user's name",
              'minLength': 1,
            },
          },
          'required': ["it's"],
        },
        'Apostrophes',
        workDir: workDir,
      );
    });

    test('unicode and emoji property names', () async {
      await expectGeneratesValidDart(
        {
          r'$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'UnicodeNames',
          'type': 'object',
          'properties': {
            'naïve': {'type': 'string', 'minLength': 1},
            '日本語': {'type': 'integer', 'minimum': 0},
          },
        },
        'UnicodeNames',
        workDir: workDir,
      );
    });

    test('enum values containing quotes and dollars', () async {
      await expectGeneratesValidDart(
        {
          r'$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'TrickyEnum',
          'type': 'object',
          'properties': {
            'kind': {
              'type': 'string',
              'enum': [r"it's", r'$price', 'plain'],
            },
          },
        },
        'TrickyEnum',
        workDir: workDir,
      );
    });
  });

  group('generated classes do not shadow types they reference', () {
    for (final name in [
      'List',
      'Object',
      'Map',
      'String',
      'Duration',
      'Error',
    ]) {
      test('a schema titled "$name" still compiles', () async {
        await expectGeneratesValidDart(
          {
            r'$schema': 'https://json-schema.org/draft/2020-12/schema',
            'title': name,
            'type': 'object',
            'properties': {
              'howLong': {'type': 'string', 'format': 'date-time'},
              'items': {
                'type': 'array',
                'items': {'type': 'string'},
                'minItems': 1,
              },
            },
            'required': ['howLong'],
          },
          name,
          workDir: workDir,
        );
      });
    }
  });

  group('hostile schema text cannot inject Dart', () {
    test(r'$comment containing a newline stays inside the doc comment', () async {
      await expectGeneratesValidDart(
        {
          r'$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'HostileComment',
          'type': 'object',
          'properties': {
            'field': {
              'type': 'string',
              r'$comment':
                  "harmless\n}\n\nvoid injected() { throw 'pwned'; }\n\nclass Leftover {",
            },
          },
        },
        'HostileComment',
        workDir: workDir,
      );
    });

    test(r'$comment containing quotes and $ interpolation', () async {
      await expectGeneratesValidDart(
        {
          r'$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'QuotedComment',
          'type': 'object',
          'properties': {
            'field': {
              'type': 'string',
              r'$comment': r"it's ${injected} \ [NotAType] */",
            },
          },
        },
        'QuotedComment',
        workDir: workDir,
      );
    });

    test('enum values containing quotes and backslashes', () async {
      await expectGeneratesValidDart(
        {
          r'$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'HostileEnum',
          'type': 'object',
          'properties': {
            'kind': {
              'enum': [r"it's", r'back\slash', r'${injected}', 'line\nbreak'],
            },
          },
          'required': ['kind'],
        },
        'HostileEnum',
        workDir: workDir,
      );
    });

    test('discriminator property name containing a quote', () async {
      await expectGeneratesValidDart(
        {
          r'$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'HostileDiscriminator',
          'oneOf': [
            {
              'type': 'object',
              'title': 'Cat',
              'properties': {
                r"it's a type": {'const': 'cat'},
              },
            },
            {
              'type': 'object',
              'title': 'Dog',
              'properties': {
                r"it's a type": {'const': 'dog'},
              },
            },
          ],
          'discriminator': {
            'propertyName': r"it's a type",
            'mapping': {r"cat's": '#/oneOf/0', r'dog\s': '#/oneOf/1'},
          },
        },
        'HostileDiscriminator',
        workDir: workDir,
      );
    });

    test('union option titles containing quotes', () async {
      await expectGeneratesValidDart(
        {
          r'$schema': 'https://json-schema.org/draft/2020-12/schema',
          'title': 'HostileUnionTitles',
          'oneOf': [
            {'type': 'object', 'title': r"Alice's ${thing}"},
            {'type': 'string'},
          ],
        },
        'HostileUnionTitles',
        workDir: workDir,
      );
    });
  });

  group('dartStringLiteral', () {
    test('escapes the characters that are significant in a Dart literal', () {
      expect(dartStringLiteral('plain'), "'plain'");
      expect(dartStringLiteral("it's"), r"'it\'s'");
      expect(dartStringLiteral(r'$var'), r"'\$var'");
      expect(dartStringLiteral(r'back\slash'), r"'back\\slash'");
      expect(dartStringLiteral('a\nb'), r"'a\nb'");
      expect(dartStringLiteral('a\tb'), r"'a\tb'");
    });

    test('preserves non-ASCII text verbatim', () {
      expect(dartStringLiteral('日本語'), "'日本語'");
      expect(dartStringLiteral('naïve'), "'naïve'");
    });
  });

  group('dartDocComment', () {
    test('prefixes every line so text cannot escape the comment', () {
      expect(dartDocComment('one\ntwo'), '  /// one\n  /// two\n');
      expect(dartDocComment('a\r\nb\rc'), '  /// a\n  /// b\n  /// c\n');
    });

    test('escapes brackets so they are not dartdoc references', () {
      expect(
        dartDocComment('see [NotAType]'),
        r'  /// see \[NotAType\]'
        '\n',
      );
    });

    test('strips control characters', () {
      expect(dartDocComment('a\u0000b'), '  /// ab\n');
    });

    test('keeps blank lines as bare ///', () {
      expect(dartDocComment('a\n\nb'), '  /// a\n  ///\n  /// b\n');
    });
  });
}
