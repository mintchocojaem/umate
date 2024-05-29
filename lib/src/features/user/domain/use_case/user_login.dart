import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repository/user_repository.dart';
import '../model/token.dart';

final userLoginProvider = Provider.autoDispose<UserLogin>(
  (ref) => UserLogin(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

class UserLoginParams extends UseCaseParams {
  final String studentId;
  final String password;

  UserLoginParams({
    required this.studentId,
    required this.password,
  });
}

class UserLogin extends UseCase<Token, UserLoginParams> {
  final UserRepository userRepository;

  UserLogin({
    required this.userRepository,
  });

  @override
  Future<Token> execute(UserLoginParams params) async {
    // TODO: implement execute
    return await userRepository.login(
      studentId: params.studentId,
      password: params.password,
    );
  }
}
