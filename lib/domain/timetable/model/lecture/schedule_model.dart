import 'package:flutter/material.dart';

import 'schedule_time.dart';

enum ScheduleType{
  lecture,
  schedule,
}

extension ScheduleTypeExtension on ScheduleType{
  String get name => [
    'LECTURE',
    'SCHEDULE',
  ][index];
}

class ScheduleModel{
  String id = UniqueKey().toString();
  ScheduleType type;
  String name;
  List<ScheduleTime> times;
  Color color;
  String? memo;

  ScheduleModel({
    required this.type,
    required this.name,
    required this.color,
    required this.times,
    this.memo
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      type: ScheduleType.values.firstWhere((element) => element.name == json['type']),
      name: json['name'],
      color: Color(int.parse(json['color'])),
      times: List<ScheduleTime>.from(json['times'].map((x) => ScheduleTime.fromJson(x))),
      memo: json['memo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'color': color.value.toString(),
    'memo': memo,
    'type': type.name,
    'times': List<dynamic>.from(times.map((x) => x.toJson())),
  };

}
