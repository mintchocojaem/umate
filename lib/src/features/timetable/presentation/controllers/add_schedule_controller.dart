import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/schedule_time.dart';
import '../../domain/models/schedule_type.dart';
import '../../domain/use_caces/timetable_use_cases.dart';
import 'timetable_controller.dart';

final addScheduleControllerProvider =
    AsyncNotifierProvider.autoDispose<AddScheduleController, void>(
  () => AddScheduleController(),
);

class AddScheduleController extends AutoDisposeAsyncNotifier<void> {
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
    final timetable = ref.read(timetableControllerProvider).requireValue;

    final result = await AsyncValue.guard(
      () => ref.read(timetableUseCasesProvider).addSchedule(
            timetable: timetable,
            name: name,
            type: ScheduleType.schedule,
            times: times,
            memo: memo,
            color: color,
          ),
    );

    result.whenOrNull(
      data: (_) {
        ref.invalidate(timetableControllerProvider);
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
