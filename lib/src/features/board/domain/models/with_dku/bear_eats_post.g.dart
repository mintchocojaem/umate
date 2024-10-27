// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bear_eats_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BearEatsPost _$BearEatsPostFromJson(Map<String, dynamic> json) => BearEatsPost(
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
      restaurant: json['restaurant'] as String,
      deliveryPlace: json['deliveryPlace'] as String,
      deliveryTime: json['deliveryTime'] as String,
      recruitedUsers: (json['recruitedUsers'] as List<dynamic>?)
              ?.map(
                  (e) => RecruitedUserInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      recruitedCount: (json['recruitedCount'] as num).toInt(),
      applied: json['applied'] as bool? ?? false,
      gender: json['gender'] as String? ?? '알 수 없음',
      major: json['major'] as String? ?? '알 수 없음',
      status: json['status'] as String,
    );

Map<String, dynamic> _$BearEatsPostToJson(BearEatsPost instance) =>
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
      'restaurant': instance.restaurant,
      'deliveryPlace': instance.deliveryPlace,
      'deliveryTime': instance.deliveryTime,
      'recruitedUsers': instance.recruitedUsers.map((e) => e.toJson()).toList(),
      'recruitedCount': instance.recruitedCount,
      'applied': instance.applied,
      'gender': instance.gender,
      'major': instance.major,
      'status': instance.status,
    };
