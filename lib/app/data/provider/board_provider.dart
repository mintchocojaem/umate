import 'dart:convert';

import 'package:danvery/app/data/model/petition_model.dart';
import 'package:danvery/app/data/model/post_model.dart';
import 'package:danvery/app/data/provider/url.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BoardProvider extends GetConnect {
  Future<List<PostModel>> getSuggestionBoardList(
      String accessToken, int page, int size) async {
    String url =
        '$apiUrl/api/suggestion?page=$page&size=$size&sort=createDate,desc';
    final headers = {
      "x-aut-token": accessToken
    };

    final Response response = await get(url, contentType: "application/json",headers: headers);

    if (kDebugMode) {
      print("getSuggestionBoardList : ${response.statusCode}");
    }

    if (response.status.hasError || response.body == null) {
      throw Exception('GetSuggestionBoardList Error');
    } else {

      return json.decode(utf8.decode(await response.bodyBytes!.elementAt(0)))["content"]
          .map<PostModel>((json) => PostModel.fromJson(json))
          .toList();
    }
  }

  Future<List<PetitionModel>> getPetitionBoardList(
      String accessToken, int page, int size) async {
    String url =
        '$apiUrl/api/petition';
    final headers = {
      "x-aut-token": accessToken
    };

    final Response response = await get(url, contentType: "application/json",headers: headers);

    if (kDebugMode) {
      print('getPetitionBoardList : ${response.statusCode}');
    }

    if (response.status.hasError || response.body == null) {
      throw Exception('GetPetitionBoardList Error');
    } else {
      return json.decode(utf8.decode(await response.bodyBytes!.elementAt(0)))["content"]
          .map<PetitionModel>((json) => PetitionModel.fromJson(json))
          .toList();
    }
  }
}
