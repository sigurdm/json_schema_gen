// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides, unnecessary_null_comparison
// ignore_for_file: prefer_is_empty, unnecessary_string_interpolations, avoid_init_to_null, unnecessary_const
// ignore_for_file: unnecessary_question_mark, unnecessary_cast

import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';

final class UndefinedVsNullModel implements JsonModel {
  const UndefinedVsNullModel({
    this.foo,
    this.bar,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory UndefinedVsNullModel.fromJson(
    JsonReader reader, {
    bool validate = true,
  }) =>
      parseWithDescriptor(reader, descriptor, validate: validate)
          as UndefinedVsNullModel;

  /// Creates an instance of [UndefinedVsNullModel] from a JSON Map.
  factory UndefinedVsNullModel.fromMap(
    Map<String, dynamic> map, {
    bool validate = true,
  }) => UndefinedVsNullModel.fromJson(
    JsonReader.fromObject(map),
    validate: validate,
  );

  final String? foo;

  final int? bar;

  final Map<String, Object?> additionalProperties;

  final Set<String>? _$explicitKeys;

  static final ObjectDescriptor<UndefinedVsNullModel> descriptor =
      ObjectDescriptor<UndefinedVsNullModel>(
        title: 'UndefinedVsNullModel',
        matches: (instance) => instance is UndefinedVsNullModel,
        instantiate: (fields) => UndefinedVsNullModel(
          foo: (fields['foo'] as String?),
          bar: (fields['bar'] as int?),
          additionalProperties: fields.entries
              .where(
                (e) => !const <String>{'foo', 'bar'}.contains(e.key) && true,
              )
              .fold<Map<String, Object?>>(
                {},
                (m, e) => m..[e.key] = e.value as Object?,
              ),
          explicitKeys: fields.keys.toSet(),
        ),
        getFields: (instance) {
          final typedInstance = (instance as UndefinedVsNullModel);
          final map = <String, dynamic>{
            'foo': typedInstance.foo,
            'bar': typedInstance.bar,
            ...typedInstance.additionalProperties,
          };
          final explicit = typedInstance._$explicitKeys;
          if (explicit != null) {
            return map.entries
                .where((e) => e.value != null || explicit.contains(e.key))
                .fold<Map<String, dynamic>>({}, (m, e) => m..[e.key] = e.value);
          }
          return map..removeWhere((k, v) => v == null);
        },
        properties: {
          'foo': PropertyDescriptor(
            name: 'foo',
            isRequired: false,
            schema: NullableDescriptor(const StringDescriptor()),
          ),
          'bar': PropertyDescriptor(
            name: 'bar',
            isRequired: false,
            schema: NullableDescriptor(const IntDescriptor()),
          ),
        },
        required: const [],
        additionalProperties: const AnythingDescriptor(),
      );

  @override
  void writeJson(JsonSink target) =>
      writeWithDescriptor(target, this, descriptor);

  String toJson() {
    final buffer = StringBuffer();
    writeJson(jsonStringWriter(buffer));
    return buffer.toString();
  }

  @override
  Object? toJsonValue() {
    Object? result;
    final sink = jsonObjectWriter((obj) => result = obj);
    writeJson(sink);
    return result;
  }

  /// Converts this instance to a JSON Map.
  Map<String, dynamic> toMap() => (toJsonValue() as Map<String, dynamic>);

  UndefinedVsNullModel copyWith({
    String? foo,
    int? bar,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (foo != null) {
      nextKeys?.add('foo');
    }
    if (bar != null) {
      nextKeys?.add('bar');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }
    return UndefinedVsNullModel(
      foo: foo ?? this.foo,
      bar: bar ?? this.bar,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    final val_foo = foo;
    final val_bar = bar;
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UndefinedVsNullModel &&
          runtimeType == other.runtimeType &&
          foo == other.foo &&
          bar == other.bar &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    foo,
    bar,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'UndefinedVsNullModel(foo: ${foo}, bar: ${bar}, additionalProperties: ${additionalProperties})';
}
