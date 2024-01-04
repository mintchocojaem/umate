// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignUpImpl _$$SignUpImplFromJson(Map<String, dynamic> json) => _$SignUpImpl(
      signUpToken: json['signupToken'] as String,
      student: Student.fromJson(json['student'] as Map<String, dynamic>),
      validPhoneNumber: json['validPhoneNumber'] as String?,
      validNickname: json['validNickname'] as String?,
    );

Map<String, dynamic> _$$SignUpImplToJson(_$SignUpImpl instance) =>
    <String, dynamic>{
      'signupToken': instance.signUpToken,
      'student': instance.student.toJson(),
      'validPhoneNumber': instance.validPhoneNumber,
      'validNickname': instance.validNickname,
    };

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      studentName: json['studentName'] as String,
      studentId: json['studentId'] as String,
      major: json['major'] as String,
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      'studentName': instance.studentName,
      'studentId': instance.studentId,
      'major': instance.major,
    };
