
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/user_remote_repository.dart';
import '../models/user_info.dart';

part 'user_use_cases.g.dart';

@riverpod
UserUseCases userUseCases(UserUseCasesRef ref) {
  return UserUseCases(
    userRemoteRepository: ref.watch(userRemoteRepositoryProvider),
  );
}
class UserUseCases{

  final UserRemoteRepository userRemoteRepository;

  UserUseCases({
    required this.userRemoteRepository,
  });

  Future<UserInfo> getUserInfo() async {
    return await userRemoteRepository.getUserInfo();
  }

  Future<bool> deleteUser() async {
    return await userRemoteRepository.deleteUser();
  }
}