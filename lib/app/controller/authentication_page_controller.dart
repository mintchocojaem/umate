import 'package:get/get.dart';

class AuthenticationPageController extends GetxController {

  final RxBool _check1 = false.obs;
  final RxBool _check2 = false.obs;

  bool get check1 => _check1.value;
  bool get check2 => _check2.value;

  set check1(index) => _check1.value = index;
  set check2(index) => _check2.value = index;


}
