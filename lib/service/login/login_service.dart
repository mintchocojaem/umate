import 'package:danvery/domain/user/login/model/login_model.dart';
import 'package:danvery/domain/user/login/model/token_model.dart';
import 'package:danvery/domain/user/login/model/user_info_model.dart';
import 'package:danvery/domain/user/login/repository/login_repository.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginService extends GetxService {
  static final LoginService _singleton = LoginService._internal();

  LoginService._internal();

  factory LoginService() => _singleton;

  final LoginRepository _loginRepository = LoginRepository();

  late Rx<LoginModel> loginModel;
  final RxBool isLogin = false.obs;

  final GetStorage _box = GetStorage();

  Future<void> login(String classId, String password) async {
    await _loginRepository
        .login(classId: classId, password: password)
        .then((apiResponse) async {
      if (apiResponse.success) {
        loginModel = (apiResponse.data as LoginModel).obs;
        _box.write("accessToken", apiResponse.data.accessToken);
        _box.write("refreshToken", apiResponse.data.refreshToken);
        isLogin.value = true;
      } else {
        isLogin.value = false;
        GetXSnackBar(
          type: GetXSnackBarType.customError,
          title: "로그인 실패",
          content: apiResponse.message,
        ).show();
      }
    });
  }

  Future<void> autoLogin(String accessToken, String refreshToken) async {
    await _loginRepository
        .reissueToken(accessToken: accessToken, refreshToken: refreshToken)
        .then((token) async {
      if (token.success) {

        final TokenModel tokenModel = token.data as TokenModel;

        await _getUserInfo(token.data.accessToken).then((userInfo){
          final UserInfoModel? userInfoModel = userInfo;
          if(userInfoModel != null){
            loginModel= LoginModel(
              accessToken: tokenModel.accessToken,
              refreshToken: tokenModel.refreshToken,
              studentId: userInfoModel.studentId,
              username: userInfoModel.username,
              major: userInfoModel.major,
              nickname: userInfoModel.nickname,
              department: userInfoModel.department,
              admin: false,
            ).obs;
            isLogin.value = true;

          }else{
            isLogin.value = false;
          }

        });
      } else {
        isLogin.value = false;
       _box.remove("accessToken");
       _box.remove("refreshToken");
      }
    });
  }

  Future<UserInfoModel?> _getUserInfo(String accessToken) async {
    return await _loginRepository
        .getUserInfo(accessToken: accessToken)
        .then((apiResponse) async {
      if (apiResponse.success) {
        final UserInfoModel userInfoModel = apiResponse.data as UserInfoModel;
        return userInfoModel;
      } else {
        GetXSnackBar(
          type: GetXSnackBarType.customError,
          title: "로그인 실패",
          content: apiResponse.data.message,
        ).show();
        return null;
      }
    });
  }

}
