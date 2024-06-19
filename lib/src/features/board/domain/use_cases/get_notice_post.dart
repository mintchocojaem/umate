import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/notice_remote_repository.dart';
import '../models/notice_post.dart';

final getNoticePostProvider =
    Provider.autoDispose.family<Future<NoticePost>, GetNoticePostParams>(
  (ref, params) => GetNoticePost(
    noticeRemoteRepository: ref.watch(noticeRemoteRepositoryProvider),
  )(params),
);

class GetNoticePostParams extends UseCaseParams {
  final CancelToken? cancelToken;
  final int id;

  const GetNoticePostParams({
    this.cancelToken,
    required this.id,
  });

  @override
// TODO: implement props
  List<Object?> get props => [cancelToken, id];
}

class GetNoticePost extends UseCase<NoticePost, GetNoticePostParams> {
  final NoticeRemoteRepository noticeRemoteRepository;

  GetNoticePost({
    required this.noticeRemoteRepository,
  });

  @override
  Future<NoticePost> call(GetNoticePostParams params) async {
// TODO: implement call
    return await noticeRemoteRepository.getPost(
      cancelToken: params.cancelToken,
      id: params.id,
    );
  }
}
