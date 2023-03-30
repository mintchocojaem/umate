import 'package:danvery/utils/dto/api_response_dto.dart';
import 'package:danvery/utils/dto/exception/exception_response_dto.dart';
import 'package:danvery/utils/dto/success/success_response_dto.dart';
import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../model/bus_model.dart';

class BusProvider {
  final Dio _dio;

  static final BusProvider _singleton =
      BusProvider._internal(DioInterceptor().dio);

  BusProvider._internal(this._dio);

  factory BusProvider() => _singleton;

  Future<ApiResponseDTO> getBusListFromStation(String stationName) async {
    String url = '/bus?stationName=$stationName';

    try {
      final Response response = await _dio.get(url);

      return SuccessResponseDTO(data: response.data["busArrivalList"]
          .map<BusModel>((json) => BusModel.fromJson(json))
          .toList());
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }
}
