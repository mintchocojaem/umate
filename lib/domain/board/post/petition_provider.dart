import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../modules/orb/components/components.dart';
import '../../domain.dart';

final petitionContentLengthProvider =
    StateProvider.autoDispose<int>((ref) => 0);

final petitionReportProvider =
    StateProvider.autoDispose<PostReportType?>((ref) => null);

final petitionAgreeProvider = StateProvider.autoDispose<bool>((ref) => false);

final petitionWriteProvider = StateProvider.autoDispose<PetitionWriteProvider>(
    (ref) => PetitionWriteProvider(ref));

class PetitionWriteProvider {
  final Ref ref;

  PetitionWriteProvider(this.ref);

  Future<bool> writePetitionPost(
      {required String title,
      required String body,
      XFile? image,
      FilePickerResult? file}) async {
    final result = await AsyncValue.guard(
      () async => await ref.read(boardRepositoryProvider).writePetitionPost(
            title: title,
            body: body,
            image: image,
            file: file,
          ),
    );
    return !result.hasError;
  }
}

final petitionDetailProvider = AsyncNotifierProvider.autoDispose
    .family<PetitionDetailNotifier, Petition, int>(
  () => PetitionDetailNotifier(),
);

class PetitionDetailNotifier
    extends AutoDisposeFamilyAsyncNotifier<Petition, int> {
  late final int _id = arg;

  Future<void> getPetitionPost() async {
    state = await AsyncValue.guard(
      () async => await ref.read(boardRepositoryProvider).getPetitionPost(
            id: _id,
          ),
    );
    ref
        .read(petitionAgreeProvider.notifier)
        .update((value) => state.value!.agree);
  }

  Future<void> agreePetitionPost() async {
    final result = await AsyncValue.guard(
      () async => await ref.read(boardRepositoryProvider).agreePetitionPost(
            id: _id,
          ),
    );

    if (!result.hasError) {
      await getPetitionPost();
    }
  }

  Future<void> reportPetitionPost({required String categoryName}) async {
    final result = await AsyncValue.guard(
      () async => await ref.read(boardRepositoryProvider).reportPetitionPost(
            id: _id,
            categoryName: categoryName,
          ),
    );
    if (!result.hasError) {
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
