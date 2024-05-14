import '../../../../core/utils/use_case.dart';
import '../repositories/user_repository.dart';

class SendStudentIdParams {
  final String phoneNumber;

  const SendStudentIdParams({
    required this.phoneNumber,
  });
}

class SendStudentIdUseCase extends UseCase<bool, SendStudentIdParams> {
  final UserRepository userRepository;

  SendStudentIdUseCase({
    required this.userRepository,
  });

  @override
  Future<bool> execute(SendStudentIdParams params) async {
    // TODO: implement execute
    return await userRepository.sendStudentId(phoneNumber: params.phoneNumber);
  }
}
