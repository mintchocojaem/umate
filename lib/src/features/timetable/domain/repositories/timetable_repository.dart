import 'package:dio/dio.dart';

import '../models/lecture_info.dart';
import '../models/schedule.dart';
import '../models/timetable.dart';

abstract class TimetableRepository {
  Future<List<Timetable>> getAllTimetableInfo();

  Future<Timetable> getTimetable({
    required int id,
  });

  Future<int> addTimeTable({
    required String name,
  });

  Future<List<LectureInfo>> getAllLectureInfo({
    String? keyword,
    CancelToken? cancelToken,
  });

  Future<bool> editTimeTable({
    required int id,
    required List<Schedule> schedules,
  });

}
