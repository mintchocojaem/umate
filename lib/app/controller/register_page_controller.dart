import 'package:get/get.dart';


class RegisterPageController extends GetxController {

  final RxInt _currentStep = 1.obs;

  final RxBool _check1 = false.obs;
  final RxBool _check2 = false.obs;

  bool get check1 => _check1.value;
  bool get check2 => _check2.value;
  int get currentStep => _currentStep.value;

  set check1(index) => _check1.value = index;
  set check2(index) => _check2.value = index;
  set currentStep(index) => _currentStep.value = index;

}
