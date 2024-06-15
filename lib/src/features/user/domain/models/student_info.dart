import 'package:json_annotation/json_annotation.dart';

part 'student_info.g.dart';

@JsonSerializable()
class StudentInfo {
  final String studentName;
  final String studentId;
  final String major;
  final String age;
  final String gender;

  StudentInfo({
    required this.studentName,
    required this.studentId,
    required this.major,
    required this.age,
    required this.gender,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) =>
      _$StudentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$StudentInfoToJson(this);
}
