import 'dart:async';

import 'package:danvery/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/orb/components/components.dart';
import '../../domain.dart';

final postReportProvider = StateProvider.autoDispose<PostReportType?>((ref) => null);

final petitionAgreeProvider = StateProvider.autoDispose<bool>((ref) => false);

final petitionProvider =
    AsyncNotifierProvider.autoDispose.family<PetitionNotifier, Petition, int>(
      () => PetitionNotifier(),
);

class PetitionNotifier extends AutoDisposeFamilyAsyncNotifier<Petition, int> {
  
  late final int id = arg;
  
  Future<void> getPetitionPost() async {
    state = await AsyncValue.guard(
      () async => await ref.read(boardRepositoryProvider).getPetitionPost(
            id: id,
          ),
    );
    ref.read(petitionAgreeProvider.notifier).update((value) => state.value!.agree);
  }

  Future<void> agreePetitionPost() async {

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

  Future<void> reportPetitionPost({required String categoryName}) async {

    final result = await AsyncValue.guard(
      () async => await ref.read(boardRepositoryProvider).reportPetitionPost(
            id: id,
            categoryName: categoryName,
          ),
    );
    if(!result.hasError) {
      OrbSnackBar.show(
        message: '해당 청원 게시글이 신고되었습니다.',
        type: OrbSnackBarType.info,
      );
    }
  }

  @override
  FutureOr<Petition> build(arg) async {
    // TODO: implement build
    await getPetitionPost();
    return state.value!;
  }
}
