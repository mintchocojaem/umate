sealed class CustomException implements Exception {
  final String message;
  final StackTrace stackTrace;

  const CustomException({
    required this.message,
    required this.stackTrace,
  });
}

class AppException extends CustomException {

  @override
  toString() => 'AppException: message = $message, stackTrace = $stackTrace';

  const AppException({
    final String? message,
    required super.stackTrace,
  }) : super(message: message ?? '알 수 없는 오류가 발생했어요.');
}