import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_remote_repository.dart';

class SendStudentIdParams extends UseCaseParams {
  final String phoneNumber;

  const SendStudentIdParams({
    required this.phoneNumber,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [phoneNumber];
}

class SendStudentIdUseCase extends UseCase<bool, SendStudentIdParams> {
  final AuthRemoteRepository authRemoteRepository;

  SendStudentIdUseCase({
    required this.authRemoteRepository,
  });

  @override
  Future<bool> call(SendStudentIdParams params) async {
    // TODO: implement call
    return await authRemoteRepository.sendStudentId(
      phoneNumber: params.phoneNumber,
    );
  }
}
