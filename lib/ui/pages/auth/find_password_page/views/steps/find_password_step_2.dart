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

class FindPasswordStep2 extends GetView<FindPasswordPageController> {
  const FindPasswordStep2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("발송된 인증번호를 입력해주세요", style: regularStyle.copyWith(color: Palette.darkGrey)),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: PinCodeTextField(
              textStyle: titleStyle.copyWith(
                color: Palette.darkGrey,
              ),
              appContext: context,
              showCursor: false,
              length: 6,
              obscureText: false,
              animationType: AnimationType.none,
              pinTheme: PinTheme(
                borderWidth: 1,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 48,
                fieldWidth: 36,
                activeFillColor: Palette.lightGrey,
                inactiveFillColor: Palette.lightGrey,
                activeColor: Palette.blue,
                inactiveColor: Palette.blue,
                selectedColor: Palette.blue,
                selectedFillColor: Palette.lightGrey,
              ),
              animationDuration: const Duration(milliseconds: 0),
              backgroundColor: Palette.transparent,
              enableActiveFill: true,
              //errorAnimationController: controller.errorController,
              //controller: controller.textEditingController,
              keyboardType: TextInputType.number,
              onCompleted: (v) {
                print("Completed");
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              }, onChanged: (String value) {

              },
            ),
          ),
          const SizedBox(height: 16),
          ModernFormButton(
            text: "확인",
            onPressed: () async{
              if (isValidPhoneNumberFormat(controller.phoneNumber) == false) {
                Get.snackbar("인증번호 오류", "인증번호를 올바르게 입력해주세요.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Palette.darkGrey,
                    colorText: Palette.pureWhite);
                return;
              }
              if (!await controller.verifySMS(
                controller.phoneAuthenticationNumber)) {
                Get.snackbar("인증번호 오류", "인증번호가 일치하지 않습니다",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Palette.darkGrey,
                colorText: Palette.pureWhite);
                return;
              }
              controller.currentStep = 3;
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ],
      ),
    );
  }
}
