import 'package:dio/dio.dart';
import 'package:umate/src/features/timetable/domain/models/schedule.dart';

import '../../domain/models/lecture_info.dart';
import '../../domain/models/timetable.dart';
import '../../domain/repositories/timetable_repository.dart';
import '../data_sources/timetable_remote_data_source.dart';
import '../dto/schedule_dto.dart';
import '../dto/schedule_time_dto.dart';

class TimetableRepositoryImpl implements TimetableRepository {
  final TimetableRemoteDataSource remoteDataSource;

  TimetableRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<Timetable>> getAllTimetableInfo() async {
    final result = await remoteDataSource.getAllTimetableInfo();
    return result.map((e) => e.mapToModel()).toList();
  }

  @override
  Future<Timetable> getTimetable({
    required int id,
  }) async {
    final result = await remoteDataSource.getTimetable(id: id);
    return result.mapToModel();
  }

  @override
  Future<List<LectureInfo>> getAllLectureInfo({
    String? keyword,
    CancelToken? cancelToken,
  }) async {
    final result = await remoteDataSource.getAllLectureInfo(
      keyword: keyword,
      cancelToken: cancelToken,
    );
    return result.map((e) => e.mapToModel()).toList();
  }

  @override
  Future<int> addTimeTable({required String name}) {
    // TODO: implement addTimeTable
    final result = remoteDataSource.addTimeTable(name: name);
    return result;
  }

  @override
  Future<bool> editTimeTable({
    required int id,
    required List<Schedule> schedules,
  }) {
    // TODO: implement editTimeTable
    final result = remoteDataSource.editTimeTable(
      id: id,
      lectures: schedules
          .map(
            (e) => ScheduleDTO(
              name: e.name,
              type: e.type.value,
              professor: e.professor,
              memo: e.memo,
              color: e.color.value.toString(),
              times: e.times
                  .map(
                    (e) => ScheduleTimeDTO(
                      week: e.day.value,
                      //HH.mm.ss
                      start:
                          e.startTime.toDateTime().toString().substring(11, 19),
                      end: e.endTime.toDateTime().toString().substring(11, 19),
                    ),
                  )
                  .toList(),
            ).toJson(),
          )
          .toList(),
    );
    return result;
  }
}
