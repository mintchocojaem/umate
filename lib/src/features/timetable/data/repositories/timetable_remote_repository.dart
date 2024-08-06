import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/timetable/domain/models/schedule.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/lecture_info.dart';
import '../../domain/models/timetable.dart';

final timetableRemoteRepositoryProvider =
    Provider.autoDispose<TimetableRemoteRepository>(
  (ref) => TimetableRemoteRepository(
    client: ref.watch(networkClientServiceProvider),
  ),
);

class TimetableRemoteRepository extends RemoteRepository {
  TimetableRemoteRepository({required super.client});

  Future<List<Timetable>> getAllTimetable() async {
    final result = await client.request(
      path: '/timetable',
      method: RequestType.get,
    );
    return (result.data as List).map((e) => Timetable.fromJson(e)).toList();
  }

  Future<Timetable> getTimetable({
    required int id,
  }) async {
    final result = await client.request(
      path: '/timetable/$id',
      method: RequestType.get,
    );
    return Timetable.fromJson(result.data);
  }

  Future<List<LectureInfo>> getAllLectureInfo({
    CancelToken? cancelToken,
    String? keyword,
    int? page,
    int? size,
  }) async {
    final result = await client.request(
      path: '/timetable/lecture',
      method: RequestType.get,
      cancelToken: cancelToken,
      queryParameters: {
        'keyword': keyword,
        'page': page,
        'size': size,
      },
    );
    return (result.data['content'] as List)
        .map((e) => LectureInfo.fromJson(e))
        .toList();
  }

  Future<int> addTimeTable({
    required String name,
  }) async {
    final result = await client.request(
      path: '/timetable',
      method: RequestType.post,
      data: {
        'name': name,
        'lectures': [],
      },
    );
    return result.data['id'];
  }

  Future<bool> editTimeTable({
    required int id,
    required List<Schedule> schedules,
  }) async {
    final result = await client.request(
      path: '/timetable/$id',
      method: RequestType.patch,
      data: {
        'lectures': schedules,
      },
    );
    return result.statusCode == 200;
  }
}
