import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/schedule.dart';
import '../../../timetable_dependency_injections.dart';
import '../states/schedule_state.dart';
import '../states/timetable_state.dart';

class ScheduleNotifier extends AutoDisposeNotifier<ScheduleState> {
  @override
  ScheduleState build() {
    // TODO: implement build
    return const ScheduleInitialState();
  }

  Schedule? getScheduleById(int id) {
    final timetableState = ref.read(timetableProvider);

    if (timetableState is! TimetableSuccessState) {
      return null;
    }

    final timetable = timetableState.timetable;
    return timetable.schedules.firstWhere(
      (element) => element.id == id,
    );
  }

  Future<void> updateSchedule({
    required Schedule schedule,
  }) async {
    state = const ScheduleInitialState();

    final timetableState = ref.read(timetableProvider);

    if (timetableState is! TimetableSuccessState ||
        !_checkAvailableSchedule(schedule)) {
      return;
    }

    state = await ref.read(timetableProvider.notifier).updateTimetable(
      id: timetableState.timetable.id,
      schedules: [
        ...timetableState.timetable.schedules
            .where((element) => element.id != schedule.id),
        schedule,
      ],
    );
  }

  Future<void> addSchedule({
    required Schedule schedule,
  }) async {
    state = const ScheduleInitialState();

    final timetableState = ref.read(timetableProvider);

    if (timetableState is! TimetableSuccessState ||
        !_checkAvailableSchedule(schedule)) {
      return;
    }

    state = await ref.read(timetableProvider.notifier).updateTimetable(
      id: timetableState.timetable.id,
      schedules: [
        ...timetableState.timetable.schedules,
        schedule,
      ],
    );
  }

  Future<bool> removeSchedule({
    required int id,
  }) async {
    state = const ScheduleInitialState();

    final timetableState = ref.read(timetableProvider);

    if (timetableState is! TimetableSuccessState) {
      return false;
    }

    state = await ref.read(timetableProvider.notifier).updateTimetable(
      id: timetableState.timetable.id,
      schedules: [
        ...timetableState.timetable.schedules
            .where((element) => element.id != id),
      ],
    );

    if (state is ScheduleSuccessState) {
      return true;
    } else {
      return false;
    }
  }

  bool _checkAvailableSchedule(Schedule schedule) {
    final timetableState = ref.read(timetableProvider);

    if (timetableState is! TimetableSuccessState) {
      return false;
    }

    final timetable = timetableState.timetable;

    //check if the schedule time is valid
    for (final i in schedule.times) {
      if (i.startTime.isAfter(i.endTime)) {
        state = const ScheduleFailureState(
          message: '시작 시간은 종료 시간보다 늦을 수 없어요.',
        );
        return false;
      }
    }

    //check if the schedule time is within the table time
    for (final i in schedule.times) {
      if (i.startTime.hour < timetable.startHour ||
          i.endTime.hour > timetable.endHour) {
        state = const ScheduleFailureState(
          message: '일정이 시간표 시간을 벗어나요.',
        );
        return false;
      }

      //check if the schedule time is over 30 minutes
      for (final i in schedule.times) {
        if (i.endTime.subtract(i.startTime).inMinutes() < 30) {
          state = const ScheduleFailureState(
            message: '일정은 30분 이상이어야 해요.',
          );
          return false;
        }
      }

      //check if the schedule time is overlapped with other schedules except itself
      for (final i in timetable.schedules) {
        if (i.id == schedule.id) {
          continue;
        }

        for (final j in i.times) {
          for (final k in schedule.times) {
            if (j.day == k.day) {
              if (j.startTime.isBefore(k.endTime) &&
                  j.endTime.isAfter(k.startTime)) {
                state = const ScheduleFailureState(
                  message: '동일한 시간에 다른 일정이 존재해요.',
                );
                return false;
              }
            }
          }
        }
      }
    }
    return true;
  }
}
