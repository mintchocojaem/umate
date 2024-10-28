import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/timetable/domain/use_caces/timetable_use_cases.dart';

import '../../../board/domain/models/student_council/petition_status.dart';
import '../../../board/domain/use_cases/student_council/petition_use_cases.dart';
import '../../data/repositories/dashboard_remote_repository.dart';
import '../models/home_board.dart';

final homeUseCasesProvider = Provider.autoDispose(
  (ref) => HomeUseCases(
    dashBoardRemoteRepository: ref.watch(dashBoardRemoteRepositoryProvider),
    petitionUseCases: ref.watch(petitionUseCasesProvider),
    timetableUseCases: ref.watch(timetableUseCasesProvider),
  ),
);

class HomeUseCases {
  final DashBoardRemoteRepository dashBoardRemoteRepository;
  final PetitionUseCases petitionUseCases;
  final TimetableUseCases timetableUseCases;

  HomeUseCases({
    required this.dashBoardRemoteRepository,
    required this.petitionUseCases,
    required this.timetableUseCases,
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

    final timetable = await timetableUseCases.getFirstTimetable();

    return homeBoard.copyWith(
      schedules: timetable.schedules,
      petitions: petitionBoard.content,
    );
  }
}
