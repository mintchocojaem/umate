import 'package:danvery/domain/timetable/model/lecture/lecture_model.dart';

class TimetableModel{
  final int id;
  String? name;
  List<LectureModel> lectures;

  TimetableModel({
    required this.id,
    this.name,
    required this.lectures
  });

  factory TimetableModel.fromJson(Map<String, dynamic> json) {
    return TimetableModel(
      id: json['id'] as int,
      name: json['name'] as String?,
      lectures: (json['lectures'] as List).map((e) => LectureModel.fromJson(e)).toList()
    );
  }

}
