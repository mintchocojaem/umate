// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpInfoDTO _$SignUpInfoDTOFromJson(Map<String, dynamic> json) =>
    SignUpInfoDTO(
      signupToken: json['signupToken'] as String,
      student: StudentDTO.fromJson(json['student'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpInfoDTOToJson(SignUpInfoDTO instance) =>
    <String, dynamic>{
      'signupToken': instance.signupToken,
      'student': instance.student.toJson(),
    };
