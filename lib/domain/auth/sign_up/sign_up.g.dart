// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SignUp _$$_SignUpFromJson(Map<String, dynamic> json) => _$_SignUp(
      signUpToken: json['signupToken'] as String,
      student: Student.fromJson(json['student'] as Map<String, dynamic>),
      isVerified: json['isVerified'] as bool? ?? false,
      isSignedUp: json['isSignedUp'] as bool? ?? false,
      isSentSMS: json['isSentSMS'] as bool? ?? false,
    );

Map<String, dynamic> _$$_SignUpToJson(_$_SignUp instance) => <String, dynamic>{
      'signupToken': instance.signUpToken,
      'student': instance.student,
      'isVerified': instance.isVerified,
      'isSignedUp': instance.isSignedUp,
      'isSentSMS': instance.isSentSMS,
    };

_$_Student _$$_StudentFromJson(Map<String, dynamic> json) => _$_Student(
      studentName: json['studentName'] as String,
      studentId: json['studentId'] as String,
      major: json['major'] as String,
    );

Map<String, dynamic> _$$_StudentToJson(_$_Student instance) =>
    <String, dynamic>{
      'studentName': instance.studentName,
      'studentId': instance.studentId,
      'major': instance.major,
    };
