import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

class GeneralPostProvider {
  final Dio _dio;

  static final GeneralPostProvider _singleton =
      GeneralPostProvider._internal(DioInterceptor().dio);

  GeneralPostProvider._internal(this._dio);

  factory GeneralPostProvider() => _singleton;

  Future<bool> writeGeneralPost(
      String token, GeneralPostModel postModel) async {
    String url = '/post/general-forum';

    final data = FormData.fromMap({
      'title': postModel.title,
      'body': postModel.body,
    });

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      await _dio.post(url,
          data: data,
          options:
              Options(contentType: "multipart/form-data", headers: headers));

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteGeneralPost(String token, int id) async {
    String url = '/post/general-forum/$id';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      await _dio.delete(url, options: Options(headers: headers));

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<GeneralPostModel?> getGeneralPost(String token, int id) async {
    String url = '/post/general-forum/$id';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.get(url,
          options: Options(
            headers: headers,
          ));

      return GeneralPostModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }

  Future<List<GeneralPostModel>?> getGeneralBoard(
      int page, int size, String keyword) async {
    String url =
        '/post/general-forum?page=$page&size=$size&keyword=$keyword';

    try {
      final Response response = await _dio.get(url);

      return response.data["content"]
          .map<GeneralPostModel>((json) => GeneralPostModel.fromJson(json))
          .toList();
    } catch (e) {
      return null;
    }
  }
}
