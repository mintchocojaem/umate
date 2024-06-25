// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyPost _$StudyPostFromJson(Map<String, dynamic> json) => StudyPost(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      author: json['author'] as String,
      body: json['body'] as String? ?? '',
      createdAt: json['createdAt'] as String,
      files: (json['files'] as List<dynamic>?)
              ?.map((e) => PostFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => PostImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      views: (json['views'] as num?)?.toInt() ?? 0,
      mine: json['mine'] as bool? ?? false,
      blinded: json['blinded'] as bool? ?? false,
      recruitedCount: (json['recruitedCount'] as num?)?.toInt() ?? 0,
      tag: json['tag'] as String?,
    );

Map<String, dynamic> _$StudyPostToJson(StudyPost instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'body': instance.body,
      'createdAt': instance.createdAt,
      'files': instance.files.map((e) => e.toJson()).toList(),
      'images': instance.images.map((e) => e.toJson()).toList(),
      'views': instance.views,
      'mine': instance.mine,
      'blinded': instance.blinded,
      'tag': instance.tag,
      'recruitedCount': instance.recruitedCount,
    };