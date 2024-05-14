// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coalition_board_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoalitionBoardDTO _$CoalitionBoardDTOFromJson(Map<String, dynamic> json) =>
    CoalitionBoardDTO(
      content: (json['content'] as List<dynamic>)
          .map((e) => CoalitionPostDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasNext: json['hasNext'] as bool,
      totalPages: (json['totalPages'] as num).toInt(),
      totalElements: (json['totalElements'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      first: json['first'] as bool,
      last: json['last'] as bool,
    );

Map<String, dynamic> _$CoalitionBoardDTOToJson(CoalitionBoardDTO instance) =>
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
