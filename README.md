# json_schema_gen

A JSON Schema code generator for Dart. It compiles JSON Schema files (`.schema.json`) into type-safe Dart models that parse streaming JSON directly using `package:jsontool`.

- Generates immutable final classes with `copyWith`, `operator ==`, `hashCode`, `toString`, and JSON serialization.
- Non-Recursive Parser: Avoids stack overflow exceptions on deeply nested JSON payloads.
(`oneOf` / `anyOf`), and `$ref` linking.
- Path-Tracking Error Handling: Collects precise JSON paths (e.g., `$.profile.avatarUrl`) on constraint validation and format exceptions.

## JSON Schema Draft Version & Feature Coverage

This package supports schemas conforming to **JSON Schema Draft 2020-12**.

### Supported Core Types
- `object` $\rightarrow$ compiles to Dart `final class`.
- `array` $\rightarrow$ compiles to Dart `List<T>`. Supports positional validation via `prefixItems` (compiles to `List<dynamic>` if types differ).
- `string` $\rightarrow$ compiles to Dart `String`.
- `integer` $\rightarrow$ compiles to Dart `int`.
- `number` $\rightarrow$ compiles to Dart `num`.
- `boolean` $\rightarrow$ compiles to Dart `bool`.
- `null` $\rightarrow$ compiles to Dart `Null`.
- `oneOf` / `anyOf` $\rightarrow$ compiles to Dart `sealed class` unions.
- `allOf` $\rightarrow$ merges subschemas into a single flattened Dart class.
- `enum` $\rightarrow$ compiles to Dart `enum`.
- `not` $\rightarrow$ supported. Inverts subschema validation. Fields with only `not` constraints fall back to `dynamic` typing.

### Supported Validation Constraints
- **Strings**: `minLength`, `maxLength`, `pattern`, `format` (supporting `date-time`, `date`, `time`, `email`, `ipv4`, `ipv6`, `hostname`, `uri`, `uri-reference`, `uuid`).
- **Numbers/Integers**: `minimum`, `maximum`, `exclusiveMinimum`, `exclusiveMaximum`, `multipleOf`.
- **Arrays**: `minItems`, `maxItems`, `uniqueItems`, `contains`, `minContains`, `maxContains`.
- **Objects**: `required`, `minProperties`, `maxProperties`, `dependentRequired`, `additionalProperties`, `patternProperties`.
- **Defaults**: Supports `default` values in constructors and fallback values during parsing.

### Custom Specification Extensions
We support some custom annotations to customize the generated Dart code:
- **`x-dart-name`**: Overrides the name of the generated Dart class or enum. Useful for naming nested objects or inline schemas that would otherwise receive automatic names (e.g. `ParentClass_PropertyName`).
- **`x-deprecated-message`**: Generates a Dart `@Deprecated('message')` annotation with the specified warning text. It can be applied to fields (properties), classes, or enums. If the standard `deprecated: true` is used without this extension, the standard `@deprecated` annotation (without message) is generated.

### Missing/Unsupported JSON Schema Features
- Non-discriminator object unions (overlapping schemas without explicit discriminator properties require distinct primitive types or simple structure speculative checks).

### The `not` Keyword & Typing Caveats

The `not` keyword inverts the validation logic of a subschema.
- If a property only has a `not` constraint (without an explicit `type` keyword), the generator cannot infer a specific Dart type and will fall back to `dynamic`.
- If the `not` subschema negates the parent schema's type (e.g. `{ "type": "string", "not": { "type": "string" } }`), validation will always fail at runtime. The generator will emit a warning during code generation for such cases.

---

## Mapping JSON Schema to Dart

This section details how various JSON Schema features map to the generated Dart code.

### Objects
JSON Schema `object` types map to Dart `final class` definitions.
*   **Properties**: Each defined property maps to a final field in the Dart class.
*   **Nullability**: A field is non-nullable if it is listed in the schema's `required` array. Otherwise, it is nullable (e.g., `String?`).
*   **Constructors and Defaults**: Generated classes have a const constructor. Schema `default` values are used as default values in the Dart constructor if they are constant.
*   **Additional Properties**:
    *   If `"additionalProperties": false` is specified, no additional fields are generated, and the parser will throw an exception if it encounters any extra properties.
    *   If `"additionalProperties"` has a schema (e.g., `{"type": "string"}`), it maps to a `final Map<String, T> additionalProperties;` field, where `T` is the mapped Dart type.
    *   If not specified (defaults to `true`), additional properties are ignored during parsing and not stored.
*   **Pattern Properties**: Map to a `final Map<String, dynamic> patternProperties;` field if defined in the schema.

### Arrays
JSON Schema `array` types map to Dart `List<T>`.
*   **Items**: The type `T` is determined by the `items` schema.
*   **Prefix Items (Tuples)**: If `prefixItems` is used, the list element type `T` is determined by finding a common type among all prefix items and the base item schema. If the types differ, it falls back to `List<dynamic>`.

### Primitives
JSON Schema primitive types map to standard Dart types:
*   `string` $\rightarrow$ `String`
*   `integer` $\rightarrow$ `int`
*   `number` $\rightarrow$ `num`
*   `boolean` $\rightarrow$ `bool`
*   `null` $\rightarrow$ `Null`

### Unions (oneOf / anyOf)
Unions of different types map to a `sealed class` hierarchy.
*   **Sealed Class**: A base `sealed class ClassName implements JsonModel` is generated.
*   **Option Classes**: For each active subschema in the union, a `final class ClassNameOptionN extends ClassName` is generated, which wraps the actual value in a `value` field.
*   **Nullable Unions**: Simple unions with `null` (e.g., `["string", "null"]`) are optimized to nullable types (e.g., `String?`) instead of generating a sealed class hierarchy.
*   **Discriminators**: If a `discriminator` object is specified, the generator uses the defined `propertyName` and `mapping` to route JSON payloads to the subclass during parsing.

### AllOf
JSON Schema `allOf` subschemas are merged and flattened into a single Dart class during parsing. If the subschemas are incompatible, the generator may fail or fall back to `dynamic`.

### Not
The `not` keyword inverts validation logic.
*   **Type Fallback**: If a schema only contains `not` constraints without an explicit `type`, the generator cannot infer a type and falls back to `dynamic`.
*   **Validation**: The generator produces code that attempts to validate the value against the negated schema; if it succeeds, validation fails.

### Validation Constraints
Validation constraints (like `minLength`, `minimum`, `uniqueItems`, etc.) are validated at runtime.
*   **Generated Classes**: The `validate()` method in generated classes performs these checks on the field values.
*   **Nested Validation**: The `validate()` method recursively calls `validate()` on nested objects and list items that implement `JsonModel`.
*   **Manual Validation**: You can also validate raw Dart maps/lists against a parsed schema using `SchemaValidationExtension.validate(value)`.

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

## Dynamic Runtime Validation (Without Code Generation)

You can also use this package at runtime to dynamically parse a JSON Schema and validate JSON payloads against it, without generating Dart classes.

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

For more advanced use cases (like resolving external references), you can use `SchemaParser` directly and provide a custom `uriResolver`:

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

This generator is tested against the official [JSON Schema Test Suite](https://github.com/json-schema-org/JSON-Schema-Test-Suite) for Draft 2020-12 to ensure compliance with the specification.

## Implementation Details

- **Stack-Overflow Safety**: The parser uses a non-recursive, frame-based state machine, allowing it to safely parse deeply nested JSON documents that would cause stack overflow errors in standard recursive parsers.
