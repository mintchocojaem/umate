import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../domain/models/schedule.dart';
import '../../domain/models/timetable.dart';
import '../../domain/use_caces/add_schedule.dart';
import '../../domain/use_caces/delete_schedule.dart';
import '../../domain/use_caces/get_first_timetable.dart';
import '../../domain/use_caces/update_schedule.dart';

final timetableProvider =
    AsyncNotifierProvider.autoDispose<TimetableNotifier, Timetable>(
  () => TimetableNotifier(),
);

class TimetableNotifier extends AutoDisposeAsyncNotifier<Timetable> {
  @override
  FutureOr<Timetable> build() {
    // TODO: implement build
    return _fetch();
  }

  Future<void> fetch() async {
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<Timetable> _fetch() async {
    final result = await ref.read(
      getFirstTimetableProvider(
        const NoParams(),
      ),
    );
    return result;
  }

  Future<bool> addSchedule({
    required Schedule schedule,
  }) async {
    final result = await AsyncValue.guard(
      () => ref.read(
        addScheduleProvider(
          AddScheduleParams(
            schedule: schedule,
            timetable: state.requireValue,
          ),
        ),
      ),
    );

    result.whenOrNull(
      data: (data) {
        ref.invalidateSelf();
      },
      error: (error, stackTrace) {
        state = AsyncError(error, stackTrace);
      },
    );

    return result.hasValue;
  }

  Future<bool> updateSchedule({
    required Schedule newSchedule,
  }) async {
    final result = await AsyncValue.guard(
      () => ref.read(
        updateScheduleProvider(
          UpdateScheduleParams(
            newSchedule: newSchedule,
            timetable: state.requireValue,
          ),
        ),
      ),
    );

    result.whenOrNull(
      data: (data) {
        ref.invalidateSelf();
      },
      error: (error, stackTrace) {
        state = AsyncError(error, stackTrace);
      },
    );

    return result.hasValue;
  }

  Future<bool> deleteSchedule({
    required Schedule schedule,
  }) async {
    final result = await AsyncValue.guard(
      () => ref.read(
        deleteScheduleProvider(
          DeleteScheduleParams(
            schedule: schedule,
            timetable: state.requireValue,
          ),
        ),
      ),
    );

    result.whenOrNull(
      data: (data) {
        ref.invalidateSelf();
      },
      error: (error, stackTrace) {
        state = AsyncError(error, stackTrace);
      },
    );

    return result.hasValue;
  }
}
