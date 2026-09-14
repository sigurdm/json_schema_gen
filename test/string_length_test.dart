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

import 'package:json_schema_gen/json_schema.dart';
import 'package:test/test.dart';

/// JSON Schema defines `minLength`/`maxLength` in terms of Unicode code
/// points, which is neither Dart's `String.length` (UTF-16 code units) nor
/// `characters.length` (grapheme clusters).
///
/// The three measures only diverge on specific inputs, which is why the
/// official conformance suite did not catch this: it exercises astral
/// characters such as `💩`, where code points and grapheme clusters agree.
void main() {
  // 1 code point, 2 UTF-16 code units, 1 grapheme cluster.
  const astral = '💩';
  // 3 code points (man, ZWJ, boy), 5 UTF-16 code units, 1 grapheme cluster.
  const zwjSequence = '👨‍👦';

  group('string length is counted in code points', () {
    test('sanity: the three measures really do differ', () {
      expect(astral.runes.length, 1);
      expect(astral.length, 2);

      expect(zwjSequence.runes.length, 3);
      expect(zwjSequence.length, 5);
    });

    test('an astral character counts as one, not two', () async {
      final validate = await createValidator({
        r'$schema': 'https://json-schema.org/draft/2020-12/schema',
        'type': 'string',
        'maxLength': 1,
      });
      // Would fail if UTF-16 code units were counted.
      expect(() => validate(astral), returnsNormally);
    });

    test('a ZWJ sequence counts its code points, not its glyphs', () async {
      final validate = await createValidator({
        r'$schema': 'https://json-schema.org/draft/2020-12/schema',
        'type': 'string',
        'maxLength': 2,
      });
      // Would pass if grapheme clusters were counted: the sequence renders as
      // a single glyph but is three code points.
      expect(
        () => validate(zwjSequence),
        throwsA(isA<JsonValidationException>()),
      );
    });

    test('minLength also counts code points', () async {
      final validate = await createValidator({
        r'$schema': 'https://json-schema.org/draft/2020-12/schema',
        'type': 'string',
        'minLength': 3,
      });
      expect(() => validate(zwjSequence), returnsNormally);
      // Two code points, below the minimum.
      expect(() => validate('ab'), throwsA(isA<JsonValidationException>()));
    });
  });

  group('generated code uses the same measure as the runtime validator', () {
    test('emits runes.length for minLength/maxLength', () async {
      final parser = SchemaParser({
        r'$schema': 'https://json-schema.org/draft/2020-12/schema',
        'title': 'Lengths',
        'type': 'object',
        'properties': {
          'name': {'type': 'string', 'minLength': 2, 'maxLength': 5},
        },
        'required': ['name'],
      }, baseUri: 'test.schema.json');
      final code = generateCode(await parser.parse(), 'Lengths');

      expect(code, contains('.runes.length < 2'));
      expect(code, contains('.runes.length > 5'));
    });
  });
}
