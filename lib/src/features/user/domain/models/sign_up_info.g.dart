// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpInfo _$SignUpInfoFromJson(Map<String, dynamic> json) => SignUpInfo(
      signupToken: json['signupToken'] as String,
      studentInfo: StudentInfo.fromJson(json['student'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpInfoToJson(SignUpInfo instance) =>
    <String, dynamic>{
      'signupToken': instance.signupToken,
      'student': instance.studentInfo.toJson(),
    };
