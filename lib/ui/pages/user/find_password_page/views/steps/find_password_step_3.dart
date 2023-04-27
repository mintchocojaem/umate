import 'package:danvery/core/regex/regex.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/pages/user/find_password_page/controller/find_password_page_controller.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FindPasswordStep3 extends GetView<FindPasswordPageController> {
  const FindPasswordStep3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("재설정할 비밀번호를 입력해주세요",
              style: regularStyle.copyWith(color: Palette.darkGrey)),
          const SizedBox(height: 32),
          ModernFormField(
            hint: "비밀번호를 입력하세요",
            validateHint: "비밀번호를 재입력하세요",
            validateHelperText: "8~24자, 하나 이상의 영문자와 숫자 포함",
            validate: true,
            isPassword: true,
            onTextChanged: (value) {
              controller.passwordController.update((val) {
                if (val != null) val.text = value;
              });
            },
            onValidateChanged: (value) {
              controller.passwordValidateController.update((val) {
                if (val != null) val.text = value;
              });
            },
          ),
          const SizedBox(height: 32),
          Obx(
            () => ModernFormButton(
              isEnabled: controller.passwordController.value.text.isNotEmpty &&
                  controller.passwordValidateController.value.text.isNotEmpty,
              text: "완료",
              onPressed: () async {
                if (!passwordCheckRegExp
                    .hasMatch(controller.passwordController.value.text)) {
                  GetXSnackBar(type: GetXSnackBarType.passwordInputError)
                      .show();
                  return;
                }

                if (controller.passwordController.value.text !=
                    controller.passwordValidateController.value.text) {
                  GetXSnackBar(type: GetXSnackBarType.passwordConfirmError)
                      .show();
                  return;
                }

                if (await controller.changePassword()) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.currentStep.value = 4;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
