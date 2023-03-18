import 'package:get/get.dart';

import '../model/register_model.dart';
import '../repository/register_repository.dart';

class RegisterController extends GetxController{

  final RegisterRepository registerRepository;

  RegisterController({required this.registerRepository});

  final Rx<RegisterModel> _registerModel = RegisterModel().obs;
  final RxBool _isStudentAuthenticated = false.obs;
  final RxBool _isRegistered = false.obs;

  RegisterModel get registerModel => _registerModel.value;

  bool get isStudentAuthenticated => _isStudentAuthenticated.value;
  bool get isRegistered => _isRegistered.value;

  Future<bool> studentAuthenticate(String id, String password) async{
    await registerRepository.studentAuthenticate(id, password).then((value) {

      if(value == null){
        _isStudentAuthenticated.value = false;
      }else{
        _registerModel.value = value;
        _isStudentAuthenticated.value = true;
      }

    });
    return _isStudentAuthenticated.value;
  }

  Future<bool> register(RegisterModel registerModel) async{
    await registerRepository.register(registerModel).then((value) {

      if(value == null){
        _isRegistered.value = false;
      }else{
        _registerModel.value = value;
        _isRegistered.value = true;
      }

    });
    return _isStudentAuthenticated.value;
  }

  Future<bool> sendSMSAuth(String signupToken , String phoneNumber) async {
    try {
      final bool isSend = await registerRepository.sendSMSAuth(signupToken, phoneNumber);
      return isSend;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifySMSAuth(String signupToken, String code) async {
    try {
      final bool isVerify = await registerRepository.verifySMSAuth(signupToken, code);
      return isVerify;
    } catch (e) {
      return false;
    }
  }

}
