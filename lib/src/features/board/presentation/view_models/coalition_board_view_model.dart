import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_exception.dart';
import '../../domain/models/board.dart';
import '../../domain/models/coalition_post.dart';
import '../../domain/models/coalition_type.dart';
import '../../domain/use_cases/get_coalition_board.dart';

final coalitionTypeProvider =
    StateProvider<CoalitionType>((ref) => CoalitionType.food);

final coalitionBoardViewModelProvider = AsyncNotifierProvider.autoDispose<
    CoalitionBoardViewModel, Board<CoalitionPost>>(
  () => CoalitionBoardViewModel(),
);

class CoalitionBoardViewModel
    extends AutoDisposeAsyncNotifier<Board<CoalitionPost>> {
  CancelToken? _cancelToken;

  @override
  FutureOr<Board<CoalitionPost>> build() {
    // TODO: implement build
    ref.watch(coalitionTypeProvider);
    fetch();
    return future;
  }

  Future<void> fetch() async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    state = const AsyncLoading();
    final result = await ref.read(getCoalitionBoardProvider)(
      GetCoalitionBoardParams(
        cancelToken: _cancelToken,
        type: ref.read(coalitionTypeProvider),
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

    final result = await ref.read(getCoalitionBoardProvider)(
      GetCoalitionBoardParams(
        cancelToken: _cancelToken,
        type: ref.read(coalitionTypeProvider),
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
