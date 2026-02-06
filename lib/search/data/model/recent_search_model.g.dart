// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentSearchModel _$RecentSearchModelFromJson(Map<String, dynamic> json) =>
    RecentSearchModel(
      searchText: json['searchText'] as String,
      timestamp: json['timestamp'] as String,
      isSuccess: json['isSuccess'] as bool,
    );

Map<String, dynamic> _$RecentSearchModelToJson(RecentSearchModel instance) =>
    <String, dynamic>{
      'searchText': instance.searchText,
      'timestamp': instance.timestamp,
      'isSuccess': instance.isSuccess,
    };
