// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petition_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetitionPostDTO _$PetitionPostDTOFromJson(Map<String, dynamic> json) =>
    PetitionPostDTO(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      author: json['author'] as String? ?? '익명',
      body: json['body'] as String,
      createdAt: json['createdAt'] as String,
      files: (json['files'] as List<dynamic>?)
              ?.map((e) => PostFileDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => PostImageDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      views: (json['views'] as num?)?.toInt() ?? 0,
      mine: json['mine'] as bool? ?? false,
      blinded: json['blinded'] as bool? ?? false,
      answer: json['answer'] as String?,
      status: json['status'] as String,
      expiresAt: json['expiresAt'] as String,
      agreeCount: (json['agreeCount'] as num?)?.toInt() ?? 0,
      agree: json['agree'] as bool? ?? false,
    );

Map<String, dynamic> _$PetitionPostDTOToJson(PetitionPostDTO instance) =>
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
      'answer': instance.answer,
      'status': instance.status,
      'expiresAt': instance.expiresAt,
      'agreeCount': instance.agreeCount,
      'agree': instance.agree,
    };
