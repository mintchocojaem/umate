// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostFile _$PostFileFromJson(Map<String, dynamic> json) => PostFile(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      name: json['name'] as String? ?? 'unknown_file',
      mimeType: json['mimeType'] as String,
    );

Map<String, dynamic> _$PostFileToJson(PostFile instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'mimeType': instance.mimeType,
    };
