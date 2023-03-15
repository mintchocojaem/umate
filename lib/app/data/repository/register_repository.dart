import 'package:danvery/app/data/provider/register_provider.dart';

import '../model/register_model.dart';

class RegisterRepository {
  final RegisterProvider _registerProvider = RegisterProvider();

  Future<RegisterModel?> studentAuthenticate(String id, String password) async {
    return await _registerProvider.studentAuthenticate(id, password);
  }

  Future<RegisterModel?> register(RegisterModel registerModel) async {
    return await _registerProvider.register(registerModel);
  }

}
