import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/timetable/domain/models/timetable.dart';

import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/use_case.dart';
import '../models/schedule.dart';

final checkScheduleAvailableProvider =
    Provider.autoDispose.family<bool, CheckScheduleAvailableParams>(
  (ref, params) => CheckScheduleAvailable()(params),
);

class CheckScheduleAvailableParams extends UseCaseParams {
  final Timetable timetable;
  final Schedule newSchedule;

  const CheckScheduleAvailableParams({
    required this.timetable,
    required this.newSchedule,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [timetable, newSchedule];
}

class CheckScheduleAvailable
    extends UseCase<bool, CheckScheduleAvailableParams> {
  CheckScheduleAvailable();

  @override
  bool call(CheckScheduleAvailableParams params) {
    // TODO: implement call
    //check if the schedule time is valid
    for (final i in params.newSchedule.times) {
      if (i.start.isAfter(i.end)) {
        throw AppWarning(
          message: '시작 시간은 종료 시간보다 늦을 수 없어요.',
          stackTrace: StackTrace.current,
        );
      }
    }

    //check if the schedule time is within the table time
    for (final i in params.newSchedule.times) {
      if (i.start.hour < params.timetable.startHour ||
          i.end.hour > params.timetable.endHour) {
        throw AppWarning(
          message: '일정이 시간표 시간을 벗어나요.',
          stackTrace: StackTrace.current,
        );
      }

      //check if the schedule time is over 30 minutes
      for (final i in params.newSchedule.times) {
        if (i.end.subtract(i.start).inMinutes() < 30) {
          throw AppWarning(
            message: '일정은 30분 이상이어야 해요.',
            stackTrace: StackTrace.current,
          );
        }
      }

      //check if the schedule time is overlapped with other times
      for (final i in params.newSchedule.times) {
        for (final j in params.newSchedule.times) {
          if (i == j || i.day != j.day) continue;
          if (j.start.isBefore(i.end) && j.end.isAfter(i.start)) {
            throw AppWarning(
              message: '같은 요일에 겹치는 시간이 존재해요.',
              stackTrace: StackTrace.current,
            );
          }
        }
      }

      params.timetable.schedules
          .removeWhere((element) => element.id == params.newSchedule.id);
      for (final i in params.timetable.schedules) {
        //check if the schedule time is overlapped with other schedules
        for (final j in i.times) {
          for (final k in params.newSchedule.times) {
            if (j.day != k.day) continue;
            if (k.start.isBefore(j.end) && k.end.isAfter(j.start)) {
              throw AppWarning(
                message: '동일한 시간에 다른 일정이 존재해요.',
                stackTrace: StackTrace.current,
              );
            }
          }
        }
      }
    }

    return true;
  }
}
