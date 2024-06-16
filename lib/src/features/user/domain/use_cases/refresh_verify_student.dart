import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_remote_repository.dart';

final refreshVerifyStudentProvider =
    Provider.autoDispose.family<Future<bool>, RefreshVerifyStudentParams>(
  (ref, params) => RefreshVerifyStudent(
    authRemoteRepository: ref.read(authRemoteRepositoryProvider),
  )(params),
);

class RefreshVerifyStudentParams extends UseCaseParams {
  final String dkuStudentId;
  final String dkuPassword;

  const RefreshVerifyStudentParams({
    required this.dkuStudentId,
    required this.dkuPassword,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [dkuStudentId, dkuPassword];
}

class RefreshVerifyStudent extends UseCase<bool, RefreshVerifyStudentParams> {
  final AuthRemoteRepository authRemoteRepository;

  RefreshVerifyStudent({
    required this.authRemoteRepository,
  });

  @override
  Future<bool> call(RefreshVerifyStudentParams params) async {
    // TODO: implement call
    return await authRemoteRepository.refreshStudent(
      dkuStudentId: params.dkuStudentId,
      dkuPassword: params.dkuPassword,
    );
  }
}
