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

import 'dart:async';
import 'package:test/test.dart';
import 'package:json_schema_gen/json_schema.dart';

void main() {
  test('generateCode is reentrant and safe for concurrent execution', () async {
    final schemas = <Schema>[
      Schema(
        title: 'StatusModel',
        type: ['object'],
        properties: {
          'status': Schema(
            enumValues: [
              'active',
              'inactive',
              'pending',
              'values',
              'descriptor',
            ],
          ),
          'code': Schema(type: ['integer']),
        },
      ),
      Schema(
        title: 'UserModel',
        type: ['object'],
        properties: {
          'name': Schema(type: ['string']),
          'role': Schema(
            enumValues: ['admin', 'user', 'guest', 'value', 'fromValue'],
          ),
          'validate': Schema(type: ['string']),
        },
      ),
      Schema(
        title: 'CollidingModel',
        type: ['object'],
        properties: {
          'foo': Schema(type: ['string']),
          'foo_1': Schema(type: ['string']),
          'type': Schema(enumValues: ['a', 'b', 'c', 'values_1']),
        },
      ),
    ];

    // Get expected single-threaded baseline outputs
    final baselines = [
      generateCode(schemas[0], 'StatusModel'),
      generateCode(schemas[1], 'UserModel'),
      generateCode(schemas[2], 'CollidingModel'),
    ];

    // Run 60 concurrent generations interleaved across event loop
    final futures = <Future<void>>[];
    for (var i = 0; i < 60; i++) {
      final index = i % schemas.length;
      futures.add(
        Future(() {
          final code = generateCode(schemas[index], schemas[index].title!);
          expect(code, equals(baselines[index]));
        }),
      );
    }

    await Future.wait(futures);
  });

  test('generateCode is safe for recursive reentrant invocation', () {
    final childSchema = Schema(
      title: 'ChildModel',
      type: ['object'],
      properties: {
        'tag': Schema(enumValues: ['child_a', 'child_b']),
      },
    );

    late final String childCode;
    final parentSchema = Schema(
      title: 'ParentModel',
      type: ['object'],
      properties: {
        'status': Schema(enumValues: ['active', 'inactive']),
        'child': Schema(ref: 'child.schema.json')..resolvedRef = childSchema,
      },
    );

    final parentCode = generateCode(
      parentSchema,
      'ParentModel',
      dartImportResolver: (Uri uri) {
        // Recursive reentrant call to generateCode while parent generation is active
        childCode = generateCode(childSchema, 'ChildModel');
        return 'child.g.dart';
      },
    );

    expect(parentCode, contains('final class ParentModel'));
    expect(parentCode, contains("import 'child.g.dart' as"));
    expect(parentCode, contains('ParentModelStatus'));
    expect(childCode, contains('final class ChildModel'));
    expect(childCode, contains('ChildModelTag'));
  });
}
