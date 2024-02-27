// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpInfoDto _$SignUpInfoDtoFromJson(Map<String, dynamic> json) =>
    SignUpInfoDto(
      signUpToken: json['signUpToken'] as String,
      student: StudentDto.fromJson(json['student'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpInfoDtoToJson(SignUpInfoDto instance) =>
    <String, dynamic>{
      'signUpToken': instance.signUpToken,
      'student': instance.student.toJson(),
    };
