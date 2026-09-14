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

export 'src/descriptors.dart'
    show
        AnythingDescriptor,
        ArrayDescriptor,
        BoolDescriptor,
        EnumDescriptor,
        IntDescriptor,
        NeverDescriptor,
        NotDescriptor,
        NullableDescriptor,
        NumDescriptor,
        NullDescriptor,
        ObjectDescriptor,
        PrimitiveDescriptor,
        PropertyDescriptor,
        RefDescriptor,
        SchemaDescriptor,
        StringDescriptor,
        UnionDescriptor,
        UnionOptionDescriptor;
export 'src/generator.dart' show DartImportResolver, generateCode;
export 'src/parser.dart' show SchemaParser, ioFileResolver;
export 'src/schema.dart'
    show Discriminator, Schema, SchemaHelpers, UnionAnalysis;
export 'src/validator.dart'
    show
        JsonModel,
        JsonParseException,
        JsonValidationException,
        SchemaValidationExtension,
        ValidationError,
        createErrorCollector,
        createValidator,
        isValidDuration,
        isValidHostname,
        isValidIPv6,
        isValidIdnEmail,
        isValidIdnHostname,
        isValidIri,
        isValidIriReference,
        isValidJsonPointer,
        isValidRelativeJsonPointer,
        isValidTime,
        isValidUri,
        isValidUriReference,
        isValidUriTemplate,
        parseWithDescriptor,
        readAny,
        wrapException,
        writeAny,
        writeWithDescriptor;
