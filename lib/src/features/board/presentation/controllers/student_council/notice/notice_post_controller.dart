part of '../../post_controller.dart';

final noticePostControllerProvider = AsyncNotifierProvider.autoDispose
    .family<NoticePostController, NoticePost, int>(
  () => NoticePostController(),
);

class NoticePostController extends PostController<NoticePost> {
  @override
  Future<NoticePost> _fetch({
    CancelToken? cancelToken,
    required int id,
  }) {
    return ref.read(noticeUseCasesProvider).getPost(
          cancelToken: cancelToken,
          id: id,
        );
  }
}
