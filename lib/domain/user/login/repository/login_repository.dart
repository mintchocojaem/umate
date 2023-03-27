import '../model/login_model.dart';
import '../provider/login_provider.dart';

class LoginRepository {

  final LoginProvider _loginProvider;

  LoginRepository._internal(this._loginProvider);

  static final LoginRepository _singleton =
      LoginRepository._internal(LoginProvider());

  factory LoginRepository() => _singleton;

  //get login
  Future<LoginModel?> login({required String classId, required String password}) async {
    return await _loginProvider.getLogin(classId, password);
  }
}
