part of '../../post_controller.dart';

final bearEatsPostControllerProvider = AsyncNotifierProvider.autoDispose
    .family<BearEatsPostController, BearEatsPost, int>(
  () => BearEatsPostController(),
);

class BearEatsPostController extends PostController<BearEatsPost> {
  @override
  Future<BearEatsPost> _fetch({
    CancelToken? cancelToken,
    required int id,
  }) {
    return ref.read(bearEatsUseCasesProvider).getPost(
          cancelToken: cancelToken,
          id: id,
        );
  }

  Future<bool> deletePost() async {
    final result = await AsyncValue.guard(
        () async => ref.read(bearEatsUseCasesProvider).deletePost(id: arg));

    result.whenOrNull(
      data: (data) {
        ref.invalidate(bearEatsBoardControllerProvider);
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

  Future<bool> enterPost() async {
    final result = await AsyncValue.guard(
        () async => ref.read(bearEatsUseCasesProvider).enterPost(id: arg));

    result.whenOrNull(
      data: (data) {
        ref.invalidateSelf();
        ref.invalidate(bearEatsBoardControllerProvider);
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
        () async => ref.read(bearEatsUseCasesProvider).closePost(id: arg));

    result.whenOrNull(
      data: (data) {
        ref.invalidate(bearEatsBoardControllerProvider);
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
