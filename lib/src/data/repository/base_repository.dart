import 'package:dio/dio.dart';
import '../data.dart';

enum RequestType {
  get("GET"),
  post("POST"),
  patch("PATCH");

  final String value;

  const RequestType(this.value);

  get name => value;
}

base class BaseRepository {
  final DioClient _dioClient = DioClient();

  Future<Response?> request({
    required RequestType requestType,
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    //dio request 할 때 공통적으로 처리할 내용 추가

    final request = switch (requestType) {
      RequestType.get => await _dioClient.dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
      RequestType.post => await _dioClient.dio.post(
          path,
          data: data,
          options: options,
          cancelToken: cancelToken,
        ),
      RequestType.patch => await _dioClient.dio.patch(
          path,
          data: data,
          options: options,
          cancelToken: cancelToken,
        ),
    };

    return request;
  }
}
