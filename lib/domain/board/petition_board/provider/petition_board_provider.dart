import 'package:danvery/domain/board/petition_board/model/petition_board_model.dart';
import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

class PetitionBoardProvider{
  final Dio _dio;

  static final PetitionBoardProvider _singleton =
  PetitionBoardProvider._internal(DioInterceptor().dio);

  PetitionBoardProvider._internal(this._dio);

  factory PetitionBoardProvider() => _singleton;

  Future<PetitionBoardModel?> getPetitionPostBoard(
      int page, int size, String status) async {
    String url = '/post/petition?page=$page&size=$size&status=$status';

    try {
      final Response response = await _dio.get(url);
      return PetitionBoardModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }
}
