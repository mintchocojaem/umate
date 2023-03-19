import 'package:dio/dio.dart';

import '../model/login_model.dart';

class LoginProvider {

  final Dio dio;
  LoginProvider({required this.dio});

  Future<LoginModel?> getLogin(String classId, String password) async {
    const String url = '/user/login';
    final body = {"studentId": classId, "password": password};

    try {
      final Response response = await dio.post(url, data: body,);

      return LoginModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }
}
