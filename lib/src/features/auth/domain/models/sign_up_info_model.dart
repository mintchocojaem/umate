import 'package:flutter/foundation.dart';

import 'student_model.dart';

@immutable
final class SignUpInfoModel {
  final String signUpToken;
  final StudentModel student;

  const SignUpInfoModel({
    required this.signUpToken,
    required this.student,
  });
}
