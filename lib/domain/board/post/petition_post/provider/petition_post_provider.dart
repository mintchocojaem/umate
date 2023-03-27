import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../model/petition_post_model.dart';

class PetitionPostProvider {
  final Dio _dio;

  static final PetitionPostProvider singleton =
      PetitionPostProvider._internal(DioInterceptor().dio);

  PetitionPostProvider._internal(this._dio);

  factory PetitionPostProvider() => singleton;

  Future<PetitionPostModel?> getPetitionPost(String token, int id) async {
    String url = '/post/petition/$id';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.get(url,
          options: Options(
            headers: headers,
          ));

      return PetitionPostModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }

}
