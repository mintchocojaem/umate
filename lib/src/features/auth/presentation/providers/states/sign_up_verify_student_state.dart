import 'package:flutter/foundation.dart';

import '../../../../../core/utils/app_exception.dart';
import '../../../domain/models/sign_up_info_model.dart';

@immutable
sealed class SignUpVerifyStudentState{
  const SignUpVerifyStudentState();
}

final class SignUpVerifyStudentInitial extends SignUpVerifyStudentState {
  const SignUpVerifyStudentInitial();
}

final class SignUpVerifyStudentLoading extends SignUpVerifyStudentState {
  const SignUpVerifyStudentLoading();
}

final class SignUpVerifyStudentSuccess extends SignUpVerifyStudentState {
  final SignUpInfoModel signUpInfo;

  const SignUpVerifyStudentSuccess({
    required this.signUpInfo,
  });
}

final class SignUpVerifyStudentFailure extends SignUpVerifyStudentState {
  final AppException exception;

  const SignUpVerifyStudentFailure({
    required this.exception,
  });
}