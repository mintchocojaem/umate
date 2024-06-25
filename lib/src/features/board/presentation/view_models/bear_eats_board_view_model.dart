import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/bear_eats_post.dart';
import '../../domain/models/board.dart';
import '../../domain/use_cases/get_bear_eats_board.dart';
import 'board_view_model.dart';

final bearEatsBoardViewModelProvider = AsyncNotifierProvider.autoDispose<
    BearEatsBoardViewModel, Board<BearEatsPost>>(
  () => BearEatsBoardViewModel(),
);

class BearEatsBoardViewModel extends BoardViewModel<BearEatsPost> {
  @override
  Future<Board<BearEatsPost>> getBoard({
    CancelToken? cancelToken,
    int? page,
  }) {
    // TODO: implement _getBoard
    final result = ref.read(
      getBearEatsBoardProvider(
        GetBearEatsBoardParams(
          cancelToken: cancelToken,
          page: page,
        ),
      ),
    );
    return result;
  }
}
