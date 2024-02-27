import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/network/network_service.dart';
import '../dto/sign_up_info_dto.dart';
import '../dto/token_dto.dart';

final authRemoteDataSourceProvider = Provider.autoDispose<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(
    networkService: ref.watch(networkServiceProvider),
  );
});

class AuthRemoteDataSource {
  final NetworkService networkService;

  AuthRemoteDataSource({required this.networkService});

  Future<TokenDto> login({
    required String studentId,
    required String password,
  }) async {
    final response = await networkService.request(
      path: '/user/login',
      method: RequestType.post,
      data: {
        'studentId': studentId,
        'password': password,
      },
    );
    return TokenDto.fromJson(response.data);
  }

  Future<SignUpInfoDto> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    final response = await networkService.request(
      path: '/user/dku/verify',
      method: RequestType.post,
      data: {
        'dkuStudentId': dkuStudentId,
        'dkuPassword': dkuPassword,
      },
    );
    return SignUpInfoDto.fromJson(response.data);
  }

  Future<bool> sendSignUpCode({
    required String signUpToken,
    required String phoneNumber,
  }) async {
    final result = await networkService.request(
      path: '/user/sms/$signUpToken',
      method: RequestType.post,
      data: {
        "phoneNumber": phoneNumber,
      },
    );
    return result.statusCode == 200;
  }

  Future<bool> verifySMS({
    required String signUpToken,
    required String code,
  }) async {
    final result = await networkService.request(
      path: '/user/sms/verify/$signUpToken',
      method: RequestType.post,
      data: {
        "code": code,
      },
    );
    return result.statusCode == 200;
  }

  Future<bool> validNickname({required String nickname}) async {
    final result = await networkService.request(
      path: '/user/valid?nickname=$nickname',
      method: RequestType.get,
    );
    return result.statusCode == 200;
  }

  Future<bool> signUp({
    required String signUpToken,
    required String nickname,
    required String password,
  }) async {
    final result = await networkService.request(
      path: '/user/$signUpToken',
      method: RequestType.post,
      data: {
        "nickname": nickname,
        "password": password,
      },
    );
    return result.statusCode == 200;
  }

}
