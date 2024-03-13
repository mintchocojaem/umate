import 'student_model.dart';

class SignUpInfoModel{
  final String signUpToken;
  final StudentModel student;

  SignUpInfoModel({
    required this.signUpToken,
    required this.student,
  });

  SignUpInfoModel copyWith({
    String? signUpToken,
    StudentModel? student,
  }) {
    return SignUpInfoModel(
      signUpToken: signUpToken ?? this.signUpToken,
      student: student ?? this.student,
    );
  }

}