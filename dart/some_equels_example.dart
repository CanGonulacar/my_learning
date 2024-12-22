/*
* bool equals(Object? v1, Object? v2) {
  if (identical(v1, v2) || v1 == v2) return true;
  if (v1 is Map) return v2 is Map && mapsEqual(v1, v2);
  if (v1 is List) return v2 is List && listsEqual(v1, v2);
  if (v1 is Set) return v2 is Set && setsEqual(v1, v2);
  if (v1 is double) {
    return v1.isNaN && v2 is double && v2.isNaN;
  }
  return false;
}

* bool mapsEqual(Map map1, Map map2) {
  if (map1.length != map2.length) return false;
  for (var key in map1.keys) {
    var value1 = map1[key];
    var value2 = map2[key];
    if (value1 == null && (value2 != null || !map2.containsKey(key))) {
      return false;
    }
    if (!equals(value1, value2)) return false;
  }
  return true;
}

* bool setsEqual(Set v1, Set v2) {
  if (v1.length != v2.length) return false;
  for (var v in v1) {
    if (!v2.contains(v)) return false;
  }
  return true;
}

* bool listsEqual(List v1, List v2) {
  if (v1.length != v2.length) return false;
  for (var i = 0; i < v1.length; i++) {
    if (!equals(v1[i], v2[i])) return false;
  }
  return true;


 */