# Vendored JSON Schema Draft 2020-12 metaschema

These files are a verbatim copy of the official Draft 2020-12 metaschema
published at <https://json-schema.org/draft/2020-12/schema> and the vocabulary
schemas it references under `meta/`.

They are checked in because `tool/test_bootstrap_gen.dart` needs them to
regenerate `lib/src/generated/schema_202012.g.dart`, and
`test/json_schema_suite_test.dart` needs them to resolve
`https://json-schema.org/draft/2020-12/...` references. Neither the metaschema
nor the vocabulary schemas ship with the JSON-Schema-Test-Suite checkout under
`third_party/`, and that checkout is gitignored, so relying on it made both the
bootstrap tool and the conformance runner unusable on a fresh clone.

The only change from upstream is the `.json` file extension, which upstream
omits because the files are served by content negotiation.

Source: <https://github.com/json-schema-org/json-schema-spec>
