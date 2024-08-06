import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/student_council/petition_status.dart';
import '../../../../domain/use_cases/student_council/petition_use_cases.dart';
import 'petition_category_controller.dart';

final addpetitionPostControllerProvider =
    AsyncNotifierProvider.autoDispose<AddPetitionPostController, void>(
  () => AddPetitionPostController(),
);

class AddPetitionPostController extends AutoDisposeAsyncNotifier<void> {
  CancelToken? _cancelToken;

  @override
  FutureOr<void> build() {
    ref.onDispose(() {
      _cancelToken?.cancel();
    });
    return null;
  }

  Future<bool> writePetition({
    required String title,
    required String body,
    required List<String> images,
    required List<String> files,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = await AsyncValue.guard(
      () => ref.read(petitionUseCasesProvider).writePost(
            title: title,
            body: body,
            images: images,
            files: files,
          ),
    );

    result.whenOrNull(
      data: (data) {
        ref
            .read(petitionCategoryControllerProvider.notifier)
            .change(type: PetitionStatus.active);
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
