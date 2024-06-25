import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/schedule.dart';
import '../../domain/models/schedule_time.dart';
import '../../domain/models/schedule_type.dart';
import '../../domain/use_caces/check_schedule_available.dart';
import '../../domain/use_caces/edit_timetable.dart';
import 'timetable_view_model.dart';

final addScheduleViewModelProvider =
    AsyncNotifierProvider.autoDispose<AddScheduleViewModel, void>(
  () => AddScheduleViewModel(),
);

class AddScheduleViewModel extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // TODO: implement build
    return null;
  }

  Future<bool> addSchedule({
    required String name,
    required List<ScheduleTime> times,
    String? memo,
    required Color color,
  }) async {
    final timetable = ref.read(timetableViewModelProvider).requireValue;

    final newSchedule = Schedule(
      name: name,
      type: ScheduleType.schedule,
      times: times,
      memo: memo ?? '',
      color: color,
    );

    final result = await AsyncValue.guard(
      () {
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
              schedules: timetable.schedules..add(newSchedule),
            ),
          ),
        );
      },
    );

    result.whenOrNull(
      data: (_) {
        ref.invalidate(timetableViewModelProvider);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(
          error,
          stackTrace,
        );
      },
    );

    return result.hasValue;
  }
}
