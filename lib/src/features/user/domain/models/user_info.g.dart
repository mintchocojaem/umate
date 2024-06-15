// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      studentId: json['studentId'] as String,
      username: json['username'] as String,
      nickname: json['nickname'] as String,
      age: json['age'] as String,
      gender: json['gender'] as String,
      yearOfAdmission: json['yearOfAdmission'] as String,
      major: json['major'] as String,
      department: json['department'] as String,
      phoneNumber: json['phoneNumber'] as String,
      writePostCount: (json['writePostCount'] as num?)?.toInt() ?? 0,
      commentedPostCount: (json['commentedPostCount'] as num?)?.toInt() ?? 0,
      likePostCount: (json['likePostCount'] as num?)?.toInt() ?? 0,
      petitionCount: (json['petitionCount'] as num?)?.toInt() ?? 0,
      agreePetitionCount: (json['agreePetitionCount'] as num?)?.toInt() ?? 0,
      admin: json['admin'] as bool? ?? false,
      dkuChecked: json['dkuChecked'] as bool? ?? false,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
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
