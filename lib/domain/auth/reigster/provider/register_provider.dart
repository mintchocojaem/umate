import 'package:dio/dio.dart';

import '../model/register_model.dart';

class RegisterProvider {

  final Dio dio;
  RegisterProvider({required this.dio});

  Future<RegisterModel?> studentAuthenticate(String id, String password) async {

    String url = '/user/dku/verify';
    final body = {"dkuStudentId": id,"dkuPassword": password};

    try {
      final Response response = await dio.post(url, data: body);

      return RegisterModel.fromJson(response.data);
    } catch (_) {
      return null;
    }

  }

  Future<RegisterModel?> register(RegisterModel registerModel) async{

    String url = '/user/${registerModel.signupToken}';
    final body = {"nickname": registerModel.nickname,"password": registerModel.password};

    try {
      final Response response = await dio.post(url, data: body);

      return RegisterModel.fromJson(response.data);
    } catch (_) {
      return null;
    }

  }

  Future<bool> sendSMSAuth(String signupToken, String phoneNumber) async {

    String url = '/user/sms/$signupToken';
    final body = {'phoneNumber': phoneNumber};

    try {
      await dio.post(url, data: body);

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> verifySMSAuth(String signupToken, String code) async {

    String url = '/user/sms/verify/$signupToken';
    final body = {'code': code};

    try {
      await dio.post(url, data: body);

      return true;
    } catch (_) {
      return false;
    }
  }

}
