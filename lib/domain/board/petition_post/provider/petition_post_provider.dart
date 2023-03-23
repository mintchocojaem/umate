import 'package:dio/dio.dart';

import '../model/petition_post_model.dart';

class PetitionPostProvider{

  final Dio dio;
  PetitionPostProvider({required this.dio});

  Future<PetitionPostModel?> getPetitionPost(String token, int id) async {
    String url = '/post/petition/$id';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await dio.get(url,
          options: Options(headers: headers,));

      return PetitionPostModel.fromJson(response.data);
    } catch (_) {
      return null;
    }

  }

  Future<List<PetitionPostModel>?> getPetitionPostBoard(int page, int size, String status) async {
    String url = '/post/petition?page=$page&size=$size&status=$status';

    try {
      final Response response = await dio.get(url);

      return response.data["content"]
          .map<PetitionPostModel>((json) => PetitionPostModel.fromJson(json)).toList();
    } catch (_) {
      return null;
    }

  }

}
