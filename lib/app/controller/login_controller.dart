import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../data/model/login_model.dart';
import '../data/repository/login_repository.dart';

class LoginController extends GetxController{
  // Path: lib/app/controller/login_controller.dart
  static LoginController get to => Get.find();

  final LoginRepository loginRepository;

  LoginController({required this.loginRepository});

  final Rx<LoginModel> _loginModel = LoginModel().obs;
  final RxBool _isLogin = false.obs;
  final RxBool _isLoading = false.obs; //login 결과를 불러왔으면 false 아니면 true

  LoginModel get loginModel => _loginModel.value;

  bool get isLogin => _isLogin.value;
  bool get isLoading => _isLoading.value;

  Future<bool> login(String classId, String password) async{
    await loginRepository.login(classId, password).then((value) {
      if(value == null){
        _isLogin.value = false;
        _isLoading.value = false;
      }else{
        _loginModel.value = value;
        _isLogin.value = true;
        _isLoading.value = false;
      }
    });
    return _isLogin.value;
  }

}
