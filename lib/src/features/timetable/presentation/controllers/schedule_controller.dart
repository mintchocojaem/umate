import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/schedule.dart';
import '../../domain/models/schedule_time.dart';
import '../../domain/use_caces/timetable_use_cases.dart';
import 'timetable_controller.dart';

final scheduleControllerProvider =
    AsyncNotifierProvider.autoDispose.family<ScheduleController, Schedule, int>(
  () => ScheduleController(),
);

class ScheduleController extends AutoDisposeFamilyAsyncNotifier<Schedule, int> {
  @override
  FutureOr<Schedule> build(int arg) {
    // TODO: implement build
    return _fetch();
  }

  Future<Schedule> _fetch() async {
    final timetable = ref.read(timetableControllerProvider).requireValue;
    return timetable.schedules.firstWhere((element) => element.id == arg);
  }

  Future<bool> updateSchedule({
    String? name,
    List<ScheduleTime>? times,
    String? memo,
    String? professor,
    Color? color,
  }) async {
    final timetable = ref.read(timetableControllerProvider).requireValue;
    final schedule =
        timetable.schedules.firstWhere((element) => element.id == arg);

    final result = await AsyncValue.guard(
      () => ref.read(timetableUseCasesProvider).editSchedule(
            timetable: timetable,
            id: schedule.id,
            name: name,
            times: times,
            memo: memo,
            professor: professor,
            color: color,
          ),
    );

    result.whenOrNull(
      data: (_) {
        ref.invalidate(timetableControllerProvider);
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
    final timetable = ref.read(timetableControllerProvider).requireValue;
    final result = await AsyncValue.guard(
      () => ref.read(timetableUseCasesProvider).deleteSchedule(
            timetable: timetable,
            id: arg,
          ),
    );

    result.whenOrNull(
      data: (_) {
        ref.invalidate(timetableControllerProvider);
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
