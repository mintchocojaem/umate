import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../board/domain/models/student_council/petition_status.dart';
import '../../../board/domain/use_cases/student_council/petition_use_cases.dart';
import '../../data/repositories/dashboard_remote_repository.dart';
import '../models/home_board.dart';

final homeUseCasesProvider = Provider.autoDispose(
  (ref) => HomeUseCases(
    dashBoardRemoteRepository: ref.watch(dashBoardRemoteRepositoryProvider),
    petitionUseCases: ref.watch(petitionUseCasesProvider),
  ),
);

class HomeUseCases {
  final DashBoardRemoteRepository dashBoardRemoteRepository;
  final PetitionUseCases petitionUseCases;

  HomeUseCases({
    required this.dashBoardRemoteRepository,
    required this.petitionUseCases,
  });

  Future<HomeBoard> getHome({
    CancelToken? cancelToken,
  }) async {
    final homeBoard = await dashBoardRemoteRepository.getHomeBoard(
      cancelToken: cancelToken,
    );

    final petitionBoard = await petitionUseCases.getBoard(
      cancelToken: cancelToken,
      page: 0,
      status: PetitionStatus.active,
    );

    return homeBoard.copyWith(
      schedules: [],
      petitions: petitionBoard.content,
    );
  }
}
