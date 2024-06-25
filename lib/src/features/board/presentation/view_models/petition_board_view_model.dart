import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/board.dart';
import '../../domain/models/petition_post.dart';
import '../../domain/models/petition_status.dart';
import '../../domain/use_cases/get_petition_board.dart';
import '../../domain/use_cases/write_petition_post.dart';
import 'board_view_model.dart';

final petitionStatusProvider = StateProvider.autoDispose<PetitionStatus>((ref) {
  return PetitionStatus.active;
});

final petitionBoardViewModelProvider = AsyncNotifierProvider.autoDispose<
    PetitionBoardViewModel, Board<PetitionPost>>(
  () => PetitionBoardViewModel(),
);

class PetitionBoardViewModel extends BoardViewModel<PetitionPost> {
  @override
  build() {
    // TODO: implement build
    ref.listen(
      petitionStatusProvider,
      (prev, next) {
        ref.invalidateSelf();
      },
    );
    return super.build();
  }

  @override
  Future<Board<PetitionPost>> getBoard({
    CancelToken? cancelToken,
    int? page,
  }) {
    // TODO: implement _getBoard
    final result = ref.read(
      getPetitionBoardProvider(
        GetPetitionBoardParams(
          cancelToken: cancelToken,
          page: page,
          status: ref.read(petitionStatusProvider),
        ),
      ),
    );
    return result;
  }

  Future<bool> writePetition({
    required String title,
    required String body,
    required List<String> images,
    required List<String> files,
  }) async {
    final result = await AsyncValue.guard(
      () => ref.read(
        writePetitionPostProvider(
          WritePetitionPostParams(
            title: title,
            body: body,
            images: images,
            files: files,
          ),
        ),
      ),
    );

    result.whenOrNull(
      data: (data) {
        fetch();
      },
      error: (error, stackTrace) {
        state = AsyncError(
          error,
          stackTrace,
        );
      },
    );

    return result.hasValue;
  }
}
