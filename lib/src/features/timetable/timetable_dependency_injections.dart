import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../init_dependency_injections.dart';
import 'data/data_sources/timetable_remote_data_source.dart';
import 'data/repositories/time_table_repository_impl.dart';
import 'domain/repositories/timetable_repository.dart';
import 'domain/use_cases/edit_timetable_use_case.dart';
import 'domain/use_cases/get_all_lecture_info_use_case.dart';
import 'domain/use_cases/get_all_timetable_info_use_case.dart';
import 'domain/use_cases/get_first_timetable_use_case.dart';
import 'presentation/providers/notifiers/schedule_notifier.dart';
import 'presentation/providers/notifiers/search_lecture_notifier.dart';
import 'presentation/providers/notifiers/timetable_notifier.dart';
import 'presentation/providers/states/schedule_state.dart';
import 'presentation/providers/states/search_lecture_state.dart';
import 'presentation/providers/states/timetable_state.dart';

final timetableRemoteDataSourceProvider =
    Provider.autoDispose<TimetableRemoteDataSource>(
  (ref) => TimetableRemoteDataSource(
    networkClientService: ref.watch(networkClientServiceProvider),
  ),
);

final timetableRepositoryProvider = Provider.autoDispose<TimetableRepository>(
  (ref) => TimetableRepositoryImpl(
    remoteDataSource: ref.watch(timetableRemoteDataSourceProvider),
  ),
);

final getAllTimetableInfoUseCaseProvider =
    Provider.autoDispose<GetAllTimetableInfoUseCase>(
  (ref) => GetAllTimetableInfoUseCase(
    timetableRepository: ref.watch(timetableRepositoryProvider),
  ),
);

final getFirstTimetableUseCaseProvider =
    Provider.autoDispose<GetFirstTimetableUseCase>(
  (ref) => GetFirstTimetableUseCase(
    timetableRepository: ref.watch(timetableRepositoryProvider),
    getAllTimetableInfoUseCase: ref.watch(getAllTimetableInfoUseCaseProvider),
  ),
);

final getAllLectureInfoUseCaseProvider =
    Provider.autoDispose<GetAllLectureInfoUseCase>(
  (ref) => GetAllLectureInfoUseCase(
    timetableRepository: ref.watch(timetableRepositoryProvider),
  ),
);

final editTimetableUseCaseProvider = Provider.autoDispose<EditTimetableUseCase>(
  (ref) => EditTimetableUseCase(
    timetableRepository: ref.watch(timetableRepositoryProvider),
  ),
);

final timetableProvider =
    NotifierProvider.autoDispose<TimetableNotifier, TimetableState>(
  () => TimetableNotifier(),
);

final searchLectureProvider =
    NotifierProvider.autoDispose<SearchLectureNotifier, SearchLectureState>(
  () => SearchLectureNotifier(),
);

final scheduleProvider =
    NotifierProvider.autoDispose<ScheduleNotifier, ScheduleState>(
  () => ScheduleNotifier(),
);
