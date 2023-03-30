import 'package:danvery/domain/user/find/repository/find_repository.dart';
import 'package:danvery/ui/pages/user/find_id_page/views/steps/find_id_step_1.dart';
import 'package:danvery/ui/pages/user/find_id_page/views/steps/find_id_step_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FindIdPageController extends GetxController {

  final FindRepository _findRepository = FindRepository();

  List<String> stepTitle = [
    "휴대폰 번호 입력",
    "아이디가 전송되었습니다",
  ];

  List<Widget> pages = const [
    FindIdStep1(),
    FindIdStep2(),
  ];

  final PageController pageController = PageController();

  final RxInt currentStep = 1.obs;

  final RxString phoneNumber = "".obs;

  Future<bool> sendIdToPhoneNumber(String phoneNumber) {
    return _findRepository.sendIdToSMS(phoneNumber: phoneNumber);
  }

}
