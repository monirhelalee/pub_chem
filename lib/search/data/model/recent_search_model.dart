import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_chem/search/domain/entities/recent_search.dart';

part 'recent_search_model.g.dart';

@JsonSerializable()
class RecentSearchModel {
  RecentSearchModel({
    required this.searchText,
    required this.timestamp,
    required this.isSuccess,
  });

  factory RecentSearchModel.fromJson(Map<String, dynamic> json) =>
      _$RecentSearchModelFromJson(json);
  final String searchText;
  final String timestamp;
  final bool isSuccess;

  Map<String, dynamic> toJson() => _$RecentSearchModelToJson(this);

  RecentSearch toEntity() {
    return RecentSearch(
      searchText: searchText,
      timestamp: DateTime.parse(timestamp),
      isSuccess: isSuccess,
    );
  }
}
