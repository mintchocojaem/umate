import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_exception.dart';
import '../../data/repositories/timetable_remote_repository.dart';
import '../models/lecture_info.dart';
import '../models/schedule.dart';
import '../models/schedule_time.dart';
import '../models/schedule_type.dart';
import '../models/timetable.dart';

final timetableUseCasesProvider = Provider.autoDispose<TimetableUseCases>(
  (ref) => TimetableUseCases(
    timetableRemoteRepository: ref.watch(timetableRemoteRepositoryProvider),
  ),
);

class TimetableUseCases {
  final TimetableRemoteRepository timetableRemoteRepository;

  TimetableUseCases({
    required this.timetableRemoteRepository,
  });

  Future<int> addTimetable({
    required String name,
  }) async {
    return await timetableRemoteRepository.addTimeTable(
      name: name,
    );
  }

  Future<List<Timetable>> getAllTimetable() async {
    return await timetableRemoteRepository.getAllTimetable();
  }

  Future<Timetable> getFirstTimetable() async {
    final timetables = await timetableRemoteRepository.getAllTimetable();

    int? newTimetableId;
    if (timetables.isEmpty) {
      newTimetableId = await timetableRemoteRepository.addTimeTable(
        name: "시간표",
      );
    }
    return await timetableRemoteRepository.getTimetable(
      id: newTimetableId ?? timetables.first.id,
    );
  }

  Future<List<LectureInfo>> getAllLectureInfo({
    CancelToken? cancelToken,
    required String keyword,
  }) async {
    return await timetableRemoteRepository.getAllLectureInfo(
      keyword: keyword,
      cancelToken: cancelToken,
    );
  }

  Future<bool> editTimetable({
    required int id,
    required List<Schedule> schedules,
  }) async {
    return await timetableRemoteRepository.editTimeTable(
      id: id,
      schedules: schedules,
    );
  }

  bool checkScheduleAvailable({
    required Timetable timetable,
    required int scheduleId,
    required List<ScheduleTime> scheduleTimes,
  }) {
    //check if the schedule time is valid
    for (final i in scheduleTimes) {
      if (i.start.isAfter(i.end)) {
        throw AppWarning(
          message: '시작 시간은 종료 시간보다 늦을 수 없어요.',
          stackTrace: StackTrace.current,
        );
      }
    }

    //check if the schedule time is within the table time
    for (final i in scheduleTimes) {
      if (i.start.hour < timetable.startHour ||
          i.end.hour > timetable.endHour) {
        throw AppWarning(
          message: '일정이 시간표 시간을 벗어나요.',
          stackTrace: StackTrace.current,
        );
      }

      //check if the schedule time is over 30 minutes
      for (final i in scheduleTimes) {
        if (i.end.subtract(i.start).inMinutes() < 30) {
          throw AppWarning(
            message: '일정은 30분 이상이어야 해요.',
            stackTrace: StackTrace.current,
          );
        }
      }

      //check if the schedule time is overlapped with other times
      for (final i in scheduleTimes) {
        for (final j in scheduleTimes) {
          if (i != j) {
            if (i.start.isBefore(j.end) && i.end.isAfter(j.start)) {
              throw AppWarning(
                message: '일정이 겹쳐요.',
                stackTrace: StackTrace.current,
              );
            }
          }
        }
      }
    }

    return true;
  }

  Future<bool> addSchedule({
    required Timetable timetable,
    required String name,
    required ScheduleType type,
    required List<ScheduleTime> times,
    String? memo,
    required Color color,
  }) async {
    final newSchedule = Schedule(
      name: name,
      type: type,
      times: times,
      memo: memo,
      color: color,
    );

    checkScheduleAvailable(
      timetable: timetable,
      scheduleId: newSchedule.id,
      scheduleTimes: newSchedule.times,
    );

    final newSchedules = List<Schedule>.from(timetable.schedules)
      ..add(newSchedule);

    return await timetableRemoteRepository.editTimeTable(
      id: timetable.id,
      schedules: newSchedules,
    );
  }

  Future<bool> editSchedule({
    required Timetable timetable,
    required int id,
    String? name,
    List<ScheduleTime>? times,
    String? memo,
    String? professor,
    Color? color,
  }) async {
    final newSchedule = timetable.schedules
        .firstWhere(
          (schedule) => schedule.id == id,
        )
        .copyWith(
          name: name,
          times: times,
          memo: memo,
          professor: professor,
          color: color,
        );

    checkScheduleAvailable(
      timetable: timetable,
      scheduleId: id,
      scheduleTimes: newSchedule.times,
    );

    final newSchedules = List<Schedule>.from(timetable.schedules)
      ..where((schedule) => schedule.id != id)
      ..add(newSchedule);

    return await timetableRemoteRepository.editTimeTable(
      id: timetable.id,
      schedules: newSchedules,
    );
  }

  Future<bool> deleteSchedule({
    required Timetable timetable,
    required int id,
  }) async {
    final newSchedules = List<Schedule>.from(timetable.schedules)
        .where((schedule) => schedule.id != id)
        .toList();

    return await timetableRemoteRepository.editTimeTable(
      id: timetable.id,
      schedules: newSchedules,
    );
  }
}
