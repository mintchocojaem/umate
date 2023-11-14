import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain.dart';

final petitionAgreeProvider = StateProvider.autoDispose<bool>((ref) => false);

final postProvider =
    AsyncNotifierProvider.autoDispose.family<PostNotifier, Petition, int>(
  () => PostNotifier(),
);

class PostNotifier extends AutoDisposeFamilyAsyncNotifier<Petition, int> {

  Future<void> getPetitionPost({required int id}) async {
    state = await AsyncValue.guard(
      () async => await ref.read(boardRepositoryProvider).getPetitionPost(
            id: id,
          ) as Petition,
    );
    ref.read(petitionAgreeProvider.notifier).update((value) => state.value!.agree);
  }

  Future<void> agreePetitionPost({required int id}) async {
    final result = await AsyncValue.guard(
      () async => await ref.read(boardRepositoryProvider).agreePetitionPost(
            id: id,
          ),
    );
    if(result.value!) {
      state = AsyncData(
        state.value!.copyWith(
          agreeCount: state.value!.agreeCount + 1,
          agree: true,
        ),
      );
      ref.read(petitionAgreeProvider.notifier).update((value) => true);
    }

  }

  @override
  FutureOr<Petition> build(int arg) async {
    // TODO: implement build
    await getPetitionPost(id: arg);
    return state.value!;
  }
}
