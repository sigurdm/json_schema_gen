import 'package:json_schema_gen/json_schema.dart';
import 'package:test/test.dart';

void main() {
  group('Format validators', () {
    test('isValidDuration', () {
      expect(isValidDuration('P3D'), isTrue);
      expect(isValidDuration('PT1H'), isTrue);
      expect(isValidDuration('P1Y2M3D'), isTrue);
      expect(isValidDuration('P'), isFalse);
      expect(isValidDuration('P1Y2D'), isFalse);
    });

    test('isValidJsonPointer', () {
      expect(isValidJsonPointer(''), isTrue);
      expect(isValidJsonPointer('/foo/bar'), isTrue);
      expect(isValidJsonPointer('/foo~0bar'), isTrue);
      expect(isValidJsonPointer('/foo~1bar'), isTrue);
      expect(isValidJsonPointer('/foo~bar'), isFalse);
    });

    test('isValidRelativeJsonPointer', () {
      expect(isValidRelativeJsonPointer('0'), isTrue);
      expect(isValidRelativeJsonPointer('0/foo/bar'), isTrue);
      expect(isValidRelativeJsonPointer('1#'), isTrue);
      expect(isValidRelativeJsonPointer('01'), isFalse);
    });

    test('isValidUriTemplate', () {
      expect(isValidUriTemplate('http://example.com/{id}'), isTrue);
      expect(isValidUriTemplate('http://example.com/{id'), isFalse);
    });

    test('isValidIri', () {
      expect(isValidIri('http://example.com/é'), isTrue);
      expect(isValidIri('/foo/bar'), isFalse);
    });

    test('isValidIriReference', () {
      expect(isValidIriReference('http://example.com/é'), isTrue);
      expect(isValidIriReference('/foo/bar'), isTrue);
    });

    test('isValidIdnEmail', () {
      expect(isValidIdnEmail('test@example.com'), isTrue);
      expect(isValidIdnEmail('user@xn--example-domain.com'), isTrue);
      expect(isValidIdnEmail('foo'), isFalse);
    });

    test('isValidIdnHostname', () {
      expect(isValidIdnHostname('example.com'), isTrue);
      expect(isValidIdnHostname('xn--example-domain.com'), isTrue);
      expect(isValidIdnHostname('-example.com'), isFalse);
    });
  });
}
