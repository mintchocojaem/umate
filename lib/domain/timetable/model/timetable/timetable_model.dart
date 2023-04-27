import 'package:danvery/domain/timetable/model/lecture/schedule_model.dart';

class TimetableModel{
  final int id;
  String? name;
  List<ScheduleModel> schedules;

  TimetableModel({
    required this.id,
    this.name,
    required this.schedules
  });

  factory TimetableModel.fromJson(Map<String, dynamic> json) {
    return TimetableModel(
      id: json['id'] as int,
      name: json['name'] as String?,
      schedules: (json['lectures'] as List).map((e) => ScheduleModel.fromJson(e)).toList()
    );
  }

}
