import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../utils/url/url.dart';
import '../model/login_model.dart';

class LoginProvider {
  //get login
  Future<LoginModel?> getLogin(String classId, String password) async {
    final dio = Dio();

    String url = '$apiUrl/user/login';
    final body = {"studentId": classId, "password": password};

    //로그인 오류 처리
    try {
      final Response response = await dio.post(url,
          data: body,
          options: Options(
              contentType: "application/json",
              responseType: ResponseType.bytes));

      if (kDebugMode) {
        print("Login : ${response.statusCode}");
      }

      if (response.statusCode != 200) {
        throw Exception('Login error');
      } else {
        return LoginModel.fromJson(json.decode(utf8.decode(response.data)));
      }
    } catch (e) {
      //오류 내용 출력
      if (kDebugMode) {
        print(e);
      }

      return null;
    }
  }
}
