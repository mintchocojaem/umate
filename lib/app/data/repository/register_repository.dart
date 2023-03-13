import 'package:danvery/app/data/provider/register_provider.dart';

import '../model/register_model.dart';

class RegisterRepository {
  final RegisterProvider _registerProvider = RegisterProvider();

  Future<RegisterModel?> authenticate(
      {required String id, required String password}) async {
    return await _registerProvider.authentication(id, password);
  }
}
