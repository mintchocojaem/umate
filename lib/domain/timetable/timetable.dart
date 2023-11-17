import 'package:freezed_annotation/freezed_annotation.dart';

part 'timetable.freezed.dart';
part 'timetable.g.dart';

@freezed
class Timetable with _$Timetable{
  const factory Timetable({
    required int id,
    required String name,
    List<Lecture>? lectures,
  }) = _Timetable;

  factory Timetable.fromJson(Map<String, dynamic> json) => _$TimetableFromJson(json);
}

@freezed
class Lecture with _$Lecture{
  const factory Lecture({
    required String name,
    required String memo,
    required String type,
    required String color,
    required List<LectureTime> times,
  }) = _Lecture;

  factory Lecture.fromJson(Map<String, dynamic> json) => _$LectureFromJson(json);
}

@freezed
class LectureTime with _$LectureTime{
  const factory LectureTime({
    required String start,
    required String end,
    required String week,
    required String place,
  }) = _LectureTime;

  factory LectureTime.fromJson(Map<String, dynamic> json) => _$LectureTimeFromJson(json);
}