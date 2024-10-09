import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/with_dku/dankook_trade_remote_repository.dart';
import '../../models/board.dart';
import '../../models/post_sort.dart';
import '../../models/with_dku/dankook_trade_post.dart';
import '../board_use_cases.dart';

final dankookTradeUseCasesProvider = Provider.autoDispose<DankookTradeUseCases>(
  (ref) => DankookTradeUseCases(
    dankookTradeRemoteRepository:
        ref.watch(dankookTradeRemoteRepositoryProvider),
  ),
);

class DankookTradeUseCases extends BoardUseCases {
  final DankookTradeRemoteRepository dankookTradeRemoteRepository;

  DankookTradeUseCases({
    required this.dankookTradeRemoteRepository,
  });

  @override
  Future<Board<DankookTradePost>> getBoard({
    CancelToken? cancelToken,
    required int page,
    List<PostSort>? sort,
  }) {
    // TODO: implement getBoard
    return dankookTradeRemoteRepository.getBoard(
      cancelToken: cancelToken,
      page: page,
      size: defaultSize,
      bodySize: defaultBodySize,
      sort: (sort ?? defaultSort).map((e) => e.toString()).toList(),
    );
  }

  @override
  Future<DankookTradePost> getPost(
      {CancelToken? cancelToken, required int id}) {
    // TODO: implement getPost
    return dankookTradeRemoteRepository.getPost(
      cancelToken: cancelToken,
      id: id,
    );
  }
}
