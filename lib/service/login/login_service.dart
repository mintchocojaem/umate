import 'package:danvery/domain/user/login/model/login_model.dart';
import 'package:danvery/domain/user/login/repository/login_repository.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:get/get.dart';

class LoginService extends GetxService {
  static final LoginService _singleton = LoginService._internal();

  LoginService._internal();

  factory LoginService() => _singleton;

  final LoginRepository _loginRepository = LoginRepository();

  final Rx<LoginModel> _loginModel = LoginModel().obs;
  final RxBool _isLogin = false.obs;
  final RxBool _isLoading = false.obs; //login 결과를 불러왔으면 false 아니면 true

  LoginModel get loginModel => _loginModel.value;

  bool get isLogin => _isLogin.value;

  bool get isLoading => _isLoading.value;

  Future<bool> login(String classId, String password) async {
    await _loginRepository
        .login(classId: classId, password: password)
        .then((value) {
      if (value.success) {
        _loginModel.value = value.data as LoginModel;
        _isLogin.value = true;
        _isLoading.value = false;
      } else {
        _isLogin.value = false;
        _isLoading.value = false;
        GetXSnackBar(
          type: GetXSnackBarType.customError,
          title: "로그인 실패",
          content: value.message,
        ).show();
      }
    });
    return _isLogin.value;
  }

}
