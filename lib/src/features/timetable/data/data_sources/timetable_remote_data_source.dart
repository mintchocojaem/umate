import 'package:dio/dio.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/remote_data_source.dart';
import '../dto/lecture_info_dto.dart';
import '../dto/timetable_dto.dart';

class TimetableRemoteDataSource extends RemoteDataSource {
  TimetableRemoteDataSource({required super.networkClientService});

  Future<List<TimetableDTO>> getAllTimetableInfo() async {
    return request(
      path: '/timetable',
      method: RequestType.get,
      fromJson: TimetableDTO.fromJson,
    );
  }

  Future<TimetableDTO> getTimetable({
    required int id,
  }) async {
    return request(
      path: '/timetable/$id',
      method: RequestType.get,
      fromJson: TimetableDTO.fromJson,
    );
  }

  Future<List<LectureInfoDTO>> getAllLectureInfo({
    String? keyword,
    int? page,
    int? size,
    CancelToken? cancelToken,
  }) async {
    return request(
      path: '/timetable/lecture',
      method: RequestType.get,
      queryParameters: {
        'keyword': keyword,
        'page': page,
        'size': size,
      },
      deepToJsonByKeys: ['content'],
      fromJson: LectureInfoDTO.fromJson,
      cancelToken: cancelToken,
    );
  }

  Future<int> addTimeTable({required String name}) async {
    return request(
      path: '/timetable',
      method: RequestType.post,
      data: {
        'name': name,
        'lectures': [],
      },
      fromJson: (json) => json['id'],
    );
  }

  Future<bool> editTimeTable({
    required int id,
    required List<Map<String, dynamic>> lectures,
  }) async {
    return request(
      path: '/timetable/$id',
      method: RequestType.patch,
      data: {
        'lectures': lectures,
      },
      fromJson: (json) => true,
    );
  }

}
