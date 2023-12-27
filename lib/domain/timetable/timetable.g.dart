// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimetableImpl _$$TimetableImplFromJson(Map<String, dynamic> json) =>
    _$TimetableImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      lectures: (json['lectures'] as List<dynamic>?)
          ?.map((e) => Lecture.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TimetableImplToJson(_$TimetableImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lectures': instance.lectures?.map((e) => e.toJson()).toList(),
    };

_$LectureImpl _$$LectureImplFromJson(Map<String, dynamic> json) =>
    _$LectureImpl(
      name: json['name'] as String,
      memo: json['memo'] as String,
      type: json['type'] as String,
      color: json['color'] as String,
      times: (json['times'] as List<dynamic>)
          .map((e) => LectureTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LectureImplToJson(_$LectureImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'memo': instance.memo,
      'type': instance.type,
      'color': instance.color,
      'times': instance.times.map((e) => e.toJson()).toList(),
    };

_$LectureTimeImpl _$$LectureTimeImplFromJson(Map<String, dynamic> json) =>
    _$LectureTimeImpl(
      start: json['start'] as String,
      end: json['end'] as String,
      week: json['week'] as String,
      place: json['place'] as String?,
    );

Map<String, dynamic> _$$LectureTimeImplToJson(_$LectureTimeImpl instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'week': instance.week,
      'place': instance.place,
    };

_$LectureInfoImpl _$$LectureInfoImplFromJson(Map<String, dynamic> json) =>
    _$LectureInfoImpl(
      major: json['major'] as String?,
      grade: json['grade'] as int?,
      lectureCode: json['lectureCode'] as String,
      category: json['category'] as String,
      name: json['name'] as String,
      professor: json['professor'] as String,
      classNumber: json['classNumber'] as int,
      credit: json['credit'] as int,
      times: (json['times'] as List<dynamic>)
          .map((e) => LectureTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LectureInfoImplToJson(_$LectureInfoImpl instance) =>
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
