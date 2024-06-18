import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/user_remote_repository.dart';

final deleteUserProvider = Provider.autoDispose.family<Future<bool>, NoParams>(
  (ref, params) => DeleteUser(
    userRemoteRepository: ref.watch(userRemoteRepositoryProvider),
  )(params),
);

class DeleteUser extends UseCase<bool, NoParams> {
  final UserRemoteRepository userRemoteRepository;

  DeleteUser({
    required this.userRemoteRepository,
  });

  @override
  Future<bool> call(NoParams params) async {
    // TODO: implement call
    return await userRemoteRepository.deleteUser();
  }
}
