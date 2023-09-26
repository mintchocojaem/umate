import 'package:dio/dio.dart';

import '../main.dart';
import '../utils/exception_handler.dart';

abstract base class Repository {
  final Dio dio;

  Repository(this.dio);

  ExceptionDto invokeException(DioException e) {
    final exception = e.response == null ? const ExceptionDto() : ExceptionDto(
      code : e.response!.data['code'].toString(),
      message : e.response!.data['message'].first.toString(),
    );
    exceptionHandler.invokeException(exception.message);
    return exception;
  }
}
