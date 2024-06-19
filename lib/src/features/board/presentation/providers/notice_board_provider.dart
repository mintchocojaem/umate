import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/board.dart';
import '../../domain/models/notice_post.dart';
import '../../domain/use_cases/get_notice_board.dart';

final noticeBoardProvider =
    AsyncNotifierProvider.autoDispose<NoticeBoardNotifier, Board<NoticePost>>(
  () => NoticeBoardNotifier(),
);

class NoticeBoardNotifier extends AutoDisposeAsyncNotifier<Board<NoticePost>> {
  CancelToken? _cancelToken;

  @override
  FutureOr<Board<NoticePost>> build() {
    // TODO: implement build
    return _fetch();
  }

  Future<Board<NoticePost>> _fetch() async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = ref.read(
      getNoticeBoardProvider(
        GetNoticeBoardParams(
          cancelToken: _cancelToken,
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
        getNoticeBoardProvider(
          GetNoticeBoardParams(
            cancelToken: _cancelToken,
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
}
