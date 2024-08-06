import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../core/utils/app_exception.dart';
import '../../../../../core/utils/auth_validator.dart';
import '../../../../../design_system/orb/orb.dart';
import '../providers/reset_user_password_provider.dart';

class FindUserPasswordScreen extends ConsumerStatefulWidget {
  const FindUserPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _FindUserPasswordScreenState();
  }
}

class _FindUserPasswordScreenState extends ConsumerState<FindUserPasswordScreen>
    with AuthValidator {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordConfirmController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode codeFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode newPasswordConfirmFocusNode = FocusNode();

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
      resetUserPasswordNotifierProvider,
      (_, next) {
        if (next.isLoading) {
          return;
        } else if (next.hasError) {
          final error = next.error;
          if (error is! AppException) return;
          context.showErrorSnackBar(
            error: error,
          );
        } else if (next.hasValue) {
          switch (next.requireValue.step) {
            case ResetUserPasswordStep.passwordCodeSent:
              context.showSnackBar(
                message: '인증번호가 전송되었습니다.',
              );
              break;
            case ResetUserPasswordStep.passwordChanged:
              context.showSnackBar(
                message: '비밀번호가 변경되었습니다.',
              );
              break;
            default:
              break;
          }
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
                          .read(resetUserPasswordNotifierProvider.notifier)
                          .sendResetPasswordCode(
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
                      .read(resetUserPasswordNotifierProvider.notifier)
                      .verifyResetPassword(
                        code: codeController.text,
                      );

                  await ref
                      .read(resetUserPasswordNotifierProvider.notifier)
                      .resetPassword(
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
