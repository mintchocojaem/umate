import 'package:dio/dio.dart';

import '../../../../core/utils/use_case.dart';
import '../models/board.dart';
import '../models/notice_post.dart';
import '../models/post_sort.dart';
import '../repositories/petition_repository.dart';

class GetNoticeBoardParams {
  final CancelToken? cancelToken;
  final String? keyword;
  final int? page;
  final List<PostSort>? sort;

  GetNoticeBoardParams({
    this.cancelToken,
    this.keyword,
    this.page,
    this.sort,
  });
}

class GetNoticeBoardUseCase
    extends UseCase<Board<NoticePost>, GetNoticeBoardParams> {
  final PetitionRepository petitionRepository;

  GetNoticeBoardUseCase({
    required this.petitionRepository,
  });

  @override
  Future<Board<NoticePost>> execute(GetNoticeBoardParams params) async {
    return await petitionRepository.getNoticeBoard(
      cancelToken: params.cancelToken,
      page: params.page,
      bodySize: 100,
      size: 10,
      sort: params.sort,
    );
  }
}
