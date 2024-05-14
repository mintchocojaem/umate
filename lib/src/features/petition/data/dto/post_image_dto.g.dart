// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_image_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostImageDTO _$PostImageDTOFromJson(Map<String, dynamic> json) => PostImageDTO(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      originalName: json['originalName'] as String,
      mimeType: json['mimeType'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$PostImageDTOToJson(PostImageDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'originalName': instance.originalName,
      'mimeType': instance.mimeType,
      'thumbnailUrl': instance.thumbnailUrl,
    };
