import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_remote_repository.dart';

final sendStudentIdProvider =
    Provider.autoDispose.family<Future<bool>, SendStudentIdParams>(
  (ref, params) => SendStudentId(
    authRemoteRepository: ref.watch(authRemoteRepositoryProvider),
  )(params),
);

class SendStudentIdParams extends UseCaseParams {
  final String phoneNumber;

  const SendStudentIdParams({
    required this.phoneNumber,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [phoneNumber];
}

class SendStudentId extends UseCase<bool, SendStudentIdParams> {
  final AuthRemoteRepository authRemoteRepository;

  SendStudentId({
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
