import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/timetable_remote_repository.dart';
import '../models/schedule.dart';
import '../models/timetable.dart';
import 'check_schedule_available.dart';
import 'edit_timetable.dart';

final deleteScheduleProvider =
    Provider.autoDispose.family<Future<bool>, DeleteScheduleParams>(
  (ref, params) {
    final timetableRemoteRepository =
        ref.watch(timetableRemoteRepositoryProvider);
    return DeleteSchedule(
      timetableRemoteRepository: timetableRemoteRepository,
      checkScheduleAvailable: CheckScheduleAvailable(),
      editTimetable: EditTimetable(
        timetableRemoteRepository: timetableRemoteRepository,
      ),
    )(params);
  },
);

class DeleteScheduleParams extends UseCaseParams {
  final Schedule schedule;
  final Timetable timetable;

  const DeleteScheduleParams({
    required this.schedule,
    required this.timetable,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [schedule, timetable];
}

class DeleteSchedule extends UseCase<bool, DeleteScheduleParams> {
  final TimetableRemoteRepository timetableRemoteRepository;
  final CheckScheduleAvailable checkScheduleAvailable;
  final EditTimetable editTimetable;

  DeleteSchedule({
    required this.timetableRemoteRepository,
    required this.checkScheduleAvailable,
    required this.editTimetable,
  });

  @override
  Future<bool> call(DeleteScheduleParams params) async {
    // TODO: implement call

    checkScheduleAvailable(
      CheckScheduleAvailableParams(
        tableStartHour: params.timetable.startHour,
        tableEndHour: params.timetable.endHour,
        newSchedule: params.schedule,
        schedules: params.timetable.schedules,
      ),
    );

    final schedules = params.timetable.schedules
        .where((element) => element.id != params.schedule.id)
        .toList();
    return await editTimetable(
      EditTimetableParams(
        id: params.timetable.id,
        schedules: schedules,
      ),
    );
  }
}
