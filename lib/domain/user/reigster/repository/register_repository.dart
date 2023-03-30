import '../model/register_model.dart';
import '../provider/register_provider.dart';

class RegisterRepository {
  final RegisterProvider _registerProvider;

  static final RegisterRepository _singleton =
      RegisterRepository.internal(RegisterProvider());

  RegisterRepository.internal(this._registerProvider);

  factory RegisterRepository() => _singleton;

  Future<RegisterModel?> studentAuth(
      {required String id, required String password}) async {
    return await _registerProvider.studentAuth(id, password);
  }

  Future<RegisterModel?> register(
      {required RegisterModel registerModel}) async {
    return await _registerProvider.register(registerModel);
  }

  Future<bool> sendAuthCodeToSMS(
      {required String signupToken, required String phoneNumber}) async {
    return await _registerProvider.sendAuthCodeToSMS(signupToken, phoneNumber);
  }

  Future<bool> verifyAuthCodeToSMS(
      {required String signupToken, required String code}) async {
    return await _registerProvider.verifyAuthCodeToSMS(signupToken, code);
  }
}
