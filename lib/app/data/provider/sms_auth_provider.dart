import 'package:danvery/app/data/model/register_model.dart';
import 'package:danvery/app/data/provider/url/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class SMSAuthProvider {
  final Dio dio = Dio();

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
