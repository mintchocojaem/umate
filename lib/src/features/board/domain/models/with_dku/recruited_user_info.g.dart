// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recruited_user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecruitedUserInfo _$RecruitedUserInfoFromJson(Map<String, dynamic> json) =>
    RecruitedUserInfo(
      id: (json['id'] as num).toInt(),
      nickname: json['nickname'] as String,
      majorName: json['majorName'] as String,
    );

Map<String, dynamic> _$RecruitedUserInfoToJson(RecruitedUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'majorName': instance.majorName,
    };
