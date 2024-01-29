// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petition_post_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PetitionPostDetailModelImpl _$$PetitionPostDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PetitionPostDetailModelImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      body: json['body'] as String,
      answer: json['answer'] as String?,
      createdAt: json['createdAt'] as String,
      status: json['status'] as String,
      expiresAt: json['expiresAt'] as String,
      agreeCount: json['agreeCount'] as int,
      statisticList: (json['statisticList'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : PetitionStatisticModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      agree: json['agree'] as bool,
      mine: json['mine'] as bool,
      blinded: json['blinded'] as bool,
    );

Map<String, dynamic> _$$PetitionPostDetailModelImplToJson(
        _$PetitionPostDetailModelImpl instance) =>
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
      'statisticList': instance.statisticList.map((e) => e?.toJson()).toList(),
      'agree': instance.agree,
      'mine': instance.mine,
      'blinded': instance.blinded,
    };
