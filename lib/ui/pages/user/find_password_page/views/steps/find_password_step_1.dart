import 'package:danvery/ui/pages/user/find_password_page/controller/find_password_page_controller.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../utils/regex/regex.dart';
import '../../../../../../utils/theme/palette.dart';
import '../../../../../widgets/modern/modern_form_button.dart';

class FindPasswordStep1 extends GetView<FindPasswordPageController> {
  const FindPasswordStep1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("입력한 번호로 인증번호를 전송합니다", style: regularStyle.copyWith(color: Palette.darkGrey)),
          const SizedBox(height: 32),
          ModernFormField(
            onTextChanged: (value) {
              controller.phoneNumber.value = value;
            },
            hint: "휴대폰 번호를 입력하세요",
          ),
          const SizedBox(height: 16),
          ModernFormButton(
            text: "인증번호 받기",
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
            },
          ),
        ],
      ),
    );
  }
}
