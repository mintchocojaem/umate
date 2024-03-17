// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petition_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetitionPostDTO _$PetitionPostDTOFromJson(Map<String, dynamic> json) =>
    PetitionPostDTO(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      body: json['body'] as String,
      answer: json['answer'] as String?,
      createdAt: json['createdAt'] as String,
      status: json['status'] as String,
      expiresAt: json['expiresAt'] as String,
      agreeCount: json['agreeCount'] as int,
      agree: json['agree'] as bool,
      mine: json['mine'] as bool,
      blinded: json['blinded'] as bool,
    );

Map<String, dynamic> _$PetitionPostDTOToJson(PetitionPostDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'body': instance.body,
      'answer': instance.answer,
      'createdAt': instance.createdAt,
      'status': instance.status,
      'expiresAt': instance.expiresAt,
      'agreeCount': instance.agreeCount,
      'agree': instance.agree,
      'mine': instance.mine,
      'blinded': instance.blinded,
    };
