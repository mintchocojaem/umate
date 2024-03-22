import 'package:flutter/foundation.dart';

import '../../../../../core/utils/app_exception.dart';

@immutable
sealed class SignUpVerifyCodeState {
  const SignUpVerifyCodeState();
}

final class SignUpVerifyCodeInitial extends SignUpVerifyCodeState {
  const SignUpVerifyCodeInitial();
}

final class SignUpVerifyCodeLoading extends SignUpVerifyCodeState {
  const SignUpVerifyCodeLoading();
}

final class SignUpVerifyCodeSuccess extends SignUpVerifyCodeState {
  const SignUpVerifyCodeSuccess();
}

final class SignUpVerifyCodeFailure extends SignUpVerifyCodeState {
  final AppException exception;

  const SignUpVerifyCodeFailure({
    required this.exception,
  });
}
