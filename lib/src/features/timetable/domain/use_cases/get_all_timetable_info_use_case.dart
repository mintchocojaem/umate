import '../../../../core/utils/use_case.dart';
import '../models/timetable.dart';
import '../repositories/timetable_repository.dart';

class GetAllTimetableInfoUseCase extends UseCase<List<Timetable>, NoParams> {
  final TimetableRepository timetableRepository;

  GetAllTimetableInfoUseCase({
    required this.timetableRepository,
  });

  @override
  Future<List<Timetable>> execute(NoParams params) async {
    return await timetableRepository.getAllTimetableInfo();
  }
}