import 'dart:convert';

import 'package:danvery/utils/url/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/bus_model.dart';


class BusProvider{

  final Dio dio;
  BusProvider({required this.dio});

  Future<List<BusModel>?> getBusListFromStation(String stationName) async {

    String url =
        '/bus?stationName=$stationName';

    try {
      final Response response = await dio.get(url);

      return response.data["busArrivalList"]
          .map<BusModel>((json) => BusModel.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

}
