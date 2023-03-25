import 'package:danvery/ui/pages/auth/find_password_page/controller/find_password_page_controller.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../../../utils/regex/regex.dart';
import '../../../../../../utils/theme/palette.dart';
import '../../../../../widgets/modern/modern_form_button.dart';

class FindPasswordStep3 extends GetView<FindPasswordPageController> {
  const FindPasswordStep3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ModernFormField(
              hint: "비밀번호를 입력하세요",
              title: "",
              validateHint: "비밀번호를 재입력하세요",
              validate: true,
              isPassword: true,
              textController: controller.passwordController,
              validateController: controller.passwordValidateController,
            ),
          ),
          ModernFormButton(
            text: "완료",
            onPressed: () async {

              if (isValidPasswordFormat(controller.password) == false) {
                Get.snackbar("비밀번호 오류", "비밀번호는 영문, 숫자를 포함한 8~16자리만 사용할 수 있습니다.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Palette.darkGrey,
                    colorText: Palette.pureWhite);
                return;
              }

              if (controller.passwordValidate != controller.password) {
                Get.snackbar("비밀번호 오류", "비밀번호가 일치하지 않습니다.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Palette.darkGrey,
                    colorText: Palette.pureWhite);
                return;
              }

              controller.currentStep = 4;
            },
          ),
        ],
      ),
    );
  }
}
