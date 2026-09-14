# Changelog

## 0.1.0

Initial release of `json_schema_gen`, a comprehensive JSON Schema (Draft 2020-12) code generator and runtime validator for Dart.

### Features

- **Type-Safe Dart Model Generation**:
  - Compiles JSON schemas into immutable Dart `final class` models with `copyWith`, `operator ==`, `hashCode`, `toString`, and JSON serialization.
  - Generates `sealed class` hierarchies for polymorphic `oneOf` and `anyOf` unions.
  - Native support for discriminators (`discriminator.propertyName`) for fast union routing.
  - Strongly-typed enum generation with JSON value mapping.
  - Positional tuple parsing for `prefixItems`.
  - Merges and flattens `allOf` schemas into unified Dart models.

- **Dual Parsing Pipelines (Streaming & In-Memory)**:
  - **Stack-Safe Streaming JSON Parser**: Zero-copy, non-recursive frame-based state machine using `package:jsontool`, completely immune to call-stack overflow on deeply nested payloads.
  - **In-Memory Map Support**: High-convenience `fromMap` and `toMap` methods on every generated model for interop with `dart:convert`, HTTP clients, and database drivers.

- **100% JSON Schema Draft 2020-12 Conformance**:
  - Passes all 1,299 core tests in the official [JSON-Schema-Test-Suite](https://github.com/json-schema-org/JSON-Schema-Test-Suite) for Draft 2020-12.
  - Full keyword support: `unevaluatedProperties`, `unevaluatedItems`, `patternProperties`, `dependentRequired`, `dependentSchemas`, `contains`, `minContains`, `maxContains`, `propertyNames`, `not`, `if`/`then`/`else`, and format validations.
  - Dynamic scoping and recursion support via `$dynamicAnchor` and `$dynamicRef`.

- **Comprehensive Validation Error Accumulation**:
  - Multi-error accumulation across fields, array items, and nested objects in a single pass.
  - Non-throwing error collection via `model.collectErrors()` and `schema.collectErrors(value)`.
  - Multi-error `model.validate()` and `schema.validate(value, failFast: false)` throwing `JsonValidationException` with full list of errors.
  - Detailed `ValidationError` metadata including `path` segments, dot-notation `jsonPath` (`$.profile.email`), RFC 6901 JSON Pointer `instancePath` (`/profile/email`), failing `keyword`, and offending `value`.

- **Modular Cross-File `$ref` Resolution**:
  - Seamlessly resolves multi-file schema architectures across packages and relative paths.
  - Emits prefixed Dart imports and preserves shared nominal types across generated files.
  - Supports standalone definition-only schema files (`$defs`/`definitions`).
  - Custom schema annotations: `x-dart-name`, `x-deprecated-message`, and `x-dart-inline`.

- **Standalone CLI Generator**:
  - Command-line tool executable via `dart run json_schema_gen`.
  - Configurable input/output paths, root class names, stdout generation (`-o -`), and code formatting.
  - Standard Sysexits exit codes for CI/CD scripting.
