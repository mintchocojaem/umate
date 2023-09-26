import 'package:dio/dio.dart';

import '../utils/exception_handler.dart';

abstract base class Repository {
  final Dio dio;
  final ExceptionHandler exceptionHandler = ExceptionHandler();

  Repository(this.dio);

  Future<dynamic> fetch(Function function) async {
    try {
      return await function();
    } on DioException catch (e) {
      final exception = e.response?.statusCode != 200 ? const ExceptionDto() : ExceptionDto(
        code : e.response!.data['code'].toString(),
        message : e.response!.data['message'].first.toString(),
      );
      exceptionHandler.invokeException(exception.message);
    }
  }

}
