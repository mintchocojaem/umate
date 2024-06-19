import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/board.dart';
import '../../domain/models/petition_post.dart';
import '../../domain/models/petition_status.dart';
import '../../domain/models/post_sort.dart';
import '../../domain/use_cases/get_petition_board.dart';
import '../../domain/use_cases/write_petition_post.dart';

final petitionStatusProvider = StateProvider.autoDispose<PetitionStatus>((ref) {
  return PetitionStatus.active;
});

final petitionBoardProvider = AsyncNotifierProvider.autoDispose<
    PetitionBoardNotifier, Board<PetitionPost>>(
  () => PetitionBoardNotifier(),
);

class PetitionBoardNotifier
    extends AutoDisposeAsyncNotifier<Board<PetitionPost>> {
  CancelToken? _cancelToken;

  @override
  FutureOr<Board<PetitionPost>> build() {
    // TODO: implement build
    ref.watch(petitionStatusProvider);
    return _fetch();
  }

  Future<Board<PetitionPost>> _fetch() async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = ref.read(
      getPetitionBoardProvider(
        GetPetitionBoardParams(
          cancelToken: _cancelToken,
          status: ref.read(petitionStatusProvider),
          sort: [
            PostSort(
              type: PostSortType.createdAt,
            ),
          ],
        ),
      ),
    );

    return result;
  }

  Future<void> fetch() async {
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<void> fetchMore({
    required int page,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = await AsyncValue.guard(
      () => ref.read(
        getPetitionBoardProvider(
          GetPetitionBoardParams(
            cancelToken: _cancelToken,
            page: page,
            status: ref.read(petitionStatusProvider),
          ),
        ),
      ),
    );

    result.whenOrNull(
      data: (data) {
        state = AsyncData(
          data.copyWith(
            content: [
              ...state.requireValue.content,
              ...data.content,
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        state = AsyncError(
          error,
          stackTrace,
        );
      },
    );
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
