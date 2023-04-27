import 'package:danvery/core/regex/regex.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/pages/user/find_password_page/controller/find_password_page_controller.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FindPasswordStep1 extends GetView<FindPasswordPageController> {
  const FindPasswordStep1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("입력한 번호로 인증번호를 전송합니다",
              style: regularStyle.copyWith(color: Palette.darkGrey)),
          const SizedBox(height: 32),
          ModernFormField(
            keyboardType: TextInputType.phone,
            onTextChanged: (value) {
              controller.phoneNumberController.update((val) {
                if (val != null) {
                  val.text = value;
                }
              });
            },
            hint: "휴대폰 번호를 입력하세요",
          ),
          const SizedBox(height: 16),
          Obx(
            () => ModernFormButton(
              isEnabled: controller.phoneNumberController.value.text.isNotEmpty,
              text: "인증번호 받기",
              onPressed: () async {
                if (!phoneNumberCheckRegExp
                    .hasMatch(controller.phoneNumberController.value.text)) {
                  GetXSnackBar(type: GetXSnackBarType.phoneNumberError).show();
                  return;
                }

                if (await controller.sendAuthCodeToSMS()) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.currentStep.value = 2;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
