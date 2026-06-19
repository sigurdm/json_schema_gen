# json_schema_gen

A JSON Schema code generator for Dart. It compiles JSON Schema files (`.schema.json`) into type-safe Dart models that parse streaming JSON directly using `package:jsontool`.

- Generates immutable final classes with `copyWith`, `operator ==`, `hashCode`, `toString`, and JSON serialization.
- Non-recursive parser avoids stack overflow exceptions on deeply nested JSON.
- Supports polymorphic types (`oneOf` / `anyOf`) and `$ref` resolution.
- Detailed error path-tracking (e.g., `$.profile.avatarUrl`) for validation failures.

## JSON Schema Draft Version & Feature Coverage

This package supports schemas conforming to **JSON Schema Draft 2020-12**.

### Supported Core Types
- `object` maps to a Dart `final class`.
- `array` maps to a Dart `List<T>`. Supports positional validation via `prefixItems` (compiles to `List<dynamic>` if types differ).
- `string` maps to a Dart `String`.
- `integer` maps to a Dart `int`.
- `number` maps to a Dart `num`.
- `boolean` maps to a Dart `bool`.
- `null` maps to a Dart `Null`.
- `oneOf` / `anyOf` map to Dart `sealed class` unions.
- `allOf` merges subschemas into a single flattened Dart class.
- `enum` maps to a Dart `enum`.
- `not` is supported. Inverts subschema validation. Fields with only `not` constraints fall back to `dynamic` typing.

### Supported Validation Constraints
- **Strings**: `minLength`, `maxLength`, `pattern`, `format` (supporting `date-time`, `date`, `time`, `email`, `ipv4`, `ipv6`, `hostname`, `uri`, `uri-reference`, `uuid`).
- **Numbers/Integers**: `minimum`, `maximum`, `exclusiveMinimum`, `exclusiveMaximum`, `multipleOf`.
- **Arrays**: `minItems`, `maxItems`, `uniqueItems`, `contains`, `minContains`, `maxContains`.
- **Objects**: `required`, `minProperties`, `maxProperties`, `dependentRequired`, `additionalProperties`, `patternProperties`.
- **Defaults**: `default` values are used in constructors and as fallbacks during parsing.

### Custom Extensions
The generator supports custom annotations to configure the generated Dart code:
- **`x-dart-name`**: Overrides the name of the generated Dart class or enum. Useful for naming nested objects or inline schemas that would otherwise receive automatic names (e.g. `ParentClass_PropertyName`).
- **`x-deprecated-message`**: Generates a Dart `@Deprecated('message')` annotation with the specified warning text. It can be applied to fields (properties), classes, or enums. If the standard `deprecated: true` is used without this extension, the standard `@deprecated` annotation (without message) is generated.

### Limitations
- **Non-discriminator object unions**: Unions of objects without an explicit discriminator are only supported if they can be distinguished by primitive types or unique structural differences.

### The `not` Keyword and Typing
The `not` keyword inverts validation logic.
- If a property only has a `not` constraint (without an explicit `type`), the generator cannot infer a Dart type and falls back to `dynamic`.
- If a `not` subschema negates the parent schema's type (e.g., `{ "type": "string", "not": { "type": "string" } }`), validation will always fail at runtime. The generator emits a warning for these cases.

### Floating-Point Precision (`multipleOf`)
Validation of `multipleOf` on fractional numbers is subject to IEEE 754 double-precision limitations.
Because binary floating-point cannot exactly represent all decimal fractions (e.g., `19.9`), the validator uses a relative tolerance of `1e-14` to determine if a value is a multiple.

---

## Mapping JSON Schema to Dart

### Objects
JSON Schema `object` maps to a Dart `final class`.
*   **Properties**: Each schema property maps to a `final` field.
*   **Nullability**: Fields are non-nullable if listed in the schema's `required` array. Otherwise, they are nullable (e.g., `String?`).
*   **Constructors and Defaults**: Classes have a `const` constructor. Constant schema `default` values are used as constructor defaults.
*   **Additional Properties**:
    *   If `"additionalProperties": false`, the parser throws an exception on extra properties.
    *   If `"additionalProperties"` has a schema (e.g., `{"type": "string"}`), it maps to a `final Map<String, T> additionalProperties` field.
    *   If not specified (defaults to `true`), additional properties are ignored.
*   **Pattern Properties**: Map to a `final Map<String, dynamic> patternProperties` field.

### Arrays
JSON Schema `array` maps to Dart `List<T>`.
*   **Items**: The type `T` is derived from the `items` schema.
*   **Prefix Items (Tuples)**: If `prefixItems` is used, the element type `T` is the common supertype of all prefix items and the base item schema. If they differ, it falls back to `dynamic`.

### Primitives
*   `string` -> `String`
*   `integer` -> `int`
*   `number` -> `num`
*   `boolean` -> `bool`
*   `null` -> `Null`

### Unions (`oneOf` / `anyOf`)
Unions of different types map to a `sealed class` hierarchy.
*   **Base Class**: A `sealed class ClassName implements JsonModel` is generated.
*   **Member Classes**: For each subschema, a `final class ClassNameOptionN extends ClassName` is generated, wrapping the value in a `value` field.
*   **Nullable Unions**: Simple unions with `null` (e.g., `["string", "null"]`) are optimized to nullable types (e.g., `String?`) instead of a class hierarchy.
*   **Discriminators**: If a `discriminator` is specified, the generator uses it to route JSON payloads to the correct subclass.

### `allOf`
Subschemas in `allOf` are merged and flattened into a single Dart class. If the subschemas are incompatible, the generator may fail or fall back to `dynamic`.

### `not`
Inverts validation logic.
*   **Type Fallback**: If a schema only contains `not` constraints, the field type falls back to `dynamic`.
*   **Validation**: Validation fails if the value matches the negated schema.

### Validation Constraints
Constraints (e.g., `minLength`, `minimum`) are checked at runtime.
*   **`validate()` Method**: Generated classes include a `validate()` method to check field values.
*   **Propagation**: `validate()` recursively validates nested objects and lists.
*   **Manual Validation**: Raw Dart data can be validated using `SchemaValidationExtension.validate(value)`.

---

## Setup & Code Generation

Add `json_schema_gen` and `build_runner` to your `pubspec.yaml`:

```yaml
dependencies:
  jsontool: ^2.1.0
  json_schema_gen:
    path: path/to/json_schema_gen # Or pub package when published

dev_dependencies:
  build_runner: ^2.4.0
```

### 1. Define your Schema
Create a JSON schema file ending in `.schema.json` (e.g. `lib/user.schema.json`):

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "User",
  "type": "object",
  "properties": {
    "id": { "type": "integer" },
    "name": { "type": "string", "minLength": 2 },
    "role": {
      "type": "string",
      "enum": ["admin", "user"]
    }
  },
  "required": ["id", "name", "role"]
}
```

### 2. Configure target files (Optional)
Configure your `build.yaml` to specify target directories for schemas:

```yaml
targets:
  $default:
    builders:
      json_schema_gen|json_schema_gen:
        generate_for:
          - lib/*.schema.json
```

### 3. Run the generator
Run the build runner to compile your schemas into Dart libraries:

```bash
dart run build_runner build --delete-conflicting-outputs
```

This generates a standalone `lib/user.g.dart` file containing all parsing frames, enum types, and model classes.

---

## Usage Example

```dart
import 'package:jsontool/jsontool.dart';
import 'package:json_schema_gen/json_schema.dart';
import 'user.g.dart'; // The generated code

void main() {
  final jsonPayload = '{"id": 42, "name": "John", "role": "admin"}';

  // 1. Parse from string using streaming JsonReader
  final user = User.fromJson(JsonReader.fromString(jsonPayload));
  print('Parsed user: ${user.name} (${user.role})');

  // 2. Serialize back to JSON string
  final jsonString = user.toJson();
  print('Serialized output: $jsonString');

  // 3. Exception Path Tracking
  final invalidPayload = '{"id": 42, "name": "S", "role": "admin"}'; // name minLength is 2
  try {
    User.fromJson(JsonReader.fromString(invalidPayload));
  } on JsonValidationException catch (e) {
    print('Validation error at path: ${e.path}'); // Output: [name]
    print('Error message: ${e.message}');         // Output: Property "name" length must be >= 2
  }
}
```

---

## Runtime Validation (Without Code Generation)

You can parse a schema and validate JSON payloads at runtime without generating code.

### Example

```dart
import 'dart:convert';
import 'package:json_schema_gen/json_schema.dart';

void main() async {
  final schemaJson = '''
  {
    "\$schema": "https://json-schema.org/draft/2020-12/schema",
    "title": "Product",
    "type": "object",
    "properties": {
      "id": { "type": "integer" },
      "price": { "type": "number", "minimum": 0 }
    },
    "required": ["id", "price"]
  }
  ''';

  final schemaMap = jsonDecode(schemaJson) as Map<String, dynamic>;

  // 1. Create a validator function
  final validator = await createValidator(schemaMap, validateFormats: true);

  // 2. Validate valid data (returns normally)
  final validProduct = {'id': 101, 'price': 12.99};
  validator(validProduct); 
  print('Product is valid!');

  // 3. Validate invalid data (throws JsonValidationException)
  final invalidProduct = {'id': 101, 'price': -5.00}; // price < 0
  try {
    validator(invalidProduct);
  } on JsonValidationException catch (e) {
    print('Validation failed at path: \${e.path}'); // Output: [price]
    print('Error: \${e.message}');                  // Output: Value must be >= 0
  }
}
```

For advanced use cases (like resolving external references), use `SchemaParser` with a custom `uriResolver`:

```dart
final parser = SchemaParser(
  schemaMap,
  uriResolver: (uri) async {
    // Load reference schema from file, network, etc.
    final file = File(uri.path);
    return file.readAsBytes();
  },
);
final schema = await parser.parse();
schema.validate(payload);
```

---

## Compliance & Testing

The generator is verified against the [JSON Schema Test Suite](https://github.com/json-schema-org/JSON-Schema-Test-Suite) for Draft 2020-12.

## Implementation Details

- **Stack Safety**: The parser uses a non-recursive, frame-based state machine. This avoids stack overflows when parsing deeply nested JSON.
