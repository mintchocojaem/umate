import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/timetable_remote_repository.dart';
import '../models/schedule.dart';
import '../models/timetable.dart';
import 'check_schedule_available.dart';
import 'edit_timetable.dart';

final addScheduleProvider =
    Provider.autoDispose.family<Future<bool>, AddScheduleParams>(
  (ref, params) {
    final timetableRemoteRepository =
        ref.watch(timetableRemoteRepositoryProvider);
    return AddSchedule(
      timetableRemoteRepository: timetableRemoteRepository,
      checkScheduleAvailable: CheckScheduleAvailable(),
      editTimetable: EditTimetable(
        timetableRemoteRepository: timetableRemoteRepository,
      ),
    )(params);
  },
);

class AddScheduleParams extends UseCaseParams {
  final Schedule schedule;
  final Timetable timetable;

  const AddScheduleParams({
    required this.schedule,
    required this.timetable,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [schedule, timetable];
}

class AddSchedule extends UseCase<bool, AddScheduleParams> {
  final TimetableRemoteRepository timetableRemoteRepository;
  final CheckScheduleAvailable checkScheduleAvailable;
  final EditTimetable editTimetable;

  AddSchedule({
    required this.timetableRemoteRepository,
    required this.checkScheduleAvailable,
    required this.editTimetable,
  });

  @override
  Future<bool> call(AddScheduleParams params) async {
    // TODO: implement call

    checkScheduleAvailable(
      CheckScheduleAvailableParams(
        tableStartHour: params.timetable.startHour,
        tableEndHour: params.timetable.endHour,
        newSchedule: params.schedule,
        schedules: params.timetable.schedules,
      ),
    );

    final schedules = [
      ...params.timetable.schedules,
      params.schedule,
    ];
    return await editTimetable(
      EditTimetableParams(
        id: params.timetable.id,
        schedules: schedules,
      ),
    );
  }
}
