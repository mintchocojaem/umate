// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostImage _$PostImageFromJson(Map<String, dynamic> json) => PostImage(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      originalName: json['originalName'] as String,
      mimeType: json['mimeType'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$PostImageToJson(PostImage instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'originalName': instance.originalName,
      'mimeType': instance.mimeType,
      'thumbnailUrl': instance.thumbnailUrl,
    };
