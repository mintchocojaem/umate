import '../model/register_model.dart';
import '../provider/register_provider.dart';

class RegisterRepository {
  final RegisterProvider _registerProvider;

  static final RegisterRepository _singleton =
      RegisterRepository.internal(RegisterProvider());

  RegisterRepository.internal(this._registerProvider);

  factory RegisterRepository() => _singleton;

  Future<RegisterModel?> studentAuthenticate(
      {required String id, required String password}) async {
    return await _registerProvider.studentAuthenticate(id, password);
  }

  Future<RegisterModel?> register({required RegisterModel registerModel}) async {
    return await _registerProvider.register(registerModel);
  }

  Future<bool> sendSMSAuth({required String signupToken,required String phoneNumber}) async {
    return await _registerProvider.sendSMSAuth(signupToken, phoneNumber);
  }

  Future<bool> verifySMSAuth({required String signupToken,required String code}) async {
    return await _registerProvider.verifySMSAuth(signupToken, code);
  }
}
