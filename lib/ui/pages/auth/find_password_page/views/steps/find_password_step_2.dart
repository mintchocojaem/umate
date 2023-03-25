import 'package:danvery/ui/pages/auth/find_password_page/controller/find_password_page_controller.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../utils/regex/regex.dart';
import '../../../../../../utils/theme/palette.dart';
import '../../../../../widgets/modern/modern_form_button.dart';

class FindPasswordStep2 extends GetView<FindPasswordPageController> {
  const FindPasswordStep2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: ModernFormField(
              textController: controller.phoneNumberController,
              hint: "인증번호를 입력하세요",
            ),
          ),
          ModernFormButton(
            text: "확인",
            onPressed: () {
              if (isValidPhoneNumberFormat(controller.phoneNumber) == false) {
                Get.snackbar("인증번호 오류", "인증번호를 올바르게 입력해주세요.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Palette.darkGrey,
                    colorText: Palette.pureWhite);
              }
            },
          ),
        ],
      ),
    );
  }
}
