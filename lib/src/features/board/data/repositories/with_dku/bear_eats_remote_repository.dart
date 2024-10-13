import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../../../core/utils/repository.dart';
import '../../../domain/models/board.dart';
import '../../../domain/models/with_dku/bear_eats_post.dart';

final bearEatsRemoteRepositoryProvider = Provider.autoDispose(
  (ref) => BearEatsRemoteRepository(
    client: ref.watch(networkClientServiceProvider),
  ),
);

class BearEatsRemoteRepository extends RemoteRepository {
  BearEatsRemoteRepository({required super.client});

  Future<Board<BearEatsPost>> getBoard({
    CancelToken? cancelToken,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await client.request(
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

  Future<BearEatsPost> getPost({
    CancelToken? cancelToken,
    int? id,
  }) async {
    final result = await client.request(
      path: '/with-dankook/bear-eats/$id',
      method: RequestType.get,
      cancelToken: cancelToken,
    );
    return BearEatsPost.fromJson(result.data);
  }

  Future<bool> deletePost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    final result = await client.request(
      path: '/with-dankook/bear-eats/$id',
      method: RequestType.delete,
      cancelToken: cancelToken,
    );
    return result.statusCode == 200;
  }

  Future<bool> addPost({
    CancelToken? cancelToken,
    required String title,
    required String restaurant,
    required String deliveryPlace,
    required String deliveryTime,
    required String body,
  }) async {
    final result = await client.request(
      path: '/with-dankook/bear-eats',
      method: RequestType.post,
      data: {
        'title': title,
        'restaurant': restaurant,
        'deliveryPlace': deliveryPlace,
        'deliveryTime': deliveryTime,
        'body': body,
      },
      cancelToken: cancelToken,
    );
    return result.statusCode == 200;
  }

  Future<bool> enterPost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    final result = await client.request(
      path: '/with-dankook/bear-eats/$id/enter',
      method: RequestType.post,
      cancelToken: cancelToken,
    );
    return result.statusCode == 200;
  }

  Future<bool> closePost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    final result = await client.request(
      path: '/with-dankook/bear-eats/$id/',
      method: RequestType.patch,
      cancelToken: cancelToken,
    );
    return result.statusCode == 200;
  }
}
