import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/eating_alone_remote_repository.dart';
import '../../data/repositories/study_remote_repository.dart';
import '../models/board.dart';
import '../models/eating_alone_post.dart';
import '../models/study_post.dart';

final getStudyBoardProvider =
    Provider.autoDispose.family<Future<Board<StudyPost>>, GetStudyBoardParams>(
  (ref, params) => GetStudyBoard(
    studyRemoteRepository: ref.watch(studyRemoteRepositoryProvider),
  )(params),
);

class GetStudyBoardParams extends UseCaseParams {
  final CancelToken? cancelToken;
  final int? page;

  const GetStudyBoardParams({
    this.cancelToken,
    this.page,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [cancelToken, page];
}

class GetStudyBoard extends UseCase<Board<StudyPost>, GetStudyBoardParams> {
  final StudyRemoteRepository studyRemoteRepository;

  GetStudyBoard({required this.studyRemoteRepository});

  @override
  Future<Board<StudyPost>> call(GetStudyBoardParams params) {
    // TODO: implement call
    return studyRemoteRepository.getStudyBoard(
      cancelToken: params.cancelToken,
      page: params.page,
      size: 10,
      bodySize: 200,
    );
  }
}
