import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/remote_data_source.dart';
import '../dto/sign_up_info_dto.dart';
import '../dto/token_dto.dart';

final authRemoteDataSourceProvider =
    Provider.autoDispose<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(
    networkClientService: ref.watch(networkClientServiceProvider),
  );
});

class AuthRemoteDataSource extends RemoteDataSource {
  AuthRemoteDataSource({required super.networkClientService});

  Future<TokenDto> login({
    required String studentId,
    required String password,
  }) async {
    return request(
      path: '/user/login',
      method: RequestType.post,
      data: {
        'studentId': studentId,
        'password': password,
      },
      fromJson: (json) => TokenDto.fromJson(json),
    );
  }

  Future<SignUpInfoDto> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    return request(
      path: '/user/dku/verify',
      method: RequestType.post,
      data: {
        'dkuStudentId': dkuStudentId,
        'dkuPassword': dkuPassword,
      },
      fromJson: (json) => SignUpInfoDto.fromJson(json),
    );
  }

  Future<bool> sendSignUpCode({
    required String signUpToken,
    required String phoneNumber,
  }) async {
    return request(
      path: '/user/sms/$signUpToken',
      method: RequestType.post,
      data: {
        "phoneNumber": phoneNumber,
      },
      fromJson: (json) => true,
    );
  }

  Future<bool> verifySignUpCode({
    required String signUpToken,
    required String code,
  }) async {
    return request(
      path: '/user/sms/verify/$signUpToken',
      method: RequestType.post,
      data: {
        "code": code,
      },
      fromJson: (json) => true,
    );
  }

  Future<bool> verifyNickname({
    required String nickname,
  }) async {
    return request(
      path: '/user/valid?nickname=$nickname',
      method: RequestType.get,
      fromJson: (json) => true,
    );
  }

  Future<bool> signUp({
    required String signUpToken,
    required String nickname,
    required String password,
  }) async {
    return request(
      path: '/user/$signUpToken',
      method: RequestType.post,
      data: {
        "nickname": nickname,
        "password": password,
      },
      fromJson: (json) => true,
    );
  }
}
