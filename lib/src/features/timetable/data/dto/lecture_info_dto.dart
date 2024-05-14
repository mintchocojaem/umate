import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/lecture_info.dart';
import 'schedule_time_dto.dart';


part 'lecture_info_dto.g.dart';

@JsonSerializable()
@immutable
class LectureInfoDTO extends DataMapper<LectureInfo> {
  final String? major;
  final int grade;
  final String lectureCode;
  final String category;
  final String name;
  final String professor;
  final int classNumber;
  final int credit;
  final List<ScheduleTimeDTO> times;

  LectureInfoDTO({
    required this.name,
    this.major,
    required this.grade,
    required this.lectureCode,
    required this.category,
    required this.professor,
    required this.classNumber,
    required this.credit,
    required this.times,
  });

  factory LectureInfoDTO.fromJson(Map<String, dynamic> json) =>
      _$LectureInfoDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LectureInfoDTOToJson(this);

  @override
  LectureInfo mapToModel() {
    // TODO: implement mapToModel
    return LectureInfo(
      lectureName: name,
      major: major ?? '',
      grade: grade,
      lectureCode: lectureCode,
      category: category,
      professor: professor,
      classNumber: classNumber,
      credit: credit,
      scheduleTimes: times.map((e) => e.mapToModel()).toList(),
    );
  }
}
