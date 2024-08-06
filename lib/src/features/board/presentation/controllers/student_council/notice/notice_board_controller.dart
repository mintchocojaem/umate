part of '../../board_controller.dart';

final noticeBoardControllerProvider =
    AsyncNotifierProvider.autoDispose<NoticeBoardController, Board<NoticePost>>(
  () => NoticeBoardController(),
);

class NoticeBoardController extends BoardController<NoticePost> {

  @override
  Future<Board<NoticePost>> _fetch({
    CancelToken? cancelToken,
    required int page,
  }) {
    // TODO: implement _getBoard
    return ref.read(noticeUseCasesProvider).getBoard(
          cancelToken: cancelToken,
          page: page,
        );
  }
}
