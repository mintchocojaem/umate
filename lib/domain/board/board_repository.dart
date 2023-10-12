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
  }) async {
    return await fetch(
      () async {
        final result = await dio.get(
          '/post/petition?bodySize=$bodySize&size=$size&page=$page&keyword=$keyword&sort=createdAt,desc',
        );
        return Board.fromJson(result.data);
      },
    );
  }

  Future<Petition?> getPetitionPost({
    required int id,
  }) async {
    return await fetch(
      () async {
        final result = await dio.get(
          '/post/petition/$id',
        );
        return Petition.fromJson(result.data);
      },
    );
  }
}
