import 'package:flutter/foundation.dart';

import '../../../domain/models/token.dart';

@immutable
sealed class LoginState {
  const LoginState();
}

final class LoginInitialState extends LoginState {
  const LoginInitialState();
}

final class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

final class LoginSuccessState extends LoginState {
  final Token token;

  const LoginSuccessState({
    required this.token,
  });
}

final class LoginFailureState extends LoginState {
  final String message;

  const LoginFailureState({
    required this.message,
  });
}
