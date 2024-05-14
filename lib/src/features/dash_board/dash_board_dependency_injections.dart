import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../init_dependency_injections.dart';
import '../petition/petition_dependency_injections.dart';
import '../timetable/timetable_dependency_injections.dart';
import 'data/data_sources/dash_board_data_source.dart';
import 'data/repositories/dash_board_repository_impl.dart';
import 'domain/repositories/dash_board_repository.dart';
import 'domain/use_cases/get_home_board.dart';
import 'presentation/providers/notifiers/home_board_notifier.dart';
import 'presentation/providers/states/home_board_state.dart';

final dashBoardDataSourceProvider = Provider.autoDispose<DashBoardDataSource>(
  (ref) {
    return DashBoardDataSource(
      networkClientService: ref.watch(networkClientServiceProvider),
    );
  },
);

final dashBoardRepositoryProvider = Provider.autoDispose<DashBoardRepository>(
  (ref) {
    return DashBoardRepositoryImpl(
      dashBoardDataSource: ref.watch(dashBoardDataSourceProvider),
    );
  },
);

final getHomeBoardUseCaseProvider = Provider.autoDispose<GetHomeBoardUseCase>(
  (ref) {
    return GetHomeBoardUseCase(
      dashBoardRepository: ref.watch(dashBoardRepositoryProvider),
      getPetitionBoardUseCase: ref.watch(getPetitionBoardUseCaseProvider),
      getFirstTimetableUseCase: ref.watch(getFirstTimetableUseCaseProvider),
    );
  },
);

final homeBoardProvider =
    NotifierProvider.autoDispose<HomeBoardNotifier, HomeBoardState>(
  () => HomeBoardNotifier(),
);
