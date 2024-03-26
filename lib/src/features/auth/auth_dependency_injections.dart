import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../init_dependency_injections.dart';
import 'data/data_sources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/use_cases/login_use_case.dart';
import 'domain/use_cases/sign_up_compelete_use_case.dart';
import 'domain/use_cases/sign_up_confirm_nickname_use_case.dart';
import 'domain/use_cases/sign_up_send_code_use_case.dart';
import 'domain/use_cases/sign_up_verify_code_use_case.dart';
import 'domain/use_cases/sign_up_verify_nickname_use_case.dart';
import 'domain/use_cases/sign_up_verify_student_use_case.dart';
import 'presentation/providers/notifiers/login_notifier.dart';
import 'presentation/providers/notifiers/sign_up_complete_notifier.dart';
import 'presentation/providers/notifiers/sign_up_nickname_notifier.dart';
import 'presentation/providers/notifiers/sign_up_send_code_notifier.dart';
import 'presentation/providers/notifiers/sign_up_verify_code_notifier.dart';
import 'presentation/providers/notifiers/sign_up_verify_student_notifier.dart';
import 'presentation/providers/states/login_state.dart';
import 'presentation/providers/states/sign_up_complete_state.dart';
import 'presentation/providers/states/sign_up_nickname_state.dart';
import 'presentation/providers/states/sign_up_send_code_state.dart';
import 'presentation/providers/states/sign_up_verify_code_state.dart';
import 'presentation/providers/states/sign_up_verify_student_state.dart';

//data sources
final authRemoteDataSourceProvider = Provider.autoDispose((ref) {
  return AuthRemoteDataSource(
    networkClientService: ref.watch(networkClientServiceProvider),
  );
});

//repositories
final authRepositoryImplProvider = Provider.autoDispose((ref) {
  return AuthRepositoryImpl(
      authRemoteDataSource: ref.watch(authRemoteDataSourceProvider));
});

//use cases
final loginUseCaseProvider = Provider.autoDispose(
  (ref) => LoginUseCase(
    authRepository: ref.watch(authRepositoryImplProvider),
  ),
);

final signUpVerifyStudentUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpVerifyStudentUseCase(
    authRepository: ref.watch(authRepositoryImplProvider),
  ),
);

final signUpSendCodeUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpSendCodeUseCase(
    authRepository: ref.watch(authRepositoryImplProvider),
  ),
);

final signUpVerifyCodeUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpVerifyCodeUseCase(
    authRepository: ref.watch(authRepositoryImplProvider),
  ),
);

final signUpVerifyNicknameUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpVerifyNicknameUseCase(
    authRepository: ref.watch(authRepositoryImplProvider),
  ),
);

final signUpConfirmNicknameUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpConfirmNicknameUseCase(
    signUpVerifyNicknameUseCase: ref.watch(signUpVerifyNicknameUseCaseProvider),
  ),
);

final signUpCompleteUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpCompleteUseCase(
    authRepository: ref.watch(authRepositoryImplProvider),
  ),
);

//states
final loginProvider = NotifierProvider.autoDispose<LoginNotifier, LoginState>(
  () => LoginNotifier(),
);

final signUpPolicyProvider = StateProvider.autoDispose<bool>((ref) => false);

final signUpVerifyStudentProvider = NotifierProvider.autoDispose<
    SignUpVerifyStudentNotifier, SignUpVerifyStudentState>(
  () => SignUpVerifyStudentNotifier(),
);

final signUpSendCodeProvider =
    NotifierProvider.autoDispose<SignUpSendCodeNotifier, SignUpSendCodeState>(
  () => SignUpSendCodeNotifier(),
);

final signUpVerifyCodeProvider = NotifierProvider.autoDispose<
    SignUpVerifyCodeNotifier, SignUpVerifyCodeState>(
  () => SignUpVerifyCodeNotifier(),
);

final signUpNicknameProvider =
    NotifierProvider.autoDispose<SignUpNicknameNotifier, SignUpNicknameState>(
  () => SignUpNicknameNotifier(),
);

final signUpCompleteProvider =
    NotifierProvider.autoDispose<SignUpCompleteNotifier, SignUpCompleteState>(
  () => SignUpCompleteNotifier(),
);

