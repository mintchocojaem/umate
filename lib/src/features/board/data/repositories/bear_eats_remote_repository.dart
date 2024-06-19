import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/bear_eats_post.dart';
import '../../domain/models/board.dart';

final bearEatsRemoteRepositoryProvider = Provider.autoDispose(
  (ref) => BearEatsRemoteRepository(
    networkClientService: ref.watch(networkClientServiceProvider),
  ),
);

class BearEatsRemoteRepository extends RemoteRepository {
  BearEatsRemoteRepository({required super.networkClientService});

  Future<Board<BearEatsPost>> getBoard({
    CancelToken? cancelToken,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await networkClientService.request(
      path: '/with-dankook/bear-eats',
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
      (data) => BearEatsPost.fromJson(data as Map<String, dynamic>),
    );
  }
}
