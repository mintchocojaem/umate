import 'package:flutter/foundation.dart';

import '../../../../../core/utils/app_exception.dart';
import '../../../domain/models/token_model.dart';

@immutable
sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginSuccess extends LoginState {
  final TokenModel token;

  const LoginSuccess({
    required this.token,
  });
}

final class LoginFailure extends LoginState {
  final AppException exception;

  const LoginFailure({
    required this.exception,
  });
}
