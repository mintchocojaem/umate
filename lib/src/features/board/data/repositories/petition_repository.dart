import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/board.dart';
import '../../domain/models/petition_post.dart';

final petitionRepositoryProvider = Provider.autoDispose<PetitionRepository>(
  (ref) => PetitionRepository(
    networkClientService: ref.watch(networkClientServiceProvider),
  ),
);

class PetitionRepository extends RemoteRepository {
  PetitionRepository({required super.networkClientService});

  Future<Board<PetitionPost>> getPetitionBoard({
    CancelToken? cancelToken,
    required String status,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await networkClientService.request(
      path: '/post/petition',
      method: RequestType.get,
      queryParameters: {
        'keyword': keyword,
        'status': status,
        'bodySize': bodySize,
        'page': page,
        'size': size,
        'sort': sort?.map((e) => e).join('&'),
      },
      cancelToken: cancelToken,
    );
    return Board.fromJson(
      result.data,
      (data) => PetitionPost.fromJson(data as Map<String, dynamic>),
    );
  }
}
