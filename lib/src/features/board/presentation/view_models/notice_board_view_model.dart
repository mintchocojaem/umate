import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_exception.dart';
import '../../domain/models/board.dart';
import '../../domain/models/notice_post.dart';
import '../../domain/use_cases/get_notice_board.dart';

final noticeBoardViewModelProvider =
    AsyncNotifierProvider.autoDispose<NoticeBoardViewModel, Board<NoticePost>>(
  () => NoticeBoardViewModel(),
);

class NoticeBoardViewModel extends AutoDisposeAsyncNotifier<Board<NoticePost>> {
  CancelToken? _cancelToken;

  @override
  FutureOr<Board<NoticePost>> build() {
    // TODO: implement build
    fetch();
    return future;
  }

  Future<void> fetch() async {

    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    state = const AsyncLoading();
    final result = await ref.read(getNoticeBoardProvider)(
      GetNoticeBoardParams(
        cancelToken: _cancelToken,
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

    final result = await ref.read(getNoticeBoardProvider)(
      GetNoticeBoardParams(
        cancelToken: _cancelToken,
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
