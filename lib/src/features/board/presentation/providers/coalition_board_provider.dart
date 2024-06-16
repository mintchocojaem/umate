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

final coalitionBoardProvider = AsyncNotifierProvider.autoDispose<
    CoalitionBoardNotifier, Board<CoalitionPost>>(
  () => CoalitionBoardNotifier(),
);

class CoalitionBoardNotifier
    extends AutoDisposeAsyncNotifier<Board<CoalitionPost>> {
  CancelToken? _cancelToken;

  @override
  FutureOr<Board<CoalitionPost>> build() {
    // TODO: implement build
    ref.watch(coalitionTypeProvider);
    return _fetch();
  }

  Future<Board<CoalitionPost>> _fetch() async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = ref.read(
      getCoalitionBoardProvider(
        GetCoalitionBoardParams(
          cancelToken: _cancelToken,
          type: ref.read(coalitionTypeProvider),
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
        getCoalitionBoardProvider(
          GetCoalitionBoardParams(
            cancelToken: _cancelToken,
            page: page,
            type: ref.read(coalitionTypeProvider),
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
        if (!(error is AppNetworkError &&
            error.type == DioExceptionType.cancel)) {
          state = AsyncError(
            error,
            stackTrace,
          );
        }
      },
    );
  }
}
