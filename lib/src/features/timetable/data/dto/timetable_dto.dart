import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/timetable.dart';
import 'schedule_dto.dart';

part 'timetable_dto.g.dart';

@JsonSerializable()
@immutable
class TimetableDTO extends DataMapper<Timetable> {
  final int id;
  final String name;
  final List<ScheduleDTO>? lectures;

  TimetableDTO({
    required this.id,
    required this.name,
    this.lectures,
  });

  factory TimetableDTO.fromJson(Map<String, dynamic> json) =>
      _$TimetableDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TimetableDTOToJson(this);

  @override
  Timetable mapToModel() {
    // TODO: implement mapToModel
    return Timetable(
      id: id,
      name: name,
      schedules: (lectures ?? []).map((e) => e.mapToModel()).toList(),
      startHour: 9,
      endHour: 24,
      weekdays: 5,
    );
  }
}
