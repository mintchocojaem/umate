import 'package:dio/dio.dart';

import '../../../../core/utils/use_case.dart';
import '../models/notice_post.dart';
import '../repositories/petition_repository.dart';

class GetNoticePosParams {
  final CancelToken? cancelToken;
  final int id;

  GetNoticePosParams({
    this.cancelToken,
    required this.id,
  });
}

class GetNoticePostUseCase
    extends UseCase<NoticePost, GetNoticePosParams> {
  final PetitionRepository petitionRepository;

  GetNoticePostUseCase({
    required this.petitionRepository,
  });

  @override
  Future<NoticePost> execute(GetNoticePosParams params) async {
    return await petitionRepository.getNoticePost(
      cancelToken: params.cancelToken,
      id: params.id,
    );
  }
}
