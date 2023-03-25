import '../model/register_model.dart';
import '../provider/register_provider.dart';

class RegisterRepository {
  final RegisterProvider _registerProvider;

  static final RegisterRepository _singleton =
      RegisterRepository.internal(RegisterProvider());

  RegisterRepository.internal(this._registerProvider);

  factory RegisterRepository() => _singleton;

  Future<RegisterModel?> studentAuthenticate(String id, String password) async {
    return await _registerProvider.studentAuthenticate(id, password);
  }

  Future<RegisterModel?> register(RegisterModel registerModel) async {
    return await _registerProvider.register(registerModel);
  }

  Future<bool> sendSMSAuth(String signupToken, String phoneNumber) async {
    return await _registerProvider.sendSMSAuth(signupToken, phoneNumber);
  }

  Future<bool> verifySMSAuth(String signupToken, String code) async {
    return await _registerProvider.verifySMSAuth(signupToken, code);
  }
}
