import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/remote_data_source.dart';
import '../dto/sign_up_info_dto.dart';
import '../dto/token_dto.dart';
import '../dto/user_info_dto.dart';

class RemoteUserDataSource extends RemoteDataSource {
  RemoteUserDataSource({required super.networkClientService});

  Future<TokenDTO> reissueToken({
    required String refreshToken,
  }) async {
    return request(
      path: '/user/reissue',
      method: RequestType.post,
      data: {
        'refreshToken': refreshToken,
      },
      fromJson: TokenDTO.fromJson,
    );
  }

  Future<TokenDTO> login({
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
      fromJson: TokenDTO.fromJson,
    );
  }

  Future<SignUpInfoDTO> signUpVerifyStudent({
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
      fromJson: SignUpInfoDTO.fromJson,
    );
  }

  Future<bool> refreshStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    return request(
      path: '/user/dku/refresh',
      method: RequestType.post,
      data: {
        'dkuStudentId': dkuStudentId,
        'dkuPassword': dkuPassword,
      },
      fromJson: (_) => true,
    );
  }

  Future<bool> signUpSendCode({
    required String signUpToken,
    required String phoneNumber,
  }) async {
    return request(
      path: '/user/sms/$signUpToken',
      method: RequestType.post,
      data: {
        "phoneNumber": phoneNumber,
      },
      fromJson: (_) => true,
    );
  }

  Future<bool> signUpVerifyCode({
    required String signUpToken,
    required String code,
  }) async {
    return request(
      path: '/user/sms/verify/$signUpToken',
      method: RequestType.post,
      data: {
        "code": code,
      },
      fromJson: (_) => true,
    );
  }

  Future<bool> signUpVerifyNickname({
    required String nickname,
  }) async {
    return request(
      path: '/user/valid?nickname=$nickname',
      method: RequestType.get,
      fromJson: (_) => true,
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
      fromJson: (_) => true,
    );
  }

  Future<bool> sendStudentId({
    required String phoneNumber,
  }) async {
    return request(
      path: '/user/find/id',
      method: RequestType.post,
      data: {
        "phoneNumber": phoneNumber,
      },
      fromJson: (_) => true,
    );
  }

  Future<String> sendPasswordResetCode({
    required String phoneNumber,
  }) async {
    return request(
      path: '/user/find/pwd',
      method: RequestType.post,
      data: {
        "phoneNumber": phoneNumber,
      },
      fromJson: (json) => json['token'],
    );
  }

  Future<bool> verifyPasswordResetCode({
    required String token,
    required String code,
  }) async {
    return request(
      path: '/user/find/pwd/verify',
      method: RequestType.post,
      data: {
        "code": code,
        "token": token,
      },
      fromJson: (_) => true,
    );
  }

  Future<bool> resetPassword({
    required String token,
    required String password,
  }) async {
    return request(
      path: '/user/find/pwd/reset',
      method: RequestType.patch,
      data: {
        "token": token,
        "password": password,
      },
      fromJson: (_) => true,
    );
  }

  Future<UserInfoDTO> getUserInfo() async {
    return request(
      path: '/user',
      method: RequestType.get,
      fromJson: UserInfoDTO.fromJson,
    );
  }

  Future<bool> deleteUser() async {
    return request(
      path: '/user',
      method: RequestType.delete,
      fromJson: (_) => true,
    );
  }
}
