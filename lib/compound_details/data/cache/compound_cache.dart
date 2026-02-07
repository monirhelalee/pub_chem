import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CompoundCache {
  CompoundCache({Duration ttl = const Duration(days: 7)}) : _ttl = ttl;

  static const _prefix = 'compound_cache_';
  static const _timestampPrefix = 'compound_cache_ts_';
  static const _maxEntries = 100;

  final Duration _ttl;

  // --- Key helpers ---

  /// Creates a stable storage key from a compound name (e.g. "Aspirin" -> "compound_cache_aspirin").
  String _cacheKey(String compoundName) =>
      '$_prefix${_normalizeKey(compoundName)}';

  /// Creates the timestamp key for a compound (e.g. "Aspirin" -> "compound_cache_ts_aspirin").
  String _timestampKey(String compoundName) =>
      '$_timestampPrefix${_normalizeKey(compoundName)}';

  /// Normalizes compound names for consistent lookup (trim, lowercase, spaces -> underscores).
  String _normalizeKey(String compoundName) =>
      compoundName.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '_');

  // --- Public API ---

  /// Returns cached compound data if present and not expired, otherwise null.
  Future<Map<String, dynamic>?> get(String compoundName) async {
    final prefs = await SharedPreferences.getInstance();
    final dataKey = _cacheKey(compoundName);
    final tsKey = _timestampKey(compoundName);

    final cachedJson = prefs.getString(dataKey);
    final storedAtMs = prefs.getInt(tsKey);

    if (cachedJson == null || storedAtMs == null) return null;

    final ageMs = DateTime.now().millisecondsSinceEpoch - storedAtMs;
    if (ageMs > _ttl.inMilliseconds) {
      await _removeEntry(prefs, dataKey, tsKey);
      return null;
    }

    return json.decode(cachedJson) as Map<String, dynamic>?;
  }

  /// Stores compound data in the cache and may evict oldest entries if over capacity.
  Future<void> set(String compoundName, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final dataKey = _cacheKey(compoundName);
    final tsKey = _timestampKey(compoundName);

    await prefs.setString(dataKey, json.encode(data));
    await prefs.setInt(tsKey, DateTime.now().millisecondsSinceEpoch);

    await _evictIfOverCapacity(prefs);
  }

  /// Removes all cached compound data.
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    final dataKeys = _dataKeys(prefs);
    final timestampKeys = _timestampKeys(prefs);

    for (final key in dataKeys) await prefs.remove(key);
    for (final key in timestampKeys) await prefs.remove(key);
  }

  // --- Private helpers ---

  /// Removes a single cache entry (data + timestamp).
  Future<void> _removeEntry(
    SharedPreferences prefs,
    String dataKey,
    String timestampKey,
  ) async {
    await prefs.remove(dataKey);
    await prefs.remove(timestampKey);
  }

  /// Returns only data keys (excludes timestamp keys, which also start with _prefix).
  Iterable<String> _dataKeys(SharedPreferences prefs) => prefs.getKeys().where(
    (k) => k.startsWith(_prefix) && !k.startsWith(_timestampPrefix),
  );

  /// Returns all timestamp keys.
  Iterable<String> _timestampKeys(SharedPreferences prefs) =>
      prefs.getKeys().where((k) => k.startsWith(_timestampPrefix));

  /// Evicts oldest entries when the cache exceeds [maxEntries].
  Future<void> _evictIfOverCapacity(SharedPreferences prefs) async {
    final dataKeys = _dataKeys(prefs).toList();
    if (dataKeys.length <= _maxEntries) return;

    // Build (dataKey -> storedAtMs) and sort by oldest first
    final entriesByAge = <String, int>{};
    for (final dataKey in dataKeys) {
      final storedAtMs = prefs.getInt(_timestampKeyFromDataKey(dataKey));
      if (storedAtMs != null) entriesByAge[dataKey] = storedAtMs;
    }
    final sortedOldestFirst = entriesByAge.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    final excessCount = sortedOldestFirst.length - _maxEntries;
    for (var i = 0; i < excessCount; i++) {
      final dataKey = sortedOldestFirst[i].key;
      final tsKey = _timestampKeyFromDataKey(dataKey);
      await _removeEntry(prefs, dataKey, tsKey);
    }
  }

  /// Derives the timestamp key from a data key (e.g. "compound_cache_aspirin" -> "compound_cache_ts_aspirin").
  String _timestampKeyFromDataKey(String dataKey) =>
      '$_timestampPrefix${dataKey.replaceFirst(_prefix, '')}';
}
