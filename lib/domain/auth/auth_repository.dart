import 'package:danvery/utils/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/exception_handler.dart';
import 'sign_up/sign_up.dart';
import 'token/token.dart';
import 'user/user.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref.read(dioProvider)));

class AuthRepository {
  final Dio dio;

  AuthRepository(this.dio);

  Future<SignUp?> verifyStudent(String dkuStudentId, String dkuPassword) async {
    try {
      final response = await dio.post(
        '${dio.options.baseUrl}/user/dku/verify',
        data: {
          "dkuStudentId": dkuStudentId,
          "dkuPassword": dkuPassword,
        },
      );

      return SignUp.fromJson(response.data);
    } on DioException catch (e) {
      throw ExceptionDto(
        e.response!.data['code'].toString(),
        e.response!.data['message'].first.toString(),
      );
    }
  }

  Future<bool> sendSMS(String signUpToken, String phoneNumber) async {
    try {
      await dio.post(
        '${dio.options.baseUrl}/user/sms/$signUpToken',
        data: {
          "phoneNumber": phoneNumber,
        },
      );

      return true;
    } on DioException catch (e) {
      throw ExceptionDto(
        e.response!.data['code'].toString(),
        e.response!.data['message'].first.toString(),
      );
    }
  }

  Future<bool> verifySMS(String signUpToken, String code) async {
    try {
      await dio.post(
        '${dio.options.baseUrl}/user/sms/verify/$signUpToken',
        data: {
          "code": code,
        },
      );
      return true;
    } on DioException catch (e) {
      throw ExceptionDto(
        e.response!.data['code'].toString(),
        e.response!.data['message'].first.toString(),
      );
    }
  }

  Future<bool> signUp(
      String signUpToken, String nickname, String password) async {
    try {
      await dio.post(
        '${dio.options.baseUrl}/user/$signUpToken',
        data: {
          "nickname": nickname,
          "password": password,
        },
      );
      return true;
    } on DioException catch (e) {
      throw ExceptionDto(
        e.response!.data['code'].toString(),
        e.response!.data['message'].first.toString(),
      );
    }
  }

  Future<Token?> login(String studentId, String password) async {
    try {
      final response = await dio.post(
        '${dio.options.baseUrl}/user/login',
        data: {
          "studentId": studentId,
          "password": password,
        },
      );
      return Token.fromJson(response.data);
    } on DioException catch (e) {
      throw ExceptionDto(
        e.response!.data['code'].toString(),
        e.response!.data['message'].first.toString(),
      );
    }
  }

  Future<Token?> reissueToken(String accessToken, String refreshToken) async {
    try {
      final response = await dio.post(
        '${dio.options.baseUrl}/user/reissue',
        data: {
          "refreshToken": refreshToken,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      return Token.fromJson(response.data);
    } on DioException catch (e) {
      throw ExceptionDto(
        e.response!.data['code'].toString(),
        e.response!.data['message'].first.toString(),
      );
    }
  }

  Future<User?> getUser(String accessToken) async {
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
    } on DioException catch (e) {
      throw ExceptionDto(
        e.response!.data['code'].toString(),
        e.response!.data['message'].first.toString(),
      );
    }
  }

  Future<bool> validNickname(String nickname) async {
    try {
      await dio.get(
        '${dio.options.baseUrl}/user/valid?nickname=$nickname',
      );

      return true;
    } on DioException catch (e) {
      throw ExceptionDto(
        e.response!.data['code'].toString(),
        e.response!.data['message'].first.toString(),
      );
    }
  }

  Future<bool> findUserId(String phoneNumber) async {
    try {
      await dio.post(
        '${dio.options.baseUrl}/user/find/id',
        data: {
          "phoneNumber": phoneNumber,
        },
      );
      return true;
    } on DioException catch (e) {
      throw ExceptionDto(
        e.response!.data['code'].toString(),
        e.response!.data['message'].first.toString(),
      );
    }
  }

  Future<String?> sendSMStoResetPassword(String phoneNumber) async {
    try {
      final response = await dio.post(
        '${dio.options.baseUrl}/user/find/pwd',
        data: {
          "phoneNumber": phoneNumber,
        },
      );
      return response.data['token'];
    } on DioException catch (e) {
      throw ExceptionDto(
        e.response!.data['code'].toString(),
        e.response!.data['message'].first.toString(),
      );
    }
  }

  Future<bool> verifySMStoResetPassword(String token, String code) async {
    try {
      await dio.post(
        '${dio.options.baseUrl}/user/find/pwd/verify',
        data: {
          "token": token,
          "code": code,
        },
      );
      return true;
    } on DioException catch (e) {
      throw ExceptionDto(
        e.response!.data['code'].toString(),
        e.response!.data['message'].first.toString(),
      );
    }
  }

  Future<bool> resetPassword(String token, String password) async {
    try {
      await dio.patch(
        '${dio.options.baseUrl}/user/find/pwd/reset',
        data: {
          "token": token,
          "password": password,
        },
      );
      return true;
    } on DioException catch (e) {
      throw ExceptionDto(
        e.response!.data['code'].toString(),
        e.response!.data['message'].first.toString(),
      );
    }
  }

}
