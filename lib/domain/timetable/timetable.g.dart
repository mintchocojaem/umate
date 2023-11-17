// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Timetable _$$_TimetableFromJson(Map<String, dynamic> json) => _$_Timetable(
      id: json['id'] as int,
      name: json['name'] as String,
      lectures: (json['lectures'] as List<dynamic>?)
          ?.map((e) => Lecture.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TimetableToJson(_$_Timetable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lectures': instance.lectures,
    };

_$_Lecture _$$_LectureFromJson(Map<String, dynamic> json) => _$_Lecture(
      name: json['name'] as String,
      memo: json['memo'] as String,
      type: json['type'] as String,
      color: json['color'] as String,
      times: (json['times'] as List<dynamic>)
          .map((e) => LectureTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_LectureToJson(_$_Lecture instance) =>
    <String, dynamic>{
      'name': instance.name,
      'memo': instance.memo,
      'type': instance.type,
      'color': instance.color,
      'times': instance.times,
    };

_$_LectureTime _$$_LectureTimeFromJson(Map<String, dynamic> json) =>
    _$_LectureTime(
      start: json['start'] as String,
      end: json['end'] as String,
      week: json['week'] as String,
      place: json['place'] as String,
    );

Map<String, dynamic> _$$_LectureTimeToJson(_$_LectureTime instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'week': instance.week,
      'place': instance.place,
    };
