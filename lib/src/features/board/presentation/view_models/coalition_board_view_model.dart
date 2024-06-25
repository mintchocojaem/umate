import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/board.dart';
import '../../domain/models/coalition_post.dart';
import '../../domain/models/coalition_type.dart';
import '../../domain/use_cases/get_coalition_board.dart';
import 'board_view_model.dart';

final coalitionTypeProvider =
    StateProvider<CoalitionType>((ref) => CoalitionType.food);

final coalitionBoardViewModelProvider = AsyncNotifierProvider.autoDispose<
    CoalitionBoardViewModel, Board<CoalitionPost>>(
  () => CoalitionBoardViewModel(),
);

class CoalitionBoardViewModel extends BoardViewModel<CoalitionPost> {
  @override
  build() {
    // TODO: implement build
    ref.listen(
      coalitionTypeProvider,
      (prev, next) {
        ref.invalidateSelf();
      },
    );
    return super.build();
  }

  @override
  Future<Board<CoalitionPost>> getBoard({
    CancelToken? cancelToken,
    int? page,
  }) {
    // TODO: implement _getBoard
    final result = ref.read(
      getCoalitionBoardProvider(
        GetCoalitionBoardParams(
          cancelToken: cancelToken,
          page: page,
          type: ref.read(coalitionTypeProvider),
        ),
      ),
    );
    return result;
  }
}
