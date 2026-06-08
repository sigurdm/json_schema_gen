import 'package:jsontool/jsontool.dart';
import 'user.g.dart';

// --- Descriptor Definition ---

class PropDesc {
  final String key;
  final bool isRequired;
  final Object? Function(JsonReader reader) read;
  final void Function(JsonSink sink, Object? val) write;

  PropDesc({
    required this.key,
    required this.isRequired,
    required this.read,
    required this.write,
  });
}

class ClassDesc<T> {
  final T Function(Map<String, dynamic> map) instantiate;
  final Map<String, PropDesc> properties;

  ClassDesc({required this.instantiate, required this.properties});
}

// --- Descriptors for User & UserProfile ---

final profileDesc = ClassDesc<UserProfile>(
  instantiate: (map) => UserProfile(
    avatarUrl: map['avatarUrl'] as String?,
    bio: map['bio'] as String?,
  ),
  properties: {
    'avatarUrl': PropDesc(
      key: 'avatarUrl',
      isRequired: false,
      read: (r) => r.expectString(),
      write: (s, v) => s.addString(v as String),
    ),
    'bio': PropDesc(
      key: 'bio',
      isRequired: false,
      read: (r) => r.expectString(),
      write: (s, v) => s.addString(v as String),
    ),
  },
);

final userDesc = ClassDesc<User>(
  instantiate: (map) => User(
    id: map['id'] as int,
    name: map['name'] as String,
    email: map['email'] as String,
    role: map['role'] as UserRole,
    profile: map['profile'] as UserProfile?,
  ),
  properties: {
    'id': PropDesc(
      key: 'id',
      isRequired: true,
      read: (r) => r.expectInt(),
      write: (s, v) => s.addNumber(v as num),
    ),
    'name': PropDesc(
      key: 'name',
      isRequired: true,
      read: (r) => r.expectString(),
      write: (s, v) => s.addString(v as String),
    ),
    'email': PropDesc(
      key: 'email',
      isRequired: true,
      read: (r) => r.expectString(),
      write: (s, v) => s.addString(v as String),
    ),
    'role': PropDesc(
      key: 'role',
      isRequired: true,
      read: (r) => UserRole.fromValue(r.expectString()),
      write: (s, v) => s.addString((v as UserRole).value),
    ),
    'profile': PropDesc(
      key: 'profile',
      isRequired: false,
      read: (r) => parseGeneric(r, profileDesc),
      write: (s, v) => serializeGeneric(s, v as UserProfile, profileDesc),
    ),
  },
);

// --- Generic Descriptor-Based Deserializer ---

T parseGeneric<T>(JsonReader reader, ClassDesc<T> desc) {
  reader.expectObject();
  final map = <String, dynamic>{};
  while (reader.hasNextKey()) {
    final key = reader.nextKey();
    final prop = desc.properties[key];
    if (prop != null) {
      map[key!] = prop.read(reader);
    } else {
      reader.skipAnyValue();
    }
  }
  // Check required
  for (final prop in desc.properties.values) {
    if (prop.isRequired && !map.containsKey(prop.key)) {
      throw FormatException('Missing required property: ${prop.key}');
    }
  }
  return desc.instantiate(map);
}

// --- Generic Descriptor-Based Serializer ---

void serializeGeneric<T>(JsonSink sink, T instance, ClassDesc<T> desc) {
  sink.startObject();
  final fields = <String, Object?>{};
  if (instance is User) {
    fields['id'] = instance.id;
    fields['name'] = instance.name;
    fields['email'] = instance.email;
    fields['role'] = instance.role;
    fields['profile'] = instance.profile;
  } else if (instance is UserProfile) {
    fields['avatarUrl'] = instance.avatarUrl;
    fields['bio'] = instance.bio;
  }
  desc.properties.forEach((key, prop) {
    final val = fields[key];
    if (val != null) {
      sink.addKey(key);
      prop.write(sink, val);
    }
  });
  sink.endObject();
}

// --- Benchmark Runner ---

void main() {
  const jsonPayload = '''
  {
    "id": 42,
    "name": "John Doe",
    "email": "john.doe@google.com",
    "role": "admin",
    "profile": {
      "avatarUrl": "https://example.com/avatar.png",
      "bio": "Software Engineer working on Dart toolchains"
    }
  }
  ''';

  const iterations = 100000;

  print('Running Deserialization Benchmark ($iterations iterations)...');

  // Warm up
  for (var i = 0; i < 5000; i++) {
    User.fromJson(JsonReader.fromString(jsonPayload));
    parseGeneric(JsonReader.fromString(jsonPayload), userDesc);
  }

  // Benchmark Generated Deserializer
  var stopwatch = Stopwatch()..start();
  for (var i = 0; i < iterations; i++) {
    final reader = JsonReader.fromString(jsonPayload);
    final user = User.fromJson(reader);
    user.id; // access to avoid dead-code optimizations
  }
  stopwatch.stop();
  final generatedParseMs = stopwatch.elapsedMilliseconds;

  // Benchmark Descriptor Deserializer
  stopwatch = Stopwatch()..start();
  for (var i = 0; i < iterations; i++) {
    final reader = JsonReader.fromString(jsonPayload);
    final user = parseGeneric(reader, userDesc);
    user.id;
  }
  stopwatch.stop();
  final descriptorParseMs = stopwatch.elapsedMilliseconds;

  print('Deserialization Results:');
  print('  Generated Parser:  ${generatedParseMs}ms');
  print('  Descriptor Parser: ${descriptorParseMs}ms');
  print(
    '  Speedup:           ${(descriptorParseMs / generatedParseMs).toStringAsFixed(2)}x faster',
  );

  print('\nRunning Serialization Benchmark ($iterations iterations)...');

  final user = User.fromJson(JsonReader.fromString(jsonPayload));

  // Warm up
  for (var i = 0; i < 5000; i++) {
    user.toJson();
    final buffer = StringBuffer();
    serializeGeneric(jsonStringWriter(buffer), user, userDesc);
  }

  // Benchmark Generated Serializer
  stopwatch = Stopwatch()..start();
  for (var i = 0; i < iterations; i++) {
    final serialized = user.toJson();
    serialized.length;
  }
  stopwatch.stop();
  final generatedSerializeMs = stopwatch.elapsedMilliseconds;

  // Benchmark Descriptor Serializer
  stopwatch = Stopwatch()..start();
  for (var i = 0; i < iterations; i++) {
    final buffer = StringBuffer();
    serializeGeneric(jsonStringWriter(buffer), user, userDesc);
    buffer.toString().length;
  }
  stopwatch.stop();
  final descriptorSerializeMs = stopwatch.elapsedMilliseconds;

  print('Serialization Results:');
  print('  Generated Serializer:  ${generatedSerializeMs}ms');
  print('  Descriptor Serializer: ${descriptorSerializeMs}ms');
  print(
    '  Speedup:               ${(descriptorSerializeMs / generatedSerializeMs).toStringAsFixed(2)}x faster',
  );
}
