// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_board_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBoardDTO _$SearchBoardDTOFromJson(Map<String, dynamic> json) =>
    SearchBoardDTO(
      content: (json['content'] as List<dynamic>)
          .map((e) => SearchPostDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasNext: json['hasNext'] as bool,
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      totalElements: (json['totalElements'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      first: json['first'] as bool,
      last: json['last'] as bool,
    );

Map<String, dynamic> _$SearchBoardDTOToJson(SearchBoardDTO instance) =>
    <String, dynamic>{
      'content': instance.content.map((e) => e.toJson()).toList(),
      'hasNext': instance.hasNext,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'page': instance.page,
      'size': instance.size,
      'first': instance.first,
      'last': instance.last,
    };
