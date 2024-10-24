import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/board/presentation/controllers/board_controller.dart';

import '../../../../../user/domain/use_cases/auth_use_cases.dart';
import '../../../../domain/use_cases/with_dku/eating_alone_use_cases.dart';

final addEatingAlonePostControllerProvider =
    AsyncNotifierProvider.autoDispose<AddEatingAlonePostController, void>(
  () => AddEatingAlonePostController(),
);

class AddEatingAlonePostController extends AutoDisposeAsyncNotifier<void> {
  CancelToken? _cancelToken;

  @override
  Future<void> build() async {
    await ref.read(authUseCasesProvider).checkValidUser();
    ref.onDispose(() {
      _cancelToken?.cancel();
    });
    return;
  }

  Future<bool> addPost({
    required String title,
    required String body,
    required String kakaoOpenChatLink,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = await AsyncValue.guard(
      () => ref.read(eatingAloneUseCasesProvider).addPost(
            title: title,
            body: body,
            kakaoOpenChatLink: kakaoOpenChatLink,
          ),
    );

    result.whenOrNull(
      data: (data) {
        ref.invalidate(eatingAloneBoardControllerProvider);
      },
      error: (error, stackTrace) {
        state = AsyncError(
          error,
          stackTrace,
        );
      },
    );

    return result.hasValue;
  }
}
