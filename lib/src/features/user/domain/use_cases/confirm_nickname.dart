import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/use_case.dart';
import 'verify_nickname.dart';

final confirmNicknameProvider = Provider.autoDispose<ConfirmNickname>(
  (ref) => ConfirmNickname(
    verifyNickname: ref.watch(verifyNicknameProvider),
  ),
);

class ConfirmNicknameParams extends UseCaseParams {
  final String verifiedNickname;
  final String currentNickname;

  const ConfirmNicknameParams({
    required this.verifiedNickname,
    required this.currentNickname,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [verifiedNickname, currentNickname];
}

class ConfirmNickname extends UseCase<bool, ConfirmNicknameParams> {
  final VerifyNickname verifyNickname;

  ConfirmNickname({
    required this.verifyNickname,
  });

  @override
  Future<bool> call(ConfirmNicknameParams params) async {
    // TODO: implement call
    if (params.verifiedNickname != params.currentNickname) {
      throw AppWarning(
        message: '닉네임 중복을 확인해주세요',
        stackTrace: StackTrace.current,
      );
    }

    final isNicknameVerified = await verifyNickname(
      VerifyNicknameParams(nickname: params.verifiedNickname),
    );

    /*
    if (isNicknameVerified.isFailure) {
      throw isNicknameVerified.failure;
    }

     */

    return true;
  }
}
