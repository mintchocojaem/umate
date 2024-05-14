// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDTO _$ScheduleDTOFromJson(Map<String, dynamic> json) => ScheduleDTO(
      name: json['name'] as String,
      professor: json['professor'] as String?,
      type: json['type'] as String,
      memo: json['memo'] as String,
      color: json['color'] as String,
      times: (json['times'] as List<dynamic>)
          .map((e) => ScheduleTimeDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleDTOToJson(ScheduleDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'professor': instance.professor,
      'memo': instance.memo,
      'type': instance.type,
      'color': instance.color,
      'times': instance.times.map((e) => e.toJson()).toList(),
    };
