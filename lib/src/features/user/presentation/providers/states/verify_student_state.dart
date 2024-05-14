import 'package:flutter/foundation.dart';

import '../../../domain/models/sign_up_info.dart';

@immutable
sealed class VerifyStudentState{
  const VerifyStudentState();
}

final class VerifyStudentInitialState extends VerifyStudentState {
  const VerifyStudentInitialState();
}

final class VerifyStudentLoadingState extends VerifyStudentState {
  const VerifyStudentLoadingState();
}

final class VerifyStudentSuccessState extends VerifyStudentState {
  final SignUpInfo? signUpInfo;

  const VerifyStudentSuccessState({
    this.signUpInfo,
  });
}

final class VerifyStudentWarningState extends VerifyStudentState {
  final String message;

  const VerifyStudentWarningState({
    required this.message,
  });
}

final class VerifyStudentFailureState extends VerifyStudentState {
  final String message;

  const VerifyStudentFailureState({
    required this.message,
  });
}