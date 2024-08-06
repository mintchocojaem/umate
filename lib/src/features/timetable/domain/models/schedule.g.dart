// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      name: json['name'] as String,
      professor: json['professor'] as String?,
      type: $enumDecode(_$ScheduleTypeEnumMap, json['type']),
      memo: json['memo'] as String?,
      color: _parseColorFromJson(json['color'] as String),
      times: (json['times'] as List<dynamic>)
          .map((e) => ScheduleTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'name': instance.name,
      'professor': instance.professor,
      'memo': instance.memo,
      'type': _$ScheduleTypeEnumMap[instance.type]!,
      'color': _parseColorToJson(instance.color),
      'times': instance.times.map((e) => e.toJson()).toList(),
    };

const _$ScheduleTypeEnumMap = {
  ScheduleType.schedule: 'SCHEDULE',
  ScheduleType.lecture: 'LECTURE',
};
