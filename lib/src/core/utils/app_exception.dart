import 'package:flutter/foundation.dart';

@immutable
abstract class AppException {
  final String message;
  final StackTrace stackTrace;

  const AppException({
    required this.message,
    required this.stackTrace,
  });
}

final class AppError extends AppException {
  const AppError({
    final String? message,
    required super.stackTrace,
  }) : super(message: message ?? '알 수 없는 오류가 발생했어요.');

  @override
  toString() => 'AppError > message : $message, stackTrace : $stackTrace';
}

final class AppWarning extends AppException {
  const AppWarning({
    final String? message,
    required super.stackTrace,
  }) : super(message: message ?? '알 수 없는 경고가 발생했어요.');

  @override
  toString() => 'AppWarning > message : $message, stackTrace : $stackTrace';
}
