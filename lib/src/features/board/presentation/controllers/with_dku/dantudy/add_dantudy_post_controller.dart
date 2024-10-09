import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/board/presentation/controllers/board_controller.dart';

import '../../../../domain/use_cases/with_dku/dantudy_use_cases.dart';

final addDantudyPostControllerProvider =
    AsyncNotifierProvider.autoDispose<AddDantudyPostController, void>(
  () => AddDantudyPostController(),
);

class AddDantudyPostController extends AutoDisposeAsyncNotifier<void> {
  CancelToken? _cancelToken;

  @override
  FutureOr<void> build() {
    ref.onDispose(() {
      _cancelToken?.cancel();
    });
    return null;
  }

  Future<bool> addPost({
    required String title,
    required String body,
    required int minStudentId,
    required String tag,
    required String startTime,
    required String endTime,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = await AsyncValue.guard(
      () => ref.read(dantudyUseCasesProvider).addPost(
            title: title,
            body: body,
            minStudentId: minStudentId,
            tag: tag,
            startTime: startTime,
            endTime: endTime,
          ),
    );

    result.whenOrNull(
      data: (data) {
        ref.invalidate(dantudyBoardControllerProvider);
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
