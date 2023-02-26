import 'dart:convert';

import 'package:danvery/app/data/provider/url.dart';
import 'package:flutter/foundation.dart';

import '../model/login_model.dart';
import 'package:http/http.dart' as http;


class LoginProvider {

  //get login
  Future<LoginModel?> getLogin(String classId, String password) async {
    String url = '$apiUrl/api/users/login';
    final body = {"classId": classId, "password": password};
    final header =  {"Content-Type": "application/json"};

    //로그인 오류 처리
    try {
      final http.Response response =
          await http.post(Uri.parse(url), body: json.encode(body), headers: header);

      if (kDebugMode) {
        print("Login : ${response.statusCode}");
      }

      if (response.statusCode != 200) {
        throw Exception('Login error');
      } else {
        return LoginModel.fromJson(json.decode(response.body));
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
