import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_search.freezed.dart';

@freezed
abstract class RecentSearch with _$RecentSearch {
  const factory RecentSearch({
    required String searchText,
    required DateTime timestamp,
    required bool isSuccess,
  }) = _RecentSearch;
}
