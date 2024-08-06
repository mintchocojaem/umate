part of '../../board_controller.dart';

final bearEatsBoardControllerProvider = AsyncNotifierProvider.autoDispose<
    BearEatsBoardController, Board<BearEatsPost>>(
  () => BearEatsBoardController(),
);

class BearEatsBoardController extends BoardController<BearEatsPost> {
  @override
  Future<Board<BearEatsPost>> _fetch({
    CancelToken? cancelToken,
    required int page,
  }) {
    // TODO: implement _getBoard
    final result = ref.read(bearEatsUseCasesProvider).getBoard(
          cancelToken: cancelToken,
          page: page,
        );
    return result;
  }
}
