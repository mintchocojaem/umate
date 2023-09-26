// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_File _$$_FileFromJson(Map<String, dynamic> json) => _$_File(
      id: json['id'] as int,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      originalName: json['originalName'] as String,
      mimeType: json['mimeType'] as String,
    );

Map<String, dynamic> _$$_FileToJson(_$_File instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
      'originalName': instance.originalName,
      'mimeType': instance.mimeType,
    };

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      body: json['body'] as String,
      createdAt: json['createdAt'] as String,
      files: (json['files'] as List<dynamic>)
          .map((e) =>
              e == null ? null : File.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      expiresAt: json['expiresAt'] as String,
      agreeCount: json['agreeCount'] as int,
      blinded: json['blinded'] as bool,
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'body': instance.body,
      'createdAt': instance.createdAt,
      'files': instance.files,
      'status': instance.status,
      'expiresAt': instance.expiresAt,
      'agreeCount': instance.agreeCount,
      'blinded': instance.blinded,
    };
