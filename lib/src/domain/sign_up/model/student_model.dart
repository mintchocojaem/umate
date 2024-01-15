import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_model.freezed.dart';
part 'student_model.g.dart';


@freezed
class StudentModel with _$StudentModel {
  const factory StudentModel({
    required String studentName,
    required String studentId,
    required String major,
    required String age,
    required String gender,
  }) = _StudentModel;

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);
}