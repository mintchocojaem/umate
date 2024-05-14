import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/use_case.dart';
import '../../../domain/models/schedule.dart';
import '../../../domain/use_cases/edit_timetable_use_case.dart';
import '../../../timetable_dependency_injections.dart';
import '../states/schedule_state.dart';
import '../states/timetable_state.dart';

class TimetableNotifier extends AutoDisposeNotifier<TimetableState> {
  @override
  TimetableState build() {
    // TODO: implement build
    state = const TimetableInitialState();
    getFirstTimetable();
    return state;
  }

  Future<void> getFirstTimetable({
    bool isRefresh = false,
  }) async {
    if (!isRefresh) {
      state = const TimetableLoadingState();
    }

    final result = await ref.read(getFirstTimetableUseCaseProvider)(
      const NoParams(),
    );

    state = result.fold(
      (success) => TimetableSuccessState(
        timetable: success,
      ),
      (failure) => TimetableFailureState(
        message: failure.message,
      ),
    );
  }

  Future<ScheduleState> updateTimetable({
    required int id,
    required List<Schedule> schedules,
  }) async {
    final result = await ref.read(editTimetableUseCaseProvider)(
      EditTimetableParams(
        id: id,
        schedules: schedules,
      ),
    );

    return result.fold(
      (success) => const ScheduleSuccessState(),
      (failure) => ScheduleFailureState(
        message: failure.message,
      ),
    );
  }
}
