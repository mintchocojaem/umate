// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bear_eats_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BearEatsPost _$BearEatsPostFromJson(Map<String, dynamic> json) => BearEatsPost(
      id: (json['id'] as num).toInt(),
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
      restaurant: json['restaurant'] as String,
      deliveryPlace: json['deliveryPlace'] as String,
      deliveryTime: json['deliveryTime'] as String,
      recruitedCount: (json['recruitedCount'] as num).toInt(),
    );

Map<String, dynamic> _$BearEatsPostToJson(BearEatsPost instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'body': instance.body,
      'createdAt': instance.createdAt,
      'files': instance.files.map((e) => e.toJson()).toList(),
      'images': instance.images.map((e) => e.toJson()).toList(),
      'views': instance.views,
      'mine': instance.mine,
      'blinded': instance.blinded,
      'restaurant': instance.restaurant,
      'deliveryPlace': instance.deliveryPlace,
      'deliveryTime': instance.deliveryTime,
      'recruitedCount': instance.recruitedCount,
    };
