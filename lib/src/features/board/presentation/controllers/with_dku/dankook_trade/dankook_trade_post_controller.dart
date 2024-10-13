part of '../../post_controller.dart';

final dankookTradePostControllerProvider = AsyncNotifierProvider.autoDispose
    .family<DankookTradePostController, DankookTradePost, int>(
  () => DankookTradePostController(),
);

class DankookTradePostController extends PostController<DankookTradePost> {
  @override
  Future<DankookTradePost> _fetch({
    CancelToken? cancelToken,
    required int id,
  }) {
    return ref.read(dankookTradeUseCasesProvider).getPost(
          cancelToken: cancelToken,
          id: id,
        );
  }

  Future<bool> deletePost() async {
    final result = await AsyncValue.guard(
        () async => ref.read(dankookTradeUseCasesProvider).deletePost(id: arg));

    result.whenOrNull(
      data: (data) {
        ref.invalidate(dankookTradeBoardControllerProvider);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
    );

    if (result.hasError) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> closePost() async {
    final result = await AsyncValue.guard(
        () async => ref.read(dankookTradeUseCasesProvider).closePost(id: arg));

    result.whenOrNull(
      data: (data) {
        ref.invalidate(dankookTradeBoardControllerProvider);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
    );

    if (result.hasError) {
      return false;
    } else {
      return true;
    }
  }
}
