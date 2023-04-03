import 'package:flutter/material.dart';

class SubjectModel{
  late String name;
  late String? code;
  late String startTime;
  late String endTime;
  late String? professor;
  late String place;
  late String? dept;
  late List<String> days;
  late Color color;

  SubjectModel({
    name,
    code,
    startTime,
    endTime,
    professor,
    place,
    dept,
    days,
    color
  });

}
