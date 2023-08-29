// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      studentId: json['studentId'] as String,
      username: json['username'] as String,
      nickname: json['nickname'] as String,
      yearOfAdmission: json['yearOfAdmission'] as String,
      major: json['major'] as String,
      department: json['department'] as String,
      phoneNumber: json['phoneNumber'] as String,
      writePostCount: json['writePostCount'] as int,
      commentedPostCount: json['commentedPostCount'] as int,
      likedPostCount: json['likedPostCount'] as int,
      admin: json['admin'] as bool,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'studentId': instance.studentId,
      'username': instance.username,
      'nickname': instance.nickname,
      'yearOfAdmission': instance.yearOfAdmission,
      'major': instance.major,
      'department': instance.department,
      'phoneNumber': instance.phoneNumber,
      'writePostCount': instance.writePostCount,
      'commentedPostCount': instance.commentedPostCount,
      'likedPostCount': instance.likedPostCount,
      'admin': instance.admin,
    };
