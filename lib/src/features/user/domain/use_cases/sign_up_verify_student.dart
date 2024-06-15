import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_remote_repository.dart';
import '../models/sign_up_info.dart';

final signUpVerifyStudentProvider = Provider.autoDispose<SignUpVerifyStudent>(
  (ref) => SignUpVerifyStudent(
    authRepository: ref.watch(authRemoteRepositoryProvider),
  ),
);

class SignUpVerifyStudentParams extends UseCaseParams {
  final String dkuStudentId;
  final String dkuPassword;
  final bool isAgreePolicy;

  const SignUpVerifyStudentParams({
    required this.dkuStudentId,
    required this.dkuPassword,
    required this.isAgreePolicy,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [dkuStudentId, dkuPassword, isAgreePolicy];
}

class SignUpVerifyStudent
    extends UseCase<SignUpInfo, SignUpVerifyStudentParams> {
  final AuthRemoteRepository authRepository;

  SignUpVerifyStudent({
    required this.authRepository,
  });

  @override
  Future<SignUpInfo> call(SignUpVerifyStudentParams params) async {
    // TODO: implement call
    if (!params.isAgreePolicy) {
      throw AppWarning(
        message: '개인정보 이용약관에 동의가 필요해요.',
        stackTrace: StackTrace.current,
      );
    }

    return await authRepository.signUpVerifyStudent(
      dkuStudentId: params.dkuStudentId,
      dkuPassword: params.dkuPassword,
    );
  }
}
