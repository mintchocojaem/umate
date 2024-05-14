// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LectureInfoDTO _$LectureInfoDTOFromJson(Map<String, dynamic> json) =>
    LectureInfoDTO(
      name: json['name'] as String,
      major: json['major'] as String?,
      grade: (json['grade'] as num).toInt(),
      lectureCode: json['lectureCode'] as String,
      category: json['category'] as String,
      professor: json['professor'] as String,
      classNumber: (json['classNumber'] as num).toInt(),
      credit: (json['credit'] as num).toInt(),
      times: (json['times'] as List<dynamic>)
          .map((e) => ScheduleTimeDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LectureInfoDTOToJson(LectureInfoDTO instance) =>
    <String, dynamic>{
      'major': instance.major,
      'grade': instance.grade,
      'lectureCode': instance.lectureCode,
      'category': instance.category,
      'name': instance.name,
      'professor': instance.professor,
      'classNumber': instance.classNumber,
      'credit': instance.credit,
      'times': instance.times.map((e) => e.toJson()).toList(),
    };
