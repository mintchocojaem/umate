part of '../../board_controller.dart';

final userEatingAloneAppliedBoardControllerProvider = AsyncNotifierProvider
    .autoDispose<UserEatingAloneAppliedBoardController, Board<EatingAlonePost>>(
  () => UserEatingAloneAppliedBoardController(),
);

class UserEatingAloneAppliedBoardController
    extends BoardController<EatingAlonePost> {
  @override
  Future<Board<EatingAlonePost>> _fetch({
    CancelToken? cancelToken,
    required int page,
  }) {
    // TODO: implement _getBoard
    final result = ref.read(eatingAloneUseCasesProvider).getUserAppliedBoard(
          cancelToken: cancelToken,
          page: page,
        );
    return result;
  }
}
