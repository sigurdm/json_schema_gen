// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides, unnecessary_null_comparison
// ignore_for_file: prefer_is_empty, unnecessary_string_interpolations, avoid_init_to_null, unnecessary_const
// ignore_for_file: unnecessary_question_mark, unnecessary_cast

import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';

final class Address implements JsonModel {
  final String street;
  final String city;
  final String zipCode;
  final Map<String, Object?> additionalProperties;
  final Set<String>? _$explicitKeys;

  const Address({
    required this.street,
    required this.city,
    required this.zipCode,
    this.additionalProperties = const {},
    Set<String>? explicitKeys,
  }) : _$explicitKeys = explicitKeys;

  factory Address.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as Address;

  /// Creates an instance of [Address] from a JSON Map.
  factory Address.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      Address.fromJson(JsonReader.fromObject(map), validate: validate);

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

  Address copyWith({
    String? street,
    String? city,
    String? zipCode,
    Map<String, Object?>? additionalProperties,
  }) {
    final nextKeys = _$explicitKeys != null
        ? Set<String>.from(_$explicitKeys)
        : null;
    if (street != null) {
      nextKeys?.add('street');
    }
    if (city != null) {
      nextKeys?.add('city');
    }
    if (zipCode != null) {
      nextKeys?.add('zipCode');
    }
    if (additionalProperties != null) {
      nextKeys?.add('additionalProperties');
    }

    return Address(
      street: street ?? this.street,
      city: city ?? this.city,
      zipCode: zipCode ?? this.zipCode,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      explicitKeys: nextKeys,
    );
  }

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (!RegExp('^[0-9]{5}\$').hasMatch(zipCode)) {
      errors.add(
        ValidationError(
          message: 'Property "zipCode" must match pattern "^[0-9]{5}\$"',
          path: ['zipCode'],
          keyword: 'pattern',
        ),
      );
    }
    return errors;
  }

  @override
  void validate() {
    final errors = collectErrors();
    if (errors.isNotEmpty) {
      throw JsonValidationException(errors);
    }
  }

  static final ObjectDescriptor<Address> descriptor = ObjectDescriptor<Address>(
    title: 'Address',
    matches: (instance) => instance is Address,
    instantiate: (fields) => Address(
      street: fields['street'] as String,
      city: fields['city'] as String,
      zipCode: fields['zipCode'] as String,
      additionalProperties: fields.entries
          .where(
            (e) =>
                !const <String>{'street', 'city', 'zipCode'}.contains(e.key) &&
                true,
          )
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
      explicitKeys: fields.keys.toSet(),
    ),
    getFields: (instance) {
      final typedInstance = instance as Address;
      final map = <String, dynamic>{
        'street': typedInstance.street,
        'city': typedInstance.city,
        'zipCode': typedInstance.zipCode,
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
      'street': PropertyDescriptor(
        name: 'street',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
      'city': PropertyDescriptor(
        name: 'city',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
      'zipCode': PropertyDescriptor(
        name: 'zipCode',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
    },

    required: const ['street', 'city', 'zipCode'],
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          runtimeType == other.runtimeType &&
          street == other.street &&
          city == other.city &&
          zipCode == other.zipCode &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    street,
    city,
    zipCode,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'Address(street: ${street}, city: ${city}, zipCode: ${zipCode}, additionalProperties: ${additionalProperties})';
}
