
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/schedule_time.dart';
import '../../domain/models/schedule_time_format.dart';
import '../../domain/models/week_days.dart';

part 'schedule_time_dto.g.dart';

@JsonSerializable()
@immutable
class ScheduleTimeDTO extends DataMapper<ScheduleTime> {
  final String start;
  final String end;
  final String week;
  final String? place;

  ScheduleTimeDTO({
    required this.start,
    required this.end,
    required this.week,
    this.place
  });

  factory ScheduleTimeDTO.fromJson(Map<String, dynamic> json) =>
      _$ScheduleTimeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleTimeDTOToJson(this);

  @override
  ScheduleTime mapToModel() {
    final startTimeFormat = DateFormat('HH:mm:ss').parse(start);
    final endTimeFormat = DateFormat('HH:mm:ss').parse(end);
    return ScheduleTime(
      startTime: ScheduleTimeFormat.fromDateTime(startTimeFormat),
      endTime: ScheduleTimeFormat.fromDateTime(endTimeFormat),
      day: WeekDays.fromValue(week),
      place: place ?? '',
    );
  }
}