// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dantudy_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DantudyPost _$DantudyPostFromJson(Map<String, dynamic> json) => DantudyPost(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      author: json['author'] as String,
      body: json['body'] as String,
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
      kakaoOpenChatLink: json['kakaoOpenChatLink'] as String? ?? '',
      recruitedCount: (json['recruitedCount'] as num?)?.toInt() ?? 0,
      gender: json['gender'] as String? ?? '알 수 없음',
      major: json['major'] as String? ?? '알 수 없음',
      recruitedUsers: (json['recruitedUsers'] as List<dynamic>?)
              ?.map(
                  (e) => RecruitedUserInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tag: json['tag'] as String? ?? '',
      studyDate: json['studyDate'] as String? ?? '',
      applied: json['applied'] as bool? ?? false,
    );

Map<String, dynamic> _$DantudyPostToJson(DantudyPost instance) =>
    <String, dynamic>{
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
      'kakaoOpenChatLink': instance.kakaoOpenChatLink,
      'tag': instance.tag,
      'gender': instance.gender,
      'major': instance.major,
      'recruitedUsers': instance.recruitedUsers.map((e) => e.toJson()).toList(),
      'recruitedCount': instance.recruitedCount,
      'studyDate': instance.studyDate,
      'applied': instance.applied,
    };
