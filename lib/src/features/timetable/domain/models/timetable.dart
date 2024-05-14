import 'package:flutter/foundation.dart';

import 'schedule.dart';

@immutable
class Timetable{

  final int id;
  final String name;
  final List<Schedule> schedules;
  final int startHour;
  final int endHour;
  final int weekdays;

  const Timetable({
    required this.id,
    required this.name,
    required this.schedules,
    required this.startHour,
    required this.endHour,
    required this.weekdays,
  });

  Timetable copyWith({
    String? name,
    List<Schedule>? schedules,
    int? startHour,
    int? endHour,
    int? weekdays,
  }) {
    return Timetable(
      id: id,
      name: name ?? this.name,
      schedules: schedules ?? this.schedules,
      startHour: startHour ?? this.startHour,
      endHour: endHour ?? this.endHour,
      weekdays: weekdays ?? this.weekdays,
    );
  }

}