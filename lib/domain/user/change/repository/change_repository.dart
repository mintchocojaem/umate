import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/user/change/provider/change_provider.dart';

class ChangeRepository {
  final ChangeProvider _changeProvider;

  static final ChangeRepository _singleton =
      ChangeRepository.internal(ChangeProvider());

  ChangeRepository.internal(this._changeProvider);

  factory ChangeRepository() => _singleton;

  Future<ApiResponseDTO> changePassword(
      {required String accessToken,
      required String currentPassword,
      required String newPassword}) async {
    final ApiResponseDTO apiResponseDTO = await _changeProvider.changePassword(
        accessToken: accessToken,
        currentPassword: currentPassword,
        newPassword: newPassword);
    return apiResponseDTO;
  }

  Future<ApiResponseDTO> changeNickname(
      {required String accessToken, required String nickName}) async {
    final ApiResponseDTO apiResponseDTO = await _changeProvider.changeNickname(
        accessToken: accessToken, nickName: nickName);
    return apiResponseDTO;
  }

  Future<ApiResponseDTO> changePhoneNumber(
      {required String accessToken,
      required String token,
      required String code}) async {
    final ApiResponseDTO apiResponseDTO = await _changeProvider
        .changePhoneNumber(accessToken: accessToken, token: token, code: code);
    return apiResponseDTO;
  }

  Future<ApiResponseDTO> verifySMS(
      {required String accessToken,
      required String phoneNumber}) async {
    final ApiResponseDTO apiResponseDTO = await _changeProvider
        .verifySMS(accessToken: accessToken, phoneNumber: phoneNumber);
    return apiResponseDTO;
  }

}
