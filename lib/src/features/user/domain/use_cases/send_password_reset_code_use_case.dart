import '../../../../core/utils/use_case.dart';
import '../repositories/user_repository.dart';

class SendPasswordResetCodeParams {
  final String phoneNumber;

  const SendPasswordResetCodeParams({
    required this.phoneNumber,
  });
}

class SendPasswordResetCodeUseCase
    extends UseCase<String, SendPasswordResetCodeParams> {
  final UserRepository userRepository;

  SendPasswordResetCodeUseCase({
    required this.userRepository,
  });

  @override
  Future<String> execute(SendPasswordResetCodeParams params) async {
    // TODO: implement execute
    return await userRepository.sendPasswordResetCode(
      phoneNumber: params.phoneNumber,
    );
  }
}
