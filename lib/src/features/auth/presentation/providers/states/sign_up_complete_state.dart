import 'package:flutter/foundation.dart';

import '../../../../../core/utils/app_exception.dart';

@immutable
sealed class SignUpCompleteState{
  const SignUpCompleteState();
}

final class SignUpCompleteInitial extends SignUpCompleteState {
  const SignUpCompleteInitial();
}

final class SignUpCompleteLoading extends SignUpCompleteState {
  const SignUpCompleteLoading();
}

final class SignUpCompleteSuccess extends SignUpCompleteState {
  const SignUpCompleteSuccess();
}

final class SignUpCompleteFailure extends SignUpCompleteState {
  final AppException exception;

  const SignUpCompleteFailure({
    required this.exception,
  });
}