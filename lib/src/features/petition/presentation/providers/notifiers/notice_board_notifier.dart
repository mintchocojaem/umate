import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../domain/models/notice_post.dart';
import '../../../domain/models/post_sort.dart';
import '../../../domain/use_cases/get_notice_board_use_case.dart';
import '../../../petition_dependency_injections.dart';
import '../states/board_state.dart';

class NoticeBoardNotifier extends AutoDisposeNotifier<BoardState> {
  CancelToken? _cancelToken;

  @override
  BoardState build() {
    // TODO: implement build
    state = const BoardInitialState();
    final sort = ref.watch(noticeBoardSortProvider);
    getNoticeBoard(
      sort: sort,
    );
    return state;
  }

  Future<void> getNoticeBoard({
    required PostSort sort,
    bool isFetchMore = false,
    int page = 0,
  }) async {

    if (!isFetchMore) {
      state = const BoardLoadingState();
    }

    if (state is BoardSuccessState) {
      final successState = state as BoardSuccessState<NoticePost>;

      if (successState.isFetching || !successState.board.hasNext) {
        return;
      } else {
        state = successState.copyWith(isFetchMore: true);
      }

      _cancelToken?.cancel();
      _cancelToken = CancelToken();

      final result = await ref.read(getNoticeBoardUseCaseProvider)(
        GetNoticeBoardParams(
          cancelToken: _cancelToken,
          page: page,
          sort: [sort],
        ),
      );

      state = result.fold(
        (success) => BoardSuccessState<NoticePost>(
          board: successState.board.copyWith(
            content: [...successState.board.content, ...success.content],
            hasNext: success.hasNext,
            page: success.page,
            totalPages: success.totalPages,
            totalElements: success.totalElements,
            size: success.size,
            last: success.last,
            first: success.first,
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

      final result = await ref.read(getNoticeBoardUseCaseProvider)(
        GetNoticeBoardParams(
          cancelToken: _cancelToken,
          page: page,
          sort: [sort],
        ),
      );

      state = result.fold(
        (success) => BoardSuccessState<NoticePost>(
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
