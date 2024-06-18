import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/search_result.dart';

final searchRemoteRepositoryProvider = Provider.autoDispose(
  (ref) => SearchRemoteRepository(
    networkClientService: ref.watch(networkClientServiceProvider),
  ),
);

class SearchRemoteRepository extends RemoteRepository {
  SearchRemoteRepository({required super.networkClientService});

  Future<SearchResult> searchPost({
    CancelToken? cancelToken,
    String? keyword,
    int? page,
    int? size,
    int? bodySize,
  }) async {
    final result = await networkClientService.request(
      path: '/post/search',
      method: RequestType.get,
      queryParameters: {
        'keyword': keyword,
        'page': page,
        'size': size,
        'bodySize': bodySize,
      },
      cancelToken: cancelToken,
    );
    return SearchResult.fromJson(result.data);
  }
}
