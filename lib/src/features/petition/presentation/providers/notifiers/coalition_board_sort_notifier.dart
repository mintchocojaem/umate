import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/post_sort.dart';

class CoalitionBoardSortNotifier extends AutoDisposeNotifier<PostSort> {
  @override
  PostSort build() {
    return PostSort(
      type: PostSortType.createdAt,
      order: PostSortOrder.desc,
    );
  }

  void changeSort(PostSort sort) {
    state = sort;
  }
}
