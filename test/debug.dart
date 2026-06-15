import 'package:json_schema_gen/json_schema.dart';

void main() async {
  final jsonSchema = {
    'definitions': {
      'A': {'type': 'string'},
    },
    r'$ref': '#/definitions/A',
  };
  final parser = SchemaParser(jsonSchema);
  try {
    final schema = await parser.parse();
    print('Success: $schema');
  } catch (e, stack) {
    print('Error: $e');
    print('Stack: $stack');
  }
}
