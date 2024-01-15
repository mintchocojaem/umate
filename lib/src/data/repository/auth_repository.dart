import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import '../data.dart';

final authRepositoryProvider = Provider.autoDispose<AuthRepository>(
  (ref) => AuthRepository(),
);

final class AuthRepository extends BaseRepository {
  Future<SignUpModel> verifyStudent(
    CancelToken? cancelToken, {
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    final result = await request(
      requestType: RequestType.post,
      path: '/user/dku/verify',
      data: {
        "dkuStudentId": dkuStudentId,
        "dkuPassword": dkuPassword,
      },
      cancelToken: cancelToken,
    );
    return SignUpModel.fromJson(result!.data);
  }

  Future<bool> sendSMS(
    CancelToken? cancelToken, {
    required String signUpToken,
    required String phoneNumber,
  }) async {
    final result = await request(
      requestType: RequestType.post,
      path: '/user/sms/$signUpToken',
      data: {
        "phoneNumber": phoneNumber,
      },
      cancelToken: cancelToken,
    );
    return result!.statusCode == 200;
  }

  Future<bool> verifySMS(
    CancelToken? cancelToken, {
    required String signUpToken,
    required String code,
  }) async {
    final result = await request(
      requestType: RequestType.post,
      path: '/user/sms/verify/$signUpToken',
      data: {
        "code": code,
      },
      cancelToken: cancelToken,
    );
    return result!.statusCode == 200;
  }

  Future<bool> signUp(
    CancelToken? cancelToken, {
    required String signUpToken,
    required String nickname,
    required String password,
  }) async {
    final result = await request(
      requestType: RequestType.post,
      path: '/user/$signUpToken',
      data: {
        "nickname": nickname,
        "password": password,
      },
      cancelToken: cancelToken,
    );
    return result!.statusCode == 200;
  }

  Future<TokenModel> login(
    CancelToken? cancelToken, {
    required String studentId,
    required String password,
  }) async {
    final result = await request(
      requestType: RequestType.post,
      path: '/user/login',
      data: {
        "studentId": studentId,
        "password": password,
      },
      cancelToken: cancelToken,
    );
    return TokenModel.fromJson(result!.data);
  }

  Future<TokenModel> reissueToken(
    CancelToken? cancelToken, {
    required String accessToken,
    required String refreshToken,
  }) async {
    final result = await request(
      requestType: RequestType.post,
      path: '/user/reissue',
      data: {
        "refreshToken": refreshToken,
      },
      cancelToken: cancelToken,
    );
    return TokenModel.fromJson(result!.data);
  }

  /*
  Future<User> getUser() async {
    final result = await get(
      path: '/user',
    );
    return User.fromJson(result!.data);
  }

   */

  Future<bool> validNickname(
    CancelToken? cancelToken, {
    required String nickname,
  }) async {
    final result = await request(
      requestType: RequestType.get,
      path: '/user/valid?nickname=$nickname',
      cancelToken: cancelToken,
    );
    return result!.statusCode == 200;
  }

  Future<bool> changeNickname(
    CancelToken? cancelToken, {
    required String nickname,
  }) async {
    final result = await request(
      requestType: RequestType.patch,
      path: '/user/change/nickname',
      data: {
        "nickname": nickname,
      },
      cancelToken: cancelToken,
    );
    return result!.statusCode == 200;
  }

  Future<String> verifyPhoneNumber(
    CancelToken? cancelToken, {
    required String phoneNumber,
  }) async {
    final result = await request(
      requestType: RequestType.post,
      path: '/user/change/phone/verify',
      data: {
        "phoneNumber": phoneNumber,
      },
      cancelToken: cancelToken,
    );
    return result!.data['token'];
  }

  Future<bool> changePhoneNumber(
    CancelToken? cancelToken, {
    required String token,
    required String code,
  }) async {
    final result = await request(
      requestType: RequestType.patch,
      path: '/user/change/phone',
      data: {
        "token": token,
        "code": code,
      },
      cancelToken: cancelToken,
    );
    return result!.statusCode == 200;
  }
}
