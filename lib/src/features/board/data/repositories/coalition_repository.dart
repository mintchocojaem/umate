import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/board.dart';
import '../../domain/models/coalition_post.dart';

final coalitionRepositoryProvider = Provider.autoDispose<CoalitionRepository>(
  (ref) => CoalitionRepository(
    networkClientService: ref.watch(networkClientServiceProvider),
  ),
);

class CoalitionRepository extends RemoteRepository {
  CoalitionRepository({required super.networkClientService});

  Future<Board<CoalitionPost>> getCoalitionBoard({
    CancelToken? cancelToken,
    String? coalitionType,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await networkClientService.request(
      path: '/post/coalition',
      method: RequestType.get,
      queryParameters: {
        'coalitionType': coalitionType,
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
      (data) => CoalitionPost.fromJson(data as Map<String, dynamic>),
    );
  }
}