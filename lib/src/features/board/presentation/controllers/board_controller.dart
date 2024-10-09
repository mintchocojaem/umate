import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/board.dart';
import '../../domain/models/post.dart';
import '../../domain/models/student_council/coalition_post.dart';
import '../../domain/models/student_council/notice_post.dart';
import '../../domain/models/student_council/petition_post.dart';
import '../../domain/models/with_dku/bear_eats_post.dart';
import '../../domain/models/with_dku/dankook_trade_post.dart';
import '../../domain/models/with_dku/dantudy_post.dart';
import '../../domain/models/with_dku/eating_alone_post.dart';
import '../../domain/use_cases/student_council/coalition_use_cases.dart';
import '../../domain/use_cases/student_council/notice_use_cases.dart';
import '../../domain/use_cases/student_council/petition_use_cases.dart';
import '../../domain/use_cases/with_dku/bear_eats_use_cases.dart';
import '../../domain/use_cases/with_dku/dankook_trade_use_cases.dart';
import '../../domain/use_cases/with_dku/dantudy_use_cases.dart';
import '../../domain/use_cases/with_dku/eating_alone_use_cases.dart';
import 'student_council/coalition/coalition_category_controller.dart';
import 'student_council/petition/petition_category_controller.dart';

part 'student_council/coalition/coalition_board_controller.dart';
part 'student_council/notice/notice_board_controller.dart';
part 'student_council/petition/petition_board_controller.dart';
part 'with_dku/bear_eats/bear_eats_board_controller.dart';
part 'with_dku/dankook_trade/dankook_trade_board_controller.dart';
part 'with_dku/dantudy/dantudy_board_controller.dart';
part 'with_dku/eating_alone/eating_alone_board_controller.dart';

abstract class BoardController<P extends Post>
    extends AutoDisposeAsyncNotifier<Board<P>> {
  CancelToken? _cancelToken;
  int _page = 0;

  Future<Board<P>> _fetch({
    CancelToken? cancelToken,
    required int page,
  });

  @override
  FutureOr<Board<P>> build() {
    return _fetch(
      cancelToken: _cancelToken,
      page: 0,
    );
  }

  Future<void> refresh() async {
    _page = 0;
    ref.invalidateSelf();
  }

  Future<void> fetch() async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = await AsyncValue.guard(
      () => _fetch(
        cancelToken: _cancelToken,
        page: _page + 1,
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
        _page++;
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
