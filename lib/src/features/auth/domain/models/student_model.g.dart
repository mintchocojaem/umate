// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentModelImpl _$$StudentModelImplFromJson(Map<String, dynamic> json) =>
    _$StudentModelImpl(
      studentName: json['studentName'] as String,
      studentId: json['studentId'] as String,
      major: json['major'] as String,
      age: json['age'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$$StudentModelImplToJson(_$StudentModelImpl instance) =>
    <String, dynamic>{
      'studentName': instance.studentName,
      'studentId': instance.studentId,
      'major': instance.major,
      'age': instance.age,
      'gender': instance.gender,
    };
