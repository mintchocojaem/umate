import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/petition/domain/models/coalition_post.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../domain/models/coalition_type.dart';
import '../../../domain/models/post_sort.dart';
import '../../../domain/use_cases/get_coalition_board_use_case.dart';
import '../../../petition_dependency_injections.dart';
import '../states/board_state.dart';

class CoalitionBoardNotifier extends AutoDisposeNotifier<BoardState> {
  CancelToken? _cancelToken;

  @override
  BoardState build() {
    // TODO: implement build
    state = const BoardInitialState();
    final coalitionType = ref.watch(coalitionBoardCategoryProvider);
    final sort = ref.watch(coalitionBoardSortProvider);
    getCoalitionBoard(
      coalitionType: coalitionType,
      sort: sort,
    );
    return state;
  }

  Future<void> getCoalitionBoard({
    required CoalitionType coalitionType,
    required PostSort sort,
    bool isFetchMore = false,
    int page = 0,
  }) async {

    if (!isFetchMore) {
      state = const BoardLoadingState();
    }

    if (state is BoardSuccessState) {
      final successState = state as BoardSuccessState<CoalitionPost>;

      if (successState.isFetching || !successState.board.hasNext) {
        return;
      } else {
        state = successState.copyWith(isFetchMore: true);
      }

      _cancelToken?.cancel();
      _cancelToken = CancelToken();

      final result = await ref.read(getCoalitionBoardUseCaseProvider)(
        GetCoalitionBoardParams(
          cancelToken: _cancelToken,
          coalitionType: coalitionType,
          page: page,
          sort: [sort],
        ),
      );

      state = result.fold(
        (success) => BoardSuccessState<CoalitionPost>(
          board: successState.board.copyWith(
            content: [...successState.board.content, ...success.content],
            hasNext: success.hasNext,
            page: success.page,
            totalPages: success.totalPages,
            totalElements: success.totalElements,
            size: success.size,
          ),
        ),
        (failure) => BoardFailureState(
          message: failure.message,
          isCanceled: failure is AppNetworkError &&
              failure.type == DioExceptionType.cancel,
        ),
      );
    } else {

      _cancelToken?.cancel();
      _cancelToken = CancelToken();

      final result = await ref.read(getCoalitionBoardUseCaseProvider)(
        GetCoalitionBoardParams(
          cancelToken: _cancelToken,
          coalitionType: coalitionType,
          page: page,
          sort: [sort],
        ),
      );

      state = result.fold(
        (success) => BoardSuccessState<CoalitionPost>(
          board: success,
        ),
        (failure) => BoardFailureState(
          message: failure.message,
          isCanceled: failure is AppNetworkError &&
              failure.type == DioExceptionType.cancel,
        ),
      );
    }
  }
}
