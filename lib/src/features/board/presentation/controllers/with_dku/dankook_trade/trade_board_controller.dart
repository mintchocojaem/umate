part of '../../board_controller.dart';

final tradeBoardControllerProvider =
    AsyncNotifierProvider.autoDispose<TradeBoardController, Board<TradePost>>(
  () => TradeBoardController(),
);

class TradeBoardController extends BoardController<TradePost> {
  @override
  Future<Board<TradePost>> _fetch({
    CancelToken? cancelToken,
    required int page,
  }) {
    // TODO: implement _getBoard
    final result = ref.read(dankookTradeUseCasesProvider).getBoard(
          cancelToken: cancelToken,
          page: page,
        );
    return result;
  }
}
