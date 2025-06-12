/// Helper to parse list of strings from JSON input.
/// This is necessary because the JSON data might contain an empty string for lists that have no items,
/// instead of an empty array in the JSON.
List<String> fromJsonStringList(dynamic json) {
  if (json is List) {
    return List<String>.from(json);
  } else if (json is String) {
    if (json.isEmpty) {
      return [];
    }
    return [json];
  } else {
    return [];
  }
}
