part of '../../board_controller.dart';

final studyBoardControllerProvider =
    AsyncNotifierProvider.autoDispose<StudyBoardController, Board<StudyPost>>(
  () => StudyBoardController(),
);

class StudyBoardController extends BoardController<StudyPost> {
  @override
  Future<Board<StudyPost>> _fetch({
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
