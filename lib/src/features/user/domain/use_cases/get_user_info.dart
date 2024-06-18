import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/user_remote_repository.dart';
import '../models/user_info.dart';

final getUserInfoProvider =
    Provider.autoDispose.family<Future<UserInfo>, NoParams>(
  (ref, params) => GetUserInfo(
    userRemoteRepository: ref.watch(userRemoteRepositoryProvider),
  )(params),
);

class GetUserInfo extends UseCase<UserInfo, NoParams> {
  final UserRemoteRepository userRemoteRepository;

  GetUserInfo({
    required this.userRemoteRepository,
  });

  @override
  Future<UserInfo> call(NoParams params) async {
    // TODO: implement call
    return await userRemoteRepository.getUserInfo();
  }
}
