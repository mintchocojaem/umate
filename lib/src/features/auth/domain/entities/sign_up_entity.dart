import '../domain.dart';

class SignUpEntity{
  final String signUpToken;
  final StudentEntity student;

  SignUpEntity({
    required this.signUpToken,
    required this.student,
  });
}