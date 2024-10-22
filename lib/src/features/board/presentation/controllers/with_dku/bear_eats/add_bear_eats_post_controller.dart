import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/board/domain/use_cases/with_dku/bear_eats_use_cases.dart';
import 'package:umate/src/features/board/presentation/controllers/board_controller.dart';

final addBearEatsPostControllerProvider =
    AsyncNotifierProvider.autoDispose<AddBearEatsPostController, void>(
  () => AddBearEatsPostController(),
);

class AddBearEatsPostController extends AutoDisposeAsyncNotifier<void> {
  CancelToken? _cancelToken;

  @override
  FutureOr<void> build() {
    ref.onDispose(() {
      _cancelToken?.cancel();
    });
    return null;
  }

  Future<bool> addPost({
    CancelToken? cancelToken,
    required String title,
    required String kakaoOpenChatLink,
    required String restaurant,
    required String deliveryPlace,
    required String deliveryTime,
    required String body,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = await AsyncValue.guard(
      () => ref.read(bearEatsUseCasesProvider).addPost(
            cancelToken: _cancelToken,
            title: title,
            kakaoOpenChatLink: kakaoOpenChatLink,
            restaurant: restaurant,
            deliveryPlace: deliveryPlace,
            deliveryTime: deliveryTime,
            body: body,
          ),
    );

    result.whenOrNull(
      data: (data) {
        ref.invalidate(bearEatsBoardControllerProvider);
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
