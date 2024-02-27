// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentDto _$StudentDtoFromJson(Map<String, dynamic> json) => StudentDto(
      studentName: json['studentName'] as String,
      studentId: json['studentId'] as String,
      major: json['major'] as String,
      age: json['age'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$StudentDtoToJson(StudentDto instance) =>
    <String, dynamic>{
      'studentName': instance.studentName,
      'studentId': instance.studentId,
      'major': instance.major,
      'age': instance.age,
      'gender': instance.gender,
    };
