import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/dio_provider.dart';
import '../domain.dart';

final boardRepositoryProvider =
    Provider<BoardRepository>((ref) => BoardRepository(ref.read(dioProvider)));

final class BoardRepository extends Repository {
  BoardRepository(super.dio);

  Future<Board?> getPetitionBoard({
    String? keyword,
    required int page,
    int? bodySize,
    required int size,
    required PetitionStatus status,
    CancelToken? cancelToken,
  }) async {
    return await fetch(
      () async {
        final result = await dio.get(
          '/post/petition?bodySize=$bodySize&size=$size&page=$page&keyword=$keyword&sort=createdAt,desc&status=${status.value}',
          cancelToken: cancelToken,
        );
        return Board.fromJson(result.data);
      },
    );
  }

  Future<Petition?> getPetitionPost({
    required int id,
    CancelToken? cancelToken,
  }) async {
    return await fetch(
      () async {
        final result = await dio.get(
          '/post/petition/$id',
          cancelToken: cancelToken,
        );
        return Petition.fromJson(result.data);
      },
    );
  }
}
