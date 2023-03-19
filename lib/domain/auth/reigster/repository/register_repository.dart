

import '../model/register_model.dart';
import '../provider/register_provider.dart';

class RegisterRepository {
  final RegisterProvider registerProvider;

  RegisterRepository({required this.registerProvider});

  Future<RegisterModel?> studentAuthenticate(String id, String password) async {
    return await registerProvider.studentAuthenticate(id, password);
  }

  Future<RegisterModel?> register(RegisterModel registerModel) async {
    return await registerProvider.register(registerModel);
  }

  Future<bool> sendSMSAuth(String signupToken, String phoneNumber) async {
    return await registerProvider.sendSMSAuth(signupToken, phoneNumber);
  }

  Future<bool> verifySMSAuth(String signupToken, String code) async {
    return await registerProvider.verifySMSAuth(signupToken, code);
  }

}
