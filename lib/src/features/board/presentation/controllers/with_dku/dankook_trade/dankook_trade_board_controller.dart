part of '../../board_controller.dart';

final dankookTradeBoardControllerProvider = AsyncNotifierProvider.autoDispose<
    DankookTradeBoardController, Board<DankookTradePost>>(
  () => DankookTradeBoardController(),
);

class DankookTradeBoardController extends BoardController<DankookTradePost> {
  @override
  Future<Board<DankookTradePost>> _fetch({
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
