import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../init_dependency_injections.dart';
import '../../../domain/models/token.dart';
import '../../../domain/use_cases/login_use_case.dart';
import '../../../domain/use_cases/reissue_token_use_case.dart';
import '../../../user_dependency_injections.dart';
import '../states/login_state.dart';

class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    // TODO: implement build
    return const LoginInitialState();
  }

  Future<void> autoLogin() async {
    final Map<String, dynamic>? savedToken =
        await ref.read(storageServiceProvider).read('token');
    final token = savedToken != null
        ? Token(
            accessToken: savedToken['accessToken']!,
            refreshToken: savedToken['refreshToken']!,
          )
        : null;
    if (savedToken != null) {
      state = const LoginLoadingState();

      final newToken = await ref.read(reissueTokenUseCaseProvider)(
        ReissueTokenParams(
          refreshToken: token!.refreshToken,
        ),
      );
      newToken.fold(
        (success) {
          ref.read(storageServiceProvider).write(
            'token',
            {
              'accessToken': success.accessToken,
              'refreshToken': success.refreshToken,
            },
          );
          state = LoginSuccessState(
            token: success,
          );
        },
        (failure) {
          ref.read(storageServiceProvider).remove('token');
          state = LoginFailureState(
            message: failure.message,
          );
        },
      );
    }
  }

  Future<void> login({
    required String studentId,
    required String password,
  }) async {
    state = const LoginLoadingState();

    final result = await ref.read(loginUseCaseProvider)(
      LoginParams(
        studentId: studentId,
        password: password,
      ),
    );

    result.fold(
      (success) {
        ref.read(storageServiceProvider).write('token', {
          'accessToken': success.accessToken,
          'refreshToken': success.refreshToken,
        });
        state = LoginSuccessState(
          token: success,
        );
      },
      (failure) {
        ref.read(storageServiceProvider).remove('token');
        state = LoginFailureState(
          message: failure.message,
        );
      },
    );
  }

  void logout() {
    ref.read(storageServiceProvider).remove('token');
    state = const LoginInitialState();
  }
}
