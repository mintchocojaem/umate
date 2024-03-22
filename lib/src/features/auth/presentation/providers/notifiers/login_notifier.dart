import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth_dependency_injections.dart';
import '../../../domain/use_cases/login_use_case.dart';
import '../states/login_state.dart';

class LoginNotifier extends AutoDisposeNotifier<LoginState> {
  @override
  LoginState build() {
    // TODO: implement build
    return const LoginInitial();
  }

  Future<void> login({
    required String studentId,
    required String password,
  }) async {
    state = const LoginLoading();

    final result = await ref.read(loginUseCaseProvider)(
      LoginParams(
        studentId: studentId,
        password: password,
      ),
    );

    state = result.fold(
      (success) => LoginSuccess(
        token: success,
      ),
      (failure) => LoginFailure(
        exception: failure,
      ),
    );
  }
}
