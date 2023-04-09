import 'package:flutter/material.dart';

class LectureModel{
  String name;
  String? code;
  String startTime;
  String endTime;
  String? professor;
  String place;
  String? dept;
  List<String> days;
  Color color;

  LectureModel({
    this.code,
    required this.startTime,
    required this.endTime,
    this.professor,
    required this.place,
    this.dept,
    required this.name,
    required this.days,
    required this.color
  });

}
