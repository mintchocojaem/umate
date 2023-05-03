import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:danvery/domain/banner/model/banner_list_model.dart';
import 'package:dio/dio.dart';

class BannerProvider {
  final Dio _dio;

  BannerProvider._internal(this._dio);

  static final BannerProvider _singleton =
      BannerProvider._internal(DioInterceptor().dio);

  factory BannerProvider() => _singleton;

  Future<ApiResponseDTO> getBannerList() async {
    String url = "https://kr1-api-object-storage.nhncloudservice.com/v1/AUTH_34f4838a2b3047f39ac9cb0701558e46/main-storage/banner/banner.json";
    final response = await _dio.get(url);
    try {

      return SuccessResponseDTO(
        data: BannerListModel.fromJson(response.data),
      );
    } on DioError catch (e) {
      return ExceptionResponseDTO(
        message: e.message,
      );
    }

  }

}
