import 'dart:convert';

import 'package:danvery/utils/url/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/petition_model.dart';

class PetitionProvider{

  final dio = Dio();

  Future<List<PetitionModel>?> getPetitionBoard(int page, int size) async {
    String url =
        '$apiUrl/post/petition?page=$page&size=$size';

    try {
      final Response response = await dio.get(url,
          options: Options(contentType: "application/json", responseType: ResponseType.bytes));

      if (kDebugMode) {
        print('GetPetitionBoard : ${response.statusCode}');
      }

      if (response.statusCode != 200) {
        throw Exception('GetPetitionBoard Error');
      } else {
        return json.decode(utf8.decode(response.data))["content"]
            .map<PetitionModel>((json) => PetitionModel.fromJson(json))
            .toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }

  }

}
