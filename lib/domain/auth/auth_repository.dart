import 'package:danvery/utils/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sign_up/sign_up.dart';
import 'token/token.dart';
import 'user/user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(ref.read(dioProvider)));

class AuthRepository{

  final Dio dio;

  AuthRepository(this.dio);

  Future<SignUp> verifyStudent(String dkuStudentId, String dkuPassword) async {
    try {
      final response = await dio.post(
        '${dio.options.baseUrl}/user/dku/verify',
        data: {
          "dkuStudentId": dkuStudentId,
          "dkuPassword": dkuPassword,
        },
      );

      return SignUp.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> sendSMS(String signUpToken, String phoneNumber) async{
    try {
      await dio.post(
        '${dio.options.baseUrl}/user/sms/$signUpToken',
        data: {
          "phoneNumber": phoneNumber,
        },
      );

      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> verifySMS(String signUpToken, String code) async{
    try {
      await dio.post(
        '${dio.options.baseUrl}/user/sms/verify/$signUpToken',
        data: {
          "code": code,
        },
      );
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> signUp(String signUpToken,String nickname , String password) async{
    try {
      await dio.post(
        '${dio.options.baseUrl}/user/$signUpToken',
        data: {
          "nickname": nickname,
          "password": password,
        },
      );
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Token> login(String studentId, String password) async {
    try {
      final response = await dio.post(
        '${dio.options.baseUrl}/user/login',
        data: {
          "studentId": studentId,
          "password": password,
        },
      );
      return Token.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> getUser(String accessToken) async {
    try {
      final response = await dio.get(
        '${dio.options.baseUrl}/user',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      return User.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

}
