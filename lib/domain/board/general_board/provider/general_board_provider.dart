import 'package:danvery/domain/board/general_board/model/general_board_model.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

class GeneralBoardProvider {
  final Dio _dio;

  static final GeneralBoardProvider _singleton =
  GeneralBoardProvider._internal(DioInterceptor().dio);

  GeneralBoardProvider._internal(this._dio);

  factory GeneralBoardProvider() => _singleton;

  Future<GeneralBoardModel?> getGeneralBoard(
      int page, int size, String keyword) async {
    String url =
        '/post/general-forum?page=$page&size=$size&keyword=$keyword';

    try {
      final Response response = await _dio.get(url);

      return GeneralBoardModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
