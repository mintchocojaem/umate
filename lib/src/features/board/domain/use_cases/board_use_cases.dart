import 'package:dio/dio.dart';

import '../models/board.dart';
import '../models/post.dart';
import '../models/post_sort.dart';

abstract class BoardUseCases<P extends Post> {
  int get defaultSize => 10;
  int get defaultBodySize => 200;
  List<PostSort> get defaultSort => const [
        PostSort(
          type: PostSortType.createdAt,
          order: PostSortOrder.desc,
        ),
      ];

  Future<Board<P>> getBoard({
    CancelToken? cancelToken,
    required int page,
    List<PostSort>? sort,
  });

  Future<P> getPost({
    CancelToken? cancelToken,
    required int id,
  });

}
