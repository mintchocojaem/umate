part of '../../board_controller.dart';

final petitionBoardControllerProvider = AsyncNotifierProvider.autoDispose<
    PetitionBoardController, Board<PetitionPost>>(
  () => PetitionBoardController(),
);

class PetitionBoardController extends BoardController<PetitionPost> {

  @override
  Future<Board<PetitionPost>> _fetch({
    CancelToken? cancelToken,
    required int page,
  }) {
    // TODO: implement _getBoard
    return ref.read(petitionUseCasesProvider).getBoard(
          cancelToken: cancelToken,
          page: page,
          status: ref.read(petitionCategoryControllerProvider),
        );
  }
}
