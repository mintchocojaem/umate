// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_file_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostFileDTO _$PostFileDTOFromJson(Map<String, dynamic> json) => PostFileDTO(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      originalName: json['originalName'] as String,
      mimeType: json['mimeType'] as String,
    );

Map<String, dynamic> _$PostFileDTOToJson(PostFileDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'originalName': instance.originalName,
      'mimeType': instance.mimeType,
    };
