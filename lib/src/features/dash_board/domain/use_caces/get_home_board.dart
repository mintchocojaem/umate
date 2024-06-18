import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../../board/data/repositories/petition_remote_repository.dart';
import '../../../board/domain/models/petition_status.dart';
import '../../../board/domain/use_cases/get_petition_board.dart';
import '../../../timetable/data/repositories/timetable_remote_repository.dart';
import '../../../timetable/domain/use_caces/get_all_timetable.dart';
import '../../../timetable/domain/use_caces/get_first_timetable.dart';
import '../../data/repositories/dashboard_remote_repository.dart';
import '../models/home_board.dart';

final getHomeBoardProvider =
    Provider.autoDispose.family<Future<HomeBoard>, GetHomeBoardParams>(
  (ref, params) => GetHomeBoard(
    dashBoardRemoteRepository: ref.watch(dashBoardRemoteRepositoryProvider),
    getFirstTimetable: GetFirstTimetable(
      timetableRemoteRepository: ref.watch(timetableRemoteRepositoryProvider),
      getAllTimetable: GetAllTimetable(
        timetableRemoteRepository: ref.watch(timetableRemoteRepositoryProvider),
      ),
    ),
    getPetitionBoard: GetPetitionBoard(
      repository: ref.watch(petitionRemoteRepositoryProvider),
    ),
  )(params),
);

class GetHomeBoardParams extends UseCaseParams {
  final CancelToken? cancelToken;

  const GetHomeBoardParams({
    this.cancelToken,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [cancelToken];
}

class GetHomeBoard extends UseCase<HomeBoard, GetHomeBoardParams> {
  final DashBoardRemoteRepository dashBoardRemoteRepository;
  final GetFirstTimetable getFirstTimetable;
  final GetPetitionBoard getPetitionBoard;

  GetHomeBoard({
    required this.dashBoardRemoteRepository,
    required this.getFirstTimetable,
    required this.getPetitionBoard,
  });

  @override
  Future<HomeBoard> call(GetHomeBoardParams params) async {
    // TODO: implement call

    final homeBoard = await dashBoardRemoteRepository.getHomeBoard(
      cancelToken: params.cancelToken,
    );

    final timetable = await getFirstTimetable(
      const NoParams(),
    );

    final petitionBoard = await getPetitionBoard(
      const GetPetitionBoardParams(status: PetitionStatus.active),
    );

    return homeBoard.copyWith(
      schedules: timetable.schedules,
      petitions: petitionBoard.content,
    );
  }
}
