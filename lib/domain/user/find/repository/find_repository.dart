import 'package:danvery/domain/user/find/provider/find_provider.dart';

class FindRepository {
  final FindProvider _findProvider;

  static final FindRepository _singleton =
      FindRepository.internal(FindProvider());

  FindRepository.internal(this._findProvider);

  factory FindRepository() => _singleton;

  Future<bool> sendIdToSMS({required String phoneNumber}) async {
    return await _findProvider.sendIdToSMS(phoneNumber);
  }

  Future<String?> sendAuthCodeToSMS({required String phoneNumber}) async {
    return await _findProvider.sendAuthCodeToSMS(phoneNumber);
  }

  Future<bool> verifyAuthCode(
      {required String token, required String code}) async {
    return await _findProvider.verifyAuthCode(token, code);
  }

  Future<bool> changePassword(
      {required String token, required String password}) async {
    return await _findProvider.changePassword(token, password);
  }
}
