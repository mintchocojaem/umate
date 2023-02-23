import 'package:danvery/app/data/repository/login_repository.dart';
import 'package:get/get.dart';

import '../data/model/login_model.dart';

class MainController extends GetxController{
  final LoginRepository loginRepository;

  MainController({required this.loginRepository});

  @override
  void onInit() {
    getLogin('17011092', '99730567');
    super.onInit();
  }

  final RxInt _selectedIndex = 0.obs;
  final Rx<LoginModel> _loginModel = LoginModel().obs;
  final RxBool _isLogin = false.obs;

  int get selectedIndex => _selectedIndex.value;

  LoginModel get loginModel => _loginModel.value;

  set selectedIndex(index) => _selectedIndex.value = index;

  bool get isLogin => _isLogin.value;

  void getLogin(String classId, String password) {
    loginRepository.login(classId, password).then((value) {
      _loginModel.value = value;
      _isLogin.value = true;
    });
  }

}
