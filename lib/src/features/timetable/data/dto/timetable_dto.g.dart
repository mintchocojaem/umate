// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableDTO _$TimetableDTOFromJson(Map<String, dynamic> json) => TimetableDTO(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      lectures: (json['lectures'] as List<dynamic>?)
          ?.map((e) => ScheduleDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimetableDTOToJson(TimetableDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lectures': instance.lectures?.map((e) => e.toJson()).toList(),
    };
