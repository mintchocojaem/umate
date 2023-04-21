
import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:danvery/domain/timetable/model/lecture_search_list_model.dart';
import 'package:danvery/domain/timetable/model/lecture_search_model.dart';
import 'package:dio/dio.dart';

class TimetableProvider {
  final Dio _dio;

  TimetableProvider.internal(this._dio);

  static final TimetableProvider _singleton =
  TimetableProvider.internal(DioInterceptor().dio);

  factory TimetableProvider() => _singleton;

  Future<ApiResponseDTO> searchLecture(String accessToken,String keyword) async {
    String url = '/timetable/lecture?keyword=$keyword';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };

    try {
      final Response response = await _dio.get(
        url,
        options: Options(headers: headers),
      );
      return SuccessResponseDTO(data: LectureSearchListModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }


}
