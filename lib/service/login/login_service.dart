import 'package:danvery/domain/user/login/model/login_model.dart';
import 'package:danvery/domain/user/login/repository/login_repository.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginService extends GetxService {
  static final LoginService _singleton = LoginService._internal();

  LoginService._internal();

  factory LoginService() => _singleton;

  final LoginRepository _loginRepository = LoginRepository();

  final Rx<LoginModel> _loginModel = LoginModel().obs;
  final RxBool isLogin = false.obs;

  LoginModel get loginModel => _loginModel.value;

  Future<bool> login(String classId, String password) async {
    final GetStorage box = GetStorage();
    await _loginRepository
        .login(classId: classId, password: password)
        .then((value) {
      if (value.success) {
        _loginModel.value = value.data as LoginModel;
        isLogin.value = true;
      }
      else {
        isLogin.value = false;
        GetXSnackBar(
          type: GetXSnackBarType.customError,
          title: "로그인 실패",
          content: value.message,
        ).show();
      }
    });
    return isLogin.value;
  }
}
