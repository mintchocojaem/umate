import 'package:flutter/material.dart';

import 'lecture_time.dart';

class LectureModel{
  String id = UniqueKey().toString();
  String name;
  List<LectureTime> times;
  Color color;
  String? memo;

  LectureModel({
    required this.name,
    required this.color,
    required this.times,
    this.memo
  });

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      name: json['name'],
      color: Color(int.parse(json['color'])),
      times: List<LectureTime>.from(json['times'].map((x) => LectureTime.fromJson(x))),
      memo: json['memo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'color': color.value.toString(),
    'memo': memo,
    'times': List<dynamic>.from(times.map((x) => x.toJson())),
  };

}
