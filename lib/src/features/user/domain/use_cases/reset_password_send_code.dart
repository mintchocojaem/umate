import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_remote_repository.dart';

final sendPasswordResetCodeProvider =
    Provider.autoDispose.family<Future<String>, SendPasswordResetCodeParams>(
  (ref, params) => SendPasswordResetCode(
    authRemoteRepository: ref.watch(authRemoteRepositoryProvider),
  )(params),
);

class SendPasswordResetCodeParams extends UseCaseParams {
  final String phoneNumber;

  const SendPasswordResetCodeParams({
    required this.phoneNumber,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [phoneNumber];
}

class SendPasswordResetCode
    extends UseCase<String, SendPasswordResetCodeParams> {
  final AuthRemoteRepository authRemoteRepository;

  SendPasswordResetCode({
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
