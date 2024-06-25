import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../domain/models/board.dart';
import '../../domain/models/post.dart';

abstract class BoardViewModel<P extends Post>
    extends AutoDisposeAsyncNotifier<Board<P>> {
  CancelToken? _cancelToken;

  //need to implement this method in child class
  Future<Board<P>> getBoard({
    CancelToken? cancelToken,
    int? page,
  });

  @override
  FutureOr<Board<P>> build() {
    return _fetch();
  }

  Future<Board<P>> _fetch() async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    return getBoard(cancelToken: _cancelToken);
  }

  Future<void> fetch() async {
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<void> fetchMore({
    required int page,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = await AsyncValue.guard(() => getBoard(
          page: page,
          cancelToken: _cancelToken,
        ));

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
