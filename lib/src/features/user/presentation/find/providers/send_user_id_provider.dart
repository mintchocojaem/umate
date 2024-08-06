import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/use_cases/auth_use_cases.dart';

part 'send_user_id_provider.g.dart';

enum SendUserIdStep {
  initial,
  studentIdSent,
}

class SendUserIdState {
  final SendUserIdStep step;

  SendUserIdState({
    required this.step,
  });

  factory SendUserIdState.empty() {
    return SendUserIdState(
      step: SendUserIdStep.initial,
    );
  }

  SendUserIdState copyWith({
    SendUserIdStep? step,
  }) {
    return SendUserIdState(
      step: step ?? this.step,
    );
  }
}

@riverpod
class SendUserIdNotifier extends _$SendUserIdNotifier {
  @override
  FutureOr<SendUserIdState> build() {
    // TODO: implement build
    return SendUserIdState.empty();
  }

  Future<void> send({
    required String phoneNumber,
  }) async {
    state = await AsyncValue.guard(
      () async {
        await ref.read(authUseCasesProvider).sendStudentId(
              phoneNumber: phoneNumber,
            );
        return state.requireValue.copyWith(
          step: SendUserIdStep.studentIdSent,
        );
      },
    );
  }
}
