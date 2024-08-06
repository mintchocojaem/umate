import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../../../core/utils/repository.dart';
import '../../../domain/models/board.dart';
import '../../../domain/models/with_dku/study_post.dart';

final studyRemoteRepositoryProvider = Provider.autoDispose(
  (ref) => StudyRemoteRepository(
    client: ref.watch(networkClientServiceProvider),
  ),
);

class StudyRemoteRepository extends RemoteRepository {
  StudyRemoteRepository({required super.client});

  Future<Board<StudyPost>> getBoard({
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
      (data) => StudyPost.fromJson(data as Map<String, dynamic>),
    );
  }
}
