import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/router/router_service.dart';
import '../../../../../core/utils/auth_validator.dart';
import '../../../../../design_system/orb/orb.dart';
import '../../../user_dependency_injections.dart';
import '../../providers/states/find_password_state.dart';

class FindPasswordScreen extends ConsumerStatefulWidget {
  const FindPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _FindPasswordScreenState();
  }
}

class _FindPasswordScreenState extends ConsumerState<FindPasswordScreen>
    with AuthValidator {
  late final TextEditingController phoneNumberController;
  late final TextEditingController codeController;
  late final TextEditingController newPasswordController;
  late final TextEditingController newPasswordConfirmController;
  late final GlobalKey<FormState> formKey;

  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode codeFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode newPasswordConfirmFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNumberController = TextEditingController();
    codeController = TextEditingController();
    newPasswordController = TextEditingController();
    newPasswordConfirmController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    phoneNumberController.dispose();
    codeController.dispose();
    newPasswordController.dispose();
    newPasswordConfirmController.dispose();

    phoneNumberFocusNode.dispose();
    codeFocusNode.dispose();
    newPasswordFocusNode.dispose();
    newPasswordConfirmFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(
      findPasswordProvider,
      (prev, next) async {
        if (next is FindPasswordFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            OrbSnackBar(
              message: next.message,
              type: OrbSnackBarType.error,
            ),
          );
        } else if (next is FindPasswordSuccessState) {
          await ref.read(routerServiceProvider).pop();
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const OrbSnackBar(
              message: '비밀번호가 변경되었어요.',
              type: OrbSnackBarType.info,
            ),
          );
        }
      },
    );

    return OrbScaffold(
      appBar: const OrbAppBar(),
      title: '비밀번호 변경에\n필요한 정보를 입력해주세요',
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              OrbTextField(
                focusNode: newPasswordFocusNode,
                controller: newPasswordController,
                hintText: '새 비밀번호',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                obscureText: true,
                validator: (value) {
                  return validatePassword(password: value);
                },
                onSubmitted: (_) {
                  newPasswordConfirmFocusNode.requestFocus();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OrbTextField(
                focusNode: newPasswordConfirmFocusNode,
                controller: newPasswordConfirmController,
                hintText: '새 비밀번호 확인',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                obscureText: true,
                validator: (value) {
                  return validatePasswordConfirm(
                    password: newPasswordController.text,
                    passwordConfirm: value,
                  );
                },
                onSubmitted: (_) {
                  phoneNumberFocusNode.requestFocus();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OrbTextField(
                focusNode: phoneNumberFocusNode,
                controller: phoneNumberController,
                hintText: '휴대폰번호',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLength: 11,
                validator: (value) {
                  return validatePhoneNumber(phoneNumber: value);
                },
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (_) {
                  codeFocusNode.requestFocus();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OrbTextField(
                focusNode: codeFocusNode,
                controller: codeController,
                hintText: '인증번호',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                maxLength: 6,
                validator: (value) {
                  return validateCode(code: value);
                },
                onChanged: (value) {
                  setState(() {});
                },
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: OrbFilledButton(
                    disabled: phoneNumberController.text.length != 11,
                    showCoolDownTime: true,
                    buttonCoolDown: const Duration(seconds: 30),
                    buttonSize: OrbButtonSize.compact,
                    buttonTextType: OrbButtonTextType.small,
                    buttonRadius: OrbButtonRadius.small,
                    onPressed: () async {
                      await ref
                          .read(findPasswordProvider.notifier)
                          .sendPasswordResetCode(
                        phoneNumber: phoneNumberController.text,
                      );
                    },
                    text: '인증번호 전송',
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              OrbFilledButton(
                disabled: codeController.text.length != 6,
                text: '비밀번호 변경하기',
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  await ref
                      .read(findPasswordProvider.notifier)
                      .verifyPasswordResetCode(
                        code: codeController.text,
                      );

                  await ref.read(findPasswordProvider.notifier).resetPassword(
                        newPassword: newPasswordController.text,
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
