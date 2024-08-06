import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/board/domain/models/post.dart';

import '../../../data/repositories/with_dku/trade_remote_repository.dart';
import '../../models/board.dart';
import '../../models/post_sort.dart';
import '../../models/with_dku/trade_post.dart';
import '../board_use_cases.dart';

final dankookTradeUseCasesProvider = Provider.autoDispose<DankookTradeUseCases>(
  (ref) => DankookTradeUseCases(
    tradeRemoteRepository: ref.watch(tradeRemoteRepositoryProvider),
  ),
);

class DankookTradeUseCases extends BoardUseCases {
  final TradeRemoteRepository tradeRemoteRepository;

  DankookTradeUseCases({
    required this.tradeRemoteRepository,
  });

  @override
  Future<Board<TradePost>> getBoard({
    CancelToken? cancelToken,
    required int page,
    List<PostSort>? sort,
  }) {
    // TODO: implement getBoard
    return tradeRemoteRepository.getBoard(
      cancelToken: cancelToken,
      page: page,
      size: defaultSize,
      bodySize: defaultBodySize,
      sort: (sort ?? defaultSort).map((e) => e.toString()).toList(),
    );
  }

  @override
  Future<Post> getPost({CancelToken? cancelToken, required int id}) {
    // TODO: implement getPost
    throw UnimplementedError();
  }
}
