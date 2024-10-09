part of '../../board_controller.dart';

final dantudyBoardControllerProvider = AsyncNotifierProvider.autoDispose<
    DantudyBoardController, Board<DantudyPost>>(
  () => DantudyBoardController(),
);

class DantudyBoardController extends BoardController<DantudyPost> {
  @override
  Future<Board<DantudyPost>> _fetch({
    CancelToken? cancelToken,
    required int page,
  }) {
    // TODO: implement _getBoard
    final result = ref.read(dantudyUseCasesProvider).getBoard(
          cancelToken: cancelToken,
          page: page,
        );
    return result;
  }
}
