part of '../../post_controller.dart';

final coalitionPostControllerProvider = AsyncNotifierProvider.autoDispose
    .family<CoalitionPostController, CoalitionPost, int>(
  () => CoalitionPostController(),
);

class CoalitionPostController extends PostController<CoalitionPost> {

  @override
  Future<CoalitionPost> _fetch({
    CancelToken? cancelToken,
    required int id,
  }) async {
    final result = await ref.read(coalitionUseCasesProvider).getPost(
          cancelToken: cancelToken,
          id: id,
        );
    return result;
  }
}
