import 'dart:async';

import 'package:danvery/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/orb/components/components.dart';
import '../../domain.dart';

final postReportProvider = StateProvider.autoDispose<PostReportType?>((ref) => null);

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
    if(!result.hasError) {
      state = AsyncData(
        state.value!.copyWith(
          agreeCount: state.value!.agreeCount + 1,
          agree: true,
        ),
      );
      ref.read(petitionAgreeProvider.notifier).update((value) => true);
    }

  }

  Future<void> reportPetitionPost({required int id, required String categoryName}) async {

    final result = await AsyncValue.guard(
      () async => await ref.read(boardRepositoryProvider).reportPetitionPost(
            id: id,
            categoryName: categoryName,
          ),
    );
    if(!result.hasError) {
      OrbSnackBar.show(
        context: globalNavigatorKey.currentContext!,
        message: '해당 청원 게시글이 신고되었습니다.',
        type: OrbSnackBarType.info,
      );
    }
  }

  @override
  FutureOr<Petition> build(int arg) async {
    // TODO: implement build
    await getPetitionPost(id: arg);
    return state.value!;
  }
}
