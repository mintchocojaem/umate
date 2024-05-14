import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../init_dependency_injections.dart';
import 'data/data_sources/remote_user_data_source.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/use_cases/delete_user_use_case.dart';
import 'domain/use_cases/get_user_info_use_case.dart';
import 'domain/use_cases/login_use_case.dart';
import 'domain/use_cases/refresh_student_use_case.dart';
import 'domain/use_cases/reissue_token_use_case.dart';
import 'domain/use_cases/reset_password_use_case.dart';
import 'domain/use_cases/send_password_reset_code_use_case.dart';
import 'domain/use_cases/send_student_id_use_case.dart';
import 'domain/use_cases/sign_up_confirm_nickname_use_case.dart';
import 'domain/use_cases/sign_up_send_code_use_case.dart';
import 'domain/use_cases/sign_up_use_case.dart';
import 'domain/use_cases/sign_up_verify_code_use_case.dart';
import 'domain/use_cases/sign_up_verify_nickname_use_case.dart';
import 'domain/use_cases/sign_up_verify_student_use_case.dart';
import 'domain/use_cases/verify_password_reset_code_use_case.dart';
import 'presentation/providers/notifiers/find_password_notiifer.dart';
import 'presentation/providers/notifiers/find_studentId_notiifer.dart';
import 'presentation/providers/notifiers/login_notifier.dart';
import 'presentation/providers/notifiers/sign_up_notifier.dart';
import 'presentation/providers/notifiers/verify_student_notifier.dart';
import 'presentation/providers/notifiers/user_info_notifier.dart';
import 'presentation/providers/states/find_password_state.dart';
import 'presentation/providers/states/find_student_id_state.dart';
import 'presentation/providers/states/login_state.dart';
import 'presentation/providers/states/sign_up_state.dart';
import 'presentation/providers/states/verify_student_state.dart';
import 'presentation/providers/states/user_info_state.dart';

final userRemoteDataSourceProvider = Provider.autoDispose<RemoteUserDataSource>(
  (ref) {
    return RemoteUserDataSource(
      networkClientService: ref.watch(networkClientServiceProvider),
    );
  },
);

final userRepositoryProvider = Provider.autoDispose<UserRepositoryImpl>(
  (ref) {
    return UserRepositoryImpl(
      remoteUserDataSource: ref.watch(userRemoteDataSourceProvider),
    );
  },
);

//use cases

final reissueTokenUseCaseProvider = Provider.autoDispose(
  (ref) => ReissueTokenUseCase(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

final loginUseCaseProvider = Provider.autoDispose(
  (ref) => LoginUseCase(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

final signUpVerifyStudentUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpVerifyStudentUseCase(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

final refreshStudentUseCaseProvider = Provider.autoDispose(
  (ref) => RefreshStudentUseCase(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

final signUpSendCodeUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpSendCodeUseCase(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

final signUpVerifyCodeUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpVerifyCodeUseCase(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

final signUpVerifyNicknameUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpVerifyNicknameUseCase(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

final signUpConfirmNicknameUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpConfirmNicknameUseCase(
    signUpVerifyNicknameUseCase: ref.watch(signUpVerifyNicknameUseCaseProvider),
  ),
);

final signUpUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpUseCase(
    userRepository: ref.watch(userRepositoryProvider),
    signUpVerifyCodeUseCase: ref.watch(signUpVerifyCodeUseCaseProvider),
    signUpVerifyNicknameUseCase: ref.watch(signUpVerifyNicknameUseCaseProvider),
  ),
);

//states
final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  () => LoginNotifier(),
);

final signUpProvider =
    NotifierProvider.autoDispose<SignUpNotifier, SignUpState>(
  () => SignUpNotifier(),
);

final verifyStudentProvider = NotifierProvider.autoDispose<
    VerifyStudentNotifier, VerifyStudentState>(
  () => VerifyStudentNotifier(),
);

final refreshStudentProvider = Provider.autoDispose(
  (ref) => RefreshStudentUseCase(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

final getUserInfoUseCaseProvider = Provider.autoDispose<GetUserInfoUseCase>(
  (ref) {
    return GetUserInfoUseCase(
      userRepository: ref.watch(userRepositoryProvider),
    );
  },
);

final deleteUserUseCaseProvider = Provider.autoDispose<DeleteUserUseCase>(
  (ref) {
    return DeleteUserUseCase(
      userRepository: ref.watch(userRepositoryProvider),
    );
  },
);

final sendStudentIdUseCaseProvider = Provider.autoDispose(
  (ref) => SendStudentIdUseCase(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

final sendPasswordResetCodeUseCaseProvider = Provider.autoDispose(
  (ref) => SendPasswordResetCodeUseCase(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

final verifyPasswordResetCodeUseCaseProvider = Provider.autoDispose(
  (ref) => VerifyPasswordResetCodeUseCase(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

final resetPasswordUseCaseProvider = Provider.autoDispose(
  (ref) => ResetPasswordUseCase(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

final findStudentIdProvider =
    NotifierProvider.autoDispose<FindStudentIdNotifier, FindStudentIdState>(
  () {
    return FindStudentIdNotifier();
  },
);

final findPasswordProvider =
    NotifierProvider.autoDispose<FindPasswordNotifier, FindPasswordState>(
  () {
    return FindPasswordNotifier();
  },
);

final userInfoProvider =
    NotifierProvider.autoDispose<UserInfoNotifier, UserInfoState>(
  () {
    return UserInfoNotifier();
  },
);
