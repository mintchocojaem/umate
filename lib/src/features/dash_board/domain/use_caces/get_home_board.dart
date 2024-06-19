import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../../board/domain/models/board.dart';
import '../../../board/domain/models/petition_post.dart';
import '../../../board/domain/models/petition_status.dart';
import '../../../board/domain/use_cases/get_petition_board.dart';
import '../../../timetable/domain/models/timetable.dart';
import '../../../timetable/domain/use_caces/get_first_timetable.dart';
import '../../data/repositories/dashboard_remote_repository.dart';
import '../models/home_board.dart';

final getHomeBoardProvider =
    Provider.autoDispose.family<Future<HomeBoard>, GetHomeBoardParams>(
  (ref, params) async => GetHomeBoard(
    dashBoardRemoteRepository: ref.watch(dashBoardRemoteRepositoryProvider),
    timetable: await ref.watch(
      getFirstTimetableProvider(
        const NoParams(),
      ),
    ),
    petitionBoard: await ref.watch(
      getPetitionBoardProvider(
        const GetPetitionBoardParams(
          status: PetitionStatus.active,
        ),
      ),
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
  final Timetable timetable;
  final Board<PetitionPost> petitionBoard;

  GetHomeBoard({
    required this.dashBoardRemoteRepository,
    required this.timetable,
    required this.petitionBoard,
  });

  @override
  Future<HomeBoard> call(GetHomeBoardParams params) async {
    // TODO: implement call

    final homeBoard = await dashBoardRemoteRepository.getHomeBoard(
      cancelToken: params.cancelToken,
    );

    return homeBoard.copyWith(
      schedules: timetable.schedules,
      petitions: petitionBoard.content,
    );
  }
}
