import '../../../../core/utils/use_case.dart';
import '../models/timetable.dart';
import '../repositories/timetable_repository.dart';
import 'get_all_timetable_info_use_case.dart';

class GetFirstTimetableUseCase extends UseCase<Timetable, NoParams> {
  final TimetableRepository timetableRepository;
  final GetAllTimetableInfoUseCase getAllTimetableInfoUseCase;

  GetFirstTimetableUseCase({
    required this.timetableRepository,
    required this.getAllTimetableInfoUseCase,
  });

  @override
  Future<Timetable> execute(NoParams params) async {
    final timetables =
        await getAllTimetableInfoUseCase.execute(const NoParams());

    int? newTimetableId;

    if (timetables.isEmpty) {
       newTimetableId = await timetableRepository.addTimeTable(name: "시간표");
    }

    return await timetableRepository.getTimetable(
      id: newTimetableId ?? timetables.first.id,
    );
  }
}
