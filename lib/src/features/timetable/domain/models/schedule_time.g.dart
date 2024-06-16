// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleTime _$ScheduleTimeFromJson(Map<String, dynamic> json) => ScheduleTime(
      start: _parseTimeFromJson(json['start'] as String),
      end: _parseTimeFromJson(json['end'] as String),
      day: $enumDecode(_$WeekDaysEnumMap, json['week']),
      place: json['place'] as String? ?? '',
    );

Map<String, dynamic> _$ScheduleTimeToJson(ScheduleTime instance) =>
    <String, dynamic>{
      'start': _parseTimeToJson(instance.start),
      'end': _parseTimeToJson(instance.end),
      'week': _$WeekDaysEnumMap[instance.day]!,
      'place': instance.place,
    };

const _$WeekDaysEnumMap = {
  WeekDays.monday: 'MONDAY',
  WeekDays.tuesday: 'TUESDAY',
  WeekDays.wednesday: 'WEDNESDAY',
  WeekDays.thursday: 'THURSDAY',
  WeekDays.friday: 'FRIDAY',
  WeekDays.saturday: 'SATURDAY',
  WeekDays.sunday: 'SUNDAY',
};
