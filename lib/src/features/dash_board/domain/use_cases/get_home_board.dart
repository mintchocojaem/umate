import 'package:dio/dio.dart';

import '../../../../core/utils/use_case.dart';
import '../../../petition/domain/models/petition_status.dart';
import '../../../petition/domain/models/post_sort.dart';
import '../../../petition/domain/use_cases/get_petition_board_use_case.dart';
import '../../../timetable/domain/use_cases/get_first_timetable_use_case.dart';
import '../models/home_board.dart';
import '../repositories/dash_board_repository.dart';

class GetHomeBoardParams {
  final CancelToken? cancelToken;

  GetHomeBoardParams({
    this.cancelToken,
  });
}

class GetHomeBoardUseCase extends UseCase<HomeBoard, GetHomeBoardParams> {
  final DashBoardRepository dashBoardRepository;
  final GetPetitionBoardUseCase getPetitionBoardUseCase;
  final GetFirstTimetableUseCase getFirstTimetableUseCase;

  GetHomeBoardUseCase({
    required this.dashBoardRepository,
    required this.getPetitionBoardUseCase,
    required this.getFirstTimetableUseCase,
  });

  @override
  Future<HomeBoard> execute(params) async {

    final homeBoard = await dashBoardRepository.getHomeBoard(
      cancelToken: params.cancelToken,
    );

    final petitionBoard = await getPetitionBoardUseCase.execute(
        GetPetitionBoardParams(
          cancelToken: params.cancelToken,
          status: PetitionStatus.active,
          sort: [
            PostSort(type: PostSortType.viewCount, order: PostSortOrder.desc,)
          ],
        ));

    final timetable = await getFirstTimetableUseCase.execute(const NoParams());

    return HomeBoard(
      carousels: homeBoard.carousels,
      petitions: petitionBoard.content,
      schedules: timetable.schedules,
    );
  }
}
