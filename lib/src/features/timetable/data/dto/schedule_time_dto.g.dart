// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_time_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleTimeDTO _$ScheduleTimeDTOFromJson(Map<String, dynamic> json) =>
    ScheduleTimeDTO(
      start: json['start'] as String,
      end: json['end'] as String,
      week: json['week'] as String,
      place: json['place'] as String?,
    );

Map<String, dynamic> _$ScheduleTimeDTOToJson(ScheduleTimeDTO instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'week': instance.week,
      'place': instance.place,
    };
