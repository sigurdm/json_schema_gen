import 'package:jsontool/jsontool.dart';
import 'address.g.dart';
import 'order.g.dart';

void main() {
  final orderJson = '''
  {
    "orderId": "ORD-12345",
    "total": 99.99,
    "shippingAddress": {
      "street": "123 Market St",
      "city": "San Francisco",
      "zipCode": "94105"
    },
    "billingAddress": {
      "street": "456 Mission St",
      "city": "San Francisco",
      "zipCode": "94103"
    }
  }
  ''';

  print('--- Parsing Modular Schema Models ---');
  final order = Order.fromJson(JsonReader.fromString(orderJson));
  print('Parsed Order:');
  print('  Order ID: ${order.orderId}');
  print('  Total: \$${order.total}');
  print(
    '  Shipping: ${order.shippingAddress.street}, ${order.shippingAddress.city}',
  );
  print(
    '  Billing: ${order.billingAddress?.street}, ${order.billingAddress?.city}',
  );

  print('\n--- Sharing an Address instance ---');
  const newShipping = Address(
    street: '789 Broadway',
    city: 'Oakland',
    zipCode: '94607',
  );
  final updatedOrder = order.copyWith(shippingAddress: newShipping);
  print(
    'Updated Shipping: ${updatedOrder.shippingAddress.street}, ${updatedOrder.shippingAddress.city}',
  );
  print('Serialized: ${updatedOrder.toJson()}');
}
