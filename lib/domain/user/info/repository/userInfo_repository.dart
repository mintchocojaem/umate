import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/user/info/provider/userInfo_provider.dart';

class UserInfoRepository {
  final UserInfoProvider _infoProvider;

  static final UserInfoRepository _singleton =
      UserInfoRepository.internal(UserInfoProvider());

  UserInfoRepository.internal(this._infoProvider);

  factory UserInfoRepository() => _singleton;

  Future<ApiResponseDTO> sendIdToSMS({required String phoneNumber}) async {
    return await _infoProvider.sendIdToSMS(phoneNumber);
  }

  Future<ApiResponseDTO> sendAuthCodeToSMS(
      {required String phoneNumber}) async {
    return await _infoProvider.sendAuthCodeToSMS(phoneNumber);
  }

  Future<ApiResponseDTO> verifyAuthCode(
      {required String token, required String code}) async {
    return await _infoProvider.verifyAuthCode(token, code);
  }

  Future<ApiResponseDTO> resetPassword(
      {required String token, required String password}) async {
    return await _infoProvider.resetPassword(token, password);
  }

  Future<ApiResponseDTO> changePassword(
      {required String accessToken,
      required String currentPassword,
      required String newPassword}) async {
    final ApiResponseDTO apiResponseDTO = await _infoProvider.changePassword(
        accessToken: accessToken,
        currentPassword: currentPassword,
        newPassword: newPassword);
    return apiResponseDTO;
  }

  Future<ApiResponseDTO> changeNickname(
      {required String accessToken, required String nickName}) async {
    final ApiResponseDTO apiResponseDTO = await _infoProvider.changeNickname(
        accessToken: accessToken, nickName: nickName);
    return apiResponseDTO;
  }

  Future<ApiResponseDTO> verifySMS(
      {required String accessToken, required String phoneNumber}) async {
    final ApiResponseDTO apiResponseDTO = await _infoProvider.verifySMS(
        accessToken: accessToken, phoneNumber: phoneNumber);
    return apiResponseDTO;
  }

  Future<ApiResponseDTO> changePhoneNumber(
      {required String accessToken,
      required String token,
      required String code}) async {
    final ApiResponseDTO apiResponseDTO = await _infoProvider.changePhoneNumber(
        accessToken: accessToken, token: token, code: code);
    return apiResponseDTO;
  }

  Future<ApiResponseDTO> getUserWritePostList(
      {required String accessToken,
      required int page,
      required int size}) async {
    final ApiResponseDTO apiResponseDTO = await _infoProvider
        .getUserWritePostList(accessToken: accessToken, page: page, size: size);
    return apiResponseDTO;
  }

  Future<ApiResponseDTO> getUserCommentedPostList(
      {required String accessToken,
      required int page,
      required int size}) async {
    final ApiResponseDTO apiResponseDTO =
        await _infoProvider.getUserCommentedPostList(
            accessToken: accessToken, page: page, size: size);
    return apiResponseDTO;
  }

  Future<ApiResponseDTO> getUserLikedPostList(
      {required String accessToken,
      required int page,
      required int size}) async {
    final ApiResponseDTO apiResponseDTO = await _infoProvider
        .getUserLikedPostList(accessToken: accessToken, page: page, size: size);
    return apiResponseDTO;
  }
}
