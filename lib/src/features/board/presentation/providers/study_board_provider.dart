import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/board.dart';
import '../../domain/models/study_post.dart';
import '../../domain/use_cases/get_study_board.dart';

final studyBoardProvider =
    AsyncNotifierProvider.autoDispose<StudyBoardNotifier, Board<StudyPost>>(
  () => StudyBoardNotifier(),
);

class StudyBoardNotifier extends AutoDisposeAsyncNotifier<Board<StudyPost>> {
  CancelToken? _cancelToken;

  @override
  FutureOr<Board<StudyPost>> build() {
    // TODO: implement build
    return _fetch();
  }

  Future<void> fetch() async {
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<Board<StudyPost>> _fetch() async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = ref.read(
      getStudyBoardProvider(
        GetStudyBoardParams(
          cancelToken: _cancelToken,
        ),
      ),
    );

    return result;
  }
}
