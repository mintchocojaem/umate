import 'package:danvery/app/data/provider/url.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/login_model.dart';

class LoginProvider extends GetConnect {
  //get login
  Future<LoginModel> getLogin(String classId, String password) async {
    String url = '$apiUrl/users/login';
    final body = {"studentId": classId, "password": password};
    final Response response =
        await post(url, body, contentType: "application/json");

    if (kDebugMode) {
      print(response.statusCode);
      print("getLogin : ${response.statusCode}");
    }

    if (response.status.hasError) {
      throw Exception('getLogin Error');
    } else {
      return LoginModel.fromJson(response.body);
    }
  }
}
