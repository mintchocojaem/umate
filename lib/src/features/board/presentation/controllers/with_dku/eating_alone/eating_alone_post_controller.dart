part of '../../post_controller.dart';

final eatingAlonePostControllerProvider = AsyncNotifierProvider.autoDispose
    .family<EatingAlonePostController, EatingAlonePost, int>(
  () => EatingAlonePostController(),
);

class EatingAlonePostController extends PostController<EatingAlonePost> {
  @override
  Future<EatingAlonePost> _fetch({
    CancelToken? cancelToken,
    required int id,
  }) {
    return ref.read(eatingAloneUseCasesProvider).getPost(
          cancelToken: cancelToken,
          id: id,
        );
  }

  Future<bool> deletePost() async {
    final result = await AsyncValue.guard(
        () async => ref.read(eatingAloneUseCasesProvider).deletePost(id: arg));

    result.whenOrNull(
      data: (data) {
        ref.invalidate(userEatingAloneAppliedBoardControllerProvider);
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
        () async => ref.read(eatingAloneUseCasesProvider).enterPost(id: arg));

    result.whenOrNull(
      data: (data) {
        ref.invalidateSelf();
        ref.invalidate(userEatingAloneAppliedBoardControllerProvider);
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
        () async => ref.read(eatingAloneUseCasesProvider).closePost(id: arg));

    result.whenOrNull(
      data: (data) {
        ref.invalidate(userEatingAloneAppliedBoardControllerProvider);
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
