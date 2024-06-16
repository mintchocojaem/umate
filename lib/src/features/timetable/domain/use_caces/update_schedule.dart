import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/timetable_remote_repository.dart';
import '../models/schedule.dart';
import '../models/timetable.dart';
import 'check_schedule_available.dart';
import 'edit_timetable.dart';

final updateScheduleProvider =
    Provider.autoDispose.family<Future<bool>, UpdateScheduleParams>(
  (ref, params) {
    final timetableRemoteRepository =
        ref.watch(timetableRemoteRepositoryProvider);
    return UpdateSchedule(
      timetableRemoteRepository: timetableRemoteRepository,
      checkScheduleAvailable: CheckScheduleAvailable(),
      editTimetable: EditTimetable(
        timetableRemoteRepository: timetableRemoteRepository,
      ),
    )(params);
  },
);

class UpdateScheduleParams extends UseCaseParams {
  final Schedule newSchedule;
  final Timetable timetable;

  const UpdateScheduleParams({
    required this.newSchedule,
    required this.timetable,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [newSchedule, timetable];
}

class UpdateSchedule extends UseCase<bool, UpdateScheduleParams> {
  final TimetableRemoteRepository timetableRemoteRepository;
  final CheckScheduleAvailable checkScheduleAvailable;
  final EditTimetable editTimetable;

  UpdateSchedule({
    required this.timetableRemoteRepository,
    required this.checkScheduleAvailable,
    required this.editTimetable,
  });

  @override
  Future<bool> call(UpdateScheduleParams params) async {
    // TODO: implement call

    checkScheduleAvailable(
      CheckScheduleAvailableParams(
        tableStartHour: params.timetable.startHour,
        tableEndHour: params.timetable.endHour,
        newSchedule: params.newSchedule,
        schedules: params.timetable.schedules,
      ),
    );

    final schedules = params.timetable.schedules
      ..removeWhere((e) => e.id == params.newSchedule.id)
      ..add(params.newSchedule);
    return await editTimetable(
      EditTimetableParams(
        id: params.timetable.id,
        schedules: schedules,
      ),
    );
  }
}
