import 'package:flutter/material.dart';

import 'schedule_time.dart';
import 'schedule_type.dart';

@immutable
class Schedule {
  final int id;
  final String name;
  final ScheduleType type;
  final String professor;
  final String memo;
  final Color color;
  final List<ScheduleTime> times;

  Schedule({
    int? id,
    required this.name,
    required this.type,
    this.professor = '',
    required this.memo,
    required this.color,
    required this.times,
  }) : id = id ?? UniqueKey().hashCode;

}
