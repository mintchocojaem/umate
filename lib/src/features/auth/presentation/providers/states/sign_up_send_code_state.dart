import 'package:flutter/foundation.dart';

import '../../../../../core/utils/app_exception.dart';

@immutable
sealed class SignUpSendCodeState{
  const SignUpSendCodeState();
}

final class SignUpSendCodeInitial extends SignUpSendCodeState {
  const SignUpSendCodeInitial();
}

final class SignUpSendCodeLoading extends SignUpSendCodeState {
  const SignUpSendCodeLoading();
}

final class SignUpSendCodeSuccess extends SignUpSendCodeState {
  final String phoneNumber;
  const SignUpSendCodeSuccess({
    required this.phoneNumber,
  });
}

final class SignUpSendCodeFailure extends SignUpSendCodeState {
  final AppException exception;

  const SignUpSendCodeFailure({
    required this.exception,
  });
}