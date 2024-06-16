import 'package:json_annotation/json_annotation.dart';

import 'schedule_time.dart';

part 'lecture_info.g.dart';

@JsonSerializable()
class LectureInfo{
  final String major;
  final int grade;
  final String lectureCode;
  final String category;
  final String name;
  final String professor;
  final int classNumber;
  final int credit;
  final List<ScheduleTime> times;

  LectureInfo({
    required this.name,
    this.major = '',
    required this.grade,
    required this.lectureCode,
    required this.category,
    required this.professor,
    required this.classNumber,
    required this.credit,
    required this.times,
  });

  factory LectureInfo.fromJson(Map<String, dynamic> json) =>
      _$LectureInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LectureInfoToJson(this);
}