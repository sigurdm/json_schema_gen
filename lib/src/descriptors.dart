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

import 'package:jsontool/jsontool.dart';
import 'validator.dart';

/// Base class for all schema descriptors.
///
/// Descriptors define the structure of JSON data and how to map it to Dart types.
sealed class SchemaDescriptor<T> {
  /// Const constructor for subclass descriptors.
  const SchemaDescriptor();
}

/// Descriptor for object schemas.
final class ObjectDescriptor<T> extends SchemaDescriptor<T> {
  /// The title of the object schema.
  final String title;

  /// Function to instantiate the Dart object from parsed fields.
  final T Function(Map<String, dynamic> fields) instantiate;

  /// Map of property names to their descriptors.
  final Map<String, PropertyDescriptor> properties;

  /// Map of patterns to their descriptors.
  final Map<RegExp, SchemaDescriptor> patternProperties;

  /// List of required property names.
  final List<String> required;

  /// Descriptor for additional properties, if allowed.
  final SchemaDescriptor? additionalProperties;

  /// Function to extract fields from a Dart object instance.
  final Map<String, Object?> Function(dynamic instance) getFields;

  /// Function to check if a dynamic instance matches this descriptor's type.
  final bool Function(dynamic instance) matches;

  /// Creates an [ObjectDescriptor].
  const ObjectDescriptor({
    required this.title,
    required this.instantiate,
    required this.properties,
    this.patternProperties = const {},
    this.required = const [],
    this.additionalProperties,
    required this.getFields,
    required this.matches,
  });
}

/// Descriptor for a single property within an object.
final class PropertyDescriptor {
  /// The name of the property in JSON.
  final String name;

  /// The descriptor for the property's value.
  final SchemaDescriptor schema;

  /// Whether this property is required in the object.
  final bool isRequired;

  /// Creates a [PropertyDescriptor].
  const PropertyDescriptor({
    required this.name,
    required this.schema,
    this.isRequired = false,
  });
}

/// Base class for primitive type descriptors.
sealed class PrimitiveDescriptor<T> extends SchemaDescriptor<T> {
  /// Const constructor.
  const PrimitiveDescriptor();

  /// Reads a primitive value from [reader].
  T read(JsonReader reader);

  /// Writes a primitive [value] to [sink].
  void write(JsonSink sink, T value);
}

/// Descriptor for string values.
final class StringDescriptor extends PrimitiveDescriptor<String> {
  /// Const constructor.
  const StringDescriptor();

  @override
  String read(JsonReader reader) => reader.expectString();

  @override
  void write(JsonSink sink, String value) => sink.addString(value);
}

/// Descriptor for integer values.
final class IntDescriptor extends PrimitiveDescriptor<int> {
  /// Const constructor.
  const IntDescriptor();

  @override
  int read(JsonReader reader) => reader.expectInt();

  @override
  void write(JsonSink sink, int value) => sink.addNumber(value);
}

/// Descriptor for numeric values (double or int).
final class NumDescriptor extends PrimitiveDescriptor<num> {
  /// Const constructor.
  const NumDescriptor();

  @override
  num read(JsonReader reader) => reader.expectNum();

  @override
  void write(JsonSink sink, num value) => sink.addNumber(value);
}

/// Descriptor for boolean values.
final class BoolDescriptor extends PrimitiveDescriptor<bool> {
  /// Const constructor.
  const BoolDescriptor();

  @override
  bool read(JsonReader reader) => reader.expectBool();

  @override
  void write(JsonSink sink, bool value) => sink.addBool(value);
}

/// Descriptor for null values.
final class NullDescriptor extends PrimitiveDescriptor<Null> {
  /// Const constructor.
  const NullDescriptor();

  @override
  Null read(JsonReader reader) => reader.expectNull();

  @override
  void write(JsonSink sink, Null value) => sink.addNull();
}

/// Descriptor for any JSON value (fallback).
final class AnythingDescriptor extends SchemaDescriptor<dynamic> {
  /// Const constructor.
  const AnythingDescriptor();
}

/// Descriptor for schemas that never validate.
final class NeverDescriptor extends SchemaDescriptor<Never> {
  /// Const constructor.
  const NeverDescriptor();
}

/// Descriptor for nullable values wrapping an [inner] descriptor.
final class NullableDescriptor<T> extends SchemaDescriptor<T?> {
  /// The descriptor for the non-null value.
  final SchemaDescriptor<T> inner;

  /// Creates a [NullableDescriptor] wrapping [inner].
  const NullableDescriptor(this.inner);
}

/// Descriptor for array schemas.
final class ArrayDescriptor<T> extends SchemaDescriptor<List<T>> {
  /// Descriptor for items in the array.
  final SchemaDescriptor<T> items;

  /// Positional descriptors for tuple-like arrays.
  final List<SchemaDescriptor>? prefixItems;

  /// Creates an [ArrayDescriptor].
  const ArrayDescriptor(this.items, {this.prefixItems});

  /// Creates a parse frame for this array descriptor.
  JsonParseFrame createFrame({required bool validate}) =>
      ArrayFrame<T>(this, validate: validate);
}

/// Descriptor for enum schemas.
final class EnumDescriptor<T> extends SchemaDescriptor<T> {
  /// The allowed enum values.
  final List<T> values;

  /// Function to map backing value to enum constant.
  final T Function(dynamic val) fromValue;

  /// Function to map enum constant to backing value.
  final dynamic Function(dynamic val) toValue;

  /// The backing primitive descriptor.
  final PrimitiveDescriptor base;

  /// Creates an [EnumDescriptor].
  const EnumDescriptor({
    required this.values,
    required this.fromValue,
    required this.toValue,
    required this.base,
  });
}

/// Descriptor for an option within a union.
final class UnionOptionDescriptor<T, V> {
  /// The schema descriptor for this option.
  final SchemaDescriptor<V> schema;

  /// Function to wrap the parsed value into the union type.
  final T Function(V val) wrap;

  /// Creates a [UnionOptionDescriptor].
  const UnionOptionDescriptor(this.schema, this.wrap);
}

/// Descriptor for union schemas.
final class UnionDescriptor<T> extends SchemaDescriptor<T> {
  /// The title of the union schema.
  final String title;

  /// The property name used as discriminator, if specified.
  final String? discriminatorProperty;

  /// Optional mapping of discriminator values to option descriptors.
  final Map<String, UnionOptionDescriptor<T, dynamic>>? discriminatorMapping;

  /// List of active option descriptors in the union.
  final List<UnionOptionDescriptor<T, dynamic>> activeOptions;

  /// Creates a [UnionDescriptor].
  const UnionDescriptor({
    required this.title,
    this.discriminatorProperty,
    this.discriminatorMapping,
    required this.activeOptions,
  });
}
