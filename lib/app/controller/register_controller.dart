import 'package:get/get.dart';

class RegisterController extends GetxController{

  final RxString _id = "".obs;
  final RxString _password = "".obs;
  final RxString _passwordCheck = "".obs;
  final RxString _name = "".obs;
  final RxString _nickname = "".obs;
  final RxString _major = "".obs;
  final RxString _phoneNumber = "".obs;
  final RxString _authCode = "".obs;

  final RxBool _isIdValid = false.obs;
  final RxBool _isPasswordValid = false.obs;
  final RxBool _isPasswordCheckValid = false.obs;
  final RxBool _isNicknameValid = false.obs;

}
