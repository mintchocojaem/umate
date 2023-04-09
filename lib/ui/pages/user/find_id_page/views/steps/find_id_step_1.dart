import 'package:danvery/core/regex/regex.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/pages/user/find_id_page/controller/find_id_page_controller.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
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
          Text("입력한 번호로 아이디를 전송합니다",
              style: regularStyle.copyWith(color: Palette.darkGrey)),
          const SizedBox(height: 32),
          ModernFormField(
            onTextChanged: (value) {
              controller.phoneNumber.value = value;
            },
            hint: "휴대폰 번호를 입력하세요",
          ),
          const SizedBox(height: 16),
          Obx(
            () => ModernFormButton(
              isEnabled: controller.phoneNumber.value.isNotEmpty,
              text: "아이디 찾기",
              onPressed: () async {
                if (!isValidPhoneNumberFormat(controller.phoneNumber.value)) {
                  GetXSnackBar(type: GetXSnackBarType.phoneNumberError).show();
                  return;
                }

                if (await controller
                    .sendIdToPhoneNumber(controller.phoneNumber.value)) {
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
