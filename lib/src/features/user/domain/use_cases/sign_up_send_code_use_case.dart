import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/use_case.dart';
import '../repositories/user_repository.dart';

class SignUpSendCodeParams {
  final String signUpToken;
  final String phoneNumber;

  const SignUpSendCodeParams({
    required this.signUpToken,
    required this.phoneNumber,
  });
}

class SignUpSendCodeUseCase extends UseCase<bool, SignUpSendCodeParams> {
  final UserRepository userRepository;

  SignUpSendCodeUseCase({
    required this.userRepository,
  });

  @override
  Future<bool> execute(SignUpSendCodeParams params) async {
    // TODO: implement execute

    if (params.phoneNumber.isEmpty) {
      throw AppError(
        message: '전화번호를 입력해주세요.',
        stackTrace: StackTrace.current,
      );
    }

    return await userRepository.signUpSendCode(
      signUpToken: params.signUpToken,
      phoneNumber: params.phoneNumber,
    );
  }
}
