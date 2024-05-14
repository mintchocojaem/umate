import 'package:flutter/material.dart';

import 'schedule_time.dart';

@immutable
class LectureInfo{
  final String lectureName;
  final String major;
  final int grade;
  final String lectureCode;
  final String category;
  final String professor;
  final int classNumber;
  final int credit;
  final List<ScheduleTime> scheduleTimes;

  const LectureInfo({
    required this.lectureName,
    required this.major,
    required this.grade,
    required this.lectureCode,
    required this.category,
    required this.professor,
    required this.classNumber,
    required this.credit,
    required this.scheduleTimes,
  });
}