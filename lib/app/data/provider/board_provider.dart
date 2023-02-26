import 'dart:convert';

import 'package:danvery/app/data/model/petition_model.dart';
import 'package:danvery/app/data/model/post_model.dart';
import 'package:danvery/app/data/provider/url.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class BoardProvider{
  Future<List<PostModel>?> getSuggestionBoardList(int page, int size) async {
    String url =
        '$apiUrl/api/suggestion?page=$page&size=$size&sort=createDate,desc';
    final headers = {
      "Content-Type": "application/json",
    };

    try {
      final http.Response response = await http.get(Uri.parse(url), headers:  headers);

      if (kDebugMode) {
        print("getSuggestionBoardList : ${response.statusCode}");
      }

      if (response.statusCode != 200) {
        throw Exception('GetSuggestionBoardList Error');
      } else {

        return json.decode(utf8.decode(response.bodyBytes))["content"]
            .map<PostModel>((json) => PostModel.fromJson(json))
            .toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<List<PetitionModel>?> getPetitionBoardList(int page, int size) async {
    String url =
        '$apiUrl/api/petition';
    final headers = {
      "Content-Type": "application/json",
    };

    try {
      final http.Response response = await http.get(Uri.parse(url),headers: headers);

      if (kDebugMode) {
        print('getPetitionBoardList : ${response.statusCode}');
      }

      if (response.statusCode != 200) {
        throw Exception('GetPetitionBoardList Error');
      } else {
        return json.decode(utf8.decode(response.bodyBytes))["content"]
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
