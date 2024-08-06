import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../../../core/utils/repository.dart';
import '../../../domain/models/board.dart';
import '../../../domain/models/student_council/notice_post.dart';

final noticeRemoteRepositoryProvider =
    Provider.autoDispose<NoticeRemoteRepository>(
  (ref) => NoticeRemoteRepository(
    client: ref.watch(networkClientServiceProvider),
  ),
);

class NoticeRemoteRepository extends RemoteRepository {
  NoticeRemoteRepository({required super.client});

  Future<Board<NoticePost>> getBoard({
    CancelToken? cancelToken,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await client.request(
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

  Future<NoticePost> getPost({
    CancelToken? cancelToken,
    int? id,
  }) async {
    final result = await client.request(
      path: '/post/notice/$id',
      method: RequestType.get,
      cancelToken: cancelToken,
    );
    return NoticePost.fromJson(result.data);
  }
}
