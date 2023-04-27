import 'package:danvery/domain/user/find/provider/find_provider.dart';
import 'package:danvery/core/dto/api_response_dto.dart';

class FindRepository {
  final FindProvider _findProvider;

  static final FindRepository _singleton =
      FindRepository.internal(FindProvider());

  FindRepository.internal(this._findProvider);

  factory FindRepository() => _singleton;

  Future<ApiResponseDTO> sendIdToSMS({required String phoneNumber}) async {
    return await _findProvider.sendIdToSMS(phoneNumber);
  }

  Future<ApiResponseDTO> sendAuthCodeToSMS({required String phoneNumber}) async {
    return await _findProvider.sendAuthCodeToSMS(phoneNumber);
  }

  Future<ApiResponseDTO> verifyAuthCode(
      {required String token, required String code}) async {
    return await _findProvider.verifyAuthCode(token, code);
  }

  Future<ApiResponseDTO> resetPassword(
      {required String token, required String password}) async {
    return await _findProvider.resetPassword(token, password);
  }
}
