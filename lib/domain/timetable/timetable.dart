
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timetable.freezed.dart';
part 'timetable.g.dart';

@freezed
class Timetable with _$Timetable {
  const factory Timetable({
    required int id,
    required String name,
    List<Lecture>? lectures,
  }) = _Timetable;

  factory Timetable.fromJson(Map<String, dynamic> json) =>
      _$TimetableFromJson(json);
}

@freezed
class Lecture with _$Lecture {
  const factory Lecture({
    required String name,
    required String memo,
    required String type,
    required String color,
    required List<LectureTime> times,
  }) = _Lecture;

  factory Lecture.fromJson(Map<String, dynamic> json) =>
      _$LectureFromJson(json);

}

@freezed
class LectureTime with _$LectureTime {
  const factory LectureTime({
    required String start,
    required String end,
    required String week,
    String? place,
  }) = _LectureTime;

  factory LectureTime.fromJson(Map<String, dynamic> json) =>
      _$LectureTimeFromJson(json);

}

@freezed
class LectureInfo with _$LectureInfo {
  const factory LectureInfo({
    String? major,
    int? grade,
    required String lectureCode,
    required String category,
    required String name,
    required String professor,
    required int classNumber,
    required int credit,
    required List<LectureTime> times,
  }) = _LectureInfo;

  factory LectureInfo.fromJson(Map<String, dynamic> json) =>
      _$LectureInfoFromJson(json);
}