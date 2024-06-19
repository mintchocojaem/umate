import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/bear_eats_post.dart';
import '../../domain/models/board.dart';
import '../../domain/use_cases/get_bear_eats_board.dart';

final bearEatsBoardProvider = AsyncNotifierProvider.autoDispose<
    BearEatsBoardNotifier, Board<BearEatsPost>>(
  () => BearEatsBoardNotifier(),
);

class BearEatsBoardNotifier
    extends AutoDisposeAsyncNotifier<Board<BearEatsPost>> {
  CancelToken? _cancelToken;

  @override
  FutureOr<Board<BearEatsPost>> build() {
    // TODO: implement build
    return _fetch();
  }

  Future<void> fetch() async {
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<Board<BearEatsPost>> _fetch() async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = ref.read(
      getBearEatsBoardProvider(
        GetBearEatsBoardParams(
          cancelToken: _cancelToken,
        ),
      ),
    );

    return result;
  }

  Future<void> fetchMore({
    required int page,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = await AsyncValue.guard(
      () => ref.read(
        getBearEatsBoardProvider(
          GetBearEatsBoardParams(
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
