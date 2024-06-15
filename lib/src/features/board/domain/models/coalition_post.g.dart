// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coalition_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoalitionPost _$CoalitionPostFromJson(Map<String, dynamic> json) =>
    CoalitionPost(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      author: json['author'] as String,
      body: json['body'] as String,
      createdAt: json['createdAt'] as String,
      files: (json['files'] as List<dynamic>)
          .map((e) => PostFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>)
          .map((e) => PostImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      views: (json['views'] as num?)?.toInt() ?? 0,
      mine: json['mine'] as bool? ?? false,
      blinded: json['blinded'] as bool,
      type: $enumDecode(_$CoalitionTypeEnumMap, json['coalitionType']),
    );

Map<String, dynamic> _$CoalitionPostToJson(CoalitionPost instance) =>
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
      'coalitionType': _$CoalitionTypeEnumMap[instance.type]!,
    };

const _$CoalitionTypeEnumMap = {
  CoalitionType.food: 'FOOD',
  CoalitionType.culture: 'CULTURE',
  CoalitionType.health: 'HEALTH',
  CoalitionType.etc: 'ETC',
};
