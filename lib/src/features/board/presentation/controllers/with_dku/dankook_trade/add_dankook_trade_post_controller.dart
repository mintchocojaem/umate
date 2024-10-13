import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/board/presentation/controllers/board_controller.dart';

import '../../../../domain/use_cases/with_dku/dankook_trade_use_cases.dart';

final addDankookTradePostControllerProvider =
    AsyncNotifierProvider.autoDispose<AddDankookTradePostController, void>(
  () => AddDankookTradePostController(),
);

class AddDankookTradePostController extends AutoDisposeAsyncNotifier<void> {
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
    required String price,
    required String body,
    required String tradePlace,
    required List<String> images,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = await AsyncValue.guard(
      () => ref.read(dankookTradeUseCasesProvider).addPost(
            title: title,
            body: body,
            price: price,
            tradePlace: tradePlace,
            images: images,
          ),
    );

    result.whenOrNull(
      data: (data) {
        ref.invalidate(dankookTradeBoardControllerProvider);
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
