import 'package:danvery/core/dto/api_response_dto.dart';

import '../provider/login_provider.dart';

class LoginRepository {

  final LoginProvider _loginProvider;

  LoginRepository._internal(this._loginProvider);

  static final LoginRepository _singleton =
      LoginRepository._internal(LoginProvider());

  factory LoginRepository() => _singleton;

  //get login
  Future<ApiResponseDTO> login({required String classId, required String password}) async {
    return await _loginProvider.getLogin(classId, password);
  }

  //reissue token
  Future<ApiResponseDTO> reissueToken({required String accessToken, required String refreshToken}) async {
    return await _loginProvider.reissueToken(accessToken, refreshToken);
  }

  //get user info
  Future<ApiResponseDTO> getUserInfo({required String accessToken}) async {
    return await _loginProvider.getUserInfo(accessToken);
  }

}
