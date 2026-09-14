// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides, unnecessary_null_comparison
// ignore_for_file: prefer_is_empty, unnecessary_string_interpolations, avoid_init_to_null, unnecessary_const
// ignore_for_file: unnecessary_question_mark, unnecessary_cast

import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';

final class UndefinedVsNullModel implements JsonModel {
  final String? foo;
  final int? bar;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

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
  Map<String, dynamic> toMap() => toJsonValue() as Map<String, dynamic>;

  static const Object _undefined = Object();

  UndefinedVsNullModel copyWith({
    Object? foo = _undefined,
    Object? bar = _undefined,
    Object? additionalProperties = _undefined,
  }) {
    final explicit = _$explicitKeys;
    final nextKeys = explicit != null ? Set<String>.from(explicit) : <String>{};
    if (!identical(foo, _undefined)) {
      nextKeys.add('foo');
    }
    if (!identical(bar, _undefined)) {
      nextKeys.add('bar');
    }
    if (!identical(additionalProperties, _undefined)) {
      nextKeys.add('additionalProperties');
    }

    return UndefinedVsNullModel(
      foo: !identical(foo, _undefined) ? foo as String? : this.foo,
      bar: !identical(bar, _undefined) ? bar as int? : this.bar,
      additionalProperties: !identical(additionalProperties, _undefined)
          ? additionalProperties as Map<String, Object?>
          : this.additionalProperties,
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

  static final ObjectDescriptor<UndefinedVsNullModel> descriptor =
      ObjectDescriptor<UndefinedVsNullModel>(
        title: 'UndefinedVsNullModel',
        matches: (instance) => instance is UndefinedVsNullModel,
        instantiate: (fields) => UndefinedVsNullModel(
          foo: fields['foo'] as String?,
          bar: fields['bar'] as int?,
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
          final typedInstance = instance as UndefinedVsNullModel;
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
