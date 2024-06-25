import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/coalition_post.dart';
import '../../domain/use_cases/get_coalition_post.dart';

final coalitionPostViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<NoticePostViewModel, CoalitionPost, int>(
  () => NoticePostViewModel(),
);

class NoticePostViewModel
    extends AutoDisposeFamilyAsyncNotifier<CoalitionPost, int> {
  @override
  FutureOr<CoalitionPost> build(int arg) {
    // TODO: implement build
    return _fetch();
  }

  Future<CoalitionPost> _fetch() async {
    return await ref.read(
      getCoalitionPostProvider(
        GetCoalitionPostParams(id: arg),
      ),
    );
  }
}
