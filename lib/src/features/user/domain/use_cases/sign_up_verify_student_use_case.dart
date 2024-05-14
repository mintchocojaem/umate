import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/use_case.dart';
import '../models/sign_up_info.dart';
import '../repositories/user_repository.dart';

class SignUpVerifyStudentParams {
  final String dkuStudentId;
  final String dkuPassword;
  final bool isAgreePolicy;

  const SignUpVerifyStudentParams({
    required this.dkuStudentId,
    required this.dkuPassword,
    required this.isAgreePolicy,
  });
}

class SignUpVerifyStudentUseCase
    extends UseCase<SignUpInfo, SignUpVerifyStudentParams> {
  final UserRepository userRepository;

  SignUpVerifyStudentUseCase({
    required this.userRepository,
  });

  @override
  Future<SignUpInfo> execute(SignUpVerifyStudentParams params) async {
    // TODO: implement execute

    if (!params.isAgreePolicy) {
      throw AppWarning(
        message: '개인정보 이용약관에 동의가 필요해요.',
        stackTrace: StackTrace.current,
      );
    }

    return await userRepository.signUpVerifyStudent(
      dkuStudentId: params.dkuStudentId,
      dkuPassword: params.dkuPassword,
    );
  }
}
