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

    // 3. copyWith preserves explicit null from previous instance
    final m3 = m2.copyWith(bar: 42);
    expect(m3.toJsonValue(), {"foo": null, "bar": 42});

    // 4. copyWith preserves unspecified from previous instance
    final m4 = m1.copyWith(bar: 10);
    expect(m4.foo, isNull);
    expect(m4.toJsonValue(), {"bar": 10});

    // 5. explicitKeys constructor parameter can explicitly specify keys
    const m5 = UndefinedVsNullModel(foo: null, explicitKeys: {'foo'});
    expect(m5.toJsonValue(), {"foo": null});
  });
}
