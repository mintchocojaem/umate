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

  Future<bool> deletePost() async {
    final result = await AsyncValue.guard(
      () => ref.read(noticeUseCasesProvider).deletePost(
            id: arg,
          ),
    );

    result.whenOrNull(
      data: (data) {
        ref.read(noticeBoardControllerProvider.notifier).refresh();
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(
          error,
          stackTrace,
        );
      },
    );

    return result.hasValue;
  }
}
