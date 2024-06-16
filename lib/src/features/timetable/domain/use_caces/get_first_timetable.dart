import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/timetable_remote_repository.dart';
import '../models/timetable.dart';
import 'get_all_timetable.dart';

final getFirstTimetableProvider =
    Provider.autoDispose.family<Future<Timetable>, NoParams>(
  (ref, params) {
    final timetableRemoteRepository =
        ref.watch(timetableRemoteRepositoryProvider);
    return GetFirstTimetable(
      timetableRemoteRepository: timetableRemoteRepository,
      getAllTimetable: GetAllTimetable(
        timetableRemoteRepository: timetableRemoteRepository,
      ),
    )(params);
  },
);

class GetFirstTimetable extends UseCase<Timetable, NoParams> {
  final TimetableRemoteRepository timetableRemoteRepository;
  final GetAllTimetable getAllTimetable;

  GetFirstTimetable({
    required this.timetableRemoteRepository,
    required this.getAllTimetable,
  });

  @override
  Future<Timetable> call(NoParams params) async {
    // TODO: implement call
    final timetables = await getAllTimetable(const NoParams());

    int? newTimetableId;

    if (timetables.isEmpty) {
      newTimetableId =
          await timetableRemoteRepository.addTimeTable(name: "시간표");
    }

    return await timetableRemoteRepository.getTimetable(
      id: newTimetableId ?? timetables.first.id,
    );
  }
}
