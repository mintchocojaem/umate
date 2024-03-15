import '../../../../core/utils/use_case.dart';
import '../repositories/auth_repository.dart';

class SignUpSendCodeParams {
  final String signUpToken;
  final String phoneNumber;

  SignUpSendCodeParams({
    required this.signUpToken,
    required this.phoneNumber,
  });
}

class SignUpSendCodeUseCase extends UseCase<bool, SignUpSendCodeParams> {
  final AuthRepository authRepository;

  SignUpSendCodeUseCase({
    required this.authRepository,
  });

  @override
  Future<bool> execute(SignUpSendCodeParams params) async{
    // TODO: implement execute
    return await authRepository.signUpSendCode(
      signUpToken: params.signUpToken,
      phoneNumber: params.phoneNumber,
    );
  }
}
