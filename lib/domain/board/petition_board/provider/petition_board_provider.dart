import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:danvery/domain/board/petition_board/model/petition_board_model.dart';
import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:dio/dio.dart';

class PetitionBoardProvider {
  final Dio _dio;

  PetitionBoardProvider._internal(this._dio);

  static final PetitionBoardProvider _singleton =
      PetitionBoardProvider._internal(DioInterceptor().dio);

  factory PetitionBoardProvider() => _singleton;

  Future<ApiResponseDTO> getPetitionPostBoard(
      int page, int size, String status, String keyword) async {
    String url =
        '/post/petition?page=$page&size=$size&status=$status&keyword=$keyword&sort=createdAt,desc&bodySize=100';

    try {
      final Response response = await _dio.get(url);
      return SuccessResponseDTO(
          data: PetitionBoardModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }
}
