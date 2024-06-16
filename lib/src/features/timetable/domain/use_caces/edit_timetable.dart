import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/timetable_remote_repository.dart';
import '../models/schedule.dart';

final editTimetableProvider =
Provider.autoDispose.family<Future<bool>, EditTimetableParams>(
      (ref, params) => EditTimetable(
    timetableRemoteRepository: ref.read(timetableRemoteRepositoryProvider),
  )(params),
);

class EditTimetableParams extends UseCaseParams {
  final int id;
  final List<Schedule> schedules;

  const EditTimetableParams({
    required this.id,
    required this.schedules,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, schedules];
}

class EditTimetable extends UseCase<bool, EditTimetableParams> {
  final TimetableRemoteRepository timetableRemoteRepository;

  EditTimetable({
    required this.timetableRemoteRepository,
  });

  @override
  Future<bool> call(EditTimetableParams params) async {
    // TODO: implement call

    return await timetableRemoteRepository.editTimeTable(
      id: params.id,
      lectures: params.schedules,
    );
  }
}
