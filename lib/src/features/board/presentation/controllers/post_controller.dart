
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/post.dart';
import '../../domain/models/student_council/coalition_post.dart';
import '../../domain/models/student_council/notice_post.dart';
import '../../domain/models/student_council/petition_post.dart';
import '../../domain/models/with_dku/eating_alone_post.dart';
import '../../domain/use_cases/student_council/coalition_use_cases.dart';
import '../../domain/use_cases/student_council/notice_use_cases.dart';
import '../../domain/use_cases/student_council/petition_use_cases.dart';
import '../../domain/use_cases/with_dku/eating_alone_use_cases.dart';
import 'board_controller.dart';

part 'student_council/notice/notice_post_controller.dart';
part 'student_council/coalition/coalition_post_controller.dart';
part 'student_council/petition/petition_post_controller.dart';
part 'with_dku/eating_alone/eating_alone_post_controller.dart';

abstract class PostController<P extends Post>
    extends AutoDisposeFamilyAsyncNotifier<P, int> {
  CancelToken? _cancelToken;

  Future<P> _fetch({
    CancelToken? cancelToken,
    required int id
  });

  @override
  FutureOr<P> build(int arg) {
    _cancelToken = CancelToken();

    ref.onDispose(() {
      _cancelToken?.cancel();
    });

    return _fetch(
      cancelToken: _cancelToken,
      id: arg,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
