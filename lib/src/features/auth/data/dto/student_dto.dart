import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/student_model.dart';

part 'student_dto.g.dart';

@JsonSerializable()
class StudentDto extends DataMapper<StudentModel> {
  final String studentName;
  final String studentId;
  final String major;
  final String age;
  final String gender;

  StudentDto({
    required this.studentName,
    required this.studentId,
    required this.major,
    required this.age,
    required this.gender,
  });

  factory StudentDto.fromJson(Map<String, dynamic> json) =>
      _$StudentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StudentDtoToJson(this);

  @override
  StudentModel mapToModel() {
    return StudentModel(
      studentName: studentName,
      studentId: studentId,
      major: major,
      age: int.parse(age),
      gender: gender,
    );
  }
}
