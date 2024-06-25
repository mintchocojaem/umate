import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/eating_alone_post.dart';
import '../../domain/use_cases/get_eating_alone_post.dart';

final eatingAlonePostViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<EatingAlonePostViewModel, EatingAlonePost, int>(
  () => EatingAlonePostViewModel(),
);

class EatingAlonePostViewModel
    extends AutoDisposeFamilyAsyncNotifier<EatingAlonePost, int> {
  @override
  FutureOr<EatingAlonePost> build(int arg) {
    // TODO: implement build
    return _fetch();
  }

  Future<EatingAlonePost> _fetch() async {
    return await ref.read(
      getEatingAlonePostProvider(
        GetEatingAlonePostParams(id: arg),
      ),
    );
  }
}
