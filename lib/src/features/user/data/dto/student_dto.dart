import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/student.dart';

part 'student_dto.g.dart';

@JsonSerializable()
@immutable
class StudentDTO extends DataMapper<Student> {
  final String studentName;
  final String studentId;
  final String major;
  final String age;
  final String gender;

  StudentDTO({
    required this.studentName,
    required this.studentId,
    required this.major,
    required this.age,
    required this.gender,
  });

  factory StudentDTO.fromJson(Map<String, dynamic> json) =>
      _$StudentDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StudentDTOToJson(this);

  @override
  Student mapToModel() {
    return Student(
      studentName: studentName,
      studentId: studentId,
      major: major,
      age: int.parse(age),
      gender: gender,
    );
  }
}
