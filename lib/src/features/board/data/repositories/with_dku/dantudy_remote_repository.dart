import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../../../core/utils/repository.dart';
import '../../../domain/models/board.dart';
import '../../../domain/models/with_dku/dantudy_post.dart';

final dantudyRemoteRepositoryProvider = Provider.autoDispose(
  (ref) => DantudyRemoteRepository(
    client: ref.watch(networkClientServiceProvider),
  ),
);

class DantudyRemoteRepository extends RemoteRepository {
  DantudyRemoteRepository({required super.client});

  Future<Board<DantudyPost>> getBoard({
    CancelToken? cancelToken,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await client.request(
      path: '/with-dankook/study',
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
      (data) => DantudyPost.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<DantudyPost> getPost({
    CancelToken? cancelToken,
    int? id,
  }) async {
    final result = await client.request(
      path: '/with-dankook/study/$id',
      method: RequestType.get,
      cancelToken: cancelToken,
    );

    return DantudyPost.fromJson(result.data);
  }

  Future<bool> addPost({
    CancelToken? cancelToken,
    required String title,
    required String body,
    required int minStudentId,
    required String tag,
    required String startTime,
    required String endTime,
  }) async {
    final result = await client.request(
      path: '/with-dankook/study',
      method: RequestType.post,
      data: {
        'title': title,
        'content': body,
        'minStudentId': minStudentId,
        'tag': tag,
        'startTime': startTime,
        'endTime': endTime,
      },
      cancelToken: cancelToken,
    );
    return result.statusCode == 200;
  }
}
