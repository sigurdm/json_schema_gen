# json_schema_gen

A JSON Schema code generator and runtime validator for Dart. It compiles JSON Schema files (`.schema.json`) into type-safe Dart models that parse streaming JSON directly using `package:jsontool` or in-memory maps using `fromMap()` and `toMap()`.

- Generates immutable final classes with `copyWith`, `operator ==`, `hashCode`, `toString`, and JSON serialization.
- Non-recursive streaming parser avoids stack overflow exceptions on deeply nested JSON.
- In-memory `fromMap()` and `toMap()` methods for seamless integration with `dart:convert`, HTTP clients, and database drivers.
- Supports polymorphic types (`oneOf` / `anyOf`), discriminators, and modular cross-file `$ref` resolution.
- Comprehensive multi-error accumulation across fields, arrays, and nested models.
- 100% conformance to JSON Schema Draft 2020-12 across all 1,299 core tests.

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
- **Objects**: `required`, `minProperties`, `maxProperties`, `dependentRequired`, `additionalProperties`, `patternProperties`, `unevaluatedProperties`.
- **Defaults**: `default` values are used in constructors and as fallbacks during parsing.

### Custom Extensions
The generator supports custom annotations to configure the generated Dart code:
- **`x-dart-name`**: Overrides the name of the generated Dart class or enum. Useful for naming nested objects or inline schemas that would otherwise receive automatic names (e.g. `ParentClass_PropertyName`).
- **`x-deprecated-message`**: Generates a Dart `@Deprecated('message')` annotation with the specified warning text. It can be applied to fields (properties), classes, or enums. If the standard `deprecated: true` is used without this extension, the standard `@deprecated` annotation (without message) is generated.
- **`x-dart-inline`**: When set to `true` on a schema definition or at a `$ref` call site, forces the generator to inline the referenced schema directly into the consumer file (the legacy behavior) rather than generating an `import` to an external library.

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
*   **`collectErrors()` Method**: Generated classes include `collectErrors()` to gather all validation errors without throwing.
*   **`validate()` Method**: Generated classes include a `validate()` method throwing `JsonValidationException` with all accumulated errors.
*   **Propagation**: `validate()` and `collectErrors()` recursively inspect nested objects and lists.
*   **Manual Validation**: Raw Dart data can be validated using `schema.validate(value)` or `schema.collectErrors(value)`.

### Modular Schemas & Cross-File References (`$ref`)
When schemas reference definitions across files within the same package or across packages:
*   **Automatic Library Imports**: The generator emits prefixed Dart imports (e.g. `import 'address.g.dart' as i1;`) and reuses external types (`i1.Address`) and descriptors (`i1.Address.descriptor`) instead of duplicating code into every output file.
*   **Shared Type Compatibility**: Instances of shared components can be passed seamlessly between different root models (e.g. sharing an `Address` instance across both `User` and `Order`).
*   **Standalone Definition Libraries**: Schema files containing only `$defs` or `definitions` without root properties generate standalone Dart libraries declaring all components.
*   **Unmapped Remote References**: External references pointing to unmapped `http:` or `https:` URIs automatically fall back to inlining.
*   **Inlining Overrides**: Use `"x-dart-inline": true` on a schema or at a `$ref` call site to force inlining an external schema locally.

---

## Setup & Code Generation

Add `json_schema_gen` and `build_runner` to your `pubspec.yaml`:

```yaml
dependencies:
  jsontool: ^2.1.0
  json_schema_gen: ^0.1.0

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
    "id": { "type": "integer", "minimum": 1 },
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

### 3. Run the generator via build_runner
Run the build runner to compile your schemas into Dart libraries:

```bash
dart run build_runner build --delete-conflicting-outputs
```

This generates a standalone `lib/user.g.dart` file containing all parsing frames, enum types, and model classes.

### Standalone CLI Generator

In addition to `build_runner`, you can compile schemas directly using the standalone CLI tool:

```bash
# Run directly via dart run
dart run json_schema_gen -i path/to/schema.schema.json

# Specify an explicit output file and root class name
dart run json_schema_gen -i path/to/schema.schema.json -o lib/models/user.g.dart -r User

# Output generated code directly to stdout
dart run json_schema_gen -i path/to/schema.schema.json -o -
```

#### CLI Options

| Option | Shorthand | Description | Default |
| --- | --- | --- | --- |
| `--input` | `-i` | Path to the input JSON Schema file (**required**). | — |
| `--output` | `-o` | Output `.dart` file path, or `-` for standard output. | `<schema_dir>/<schema_name>.g.dart` |
| `--root-name` | `-r` | Name for the root Dart class. | Schema `title`, `x-dart-name`, or PascalCase basename |
| `--[no-]format` | | Format generated Dart code with `dart_style`. | `true` |
| `--help` | `-h` | Display usage instructions and option list. | — |

#### Exit Codes

The CLI conforms to standard Sysexits conventions:
- `0`: Success
- `64` (`EX_USAGE`): Invalid argument syntax or missing required `--input`
- `65` (`EX_DATAERR`): Invalid JSON or schema parsing failure
- `66` (`EX_NOINPUT`): Input file not found
- `70` (`EX_SOFTWARE`): Unhandled code generation error

---

## Usage Example

Generated models support both zero-copy streaming JSON parsing via `JsonReader` and convenient in-memory Dart `Map<String, dynamic>` conversion (`fromMap`/`toMap`).

```dart
import "dart:convert";
import "package:jsontool/jsontool.dart";
import "package:json_schema_gen/json_schema.dart";
import "user.g.dart"; // The generated code

void main() {
  final jsonPayload = '{"id": 42, "name": "John", "role": "admin"}';

  // --- Option A: Streaming JSON (Zero-copy, Fast path) ---
  // Ideal for network I/O, files, or large payloads
  final userFromStream = User.fromJson(JsonReader.fromString(jsonPayload));
  print('Parsed user: ${userFromStream.name} (${userFromStream.role})');

  // Serialize back to JSON string:
  final jsonString = userFromStream.toJson();
  print('Serialized output: $jsonString');

  // --- Option B: In-Memory Map (fromMap / toMap) ---
  // Ideal for jsonDecode(), HTTP clients, and database interop
  final map = jsonDecode(jsonPayload) as Map<String, dynamic>;
  final userFromMap = User.fromMap(map);

  // Convert model back to a Map:
  final Map<String, dynamic> outputMap = userFromMap.toMap();
  print('Map output: $outputMap');
}
```

Both `fromJson` and `fromMap` accept `validate: false` if you wish to skip validation during instantiation.

### Validation & Error Accumulation

Unlike traditional validators that stop at the first failure, `json_schema_gen` collects all validation errors across multiple fields and nested objects in a single pass.

#### Non-Throwing Error Collection (`collectErrors()`)

Use `model.collectErrors()` to retrieve all validation errors without throwing an exception:

```dart
final user = User(
  id: -1, // minimum violation: must be >= 1
  name: "A", // minLength violation: must be >= 2
  role: UserRole.admin,
);

// Collect all errors across all fields in a single pass
final List<ValidationError> errors = user.collectErrors();

for (final error in errors) {
  print("Field: ${error.jsonPath}"); // e.g. $.id, $.name
  print("Pointer: ${error.instancePath}"); // e.g. /id, /name
  print("Keyword: ${error.keyword}"); // e.g. minimum, minLength
  print("Message: ${error.message}"); // e.g. Value must be >= 1
  print("Value: ${error.value}"); // e.g. -1
}
```

#### Exception-Based Validation (`validate()`)

Call `model.validate()` to perform validation and throw a `JsonValidationException` containing all accumulated errors:

```dart
try {
  user.validate();
} on JsonValidationException catch (e) {
  print("${e.errors.length} validation errors occurred:");
  for (final err in e.errors) {
    print("  - ${err.jsonPath}: ${err.message}");
  }

  // e.toString() prints a formatted multi-line summary:
  print(e);
}
```

#### `ValidationError` Properties

Each `ValidationError` provides rich contextual metadata about the failure:

| Property | Type | Description | Example |
| --- | --- | --- | --- |
| `path` | `List<String>` | Segments leading to the failing element. | `['users', '0', 'name']` |
| `jsonPath` | `String` | Dot-separated JSONPath string. | `$.users.0.name` |
| `instancePath` | `String` | RFC 6901 JSON Pointer (`~0` and `~1` escaped). | `/users/0/name` |
| `keyword` | `String?` | The schema constraint keyword that failed. | `minLength`, `minimum`, `pattern` |
| `value` | `dynamic` | The invalid runtime value. | `"A"` |
| `message` | `String` | Human-readable error description. | `Property "name" length must be >= 2` |
| `nestedErrors` | `List<ValidationError>` | Sub-errors for combinators such as `anyOf` or `oneOf`. | `[...]` |

---

## Runtime Validation (Without Code Generation)

You can parse a schema and validate JSON payloads dynamically at runtime without generating code.

### Example

```dart
import "dart:convert";
import "package:json_schema_gen/json_schema.dart";

void main() async {
  final schemaJson = r'''
  {
    "$schema": "https://json-schema.org/draft/2020-12/schema",
    "title": "Product",
    "type": "object",
    "properties": {
      "id": { "type": "integer", "minimum": 1 },
      "price": { "type": "number", "minimum": 0 }
    },
    "required": ["id", "price"]
  }
  ''';

  final schemaMap = jsonDecode(schemaJson) as Map<String, dynamic>;
  final parser = SchemaParser(schemaMap);
  final schema = await parser.parse();

  final invalidPayload = {
    "id": 0, // minimum violation: 0 < 1
    "price": -5.0, // minimum violation: -5.0 < 0
  };

  // 1. Non-throwing error collection (returns List<ValidationError>):
  final errors = schema.collectErrors(invalidPayload);
  print("Collected ${errors.length} validation errors:");
  for (final err in errors) {
    print("  ${err.instancePath} (${err.keyword}): ${err.message}");
  }

  // 2. Exception-based validation (accumulates all errors by default):
  try {
    schema.validate(invalidPayload); // failFast defaults to false
  } on JsonValidationException catch (e) {
    print("Validation failed with ${e.errors.length} errors:\n$e");
  }

  // 3. Fast-fail validation (stops immediately at the first error):
  try {
    schema.validate(invalidPayload, failFast: true);
  } on JsonValidationException catch (e) {
    print("First error: ${e.errors.first.message}");
  }
}
```

### Reusable Validator Functions

Create reusable validator functions for repeated checks:

```dart
// Error collector function (returns List<ValidationError> without throwing):
final collector = await createErrorCollector(schemaMap);
final errors = collector(invalidPayload);

// Throwing validator function:
final validator = await createValidator(
  schemaMap,
  validateFormats: true,
  failFast: false, // Default is false (accumulates all errors)
);
validator(validProduct);
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

### Programmatic Code Generation

You can also generate Dart code programmatically without `build_runner` using `generateCode`. Use `dartImportResolver` to specify how external schema URIs map to Dart library import paths:

```dart
final code = generateCode(
  rootSchema,
  "Order",
  dartImportResolver: (Uri uri) {
    if (uri.path.endsWith("address.schema.json")) {
      return "address.g.dart";
    }
    // Return null to fall back to inlining for this reference.
    return null;
  },
);
```

---

## Compliance & Testing

The generator and runtime validator are verified against the official [JSON Schema Test Suite](https://github.com/json-schema-org/JSON-Schema-Test-Suite) for Draft 2020-12, passing all 1,299 tests.

## Implementation Details

- **Stack Safety**: The parser uses a non-recursive, frame-based state machine. This avoids stack overflows when parsing deeply nested JSON.

## Disclaimer

This is not an official Google product.
