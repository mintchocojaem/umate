part of '../../board_controller.dart';

final eatingAloneBoardControllerProvider = AsyncNotifierProvider.autoDispose<
    EatingAloneBoardController, Board<EatingAlonePost>>(
  () => EatingAloneBoardController(),
);

class EatingAloneBoardController extends BoardController<EatingAlonePost> {

  @override
  Future<Board<EatingAlonePost>> _fetch({
    CancelToken? cancelToken,
    required int page,
  }) {
    // TODO: implement _getBoard
    final result = ref.read(eatingAloneUseCasesProvider).getBoard(
          cancelToken: cancelToken,
          page: page,
        );
    return result;
  }
}
