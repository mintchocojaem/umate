import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/user/login/model/token_model.dart';
import 'package:danvery/domain/user/login/model/user_info_model.dart';
import 'package:danvery/domain/user/login/repository/login_repository.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginService extends GetxService {
  static final LoginService _singleton = LoginService._internal();

  LoginService._internal();

  factory LoginService() => _singleton;

  final LoginRepository _loginRepository = LoginRepository();

  late Rx<TokenModel> token;
  late Rx<UserInfoModel> userInfo;
  final RxBool isLogin = false.obs;

  final GetStorage _box = GetStorage();

  Future<void> login(String classId, String password) async {
    final apiResponse =
        await _loginRepository.login(classId: classId, password: password);
    if (apiResponse.success) {
      final TokenModel tokenModel = apiResponse.data as TokenModel;
      token = tokenModel.obs;
      if(await getUserInfo()){
        _box.write("accessToken", token.value.accessToken);
        _box.write("refreshToken", token.value.refreshToken);
       isLogin.value = true;
      }else{
        isLogin.value = false;
      }
    } else {
      isLogin.value = false;
      GetXSnackBar(
        type: GetXSnackBarType.customError,
        title: "로그인 실패",
        content: apiResponse.message,
      ).show();
    }
  }

  Future<void> autoLogin(String accessToken, String refreshToken) async {
    final ApiResponseDTO apiResponseDTO = await _loginRepository.reissueToken(
        accessToken: accessToken, refreshToken: refreshToken);
    if (apiResponseDTO.success) {
      final TokenModel tokenModel = apiResponseDTO.data as TokenModel;
      token = tokenModel.obs;
      if(await getUserInfo()){
        isLogin.value = true;
      }else{
        isLogin.value = false;
      }
    } else {
      isLogin.value = false;
      _box.remove("accessToken");
      _box.remove("refreshToken");
    }
  }

  Future<void> logout() async{
    _box.remove("accessToken");
    _box.remove("refreshToken");
    isLogin.value = false;
    Get.offAllNamed(Routes.login);
  }

  Future<bool> getUserInfo() async {
    final apiResponse =
        await _loginRepository.getUserInfo(accessToken: token.value.accessToken);
    if (apiResponse.success) {
      final UserInfoModel userInfoModel = apiResponse.data as UserInfoModel;
      userInfo = UserInfoModel(
        studentId: userInfoModel.studentId,
        username: userInfoModel.username,
        major: userInfoModel.major,
        nickname: userInfoModel.nickname,
        department: userInfoModel.department,
        admin: userInfoModel.admin,
        writeCount: userInfoModel.writeCount,
        commentCount: userInfoModel.commentCount,
        likeCount: userInfoModel.likeCount,
      ).obs;
      return true;
    } else {
      GetXSnackBar(
        type: GetXSnackBarType.customError,
        title: "유저정보 불러오기 실패",
        content: apiResponse.data.message,
      ).show();
      return false;
    }
  }
}
