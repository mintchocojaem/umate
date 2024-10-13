import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/board/domain/models/board.dart';
import 'package:umate/src/features/board/domain/models/post_sort.dart';

import '../../../data/repositories/student_council/notice_remote_repository.dart';
import '../../models/student_council/notice_post.dart';
import '../board_use_cases.dart';

final noticeUseCasesProvider = Provider.autoDispose<NoticeUseCases>(
  (ref) => NoticeUseCases(
    noticeRemoteRepository: ref.watch(noticeRemoteRepositoryProvider),
  ),
);

class NoticeUseCases extends BoardUseCases {
  final NoticeRemoteRepository noticeRemoteRepository;

  NoticeUseCases({
    required this.noticeRemoteRepository,
  });

  @override
  Future<Board<NoticePost>> getBoard({
    CancelToken? cancelToken,
    required int page,
    List<PostSort>? sort,
  }) {
    // TODO: implement getBoard
    return noticeRemoteRepository.getBoard(
      cancelToken: cancelToken,
      page: page,
      size: defaultSize,
      bodySize: defaultBodySize,
      sort: (sort ?? defaultSort).map((e) => e.toString()).toList(),
    );
  }

  @override
  Future<NoticePost> getPost({
    CancelToken? cancelToken,
    required int id,
  }) {
    // TODO: implement getPost
    return noticeRemoteRepository.getPost(
      cancelToken: cancelToken,
      id: id,
    );
  }

  @override
  Future<bool> deletePost({
    CancelToken? cancelToken,
    required int id,
  }) {
    return noticeRemoteRepository.deletePost(
      cancelToken: cancelToken,
      id: id,
    );
  }
}
