// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petition_post_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PetitionPostPreviewModelImpl _$$PetitionPostPreviewModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PetitionPostPreviewModelImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      createdAt: json['createdAt'] as String,
      body: json['body'] as String,
      status: json['status'] as String,
      expiresAt: json['expiresAt'] as String,
      agreeCount: json['agreeCount'] as int,
      blinded: json['blinded'] as bool,
    );

Map<String, dynamic> _$$PetitionPostPreviewModelImplToJson(
        _$PetitionPostPreviewModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'createdAt': instance.createdAt,
      'body': instance.body,
      'status': instance.status,
      'expiresAt': instance.expiresAt,
      'agreeCount': instance.agreeCount,
      'blinded': instance.blinded,
    };
