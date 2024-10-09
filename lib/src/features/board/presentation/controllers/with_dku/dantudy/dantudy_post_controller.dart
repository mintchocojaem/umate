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
}
