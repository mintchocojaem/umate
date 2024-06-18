import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/board.dart';
import '../../domain/models/trade_post.dart';

final tradeRemoteRepositoryProvider = Provider.autoDispose(
  (ref) => TradeRemoteRepository(
    networkClientService: ref.watch(networkClientServiceProvider),
  ),
);

class TradeRemoteRepository extends RemoteRepository {
  TradeRemoteRepository({required super.networkClientService});

  Future<Board<TradePost>> getTradeBoard({
    CancelToken? cancelToken,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await networkClientService.request(
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
      (data) => TradePost.fromJson(data as Map<String, dynamic>),
    );
  }
}
