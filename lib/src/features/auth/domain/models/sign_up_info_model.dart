import 'student_model.dart';

class SignUpInfoModel{
  final String signUpToken;
  final StudentModel student;

  SignUpInfoModel({
    required this.signUpToken,
    required this.student,
  });
}