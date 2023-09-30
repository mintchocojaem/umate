import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../board_repository.dart';
import 'post.dart';

final postProvider =
    AsyncNotifierProvider.autoDispose.family<PostNotifier, Post?, int>(
  () => PostNotifier(),
);

class PostNotifier extends AutoDisposeFamilyAsyncNotifier<Post?, int> {

  Future<void> getPetitionPost({required int id}) async {
    state = await AsyncValue.guard(
      () async => await ref.read(boardRepositoryProvider).getPetitionPost(
            id: id,
          ),
    );
  }

  @override
  FutureOr<Post?> build(int arg) async {
    // TODO: implement build
    await getPetitionPost(id: arg);
    return state.value;
  }
}
