import 'package:flutter/material.dart';

import 'schedule_time_format.dart';
import 'week_days.dart';

@immutable
class ScheduleTime {
  final ScheduleTimeFormat startTime;
  final ScheduleTimeFormat endTime;
  final WeekDays day;
  final String place;

  const ScheduleTime({
    required this.startTime,
    required this.endTime,
    required this.day,
    this.place = '',
  });

}
