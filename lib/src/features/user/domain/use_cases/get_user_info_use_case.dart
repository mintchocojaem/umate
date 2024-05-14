import '../../../../core/utils/use_case.dart';
import '../models/user_info.dart';
import '../repositories/user_repository.dart';

class GetUserInfoUseCase extends UseCase<UserInfo, NoParams> {
  final UserRepository userRepository;

  GetUserInfoUseCase({
    required this.userRepository,
  });

  @override
  Future<UserInfo> execute(NoParams params) async {
    return await userRepository.getUserInfo();
  }
}
