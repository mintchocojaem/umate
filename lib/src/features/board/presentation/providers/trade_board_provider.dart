import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/board.dart';
import '../../domain/models/trade_post.dart';
import '../../domain/use_cases/get_trade_board.dart';

final tradeBoardProvider =
    AsyncNotifierProvider.autoDispose<TradeBoardNotifier, Board<TradePost>>(
  () => TradeBoardNotifier(),
);

class TradeBoardNotifier extends AutoDisposeAsyncNotifier<Board<TradePost>> {
  CancelToken? _cancelToken;

  @override
  FutureOr<Board<TradePost>> build() {
    // TODO: implement build
    return _fetch();
  }

  Future<void> fetch() async {
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<Board<TradePost>> _fetch() async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = ref.read(
      getTradeBoardProvider(
        GetTradeBoardParams(
          cancelToken: _cancelToken,
        ),
      ),
    );

    return result;
  }
}
