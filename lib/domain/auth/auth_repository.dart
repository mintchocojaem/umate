import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/dio_provider.dart';
import '../domain.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref.read(dioProvider)));

final class AuthRepository extends Repository {
  AuthRepository(super.dio);

  Future<SignUp> verifyStudent(String dkuStudentId, String dkuPassword) async {
    final result = await post(
      path: '/user/dku/verify',
      data: {
        "dkuStudentId": dkuStudentId,
        "dkuPassword": dkuPassword,
      },
    );
    return SignUp.fromJson(result!.data);
  }

  Future<bool> sendSMS(String signUpToken, String phoneNumber) async {
    final result = await post(
      path: '/user/sms/$signUpToken',
      data: {
        "phoneNumber": phoneNumber,
      },
    );
    return result!.statusCode == 200;
  }

  Future<bool> verifySMS(String signUpToken, String code) async {
    final result = await post(
      path: '/user/sms/verify/$signUpToken',
      data: {
        "code": code,
      },
    );
    return result!.statusCode == 200;
  }

  Future<bool> signUp(
      String signUpToken, String nickname, String password) async {
    final result = await post(
      path: '/user/$signUpToken',
      data: {
        "nickname": nickname,
        "password": password,
      },
    );
    return result!.statusCode == 200;
  }

  Future<Token> login(String studentId, String password) async {
    final result = await post(
      path: '/user/login',
      data: {
        "studentId": studentId,
        "password": password,
      },
    );
    return Token.fromJson(result!.data);
  }

  Future<Token> reissueToken(String accessToken, String refreshToken) async {
    final result = await post(
      path: '/user/reissue',
      data: {
        "refreshToken": refreshToken,
      },
    );
    return Token.fromJson(result!.data);
  }

  Future<User> getUser() async {
    final result = await get(
      path: '/user',
    );
    return User.fromJson(result!.data);
  }

  Future<bool> validNickname(String nickname) async {
    final result = await get(
      path: '/user/valid?nickname=$nickname',
    );
    return result!.statusCode == 200;
  }

  Future<bool> changeNickname(String nickname) async {
    final result = await patch(
      path: '/user/change/nickname',
      data: {
        "nickname": nickname,
      },
    );
    return result!.statusCode == 200;
  }

  Future<String> verifyPhoneNumber(String phoneNumber) async {
    final result = await post(
      path: '/user/change/phone/verify',
      data: {
        "phoneNumber": phoneNumber,
      },
    );
    return result!.data['token'];
    return "123";
  }

Future<bool> changePhoneNumber(String token, String code) async {
    final result = await patch(
      path: '/user/change/phone',
      data: {
        "token": token,
        "code": code,
      },
    );
    return result!.statusCode == 200;
  return true;
  }

}
