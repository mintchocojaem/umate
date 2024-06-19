import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/trade_remote_repository.dart';
import '../models/board.dart';
import '../models/trade_post.dart';

final getTradeBoardProvider =
    Provider.autoDispose.family<Future<Board<TradePost>>, GetTradeBoardParams>(
  (ref, params) => GetTradeBoard(
    tradeRemoteRepository: ref.watch(tradeRemoteRepositoryProvider),
  )(params),
);

class GetTradeBoardParams extends UseCaseParams {
  final CancelToken? cancelToken;
  final int? page;

  const GetTradeBoardParams({
    this.cancelToken,
    this.page,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [cancelToken, page];
}

class GetTradeBoard extends UseCase<Board<TradePost>, GetTradeBoardParams> {
  final TradeRemoteRepository tradeRemoteRepository;

  GetTradeBoard({required this.tradeRemoteRepository});

  @override
  Future<Board<TradePost>> call(GetTradeBoardParams params) {
    // TODO: implement call
    return tradeRemoteRepository.getBoard(
      cancelToken: params.cancelToken,
      page: params.page,
      size: 10,
      bodySize: 200,
    );
  }
}
