import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/board.dart';
import '../../domain/models/notice_post.dart';
import '../../domain/use_cases/get_notice_board.dart';
import 'board_view_model.dart';

final noticeBoardViewModelProvider =
    AsyncNotifierProvider.autoDispose<NoticeBoardViewModel, Board<NoticePost>>(
  () => NoticeBoardViewModel(),
);

class NoticeBoardViewModel extends BoardViewModel<NoticePost> {
  @override
  Future<Board<NoticePost>> getBoard({
    CancelToken? cancelToken,
    int? page,
  }) {
    // TODO: implement _getBoard
    final result = ref.read(
      getNoticeBoardProvider(
        GetNoticeBoardParams(
          cancelToken: cancelToken,
          page: page,
        ),
      ),
    );
    return result;
  }
}
