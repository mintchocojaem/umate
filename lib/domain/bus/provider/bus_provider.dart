import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../model/bus_model.dart';

class BusProvider {
  final Dio _dio;

  static final BusProvider _singleton =
      BusProvider._internal(DioInterceptor().dio);

  BusProvider._internal(this._dio);

  factory BusProvider() => _singleton;

  Future<List<BusModel>?> getBusListFromStation(String stationName) async {
    String url = '/bus?stationName=$stationName';

    try {
      final Response response = await _dio.get(url);

      return response.data["busArrivalList"]
          .map<BusModel>((json) => BusModel.fromJson(json))
          .toList();
    } catch (e) {
      return null;
    }
  }
}
