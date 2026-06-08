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

### Supported Validation Constraints
- **Strings**: `minLength`, `maxLength`, `pattern`, `format` (supporting `date-time`, `date`, `time`, `email`, `ipv4`, `ipv6`, `hostname`, `uri`, `uri-reference`, `uuid`).
- **Numbers/Integers**: `minimum`, `maximum`, `exclusiveMinimum`, `exclusiveMaximum`, `multipleOf`.
- **Arrays**: `minItems`, `maxItems`, `uniqueItems`, `contains`, `minContains`, `maxContains`.
- **Objects**: `required`, `minProperties`, `maxProperties`, `dependentRequired`.
- **Defaults**: Supports `default` values in constructors and fallback values during parsing.

### Missing/Unsupported JSON Schema Features
- `not` and `patternProperties`.
- Non-discriminator object unions (overlapping schemas without explicit discriminator properties require distinct primitive types or simple structure speculative checks).

---

## Setup & Code Generation

Add `json_schema_gen` and `build_runner` to your `pubspec.yaml`:

```yaml
dependencies:
  jsontool: ^2.1.0

dev_dependencies:
  build_runner: ^2.4.0
  json_schema_gen:
    path: path/to/json_schema_gen # Or pub package when published
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
