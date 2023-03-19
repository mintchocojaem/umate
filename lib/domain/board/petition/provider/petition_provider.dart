import 'package:dio/dio.dart';

import '../model/petition_model.dart';

class PetitionProvider{

  final Dio dio;
  PetitionProvider({required this.dio});

  Future<List<PetitionModel>?> getPetitionBoard(int page, int size) async {
    String url = '/post/petition?page=$page&size=$size';

    try {
      final Response response = await dio.get(url);

      return response.data["content"]
          .map<PetitionModel>((json) => PetitionModel.fromJson(json)).toList();
    } catch (_) {
      return null;
    }

  }

}
