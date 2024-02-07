import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/utils.dart';
import '../../../features.dart';

final authApiProvider = Provider.autoDispose<AuthApi>((ref) {
  return AuthApi(
    dioClient: ref.watch(dioClientProvider),
  );
});

class AuthApi {
  final DioClient dioClient;

  AuthApi({required this.dioClient});

  Future<TokenModel> login({
    required String studentId,
    required String password,
  }) async {
    final response = await dioClient.request(
      path: '/user/login',
      method: RequestType.post,
      data: {
        'studentId': studentId,
        'password': password,
      },
    );
    return TokenModel.fromJson(response.data);
  }

  Future<SignUpModel> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    final response = await dioClient.request(
      path: '/user/dku/verify',
      method: RequestType.post,
      data: {
        'dkuStudentId': dkuStudentId,
        'dkuPassword': dkuPassword,
      },
    );
    return SignUpModel.fromJson(response.data);
  }

  Future<bool> sendSMS({
    required String signUpToken,
    required String phoneNumber,
  }) async {
    final result = await dioClient.request(
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
    final result = await dioClient.request(
      path: '/user/sms/verify/$signUpToken',
      method: RequestType.post,
      data: {
        "code": code,
      },
    );
    return result.statusCode == 200;
  }

  Future<bool> validNickname({required String nickname}) async {
    final result = await dioClient.request(
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
    final result = await dioClient.request(
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
