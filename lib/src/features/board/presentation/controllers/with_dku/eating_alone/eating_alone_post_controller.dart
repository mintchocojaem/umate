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
    final result = ref.read(eatingAloneUseCasesProvider).getPost(
          cancelToken: cancelToken,
          id: id,
        );
    return result;
  }
}
