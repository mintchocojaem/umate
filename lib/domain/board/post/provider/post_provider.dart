import 'dart:convert';

import 'package:danvery/utils/url/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/post_model.dart';

class PostProvider {
  final Dio dio = Dio();

  Future<bool> createPost(String token, PostModel postModel) async {
    String url = '$apiUrl/post/general-forum';
    final data = FormData.fromMap({
      'title': postModel.title,
      'body': postModel.body,
    });
    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await dio.post(url,
          data: data,
          options:
              Options(contentType: "multipart/form-data", headers: headers));

      if (kDebugMode) {
        print('CreatePost : ${response.statusCode}');
      }

      if (response.statusCode != 200) {
        throw Exception('CreatePost Error');
      } else {
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> deletePost(String token, int id) async {
    String url = '$apiUrl/post/general-forum/$id';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response =
          await dio.delete(url, options: Options(headers: headers));

      if (kDebugMode) {
        print('DeletePost : ${response.statusCode}');
      }

      if (response.statusCode != 200) {
        throw Exception('DeletePost Error');
      } else {
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<PostModel?> getPost(String token, int id) async {
    String url = '$apiUrl/post/general-forum/$id';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await dio.get(url,
          options: Options(
              contentType: "application/json",
              headers: headers,
              responseType: ResponseType.bytes));

      if (kDebugMode) {
        print('getPost : ${response.statusCode}');
      }

      if (response.statusCode != 200) {
        throw Exception('getPost Error');
      } else {
        return PostModel.fromJson(jsonDecode(utf8.decode(response.data)));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<List<PostModel>?> getGeneralBoard(int page, int size) async {

    String url =
        '$apiUrl/post/general-forum?page=$page&size=$size';

    try {
      final Response response = await dio.get(url,
          options: Options(contentType: "application/json", responseType: ResponseType.bytes));

      if (kDebugMode) {
        print("GetGeneralBoard : ${response.statusCode}");
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

}
