import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_exception.dart';
import '../../domain/models/board.dart';
import '../../domain/models/petition_post.dart';
import '../../domain/models/petition_status.dart';
import '../../domain/use_cases/get_petition_board.dart';

final petitionStatusProvider = StateProvider.autoDispose<PetitionStatus>((ref) {
  return PetitionStatus.active;
});

final petitionBoardViewModelProvider = AsyncNotifierProvider.autoDispose<
    PetitionBoardViewModel, Board<PetitionPost>>(
  () => PetitionBoardViewModel(),
);

class PetitionBoardViewModel
    extends AutoDisposeAsyncNotifier<Board<PetitionPost>> {
  CancelToken? _cancelToken;

  @override
  FutureOr<Board<PetitionPost>> build() {
    // TODO: implement build
    ref.watch(petitionStatusProvider);
    fetch();
    return future;
  }

  Future<void> fetch() async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    state = const AsyncLoading();
    final result = await ref.read(getPetitionBoardProvider)(
      GetPetitionBoardParams(
        cancelToken: _cancelToken,
        status: ref.read(petitionStatusProvider),
      ),
    );

    /*
    result.fold(
      (success) {
        state = AsyncData(success);
      },
      (failure) {
        if (!(failure is AppNetworkError &&
            failure.type == DioExceptionType.cancel)) {
          state = AsyncError(
            failure.message,
            failure.stackTrace,
          );
        }
      },
    );

     */
  }

  Future<void> fetchMore({
    required int page,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = await ref.read(getPetitionBoardProvider)(
      GetPetitionBoardParams(
        cancelToken: _cancelToken,
        status: ref.read(petitionStatusProvider),
        page: page,
      ),
    );

    /*
    result.fold(
      (success) {
        state = AsyncData(
          success.copyWith(
            content: [
              ...state.requireValue.content,
              ...success.content,
            ],
          ),
        );
      },
      (failure) {
        if (!(failure is AppNetworkError &&
            failure.type == DioExceptionType.cancel)) {
          state = AsyncError(
            failure.message,
            failure.stackTrace,
          );
        }
      },
    );

     */
  }
}
