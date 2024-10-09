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
}
