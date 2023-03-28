import 'package:danvery/ui/pages/user/find_id_page/controller/find_id_page_controller.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:danvery/utils/regex/regex.dart';
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindIdStep1 extends GetView<FindIdPageController> {
  const FindIdStep1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("입력한 번호로 아이디를 전송합니다", style: regularStyle.copyWith(color: Palette.darkGrey)),
          const SizedBox(height: 32),
          ModernFormField(
            textController: controller.phoneNumberController,
            hint: "휴대폰 번호를 입력하세요",
          ),
          const SizedBox(height: 16),
          ModernFormButton(
            text: "아이디 찾기",
            onPressed: () {
              if (isValidPhoneNumberFormat(controller.phoneNumber.value) == false) {
                Get.snackbar("휴대폰 번호 오류", "휴대폰 번호를 올바르게 입력해주세요.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Palette.darkGrey,
                    colorText: Palette.pureWhite);
                return;
              }
              FocusManager.instance.primaryFocus?.unfocus();
              controller.currentStep.value = 2;
              /*
              controller.sendId().then((value){
                if(value == true){
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.currentStep = 2;
                }else{
                  Get.snackbar("아이디 찾기 오류", "해당 휴대폰 번호로 가입된 아이디가 존재하지 않습니다.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Palette.darkGrey,
                      colorText: Palette.pureWhite);
                }
              });

               */
            },
          ),
        ],
      ),
    );
  }
}
