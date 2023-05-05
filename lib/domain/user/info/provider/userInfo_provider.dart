import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:danvery/domain/board/general_board/model/general_board_model.dart';
import 'package:danvery/domain/board/petition_board/model/petition_board_model.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:dio/dio.dart';

class UserInfoProvider {
  final Dio _dio;

  static final UserInfoProvider _singleton =
  UserInfoProvider.internal(DioInterceptor().dio);

  UserInfoProvider.internal(this._dio);

  factory UserInfoProvider() => _singleton;

  Future<ApiResponseDTO> sendIdToSMS(String phoneNumber) async {
    const String url = '/user/find/id';
    final body = {"phoneNumber": phoneNumber};

    try {
      final Response response = await _dio.post(url, data: body,);
      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e){
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> sendAuthCodeToSMS(String phoneNumber) async {
    const String url = '/user/find/pwd';
    final body = {"phoneNumber": phoneNumber};

    try {
      final Response response = await _dio.post(url, data: body,);

      return SuccessResponseDTO(data: response.data['token']);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> verifyAuthCode(String token, String code) async {
    const String url = '/user/find/pwd/verify';
    final body = {"token": token, "code": code};

    try {
      final Response response = await _dio.post(url, data: body,);

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e){
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> resetPassword(String token, String password) async {
    const String url = '/user/find/pwd/reset';
    final body = {"token": token, "password": password};

    try {
      final Response response =  await _dio.patch(url, data: body,);

      return SuccessResponseDTO(data: response);
    } on DioError catch (e){
      return ExceptionResponseDTO(message: e.message);
    }
  }


  Future<ApiResponseDTO> changePassword(
      {required String accessToken,
        required String currentPassword,
        required String newPassword}) async {
    const String url = '/user/change/password';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    final body = {
      "password": currentPassword,
      "newPassword": newPassword,
    };

    try {
      final Response response = await _dio.patch(
        url,
        data: body,
        options: Options(headers: headers),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> changeNickname(
      {required String accessToken, required String nickName}) async {
    const String url = '/user/change/nickname';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    final body = {
      "nickname": nickName,
    };

    try {
      final Response response = await _dio.patch(
        url,
        data: body,
        options: Options(headers: headers),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> verifySMS(
      {required String accessToken, required String phoneNumber}) async {
    const String url = '/user/change/phone/verify';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    final body = {
      "phoneNumber": phoneNumber,
    };

    try {
      final Response response = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> changePhoneNumber(
      {required String accessToken,
        required String token, required String code}) async {

    const String url = '/user/change/phone';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    final body = {
      "token": token,
      "code": code,
    };

    try {
      final Response response = await _dio.patch(
        url,
        data: body,
        options: Options(headers: headers),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> getUserWriteGeneralPostList(
      {required String accessToken, required int page, required int size}) async {
    String url = '/post/general-forum/my?page=$page&size=$size&sort=createdAt,desc&bodySize=200';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    try {
      final Response response = await _dio.get(url, options: Options(headers: headers));

      return SuccessResponseDTO(
          data: GeneralBoardModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }

  }

  Future<ApiResponseDTO> getUserWritePetitionPostList(
      {required String accessToken, required int page, required int size}) async {
    String url = '/post/petition/my?page=$page&size=$size&sort=createdAt,desc&bodySize=200';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    try {
      final Response response = await _dio.get(url, options: Options(headers: headers));

      return SuccessResponseDTO(
          data: PetitionBoardModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }

  }

  Future<ApiResponseDTO> getUserCommentedPostList(
      {required String accessToken, required int page, required int size}) async {
    String url = '/user/post/commented?page=$page&size=$size&sort=createdAt,desc&bodySize=200';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    try {
      final Response response = await _dio.get(url, options: Options(headers: headers));

      return SuccessResponseDTO(
          data: GeneralBoardModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }

  }

  Future<ApiResponseDTO> getUserLikedPostList(
      {required String accessToken, required int page, required int size}) async {
    String url = '/user/post/liked?page=$page&size=$size&sort=createdAt,desc&bodySize=200';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    try {
      final Response response = await _dio.get(url, options: Options(headers: headers));

      return SuccessResponseDTO(
          data: GeneralBoardModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }

  }

}
