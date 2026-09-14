// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_local_variable, unnecessary_type_check, dead_code, non_constant_identifier_names, unnecessary_brace_in_string_interps, annotate_overrides, unnecessary_null_comparison
// ignore_for_file: prefer_is_empty, unnecessary_string_interpolations, avoid_init_to_null, unnecessary_const
// ignore_for_file: unnecessary_question_mark, unnecessary_cast

import 'package:collection/collection.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'package:jsontool/jsontool.dart';
import 'address.g.dart' as i1;

final class Order implements JsonModel {
  final String orderId;
  final num total;
  final i1.Address shippingAddress;
  final i1.Address? billingAddress;
  final Map<String, Object?> additionalProperties;

  const Order({
    required this.orderId,
    required this.total,
    required this.shippingAddress,
    this.billingAddress,
    this.additionalProperties = const {},
  });

  factory Order.fromJson(JsonReader reader, {bool validate = true}) =>
      parseWithDescriptor(reader, descriptor, validate: validate) as Order;

  /// Creates an instance of [Order] from a JSON Map.
  factory Order.fromMap(Map<String, dynamic> map, {bool validate = true}) =>
      Order.fromJson(JsonReader.fromObject(map), validate: validate);

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

  Order copyWith({
    String? orderId,
    num? total,
    i1.Address? shippingAddress,
    i1.Address? billingAddress,
    Map<String, Object?>? additionalProperties,
  }) => Order(
    orderId: orderId ?? this.orderId,
    total: total ?? this.total,
    shippingAddress: shippingAddress ?? this.shippingAddress,
    billingAddress: billingAddress ?? this.billingAddress,
    additionalProperties: additionalProperties ?? this.additionalProperties,
  );

  @override
  List<ValidationError> collectErrors() {
    final errors = <ValidationError>[];
    if (total < 0) {
      errors.add(
        ValidationError(
          message: 'Property "total" must be >= 0',
          path: ['total'],
          keyword: 'minimum',
        ),
      );
    }
    errors.addAll(
      (shippingAddress as JsonModel).collectErrors().map(
        (ValidationError e) => ValidationError(
          message: e.message,
          path: ['shippingAddress', ...e.path],
          keyword: e.keyword,
          schema: e.schema,
          value: e.value,
          nestedErrors: e.nestedErrors,
        ),
      ),
    );
    final val_billingAddress = billingAddress;
    if (val_billingAddress != null) {
      errors.addAll(
        (val_billingAddress as JsonModel).collectErrors().map(
          (ValidationError e) => ValidationError(
            message: e.message,
            path: ['billingAddress', ...e.path],
            keyword: e.keyword,
            schema: e.schema,
            value: e.value,
            nestedErrors: e.nestedErrors,
          ),
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

  static final ObjectDescriptor<Order> descriptor = ObjectDescriptor<Order>(
    title: 'Order',
    matches: (instance) => instance is Order,
    instantiate: (fields) => Order(
      orderId: fields['orderId'] as String,
      total: fields['total'] as num,
      shippingAddress: fields['shippingAddress'] as i1.Address,
      billingAddress: fields['billingAddress'] as i1.Address?,
      additionalProperties: fields.entries
          .where(
            (e) =>
                !const <String>{
                  'orderId',
                  'total',
                  'shippingAddress',
                  'billingAddress',
                }.contains(e.key) &&
                true,
          )
          .fold<Map<String, Object?>>(
            {},
            (m, e) => m..[e.key] = e.value as Object?,
          ),
    ),
    getFields: (instance) {
      final typedInstance = instance as Order;
      return {
        'orderId': typedInstance.orderId,
        'total': typedInstance.total,
        'shippingAddress': typedInstance.shippingAddress,
        'billingAddress': typedInstance.billingAddress,
        ...typedInstance.additionalProperties,
      };
    },
    properties: {
      'orderId': PropertyDescriptor(
        name: 'orderId',
        isRequired: true,
        schema: const StringDescriptor(),
      ),
      'total': PropertyDescriptor(
        name: 'total',
        isRequired: true,
        schema: const NumDescriptor(),
      ),
      'shippingAddress': PropertyDescriptor(
        name: 'shippingAddress',
        isRequired: true,
        schema: RefDescriptor<i1.Address>(() => i1.Address.descriptor),
      ),
      'billingAddress': PropertyDescriptor(
        name: 'billingAddress',
        isRequired: false,
        schema: RefDescriptor<i1.Address>(() => i1.Address.descriptor),
      ),
    },

    required: const ['orderId', 'total', 'shippingAddress'],
    additionalProperties: const AnythingDescriptor(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          orderId == other.orderId &&
          total == other.total &&
          shippingAddress == other.shippingAddress &&
          billingAddress == other.billingAddress &&
          const DeepCollectionEquality().equals(
            additionalProperties,
            other.additionalProperties,
          );

  @override
  int get hashCode => Object.hashAll([
    orderId,
    total,
    shippingAddress,
    billingAddress,
    const DeepCollectionEquality().hash(additionalProperties),
  ]);

  @override
  String toString() =>
      'Order(orderId: ${orderId}, total: ${total}, shippingAddress: ${shippingAddress}, billingAddress: ${billingAddress}, additionalProperties: ${additionalProperties})';
}
