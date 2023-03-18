

import '../model/login_model.dart';
import '../provider/login_provider.dart';

class LoginRepository {
  final LoginProvider loginProvider;

  LoginRepository({required this.loginProvider});

  //get login
  Future<LoginModel?> login(String classId, String password) async{
    return await loginProvider.getLogin(classId, password);
  }

}
