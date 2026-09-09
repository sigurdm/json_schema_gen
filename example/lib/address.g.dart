// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides, unnecessary_null_comparison

import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';

final class Address implements JsonModel {
  final String street;
  final String city;
  final String zipCode;
  final Map<String, Object?> additionalProperties;

  const Address({
    required this.street,
    required this.city,
    required this.zipCode,
    this.additionalProperties = const {},
  });

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
  }) => Address(
    street: street ?? this.street,
    city: city ?? this.city,
    zipCode: zipCode ?? this.zipCode,
    additionalProperties: additionalProperties ?? this.additionalProperties,
  );

  void validate() {
    if (!RegExp('^[0-9]{5}\$').hasMatch(zipCode)) {
      throw JsonValidationException(
        'Property "zipCode" must match pattern "^[0-9]{5}\$"',
        ['zipCode'],
      );
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
    ),
    getFields: (instance) {
      final typedInstance = instance as Address;
      return {
        'street': typedInstance.street,
        'city': typedInstance.city,
        'zipCode': typedInstance.zipCode,
        ...typedInstance.additionalProperties,
      };
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
