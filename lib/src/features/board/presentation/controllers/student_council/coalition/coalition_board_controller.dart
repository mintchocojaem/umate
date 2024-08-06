part of '../../board_controller.dart';

final coalitionBoardControllerProvider = AsyncNotifierProvider.autoDispose<
    CoalitionBoardController, Board<CoalitionPost>>(
  () => CoalitionBoardController(),
);

class CoalitionBoardController extends BoardController<CoalitionPost> {

  // TODO: implement getBoard
  @override
  Future<Board<CoalitionPost>> _fetch({
    CancelToken? cancelToken,
    required int page,
  }) {
    return ref.read(coalitionUseCasesProvider).getBoard(
          cancelToken: cancelToken,
          page: page,
          type: ref.read(coalitionCategoryControllerProvider),
        );
  }
}
