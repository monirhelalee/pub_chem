import 'dart:convert';

import 'package:pub_chem/search/domain/entities/recent_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentSearchService {
  static const String _recentSearchesKey = 'recent_searches';
  static const int _maxRecentSearches = 20;

  Future<List<RecentSearch>> getRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_recentSearchesKey);
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final dynamic decoded = json.decode(jsonString);
      if (decoded is! List) {
        return [];
      }
      final jsonList = decoded;
      final searches =
          jsonList
              .map((json) => _fromJson(json as Map<String, dynamic>))
              .toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return searches;
    } on Exception {
      return [];
    }
  }

  Future<void> addRecentSearch(RecentSearch search) async {
    try {
      final searches = await getRecentSearches();

      // Remove duplicate searches with the same text
      searches.removeWhere(
        (s) => s.searchText.toLowerCase() == search.searchText.toLowerCase(),
      );
      // Add new search at the beginning
      searches.insert(0, search);

      // Keep only the most recent searches
      if (searches.length > _maxRecentSearches) {
        searches.removeRange(_maxRecentSearches, searches.length);
      }

      final prefs = await SharedPreferences.getInstance();
      final jsonList = searches.map(_toJson).toList();
      await prefs.setString(_recentSearchesKey, json.encode(jsonList));
    } on Exception {
      // Silently fail if there's an error saving
    }
  }

  Future<void> clearRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_recentSearchesKey);
    } on Exception {
      // Silently fail if there's an error clearing
    }
  }

  Map<String, dynamic> _toJson(RecentSearch search) {
    return {
      'searchText': search.searchText,
      'timestamp': search.timestamp.toIso8601String(),
      'isSuccess': search.isSuccess,
    };
  }

  RecentSearch _fromJson(Map<String, dynamic> json) {
    return RecentSearch(
      searchText: json['searchText'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isSuccess: json['isSuccess'] as bool,
    );
  }
}
