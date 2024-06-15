import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/board.dart';
import '../../domain/models/notice_post.dart';

final noticeRepositoryProvider = Provider.autoDispose<NoticeRepository>(
  (ref) => NoticeRepository(
    networkClientService: ref.watch(networkClientServiceProvider),
  ),
);

class NoticeRepository extends RemoteRepository {
  NoticeRepository({required super.networkClientService});

  Future<Board<NoticePost>> getNoticeBoard({
    CancelToken? cancelToken,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await networkClientService.request(
      path: '/post/notice',
      method: RequestType.get,
      queryParameters: {
        'keyword': keyword,
        'bodySize': bodySize,
        'page': page,
        'size': size,
        'sort': sort?.map((e) => e).join('&'),
      },
      cancelToken: cancelToken,
    );
    return Board.fromJson(
      result.data,
      (data) => NoticePost.fromJson(data as Map<String, dynamic>),
    );
  }
}
