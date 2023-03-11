import 'dart:convert';

import 'package:danvery/app/data/model/petition_model.dart';
import 'package:danvery/app/data/model/post_model.dart';
import 'package:danvery/app/data/provider/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/bus_model.dart';

class BusProvider{

  final dio = Dio();

  Future<List<BusModel>?> getBusListFromStation(String stationName) async {

    String url =
        '$apiUrl/bus?stationName=$stationName';

    try {
      final Response response = await dio.get(url,
          options: Options(contentType: "application/json", responseType: ResponseType.bytes));

      if (kDebugMode) {
        print("Get bus : ${response.statusCode}");
      }

      if (response.statusCode != 200) {
        throw Exception('Get bus Error');
      } else {
        return json.decode(utf8.decode(response.data))["busArrivalList"]
            .map<BusModel>((json) => BusModel.fromJson(json)).toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

}
