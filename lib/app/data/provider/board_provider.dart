import 'dart:convert';

import 'package:danvery/app/data/model/petition_model.dart';
import 'package:danvery/app/data/model/post_model.dart';
import 'package:danvery/app/data/provider/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BoardProvider{

  final dio = Dio();

  Future<List<PostModel>?> getGeneralBoard(int page, int size) async {

    String url =
        '$apiUrl/post/general-forum?page=$page&size=$size';

    try {
      final Response response = await dio.get(url,
          options: Options(contentType: "application/json", responseType: ResponseType.bytes));

      if (kDebugMode) {
        print("getGeneralBoard : ${response.statusCode}");
      }

      if (response.statusCode != 200) {
        throw Exception('GetGeneralBoard Error');
      } else {

        return json.decode(utf8.decode(response.data))["content"]
            .map<PostModel>((json) => PostModel.fromJson(json)).toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<List<PetitionModel>?> getPetitionBoard(int page, int size) async {
    String url =
        '$apiUrl/post/petition?page=$page&size=$size';

    try {
      final Response response = await dio.get(url,
          options: Options(contentType: "application/json", responseType: ResponseType.bytes));

      if (kDebugMode) {
        print('getPetitionBoard : ${response.statusCode}');
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
