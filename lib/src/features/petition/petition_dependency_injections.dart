import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../init_dependency_injections.dart';
import 'data/data_sources/petition_remote_data_source.dart';
import 'data/repositories/petition_repository_impl.dart';
import 'domain/models/coalition_type.dart';
import 'domain/models/petition_status.dart';
import 'domain/models/post_sort.dart';
import 'domain/use_cases/agree_petition_use_case.dart';
import 'domain/use_cases/get_coalition_board_use_case.dart';
import 'domain/use_cases/get_coalition_post_use_case.dart';
import 'domain/use_cases/get_notice_board_use_case.dart';
import 'domain/use_cases/get_notice_post_use_case.dart';
import 'domain/use_cases/get_petition_board_use_case.dart';
import 'domain/use_cases/get_petition_post_use_case.dart';
import 'domain/use_cases/report_post_use_case.dart';
import 'domain/use_cases/search_post_use_case.dart';
import 'domain/use_cases/write_petition_use_case.dart';
import 'presentation/providers/notifiers/coalition_board_category_notifier.dart';
import 'presentation/providers/notifiers/coalition_board_notifier.dart';
import 'presentation/providers/notifiers/coalition_board_sort_notifier.dart';
import 'presentation/providers/notifiers/coalition_post_notifier.dart';
import 'presentation/providers/notifiers/notice_board_notifier.dart';
import 'presentation/providers/notifiers/notice_board_sort_notifier.dart';
import 'presentation/providers/notifiers/notice_post_notifier.dart';
import 'presentation/providers/notifiers/petition_board_notifier.dart';
import 'presentation/providers/notifiers/petition_board_sort_notifier.dart';
import 'presentation/providers/notifiers/petition_board_category_notifier.dart';
import 'presentation/providers/notifiers/petition_post_notifier.dart';
import 'presentation/providers/notifiers/search_post_notifier.dart';
import 'presentation/providers/states/board_state.dart';
import 'presentation/providers/states/post_state.dart';
import 'presentation/providers/states/search_state.dart';

final petitionRemoteDataSourceProvider =
    Provider.autoDispose<PetitionRemoteDataSource>(
  (ref) => PetitionRemoteDataSource(
    networkClientService: ref.watch(networkClientServiceProvider),
  ),
);

final petitionRepositoryProvider = Provider.autoDispose<PetitionRepositoryImpl>(
  (ref) => PetitionRepositoryImpl(
    petitionRemoteDataSource: ref.watch(petitionRemoteDataSourceProvider),
  ),
);

final getNoticeBoardUseCaseProvider =
    Provider.autoDispose<GetNoticeBoardUseCase>(
  (ref) => GetNoticeBoardUseCase(
    petitionRepository: ref.watch(petitionRepositoryProvider),
  ),
);

final getNoticePostUseCaseProvider = Provider.autoDispose<GetNoticePostUseCase>(
  (ref) => GetNoticePostUseCase(
    petitionRepository: ref.watch(petitionRepositoryProvider),
  ),
);

final getCoalitionBoardUseCaseProvider =
    Provider.autoDispose<GetCoalitionBoardUseCase>(
  (ref) => GetCoalitionBoardUseCase(
    petitionRepository: ref.watch(petitionRepositoryProvider),
  ),
);

final getCoalitionPostUseCaseProvider =
    Provider.autoDispose<GetCoalitionPostUseCase>(
  (ref) => GetCoalitionPostUseCase(
    petitionRepository: ref.watch(petitionRepositoryProvider),
  ),
);

final getPetitionBoardUseCaseProvider =
    Provider.autoDispose<GetPetitionBoardUseCase>(
  (ref) => GetPetitionBoardUseCase(
    petitionRepository: ref.watch(petitionRepositoryProvider),
  ),
);

final getPetitionPostUseCaseProvider =
    Provider.autoDispose<GetPetitionPostUseCase>(
  (ref) => GetPetitionPostUseCase(
    petitionRepository: ref.watch(petitionRepositoryProvider),
  ),
);

final agreePetitionPostUseCaseProvider =
    Provider.autoDispose<AgreePetitionPostUseCase>(
  (ref) => AgreePetitionPostUseCase(
    petitionRepository: ref.watch(petitionRepositoryProvider),
  ),
);

final searchPostUseCaseProvider = Provider.autoDispose<SearchPostUseCase>(
  (ref) => SearchPostUseCase(
    petitionRepository: ref.watch(petitionRepositoryProvider),
  ),
);

final writePetitionPostUseCaseProvider =
    Provider.autoDispose<WritePetitionPostUseCase>(
  (ref) => WritePetitionPostUseCase(
    petitionRepository: ref.watch(petitionRepositoryProvider),
  ),
);

final reportPostUseCaseProvider = Provider.autoDispose<ReportPostUseCase>(
  (ref) => ReportPostUseCase(
    petitionRepository: ref.watch(petitionRepositoryProvider),
  ),
);

final coalitionBoardProvider =
    NotifierProvider.autoDispose<CoalitionBoardNotifier, BoardState>(
  () => CoalitionBoardNotifier(),
);

final coalitionBoardCategoryProvider =
    NotifierProvider.autoDispose<CoalitionBoardCategoryNotifier, CoalitionType>(
  () => CoalitionBoardCategoryNotifier(),
);

final coalitionBoardSortProvider =
    NotifierProvider.autoDispose<CoalitionBoardSortNotifier, PostSort>(
  () => CoalitionBoardSortNotifier(),
);

final coalitionPostProvider =
    NotifierProvider.autoDispose.family<CoalitionPostNotifier, PostState, int>(
  () => CoalitionPostNotifier(),
);

final noticeBoardProvider =
    NotifierProvider.autoDispose<NoticeBoardNotifier, BoardState>(
  () => NoticeBoardNotifier(),
);

final noticeBoardSortProvider =
    NotifierProvider.autoDispose<NoticeBoardSortNotifier, PostSort>(
  () => NoticeBoardSortNotifier(),
);

final noticePostProvider =
    NotifierProvider.autoDispose.family<NoticePostNotifier, PostState, int>(
  () => NoticePostNotifier(),
);

final petitionBoardProvider =
    NotifierProvider.autoDispose<PetitionBoardNotifier, BoardState>(
  () => PetitionBoardNotifier(),
);

final petitionBoardCategoryProvider =
    NotifierProvider.autoDispose<PetitionBoardCategoryNotifier, PetitionStatus>(
  () => PetitionBoardCategoryNotifier(),
);

final petitionBoardSortProvider =
    NotifierProvider.autoDispose<PetitionBoardSortNotifier, PostSort>(
  () => PetitionBoardSortNotifier(),
);

final petitionPostProvider =
    NotifierProvider.autoDispose.family<PetitionPostNotifier, PostState, int>(
  () => PetitionPostNotifier(),
);

final searchPostProvider =
    NotifierProvider.autoDispose<SearchPostNotifier, SearchState>(
  () => SearchPostNotifier(),
);
