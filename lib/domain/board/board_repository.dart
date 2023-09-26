import 'package:danvery/domain/board/board.dart';
import 'package:danvery/domain/repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/dio_provider.dart';

final boardRepositoryProvider =
    Provider<BoardRepository>((ref) => BoardRepository(ref.read(dioProvider)));

final class BoardRepository extends Repository {
  BoardRepository(super.dio);

  Future<Board> getPetitionBoard({
    String? keyword,
    required int page,
    int? bodySize,
    required int size,
  }) async {

    return await fetch(() async {
      final result = await dio.get(
        '${dio.options.baseUrl}/post/petition?bodySize=$bodySize&size=$size&page=$page&keyword=$keyword',
      );
      return Board.fromJson(result.data);
    });
  }
}
