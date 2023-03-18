import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../utils/url/url.dart';
import '../model/register_model.dart';

class RegisterProvider {
  final dio = Dio();

  Future<RegisterModel?> studentAuthenticate(String id, String password) async {

    String url = '$apiUrl/user/dku/verify';
    final body = {"dkuStudentId": id,"dkuPassword": password,};

    try {

      final Response response =
      await dio.post(url, data: body, options: Options(contentType: "application/json", responseType: ResponseType.bytes));

      if (kDebugMode) {
        print("StudentAuthenticate : ${response.statusCode}");
      }

      if (response.statusCode != 200) {
        throw Exception('StudentAuthenticate error');
      } else {
        return RegisterModel.fromJson(json.decode(utf8.decode(response.data)));
      }

    } catch (e) {

      //오류 내용 출력
      if (kDebugMode) {
        print(e);
      }

      return null;
    }
  }

  Future<RegisterModel?> register(RegisterModel registerModel) async{
    String url = '$apiUrl/user/${registerModel.signupToken}';
    final body = {"nickname": registerModel.nickname,"password": registerModel.password,};

    try {

      final Response response =
          await dio.post(url, data: body, options: Options(contentType: "application/json", responseType: ResponseType.bytes));

      if (kDebugMode) {
        print("Register : ${response.statusCode}");
      }

      if (response.statusCode != 200) {
        throw Exception('Register error');
      } else {
        return RegisterModel.fromJson(json.decode(utf8.decode(response.data)));
      }

    } catch (e) {

      //오류 내용 출력
      if (kDebugMode) {
        print(e);
      }

      return null;
    }
  }

  Future<bool> sendSMSAuth(String signupToken, String phoneNumber) async {
    try {

      final Response response = await dio.post('$apiUrl/user/sms/$signupToken',
        data: {
          'phoneNumber': phoneNumber,
        },
      );

      if (kDebugMode) {
        print("SMS Send : ${response.statusCode}");
      }

      if (response.statusCode != 200) {
        throw Exception('SMS Send Error error');
      } else {
        return true;
      }

    } catch (e) {

      //오류 내용 출력
      if (kDebugMode) {
        print(e);
      }

      return false;
    }
  }

  Future<bool> verifySMSAuth(String signupToken, String code) async {
    try {

      final Response response = await dio.post('$apiUrl/user/sms/verify/$signupToken',
        data: {
          'code': code,
        },
      );

      if (kDebugMode) {
        print("SMS Verify : ${response.statusCode}");
      }

      if (response.statusCode != 200) {
        throw Exception('SMS Verify Error error');
      } else {
        return true;
      }

    } catch (e) {

      //오류 내용 출력
      if (kDebugMode) {
        print(e);
      }

      return false;
    }
  }

}
