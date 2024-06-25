import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/schedule.dart';
import '../../domain/models/schedule_time.dart';
import '../../domain/use_caces/check_schedule_available.dart';
import '../../domain/use_caces/edit_timetable.dart';
import 'timetable_view_model.dart';

final scheduleViewModelProvider =
    AsyncNotifierProvider.autoDispose.family<ScheduleViewModel, Schedule, int>(
  () => ScheduleViewModel(),
);

class ScheduleViewModel extends AutoDisposeFamilyAsyncNotifier<Schedule, int> {
  @override
  FutureOr<Schedule> build(int arg) {
    // TODO: implement build
    return _fetch();
  }

  Future<Schedule> _fetch() async {
    final timetable = ref.read(timetableViewModelProvider).requireValue;
    return timetable.schedules.firstWhere((element) => element.id == arg);
  }

  Future<bool> updateSchedule({
    String? name,
    String? professor,
    String? memo,
    List<ScheduleTime>? times,
    Color? color,
  }) async {
    final timetable = ref.read(timetableViewModelProvider).requireValue;
    final schedule =
        timetable.schedules.firstWhere((element) => element.id == arg);

    final newSchedule = schedule.copyWith(
      name: name ?? schedule.name,
      professor: professor ?? schedule.professor,
      memo: memo ?? schedule.memo,
      times: times ?? schedule.times,
      color: color ?? schedule.color,
    );

    final result = await AsyncValue.guard(() {
      ref.read(
        checkScheduleAvailableProvider(
          CheckScheduleAvailableParams(
            timetable: timetable,
            newSchedule: newSchedule,
          ),
        ),
      );

      return ref.read(
        editTimetableProvider(
          EditTimetableParams(
            id: timetable.id,
            schedules: timetable.schedules
              ..removeWhere((element) => element.id == arg)
              ..add(newSchedule),
          ),
        ),
      );
    });

    result.whenOrNull(
      data: (_) {
        ref.invalidate(timetableViewModelProvider);
      },
      error: (error, stackTrace) {
        state = AsyncError(
          error,
          stackTrace,
        );
      },
    );

    return result.hasValue;
  }

  Future<bool> deleteSchedule() async {
    final timetable = ref.read(timetableViewModelProvider).requireValue;
    final result = await AsyncValue.guard(
      () => ref.read(
        editTimetableProvider(
          EditTimetableParams(
            id: timetable.id,
            schedules: timetable.schedules
              ..removeWhere((element) => element.id == arg),
          ),
        ),
      ),
    );

    result.whenOrNull(
      data: (_) {
        ref.invalidate(timetableViewModelProvider);
      },
      error: (error, stackTrace) {
        state = AsyncError(
          error,
          stackTrace,
        );
      },
    );

    return result.hasValue;
  }
}
