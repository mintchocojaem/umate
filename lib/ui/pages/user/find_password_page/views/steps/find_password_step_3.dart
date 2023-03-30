import 'package:danvery/ui/pages/user/find_password_page/controller/find_password_page_controller.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("재설정할 비밀번호를 입력해주세요", style: regularStyle.copyWith(color: Palette.darkGrey)),
          const SizedBox(height: 32),
          ModernFormField(
            hint: "비밀번호를 입력하세요",
            validateHint: "비밀번호를 재입력하세요",
            validate: true,
            isPassword: true,
            onTextChanged: (value) {
              controller.password.value = value;
            },
            onValidateChanged: (value) {
              controller.passwordValidate.value = value;
            },
          ),
          const SizedBox(height: 16),
          ModernFormButton(
            text: "완료",
            onPressed: () async {

              if (isValidPasswordFormat(controller.password.value) == false) {
                GetXSnackBar(type: GetXSnackBarType.passwordInputError).show();
                return;
              }

              if (controller.password.value != controller.passwordValidate.value) {
                GetXSnackBar(type: GetXSnackBarType.passwordConfirmError).show();
                return;
              }

              if(await controller.changePassword()){
                FocusManager.instance.primaryFocus?.unfocus();
                controller.currentStep.value = 4;
              }

            },
          ),
        ],
      ),
    );
  }
}
