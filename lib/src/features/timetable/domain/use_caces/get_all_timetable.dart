import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/timetable_remote_repository.dart';
import '../models/timetable.dart';

final getAllTimetableProvider =
    Provider.autoDispose.family<Future<List<Timetable>>, NoParams>(
  (ref, params) => GetAllTimetable(
    timetableRemoteRepository: ref.watch(timetableRemoteRepositoryProvider),
  )(params),
);

class GetAllTimetable extends UseCase<List<Timetable>, NoParams> {
  final TimetableRemoteRepository timetableRemoteRepository;

  GetAllTimetable({
    required this.timetableRemoteRepository,
  });

  @override
  Future<List<Timetable>> call(NoParams params) async {
    // TODO: implement call
    return await timetableRemoteRepository.getAllTimetable();
  }
}
