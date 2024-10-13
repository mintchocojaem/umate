part of '../../post_controller.dart';

final dantudyPostControllerProvider = AsyncNotifierProvider.autoDispose
    .family<DantudyPostController, DantudyPost, int>(
  () => DantudyPostController(),
);

class DantudyPostController extends PostController<DantudyPost> {
  @override
  Future<DantudyPost> _fetch({
    CancelToken? cancelToken,
    required int id,
  }) {
    return ref.read(dantudyUseCasesProvider).getPost(
          cancelToken: cancelToken,
          id: id,
        );
  }

  Future<bool> deletePost() async {
    final result = await AsyncValue.guard(
        () async => ref.read(dantudyUseCasesProvider).deletePost(id: arg));

    result.whenOrNull(
      data: (data) {
        ref.invalidate(dantudyBoardControllerProvider);
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
        () async => ref.read(dantudyUseCasesProvider).enterPost(id: arg));

    result.whenOrNull(
      data: (data) {
        ref.invalidateSelf();
        ref.invalidate(dantudyBoardControllerProvider);
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
        () async => ref.read(dantudyUseCasesProvider).closePost(id: arg));

    result.whenOrNull(
      data: (data) {
        ref.invalidate(dantudyBoardControllerProvider);
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
