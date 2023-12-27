// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
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
      petitionCount: json['petitionCount'] as int,
      agreedPetitionCount: json['agreedPetitionCount'] as int,
      admin: json['admin'] as bool,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
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
      'petitionCount': instance.petitionCount,
      'agreedPetitionCount': instance.agreedPetitionCount,
      'admin': instance.admin,
    };
