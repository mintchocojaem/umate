import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/board.dart';
import '../../domain/models/trade_post.dart';
import '../../domain/use_cases/get_trade_board.dart';
import 'board_view_model.dart';

final tradeBoardViewModelProvider =
    AsyncNotifierProvider.autoDispose<TradeBoardViewModel, Board<TradePost>>(
  () => TradeBoardViewModel(),
);

class TradeBoardViewModel extends BoardViewModel<TradePost> {
  @override
  Future<Board<TradePost>> getBoard({
    CancelToken? cancelToken,
    int? page,
  }) {
    // TODO: implement _getBoard
    final result = ref.read(
      getTradeBoardProvider(
        GetTradeBoardParams(
          cancelToken: cancelToken,
          page: page,
        ),
      ),
    );
    return result;
  }
}
