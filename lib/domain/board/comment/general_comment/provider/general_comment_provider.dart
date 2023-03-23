import 'package:danvery/domain/board/comment/general_comment/model/general_comment_list_model.dart';
import 'package:dio/dio.dart';

class GeneralCommentProvider {
  final Dio dio;

  GeneralCommentProvider({required this.dio});

  Future<GeneralCommentListModel?> getGeneralComment(String token, int id) async {
    String url = '/post/general-forum/comment/$id?page=0&size=20';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await dio.get(url,
          options: Options(
            headers: headers,
          ));

      return GeneralCommentListModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }

}
