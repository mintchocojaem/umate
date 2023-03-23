import 'package:dio/dio.dart';

import '../model/general_post_model.dart';

class GeneralPostProvider {

  final Dio dio;
  GeneralPostProvider({required this.dio});

  Future<bool> createGeneralPost(String token, GeneralPostModel postModel) async {

    String url = '/post/general-forum';

    final data = FormData.fromMap({
      'title': postModel.title,
      'body': postModel.body,
    });

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {

      await dio.post(url, data: data,
          options: Options(contentType: "multipart/form-data", headers: headers)
      );

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
      await dio.delete(url, options: Options(headers: headers));

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
      final Response response = await dio.get(url,
          options: Options(headers: headers,));

      return GeneralPostModel.fromJson(response.data);
    } catch (_) {
      return null;
    }

  }

  Future<List<GeneralPostModel>?> getGeneralBoard(int page, int size) async {

    String url = '/post/general-forum?page=$page&size=$size';

    try {
      final Response response = await dio.get(url);

        return response.data["content"]
            .map<GeneralPostModel>((json) => GeneralPostModel.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

}
