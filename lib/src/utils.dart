/// Deeply compares two JSON-like values for equality.
bool deepEquals(dynamic a, dynamic b) {
  if (identical(a, b)) return true;
  if (a is List && b is List) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!deepEquals(a[i], b[i])) return false;
    }
    return true;
  }
  if (a is Map && b is Map) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key)) return false;
      if (!deepEquals(a[key], b[key])) return false;
    }
    return true;
  }
  return a == b;
}

/// Calculates the Least Common Multiple (LCM) of two numbers.
num lcm(num a, num b) {
  if (a is int && b is int) {
    if (a == 0 || b == 0) return 0;
    return (a * b).abs() / _gcd(a, b);
  }
  return a * b;
}

int _gcd(int a, int b) {
  while (b != 0) {
    var t = b;
    b = a % b;
    a = t;
  }
  return a;
}

/// Parses a JSON value into an integer if possible.
///
/// Accepts [int] and [double] values that are mathematically integers.
/// Returns null if the value is not an integer or cannot be parsed.
int? parseInt(dynamic value) {
  if (value is int) return value;
  if (value is double) {
    if (value == value.toInt()) {
      return value.toInt();
    }
  }
  return null;
}

/// Normalizes a schema URI by percent-decoding the fragment and unescaping JSON Pointer segments.
String normalizeSchemaUri(String uriStr) {
  try {
    final uri = Uri.parse(uriStr);
    if (!uri.hasFragment) return uriStr;
    final decodedFragment = Uri.decodeComponent(uri.fragment);
    final unescapedFragment = decodedFragment
        .replaceAll('~1', '/')
        .replaceAll('~0', '~');
    return uri.replace(fragment: unescapedFragment).toString();
  } catch (e) {
    return uriStr;
  }
}
