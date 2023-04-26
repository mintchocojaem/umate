
import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:danvery/domain/timetable/model/lecture/lecture_search_list_model.dart';
import 'package:danvery/domain/timetable/model/timetable/timetable_list_model.dart';
import 'package:danvery/domain/timetable/model/timetable/timetable_model.dart';
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

  Future<ApiResponseDTO> getTimetableList(String accessToken) async {
    String url = '/timetable';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };

    try {
      final Response response = await _dio.get(
        url,
        options: Options(headers: headers),
      );
      return SuccessResponseDTO(data: TimetableListModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> getTimetable(String accessToken,int timetableId) async {
    String url = '/timetable/$timetableId';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };

    try {
      final Response response = await _dio.get(
        url,
        options: Options(headers: headers),
      );
      return SuccessResponseDTO(data: TimetableModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> addTimetable(String accessToken,TimetableModel timetableModel) async {
    String url = '/timetable';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };

    final data = {
      'name': timetableModel.name,
      'lectures': timetableModel.lectures.map((e) => e.toJson()).toList(),
    };

    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> editTimetable(String accessToken,TimetableModel timetableModel) async {
    String url = '/timetable/${timetableModel.id}';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    final data = {
      'lectures': timetableModel.lectures.map((e) => e.toJson()).toList(),
    };

    try {
      final Response response = await _dio.patch(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

}
