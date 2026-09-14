import 'package:jsontool/jsontool.dart';
import 'package:test/test.dart';
import 'undefined_vs_null_model.g.dart';

void main() {
  test('fromJson vs copyWith undefined tracking', () {
    // 1. Unspecified
    final m1 = UndefinedVsNullModel.fromJson(
      JsonReader.fromString('{}'),
      validate: false,
    );
    expect(m1.foo, isNull);
    expect(m1.toJsonValue(), {});

    // 2. Explicit null
    final m2 = UndefinedVsNullModel.fromJson(
      JsonReader.fromString('{"foo": null}'),
      validate: false,
    );
    expect(m2.foo, isNull);
    expect(m2.toJsonValue(), {"foo": null});

    // 3. copyWith unspecified
    final m3 = m2.copyWith(bar: 42);
    expect(m3.toJsonValue(), {"foo": null, "bar": 42});

    // 4. copyWith specifying null
    final m4 = m1.copyWith(foo: null);
    expect(m4.foo, isNull);
    expect(m4.toJsonValue(), {"foo": null});

    // 5. copyWith omitting key
    final m5 = m4.copyWith(bar: 10);
    expect(m5.toJsonValue(), {"foo": null, "bar": 10});
  });
}
