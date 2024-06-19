import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/board.dart';
import '../../domain/models/eating_alone_post.dart';
import '../../domain/use_cases/get_eating_alone_board.dart';

final eatingAloneBoardProvider = AsyncNotifierProvider.autoDispose<
    EatingAloneBoardNotifier, Board<EatingAlonePost>>(
  () => EatingAloneBoardNotifier(),
);

class EatingAloneBoardNotifier
    extends AutoDisposeAsyncNotifier<Board<EatingAlonePost>> {
  CancelToken? _cancelToken;

  @override
  FutureOr<Board<EatingAlonePost>> build() {
    // TODO: implement build
    return _fetch();
  }

  Future<void> fetch() async {
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<Board<EatingAlonePost>> _fetch() async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = ref.read(
      getEatingAloneBoardProvider(
        GetEatingAloneBoardParams(
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
        getEatingAloneBoardProvider(
          GetEatingAloneBoardParams(
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
