import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:danvery/domain/check_update/model/check_update_model.dart';
import 'package:dio/dio.dart';

class CheckUpdateProvider {
  final Dio _dio;

  CheckUpdateProvider._internal(this._dio);

  static final CheckUpdateProvider _singleton =
  CheckUpdateProvider._internal(DioInterceptor().dio);

  factory CheckUpdateProvider() => _singleton;

  Future<ApiResponseDTO> getUpdate() async {
    String url = "https://kr1-api-object-storage.nhncloudservice.com/v1/AUTH_34f4838a2b3047f39ac9cb0701558e46/main-storage/remote_config/remote_config.json";
    final response = await _dio.get(url);
    try {

      return SuccessResponseDTO(
        data: CheckUpdateModel.fromJson(response.data),
      );
    } on DioError catch (e) {
      return ExceptionResponseDTO(
        message: e.message,
      );
    }

  }

}
