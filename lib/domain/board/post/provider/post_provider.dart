import 'dart:convert';

import 'package:danvery/utils/url/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/post_model.dart';

class PostProvider {

  final Dio dio;
  PostProvider({required this.dio});

  Future<bool> createPost(String token, PostModel postModel) async {

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

  Future<bool> deletePost(String token, int id) async {
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

    String url = '/post/general-forum?page=$page&size=$size';

    try {
      final Response response = await dio.get(url);

        return response.data["content"]
            .map<PostModel>((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

}
