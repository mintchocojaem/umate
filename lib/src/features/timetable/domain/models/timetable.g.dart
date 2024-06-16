// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timetable _$TimetableFromJson(Map<String, dynamic> json) => Timetable(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      schedules: (json['lectures'] as List<dynamic>?)
              ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      startHour: (json['startHour'] as num?)?.toInt() ?? 8,
      endHour: (json['endHour'] as num?)?.toInt() ?? 24,
      weekdays: (json['weekdays'] as num?)?.toInt() ?? 5,
    );

Map<String, dynamic> _$TimetableToJson(Timetable instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lectures': instance.schedules.map((e) => e.toJson()).toList(),
      'startHour': instance.startHour,
      'endHour': instance.endHour,
      'weekdays': instance.weekdays,
    };
