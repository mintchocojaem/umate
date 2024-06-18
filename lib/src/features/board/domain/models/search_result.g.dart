// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      notices: Board<NoticePost>.fromJson(
          json['notices'] as Map<String, dynamic>,
          (value) => NoticePost.fromJson(value as Map<String, dynamic>)),
      coalitions: Board<CoalitionPost>.fromJson(
          json['coalitions'] as Map<String, dynamic>,
          (value) => CoalitionPost.fromJson(value as Map<String, dynamic>)),
      petitions: Board<PetitionPost>.fromJson(
          json['petitions'] as Map<String, dynamic>,
          (value) => PetitionPost.fromJson(value as Map<String, dynamic>)),
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'notices': instance.notices.toJson(
        (value) => value.toJson(),
      ),
      'coalitions': instance.coalitions.toJson(
        (value) => value.toJson(),
      ),
      'petitions': instance.petitions.toJson(
        (value) => value.toJson(),
      ),
    };
