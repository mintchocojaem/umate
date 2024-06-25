import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/board.dart';
import '../../domain/models/study_post.dart';
import '../../domain/use_cases/get_study_board.dart';
import 'board_view_model.dart';

final studyBoardViewModelProvider =
    AsyncNotifierProvider.autoDispose<StudyBoardViewModel, Board<StudyPost>>(
  () => StudyBoardViewModel(),
);

class StudyBoardViewModel extends BoardViewModel<StudyPost> {
  @override
  Future<Board<StudyPost>> getBoard({
    CancelToken? cancelToken,
    int? page,
  }) {
    // TODO: implement _getBoard
    final result = ref.read(
      getStudyBoardProvider(
        GetStudyBoardParams(
          cancelToken: cancelToken,
          page: page,
        ),
      ),
    );
    return result;
  }
}
