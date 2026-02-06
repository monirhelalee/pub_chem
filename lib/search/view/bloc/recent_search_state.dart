import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_chem/search/domain/entities/recent_search.dart';

part 'recent_search_state.freezed.dart';

@freezed
class RecentSearchState with _$RecentSearchState {
  const factory RecentSearchState.initial() = _Initial;

  const factory RecentSearchState.loading() = _Loading;

  const factory RecentSearchState.loaded({
    required List<RecentSearch> recentSearches,
  }) = _Loaded;

  const factory RecentSearchState.error({required String message}) = _Error;
}
