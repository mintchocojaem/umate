import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/schedule.dart';
import '../../domain/models/schedule_type.dart';
import 'schedule_time_dto.dart';

part 'schedule_dto.g.dart';

@JsonSerializable()
@immutable
class ScheduleDTO extends DataMapper<Schedule> {
  final String name;
  final String? professor;
  final String memo;
  final String type;
  final String color;
  final List<ScheduleTimeDTO> times;

  ScheduleDTO({
    required this.name,
    this.professor,
    required this.type,
    required this.memo,
    required this.color,
    required this.times,
  });

  factory ScheduleDTO.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDTOToJson(this);

  @override
  Schedule mapToModel() {
    return Schedule(
      name: name,
      type: ScheduleType.fromValue(type),
      professor: professor ?? '',
      memo: memo,
      color: Color(int.parse(color)),
      times: times.map((e) => e.mapToModel()).toList(),
    );
  }
}
