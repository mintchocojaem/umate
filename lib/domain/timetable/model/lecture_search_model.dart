import 'package:danvery/domain/timetable/model/lecture_time.dart';

class LectureSearchModel{
  int id;
  String lectureCode;
  String name;
  String category;
  String professor;
  int classNumber;
  int credit;
  List<LectureTime> times;

  LectureSearchModel({
    required this.id,
    required this.lectureCode,
    required this.name,
    required this.category,
    required this.professor,
    required this.classNumber,
    required this.credit,
    required this.times
  });

  factory LectureSearchModel.fromJson(Map<String, dynamic> json) {
    return LectureSearchModel(
      id: json['id'],
      lectureCode: json['lectureCode'],
      name: json['name'],
      category: json['category'],
      professor: json['professor'],
      classNumber: json['classNumber'],
      credit: json['credit'],
      times: (json['times'] as List? ?? []).map((e) => LectureTime.fromJson(e)).toList()
    );
  }

}
