import 'package:danvery/domain/repository.dart';
import 'package:danvery/utils/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sign_up/sign_up.dart';
import 'token/token.dart';
import 'user/user.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref.read(dioProvider)));

final class AuthRepository extends Repository {
  AuthRepository(super.dio);

  Future<SignUp?> verifyStudent(String dkuStudentId, String dkuPassword) async {
    return await fetch(() async {
      final result = await dio.post(
        '${dio.options.baseUrl}/user/dku/verify',
        data: {
          "dkuStudentId": dkuStudentId,
          "dkuPassword": dkuPassword,
        },
      );
      return SignUp.fromJson(result.data);
    });
  }

  Future<bool> sendSMS(String signUpToken, String phoneNumber) async {
    return await fetch(() async {
      await dio.post(
        '${dio.options.baseUrl}/user/sms/$signUpToken',
        data: {
          "phoneNumber": phoneNumber,
        },
      );
      return true;
    });
  }

  Future<bool> verifySMS(String signUpToken, String code) async {
    return await fetch(() async {
      await dio.post(
        '${dio.options.baseUrl}/user/sms/verify/$signUpToken',
        data: {
          "code": code,
        },
      );
      return true;
    });
  }

  Future<bool> signUp(
      String signUpToken, String nickname, String password) async {
    return await fetch(() async {
      await dio.post(
        '${dio.options.baseUrl}/user/$signUpToken',
        data: {
          "nickname": nickname,
          "password": password,
        },
      );
      return true;
    });
  }

  Future<Token?> login(String studentId, String password) async {
    return await fetch(() async {
      final result = await dio.post(
        '${dio.options.baseUrl}/user/login',
        data: {
          "studentId": studentId,
          "password": password,
        },
      );
      return Token.fromJson(result.data);
    });
  }

  Future<Token?> reissueToken(String accessToken, String refreshToken) async {
    return await fetch(() async{
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
    });
  }

  Future<User?> getUser(String accessToken) async {
    return await fetch(() async{
      final response = await dio.get(
        '${dio.options.baseUrl}/user',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      return User.fromJson(response.data);
    });
  }

  Future<bool> validNickname(String nickname) async {
    return await fetch(() async {
      await dio.get(
        '${dio.options.baseUrl}/user/valid?nickname=$nickname',
      );
      return true;
    });
  }

  Future<bool> findUserId(String phoneNumber) async {
    return await fetch(() async {
      await dio.post(
        '${dio.options.baseUrl}/user/find/id',
        data: {
          "phoneNumber": phoneNumber,
        },
      );
      return true;
    });
  }

  Future<String?> sendSMStoResetPassword(String phoneNumber) async {
    return await fetch(() async {
      final response = await dio.post(
        '${dio.options.baseUrl}/user/find/pwd',
        data: {
          "phoneNumber": phoneNumber,
        },
      );
      return response.data['token'];
    });
  }

  Future<bool> verifySMStoResetPassword(String token, String code) async {
    return await fetch(() async{
      await dio.post(
        '${dio.options.baseUrl}/user/find/pwd/verify',
        data: {
          "token": token,
          "code": code,
        },
      );
      return true;
    });
  }

  Future<bool> resetPassword(String token, String password) async {
    return await fetch(() async{
      await dio.patch(
        '${dio.options.baseUrl}/user/find/pwd/reset',
        data: {
          "token": token,
          "password": password,
        },
      );
      return true;
    });
  }
}
