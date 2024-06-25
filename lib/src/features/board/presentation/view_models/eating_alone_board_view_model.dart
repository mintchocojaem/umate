import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/board.dart';
import '../../domain/models/eating_alone_post.dart';
import '../../domain/use_cases/get_eating_alone_board.dart';
import 'board_view_model.dart';

final eatingAloneBoardViewModelProvider = AsyncNotifierProvider.autoDispose<
    EatingAloneBoardViewModel, Board<EatingAlonePost>>(
  () => EatingAloneBoardViewModel(),
);

class EatingAloneBoardViewModel extends BoardViewModel<EatingAlonePost> {
  @override
  Future<Board<EatingAlonePost>> getBoard({
    CancelToken? cancelToken,
    int? page,
  }) {
    // TODO: implement _getBoard
    final result = ref.read(
      getEatingAloneBoardProvider(
        GetEatingAloneBoardParams(
          cancelToken: cancelToken,
          page: page,
        ),
      ),
    );
    return result;
  }
}
