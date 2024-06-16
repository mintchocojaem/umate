import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/notice_remote_repository.dart';
import '../models/board.dart';
import '../models/notice_post.dart';

final getNoticeBoardProvider = Provider.autoDispose
    .family<Future<Board<NoticePost>>, GetNoticeBoardParams>(
  (ref, params) => GetNoticeBoard(
    repository: ref.watch(noticeRemoteRepositoryProvider),
  )(params),
);

class GetNoticeBoardParams extends UseCaseParams {
  final CancelToken? cancelToken;
  final int? page;

  const GetNoticeBoardParams({
    this.cancelToken,
    this.page,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [cancelToken, page];
}

class GetNoticeBoard extends UseCase<Board<NoticePost>, GetNoticeBoardParams> {
  final NoticeRemoteRepository repository;

  GetNoticeBoard({required this.repository});

  @override
  Future<Board<NoticePost>> call(GetNoticeBoardParams params) {
    // TODO: implement call
    return repository.getNoticeBoard(
      cancelToken: params.cancelToken,
      page: params.page,
      size: 10,
    );
  }
}
