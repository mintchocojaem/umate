// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LectureInfo _$LectureInfoFromJson(Map<String, dynamic> json) => LectureInfo(
      name: json['name'] as String,
      major: json['major'] as String? ?? '',
      grade: (json['grade'] as num).toInt(),
      lectureCode: json['lectureCode'] as String,
      category: json['category'] as String,
      professor: json['professor'] as String,
      classNumber: (json['classNumber'] as num).toInt(),
      credit: (json['credit'] as num).toInt(),
      times: (json['times'] as List<dynamic>)
          .map((e) => ScheduleTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LectureInfoToJson(LectureInfo instance) =>
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
