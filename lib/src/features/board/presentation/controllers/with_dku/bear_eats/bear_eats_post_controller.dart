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
}
