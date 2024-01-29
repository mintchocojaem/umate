// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petition_board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PetitionBoardModelImpl _$$PetitionBoardModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PetitionBoardModelImpl(
      content: (json['content'] as List<dynamic>)
          .map((e) =>
              PetitionPostPreviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasNext: json['hasNext'] as bool,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
      first: json['first'] as bool,
      last: json['last'] as bool,
    );

Map<String, dynamic> _$$PetitionBoardModelImplToJson(
        _$PetitionBoardModelImpl instance) =>
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
