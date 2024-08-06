import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/board/domain/models/post.dart';

import '../../../data/repositories/with_dku/study_remote_repository.dart';
import '../../models/board.dart';
import '../../models/post_sort.dart';
import '../../models/with_dku/study_post.dart';
import '../board_use_cases.dart';

final dantudyUseCasesProvider = Provider.autoDispose<DantudyUseCases>(
  (ref) => DantudyUseCases(
    studyRemoteRepository: ref.watch(studyRemoteRepositoryProvider),
  ),
);

class DantudyUseCases extends BoardUseCases {
  final StudyRemoteRepository studyRemoteRepository;

  DantudyUseCases({
    required this.studyRemoteRepository,
  });

  @override
  Future<Board<StudyPost>> getBoard({
    CancelToken? cancelToken,
    required int page,
    List<PostSort>? sort,
  }) {
    // TODO: implement getBoard
    return studyRemoteRepository.getBoard(
      cancelToken: cancelToken,
      page: page,
      size: defaultSize,
      bodySize: defaultBodySize,
      sort: (sort ?? defaultSort).map((e) => e.toString()).toList(),
    );
  }

  @override
  Future<Post> getPost({CancelToken? cancelToken, required int id}) {
    // TODO: implement getPost
    throw UnimplementedError();
  }
}
