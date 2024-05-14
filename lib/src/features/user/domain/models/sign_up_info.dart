import 'package:flutter/foundation.dart';

import 'student.dart';

@immutable
final class SignUpInfo {
  final String signUpToken;
  final Student student;

  const SignUpInfo({
    required this.signUpToken,
    required this.student,
  });
}
