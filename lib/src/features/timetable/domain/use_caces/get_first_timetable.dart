import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/timetable_remote_repository.dart';
import '../models/timetable.dart';
import 'get_all_timetable.dart';

final getFirstTimetableProvider =
    Provider.autoDispose.family<Future<Timetable>, NoParams>(
  (ref, params) async {
    return GetFirstTimetable(
      timetableRemoteRepository: ref.watch(timetableRemoteRepositoryProvider),
      timetables: await ref.read(getAllTimetableProvider(const NoParams())),
    )(params);
  },
);

class GetFirstTimetable extends UseCase<Timetable, NoParams> {
  final TimetableRemoteRepository timetableRemoteRepository;
  final List<Timetable> timetables;

  GetFirstTimetable({
    required this.timetableRemoteRepository,
    required this.timetables,
  });

  @override
  Future<Timetable> call(NoParams params) async {
    // TODO: implement call
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
