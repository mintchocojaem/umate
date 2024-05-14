// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultDTO _$SearchResultDTOFromJson(Map<String, dynamic> json) =>
    SearchResultDTO(
      notices: SearchBoardDTO.fromJson(json['notices'] as Map<String, dynamic>),
      coalitions:
          SearchBoardDTO.fromJson(json['coalitions'] as Map<String, dynamic>),
      petitions:
          SearchBoardDTO.fromJson(json['petitions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchResultDTOToJson(SearchResultDTO instance) =>
    <String, dynamic>{
      'notices': instance.notices.toJson(),
      'coalitions': instance.coalitions.toJson(),
      'petitions': instance.petitions.toJson(),
    };
