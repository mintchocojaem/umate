import '../../../../core/utils/use_case.dart';
import '../repositories/user_repository.dart';

class DeleteUserUseCase extends UseCase<bool, NoParams> {
  final UserRepository userRepository;

  DeleteUserUseCase({
    required this.userRepository,
  });

  @override
  Future<bool> execute(NoParams params) async {
    return await userRepository.deleteUser();
  }
}
