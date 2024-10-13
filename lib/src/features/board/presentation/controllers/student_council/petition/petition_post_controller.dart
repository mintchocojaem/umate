part of '../../post_controller.dart';

final petitionPostControllerProvider = AsyncNotifierProvider.autoDispose
    .family<PetitionPostController, PetitionPost, int>(
  () => PetitionPostController(),
);

class PetitionPostController extends PostController<PetitionPost> {
  @override
  Future<PetitionPost> _fetch({
    CancelToken? cancelToken,
    required int id,
  }) {
    return ref.read(petitionUseCasesProvider).getPost(
          cancelToken: cancelToken,
          id: id,
        );
  }

  Future<bool> agreePost() async {
    final result = await AsyncValue.guard(
      () => ref.read(petitionUseCasesProvider).agreePost(
            id: arg,
          ),
    );

    result.whenOrNull(
      data: (data) {
        ref.invalidateSelf();
        ref.read(petitionBoardControllerProvider.notifier).refresh();
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

  Future<bool> deletePost() async {
    final result = await AsyncValue.guard(
      () => ref.read(petitionUseCasesProvider).deletePost(
            id: arg,
          ),
    );

    result.whenOrNull(
      data: (data) {
        ref.read(petitionBoardControllerProvider.notifier).refresh();
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
