import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/app_exception.dart';

import '../../domain/model/petition_board.dart';
import '../../domain/use_case/get_petition_board.dart';
import 'petition_status_provider.dart';

final petitionBoardProvider =
    AutoDisposeAsyncNotifierProvider<PetitionBoardNotifier, PetitionBoard>(
  () => PetitionBoardNotifier(),
);

class PetitionBoardNotifier extends AutoDisposeAsyncNotifier<PetitionBoard> {
  CancelToken? _cancelToken;

  @override
  FutureOr<PetitionBoard> build() {
    // TODO: implement build
    getPetitionBoard();
    return future;
  }

  Future<void> getPetitionBoard({
    int page = 0,
  }) async {

    if (page == 0) {
      state = const AsyncLoading();
    }

    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = await ref.read(getPetitionBoardProvider)(
      GetPetitionBoardParams(
        cancelToken: _cancelToken,
        status: ref.read(petitionStatusProvider),
        page: page,
      ),
    );

    result.fold(
      (success) {
        if(page != 0 && state.value != null){
          state = AsyncData(
            state.value!.copyWith(
              content: [
                ...state.value!.content,
                ...success.content,
              ],
              page: success.page,
              hasNext: success.hasNext,
            ),
          );
        } else {
          state = AsyncData(success);
        }
      },
      (failure) {
        if (!(failure is AppNetworkError &&
            failure.type == DioExceptionType.cancel)) {
          state = AsyncError(failure.message, failure.stackTrace);
        }
      },
    );
  }
}
