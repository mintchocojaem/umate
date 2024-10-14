import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/login_token.dart';
import '../../domain/models/sign_up_info.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository(
    client: ref.watch(networkClientServiceProvider),
  );
}

class AuthRemoteRepository extends RemoteRepository {
  AuthRemoteRepository({
    required super.client,
  });

  Future<LoginToken> login({
    required String studentId,
    required String password,
  }) async {
    final response = await client.request(
      path: '/user/login',
      method: RequestType.post,
      data: {
        'studentId': studentId,
        'password': password,
      },
    );
    return LoginToken.fromJson(response.data);
  }

  Future<LoginToken> reissueToken({
    required String accessToken,
    required String refreshToken,
  }) async {
    final response = await client.request(
      path: '/user/reissue',
      method: RequestType.post,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      data: {
        'refreshToken': refreshToken,
      },
    );
    return LoginToken.fromJson(response.data);
  }

  Future<SignUpInfo> signUpVerifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    final response = await client.request(
      path: '/user/dku/verify',
      method: RequestType.post,
      data: {
        'dkuStudentId': dkuStudentId,
        'dkuPassword': dkuPassword,
      },
    );
    return SignUpInfo.fromJson(response.data);
  }

  Future<bool> signUpSendCode({
    required String signUpToken,
    required String phoneNumber,
  }) async {
    final response = await client.request(
      path: '/user/sms/$signUpToken',
      method: RequestType.post,
      data: {
        "phoneNumber": phoneNumber,
      },
    );
    return response.statusCode == 200;
  }

  Future<bool> signUpVerifyCode({
    required String signUpToken,
    required String code,
  }) async {
    final response = await client.request(
      path: '/user/sms/verify/$signUpToken',
      method: RequestType.post,
      data: {
        "code": code,
      },
    );
    return response.statusCode == 200;
  }

  Future<bool> signUp({
    required String signUpToken,
    required String nickname,
    required String password,
  }) async {
    final response = await client.request(
      path: '/user/$signUpToken',
      method: RequestType.post,
      data: {
        "nickname": nickname,
        "password": password,
      },
    );
    return response.statusCode == 200;
  }

  Future<bool> sendStudentId({
    required String phoneNumber,
  }) async {
    final response = await client.request(
      path: '/user/find/id',
      method: RequestType.post,
      data: {
        "phoneNumber": phoneNumber,
      },
    );
    return response.statusCode == 200;
  }

  Future<String> sendPasswordResetCode({
    required String phoneNumber,
  }) async {
    final response = await client.request(
      path: '/user/find/pwd',
      method: RequestType.post,
      data: {
        "phoneNumber": phoneNumber,
      },
    );
    return response.data['token'];
  }

  Future<bool> verifyPasswordResetCode({
    required String token,
    required String code,
  }) async {
    final response = await client.request(
      path: '/user/find/pwd/verify',
      method: RequestType.post,
      data: {
        "code": code,
        "token": token,
      },
    );
    return response.statusCode == 200;
  }

  Future<bool> resetPassword({
    required String token,
    required String password,
  }) async {
    final response = await client.request(
      path: '/user/find/pwd/reset',
      method: RequestType.patch,
      data: {
        "token": token,
        "password": password,
      },
    );
    return response.statusCode == 200;
  }

  Future<bool> verifyNickname({
    required String nickname,
  }) async {
    final response = await client.request(
      path: '/user/valid?nickname=$nickname',
      method: RequestType.get,
    );

    return response.statusCode == 200;
  }

  Future<bool> refreshStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    final result = await client.request(
      path: '/user/dku/refresh',
      method: RequestType.post,
      data: {
        'dkuStudentId': dkuStudentId,
        'dkuPassword': dkuPassword,
      },
    );
    return result.statusCode == 200;
  }
}
