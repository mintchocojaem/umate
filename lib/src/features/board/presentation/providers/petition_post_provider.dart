import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/board/presentation/providers/petition_board_provider.dart';

import '../../domain/models/petition_post.dart';
import '../../domain/use_cases/agree_petition.dart';
import '../../domain/use_cases/get_petition_post.dart';

final petitionPostProvider = AsyncNotifierProvider.autoDispose
    .family<PetitionPostNotifier, PetitionPost, int>(
  () => PetitionPostNotifier(),
);

class PetitionPostNotifier
    extends AutoDisposeFamilyAsyncNotifier<PetitionPost, int> {
  @override
  FutureOr<PetitionPost> build(int arg) {
    // TODO: implement build
    return _fetch();
  }

  Future<PetitionPost> _fetch() async {
    return await ref.read(
      getPetitionPostProvider(
        GetPetitionPostParams(id: arg),
      ),
    );
  }

  Future<bool> agreePetitionPost({
    required int id,
  }) async {
    final result = await AsyncValue.guard(
      () => ref.read(
        agreePetitionPostProvider(
          AgreePetitionPostParams(id: id),
        ),
      ),
    );

    result.whenOrNull(
      data: (data) {
        ref.invalidateSelf();
        ref.invalidate(petitionBoardProvider);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(
          error,
          stackTrace,
        );
      },
    );

    return result.hasValue;
  }
}
