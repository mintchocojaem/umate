import '../../../../core/utils/use_case.dart';
import '../models/schedule.dart';
import '../repositories/timetable_repository.dart';

class EditTimetableParams {
  final int id;
  final List<Schedule> schedules;

  EditTimetableParams({
    required this.id,
    required this.schedules,
  });
}

class EditTimetableUseCase extends UseCase<bool, EditTimetableParams> {
  final TimetableRepository timetableRepository;

  EditTimetableUseCase({required this.timetableRepository});

  @override
  Future<bool> execute(EditTimetableParams params) async {
    // TODO: implement execute
    return await timetableRepository.editTimeTable(
      id: params.id,
      schedules: params.schedules,
    );
  }
}
