// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoDTO _$UserInfoDTOFromJson(Map<String, dynamic> json) => UserInfoDTO(
      studentId: json['studentId'] as String,
      username: json['username'] as String,
      nickname: json['nickname'] as String,
      age: json['age'] as String,
      gender: json['gender'] as String,
      yearOfAdmission: json['yearOfAdmission'] as String,
      major: json['major'] as String,
      department: json['department'] as String,
      phoneNumber: json['phoneNumber'] as String,
      writePostCount: (json['writePostCount'] as num?)?.toInt(),
      commentedPostCount: (json['commentedPostCount'] as num?)?.toInt(),
      likePostCount: (json['likePostCount'] as num?)?.toInt(),
      petitionCount: (json['petitionCount'] as num?)?.toInt(),
      agreePetitionCount: (json['agreePetitionCount'] as num?)?.toInt(),
      admin: json['admin'] as bool,
      dkuChecked: json['dkuChecked'] as bool,
    );

Map<String, dynamic> _$UserInfoDTOToJson(UserInfoDTO instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'username': instance.username,
      'nickname': instance.nickname,
      'age': instance.age,
      'gender': instance.gender,
      'yearOfAdmission': instance.yearOfAdmission,
      'major': instance.major,
      'department': instance.department,
      'phoneNumber': instance.phoneNumber,
      'writePostCount': instance.writePostCount,
      'commentedPostCount': instance.commentedPostCount,
      'likePostCount': instance.likePostCount,
      'petitionCount': instance.petitionCount,
      'agreePetitionCount': instance.agreePetitionCount,
      'admin': instance.admin,
      'dkuChecked': instance.dkuChecked,
    };
