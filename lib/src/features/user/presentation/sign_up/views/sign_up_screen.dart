import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/services/router/router_service.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../core/utils/app_exception.dart';
import '../../../../../core/utils/auth_validator.dart';
import '../../../../../design_system/orb/orb.dart';
import '../providers/sign_up_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends ConsumerState<SignUpScreen>
    with AuthValidator {
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode nicknameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode passwordConfirmFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode codeFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose

    nicknameFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordConfirmFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    codeFocusNode.dispose();

    nicknameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    phoneNumberController.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ref.listen(
      signUpNotifierProvider,
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
            case SignUpStep.codeSent:
              context.showSnackBar(
                message: '인증번호가 전송되었어요.',
              );
              break;
            default:
              break;
          }
        }
      },
    );

    final signUpInfo = ref.watch(signUpNotifierProvider);

    return OrbScaffold(
      appBar: OrbAppBar(
        onAutoImplyLeadingPressed: () {
          ref.read(routerServiceProvider).pop();
        },
      ),
      title: '회원가입에 필요한\n정보를 입력해주세요',
      resizeToAvoidBottomInset: true,
      body: signUpInfo.when(
        data: (data) {
          final signUpInfo = data.signUpInfo;

          if (signUpInfo == null) {
            return const OrbShimmerContent();
          }

          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  OrbTextField(
                    focusNode: nicknameFocusNode,
                    controller: nicknameController,
                    hintText: '닉네임',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 20,
                    validator: (value) {
                      return validateNickname(nickname: value);
                    },
                    onSubmitted: (_) {
                      passwordFocusNode.requestFocus();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  OrbTextField(
                    focusNode: passwordFocusNode,
                    controller: passwordController,
                    hintText: '비밀번호',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 20,
                    obscureText: true,
                    validator: (value) {
                      return validatePassword(password: value);
                    },
                    onSubmitted: (_) {
                      passwordConfirmFocusNode.requestFocus();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  OrbTextField(
                    focusNode: passwordConfirmFocusNode,
                    controller: passwordConfirmController,
                    hintText: '비밀번호 확인',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 20,
                    obscureText: true,
                    validator: (value) {
                      return validatePasswordConfirm(
                        password: passwordController.text,
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
                    maxLength: 11,
                    hintText: '휴대폰 번호',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    readOnly: false,
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) {
                      return validatePhoneNumber(phoneNumber: value);
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
                    hintText: '인증번호(6자리 숫자)',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLength: 6,
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) {
                      return validateCode(code: value);
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
                          ref.read(signUpNotifierProvider.notifier).sendCode(
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
                    text: '가입하기',
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      ref
                          .read(signUpNotifierProvider.notifier)
                          .verifyCode(code: codeController.text);

                      ref.read(signUpNotifierProvider.notifier).signUp(
                            nickname: nicknameController.text,
                            password: passwordController.text,
                          );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const OrbShimmerContent(),
        error: (error, stackTrace) => const OrbShimmerContent(),
      ),
    );
  }
}
