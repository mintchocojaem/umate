// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Agree _$$_AgreeFromJson(Map<String, dynamic> json) => _$_Agree(
      department: json['department'] as String,
      agreeCount: json['agreeCount'] as int,
    );

Map<String, dynamic> _$$_AgreeToJson(_$_Agree instance) => <String, dynamic>{
      'department': instance.department,
      'agreeCount': instance.agreeCount,
    };

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

_$_Petition _$$_PetitionFromJson(Map<String, dynamic> json) => _$_Petition(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      body: json['body'] as String,
      answer: json['answer'] as String?,
      createdAt: json['createdAt'] as String,
      files: (json['files'] as List<dynamic>)
          .map((e) =>
              e == null ? null : File.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: PetitionStatus.fromJson(json['status'] as String),
      expiresAt: json['expiresAt'] as String,
      agreeCount: json['agreeCount'] as int,
      statisticList: (json['statisticList'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Agree.fromJson(e as Map<String, dynamic>))
          .toList(),
      agree: json['agree'] as bool? ?? false,
      mine: json['mine'] as bool? ?? false,
      blinded: json['blinded'] as bool,
    );

Map<String, dynamic> _$$_PetitionToJson(_$_Petition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'body': instance.body,
      'answer': instance.answer,
      'createdAt': instance.createdAt,
      'files': instance.files,
      'status': instance.status,
      'expiresAt': instance.expiresAt,
      'agreeCount': instance.agreeCount,
      'statisticList': instance.statisticList,
      'agree': instance.agree,
      'mine': instance.mine,
      'blinded': instance.blinded,
    };
