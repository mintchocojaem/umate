import 'package:flutter/foundation.dart';

import '../../../../../core/utils/app_exception.dart';

@immutable
sealed class SignUpNicknameState {
  const SignUpNicknameState();
}

final class SignUpNicknameInitial extends SignUpNicknameState {
  const SignUpNicknameInitial();
}

final class SignUpNicknameLoading extends SignUpNicknameState {
  const SignUpNicknameLoading();
}

final class SignUpNicknameVerified extends SignUpNicknameState {
  final String verifiedNickname;

  const SignUpNicknameVerified({
    required this.verifiedNickname,
  });
}

final class SignUpNicknameConfirmed extends SignUpNicknameState {
  final String confirmedNickname;

  const SignUpNicknameConfirmed({
    required this.confirmedNickname,
  });
}

final class SignUpNicknameFailure extends SignUpNicknameState {
  final AppException exception;

  const SignUpNicknameFailure({
    required this.exception,
  });
}
