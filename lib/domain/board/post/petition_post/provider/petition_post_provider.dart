import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../model/petition_post_model.dart';

class PetitionPostProvider {
  final Dio _dio;

  static final PetitionPostProvider singleton =
      PetitionPostProvider._internal(DioInterceptor().dio);

  PetitionPostProvider._internal(this._dio);

  factory PetitionPostProvider() => singleton;

  Future<ApiResponseDTO> getPetitionPost(String token, int petitionId) async {
    String url = '/post/petition/$petitionId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.get(url,
          options: Options(
            headers: headers,
          ));

      return SuccessResponseDTO(data: PetitionPostModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> agreePetitionPost(String token, int petitionId) async{
    String url = '/post/petition/agree/$petitionId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.post(url,
          options: Options(
            headers: headers,
          )
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

}
