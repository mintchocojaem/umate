// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignUpModelImpl _$$SignUpModelImplFromJson(Map<String, dynamic> json) =>
    _$SignUpModelImpl(
      signUpToken: json['signUpToken'] as String,
      student: StudentModel.fromJson(json['student'] as Map<String, dynamic>),
      validPhoneNumber: json['validPhoneNumber'] as String?,
      validNickname: json['validNickname'] as String?,
    );

Map<String, dynamic> _$$SignUpModelImplToJson(_$SignUpModelImpl instance) =>
    <String, dynamic>{
      'signUpToken': instance.signUpToken,
      'student': instance.student.toJson(),
      'validPhoneNumber': instance.validPhoneNumber,
      'validNickname': instance.validNickname,
    };
