import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_remote_repository.dart';

class SendPasswordResetCodeParams extends UseCaseParams {
  final String phoneNumber;

  const SendPasswordResetCodeParams({
    required this.phoneNumber,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [phoneNumber];
}

class SendPasswordResetCodeUseCase
    extends UseCase<String, SendPasswordResetCodeParams> {
  final AuthRemoteRepository authRemoteRepository;

  SendPasswordResetCodeUseCase({
    required this.authRemoteRepository,
  });

  @override
  Future<String> call(SendPasswordResetCodeParams params) async {
    // TODO: implement call
    return await authRemoteRepository.sendPasswordResetCode(
      phoneNumber: params.phoneNumber,
    );
  }
}
