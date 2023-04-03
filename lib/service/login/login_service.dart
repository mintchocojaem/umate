import 'package:danvery/domain/user/login/model/login_model.dart';
import 'package:danvery/domain/user/login/model/token_model.dart';
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
  final RxBool isGetUserInfo = false.obs;

  LoginModel get loginModel => _loginModel.value;

  final GetStorage box = GetStorage();

  Future<void> login(String classId, String password) async {
    await _loginRepository
        .login(classId: classId, password: password)
        .then((value) async {
      if (value.success) {
        final LoginModel loginModel = value.data as LoginModel;
        _loginModel.value = loginModel;
        box.write("accessToken", value.data.accessToken);
        box.write("refreshToken", value.data.refreshToken);
        isLogin.value = true;
      } else {
        isLogin.value = false;
        GetXSnackBar(
          type: GetXSnackBarType.customError,
          title: "로그인 실패",
          content: value.message,
        ).show();
      }
    });
  }

  Future<void> autoLogin(String accessToken, String refreshToken) async {
    await _loginRepository
        .reissueToken(accessToken: accessToken, refreshToken: refreshToken)
        .then((value) async {
      if (value.success) {
        final TokenModel tokenModel = value.data as TokenModel;
        _loginModel.value.accessToken = tokenModel.accessToken;
        _loginModel.value.refreshToken = tokenModel.refreshToken;
        await _getUserInfo(value.data.accessToken).whenComplete((){
          if(isGetUserInfo.value){
            isLogin.value = true;
          }else{
            isLogin.value = false;
          }
        });
      } else {
        isLogin.value = false;
        box.remove("accessToken");
        box.remove("refreshToken");
      }
    });
  }

  Future<void> _getUserInfo(String accessToken) async {
    await _loginRepository
        .getUserInfo(accessToken: accessToken)
        .then((value) async {
      if (value.success) {
        final UserInfoModel userInfoModel = value.data as UserInfoModel;
        _loginModel.value.studentId = userInfoModel.studentId;
        _loginModel.value.userName = userInfoModel.userName;
        _loginModel.value.major = userInfoModel.major;
        isGetUserInfo.value = true;
      } else {
        isGetUserInfo.value = false;
        GetXSnackBar(
          type: GetXSnackBarType.customError,
          title: "로그인 실패",
          content: value.message,
        ).show();
      }
    });
  }

}
