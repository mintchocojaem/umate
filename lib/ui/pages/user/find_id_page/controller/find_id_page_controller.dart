import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/user/info/repository/userInfo_repository.dart';
import 'package:danvery/ui/pages/user/find_id_page/views/steps/find_id_step_1.dart';
import 'package:danvery/ui/pages/user/find_id_page/views/steps/find_id_step_2.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindIdPageController extends GetxController {
  final UserInfoRepository _userInfoRepository = UserInfoRepository();

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

  Future<bool> sendIdToPhoneNumber(String phoneNumber) async{
    final ApiResponseDTO apiResponseDTO = await _userInfoRepository.sendIdToSMS(phoneNumber: phoneNumber);
    if(apiResponseDTO.success) {
      return true;
    } else {
      GetXSnackBar(
        type: GetXSnackBarType.customError,
        title: "아이디 찾기 오류",
        content: apiResponseDTO.message,
      ).show();
      return false;
    }
  }

}
