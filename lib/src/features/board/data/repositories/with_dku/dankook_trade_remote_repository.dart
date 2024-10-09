import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../../../core/utils/repository.dart';
import '../../../domain/models/board.dart';
import '../../../domain/models/with_dku/dankook_trade_post.dart';

final dankookTradeRemoteRepositoryProvider = Provider.autoDispose(
  (ref) => DankookTradeRemoteRepository(
    client: ref.watch(networkClientServiceProvider),
  ),
);

class DankookTradeRemoteRepository extends RemoteRepository {
  DankookTradeRemoteRepository({required super.client});

  Future<Board<DankookTradePost>> getBoard({
    CancelToken? cancelToken,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await client.request(
      path: '/with-dankook/trade',
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
      (data) => DankookTradePost.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<DankookTradePost> getPost({
    CancelToken? cancelToken,
    int? id,
  }) async {
    final result = await client.request(
      path: '/with-dankook/trade/$id',
      method: RequestType.get,
      cancelToken: cancelToken,
    );

    return DankookTradePost.fromJson(result.data);
  }
}
