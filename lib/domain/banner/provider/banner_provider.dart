import 'dart:convert';

import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:danvery/domain/banner/model/banner_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class BannerProvider {
  final Dio _dio;

  BannerProvider._internal(this._dio);

  static final BannerProvider _singleton =
      BannerProvider._internal(DioInterceptor().dio);

  factory BannerProvider() => _singleton;

  Future<ApiResponseDTO> getBannerList() async {

    try{
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 30),
    ));
    await remoteConfig.setDefaults(const {
      "banner_list": """[
      {
        "bannerUrl":
        "https://kr1-api-object-storage.nhncloudservice.com/v1/AUTH_34f4838a2b3047f39ac9cb0701558e46/main-storage/banner_list/guide_banner.png",
        "actionUrl": null,
        "detailUrl":
        "https://kr1-api-object-storage.nhncloudservice.com/v1/AUTH_34f4838a2b3047f39ac9cb0701558e46/main-storage/banner_list/guide_detail_banner.png"
      }
    ]"""
    });
    await remoteConfig.fetchAndActivate();

    return SuccessResponseDTO(data: jsonDecode(remoteConfig.getString("banner_list"))
        .map<BannerModel>((json) => BannerModel.fromJson(json))
        .toList());
    } catch (e) {
    return ExceptionResponseDTO();
    }
  }
}
