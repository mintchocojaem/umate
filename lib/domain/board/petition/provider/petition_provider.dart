import 'package:dio/dio.dart';

import '../model/petition_model.dart';

class PetitionProvider{

  final Dio dio;
  PetitionProvider({required this.dio});

  Future<PetitionModel?> getPetition(String token, int id) async {
    String url = '/post/petition/$id';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await dio.get(url,
          options: Options(headers: headers,));

      return PetitionModel.fromJson(response.data);
    } catch (_) {
      return null;
    }

  }

  Future<List<PetitionModel>?> getPetitionBoard(int page, int size, String status) async {
    String url = '/post/petition?page=$page&size=$size&status=$status';

    try {
      final Response response = await dio.get(url);

      return response.data["content"]
          .map<PetitionModel>((json) => PetitionModel.fromJson(json)).toList();
    } catch (_) {
      return null;
    }

  }

}
