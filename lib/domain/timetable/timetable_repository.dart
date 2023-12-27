import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/dio_provider.dart';
import '../domain.dart';

final timetableRepositoryProvider = Provider<TimetableRepository>(
    (ref) => TimetableRepository(ref.read(dioProvider)));

final class TimetableRepository extends Repository {
  TimetableRepository(super.dio);

  Future<int> addTimetable({required String name, List<Lecture>? lectures}) async {
    final response = await post(
      path: '/timetable',
      data: {
        'name': name,
        'lectures': lectures?.map((e) => e.toJson()).toList() ?? [],
      },
    );
    return response?.data['id'];
  }

  Future<List<Timetable>> getTimetableInfo() async {
    final response = await get(path: '/timetable');
    return (response?.data as List).map((e) => Timetable.fromJson(e)).toList();
  }

  Future<Timetable> getTimetable(int id) async {
    final response = await get(path: '/timetable/$id');
    return Timetable.fromJson(response?.data);
  }

  Future<List<LectureInfo>> getLectureInfo(String keyword) async {
    final response = await get(
      path: '/timetable/lecture',
      queryParameters: {
        'keyword': keyword,
        'page': 0,
        'size': 20,
      },
      allowDuplicateRequest: false,
    );
    return (response?.data['content'] as List)
        .map((e) => LectureInfo.fromJson(e))
        .toList();
  }

  Future<bool> editTimetableLectures({required int id, required List<Lecture> lectures}) async {

    lectureTimeToJson(LectureTime lectureTime) {
      return {
        'start': "${lectureTime.start}:00",
        'end': "${lectureTime.end}:00",
        'week': lectureTime.week,
        'place': lectureTime.place,
      };
    }

    lectureToJson(Lecture lectures) {
      return {
        'name': lectures.name,
        'memo': lectures.memo,
        'type': lectures.type,
        'color': lectures.color,
        'times': lectures.times.map((e) => lectureTimeToJson(e)).toList(),
      };
    }

    final response = await patch(
      path: '/timetable/$id',
      data: {
        'lectures': lectures.map((e) => lectureToJson(e)).toList(),
      },
    );
    return response?.statusCode == 200;
  }


}
