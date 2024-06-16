import 'package:json_annotation/json_annotation.dart';

import 'schedule.dart';

part 'timetable.g.dart';

@JsonSerializable()
class Timetable {
  final int id;
  final String name;
  @JsonKey(name: 'lectures')
  final List<Schedule> schedules;
  final int startHour;
  final int endHour;
  final int weekdays;

  Timetable({
    required this.id,
    required this.name,
    this.schedules = const [],
    this.startHour = 8,
    this.endHour = 24,
    this.weekdays = 5,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) =>
      _$TimetableFromJson(json);

  Map<String, dynamic> toJson() => _$TimetableToJson(this);

  Timetable copyWith({
    int? id,
    String? name,
    List<Schedule>? schedules,
    int? startHour,
    int? endHour,
    int? weekdays,
  }) {
    return Timetable(
      id: id ?? this.id,
      name: name ?? this.name,
      schedules: schedules ?? this.schedules,
      startHour: startHour ?? this.startHour,
      endHour: endHour ?? this.endHour,
      weekdays: weekdays ?? this.weekdays,
    );
  }
}
