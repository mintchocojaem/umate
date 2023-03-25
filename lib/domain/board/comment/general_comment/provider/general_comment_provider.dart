import 'package:danvery/domain/board/comment/general_comment/model/general_comment_list_model.dart';
import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

class GeneralCommentProvider {
  final Dio _dio;

  static final GeneralCommentProvider _singleton =
      GeneralCommentProvider._internal(DioInterceptor().dio);

  GeneralCommentProvider._internal(this._dio);

  factory GeneralCommentProvider() => _singleton;

  Future<GeneralCommentListModel?> getGeneralComment(String token, int id) async {
    String url = '/post/general-forum/comment/$id?page=0&size=20';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.get(url,
          options: Options(
            headers: headers,
          ));

      return GeneralCommentListModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }

}
