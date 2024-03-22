import 'package:auto_route/annotations.dart';
import 'package:danvery/src/core/utils/auth_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/router/route_error_screen.dart';
import '../../../../../core/services/router/router_service.dart';
import '../../../../../core/services/snack_bar/snack_bar_service.dart';
import '../../../../../design_system/orb/components/components.dart';
import '../../../auth_dependency_injections.dart';
import '../../providers/states/sign_up_complete_state.dart';
import '../../providers/states/sign_up_nickname_state.dart';
import '../../providers/states/sign_up_verify_student_state.dart';

@RoutePage()
class SignUpPasswordScreen extends ConsumerStatefulWidget {
  const SignUpPasswordScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpPasswordScreenState();
  }
}

class _SignUpPasswordScreenState extends ConsumerState<SignUpPasswordScreen>
    with AuthValidator {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpVerifyStudentState = ref.watch(signUpVerifyStudentProvider);
    final signUpNicknameState = ref.watch(signUpNicknameProvider);

    if (signUpVerifyStudentState is! SignUpVerifyStudentSuccess ||
        signUpNicknameState is! SignUpNicknameConfirmed) {
      return const RouteErrorScreen();
    }

    ref.listen(
      signUpCompleteProvider,
      (previous, next) {
        if (next is SignUpCompleteFailure) {
          ref.read(snackBarServiceProvider).showException(
                context,
                next.exception,
              );
        }else if (next is SignUpCompleteSuccess) {
          ref.read(routerServiceProvider).replace(const SignUpCompleteRoute());
        }
      },
    );

    final submitButton = OrbButton(
      onPressed: () async {
        if (!formKey.currentState!.validate()) {
          return;
        }
        await ref.read(signUpCompleteProvider.notifier).signUpComplete(
              signUpToken: signUpVerifyStudentState.signUpInfo.signUpToken,
              nickname: signUpNicknameState.confirmedNickname,
              password: passwordController.text,
            );
      },
      buttonText: '완료',
    );

    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '단버리 로그인에\n사용할 비밀번호를 입력해주세요',
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: passwordController,
              labelText: '비밀번호',
              textInputAction: TextInputAction.next,
              maxLength: 20,
              obscureText: true,
              validator: (value) {
                return validatePassword(password: value);
              },
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: passwordConfirmController,
              labelText: '비밀번호 확인',
              textInputAction: TextInputAction.done,
              maxLength: 20,
              obscureText: true,
              validator: (value) {
                return validatePasswordConfirm(
                  password: passwordController.text,
                  passwordConfirm: value,
                );
              },
            ),
          ],
        ),
      ),
      submitButton: submitButton,
      submitButtonOnKeyboard: submitButton.copyWith(
        buttonRadius: OrbButtonRadius.none,
      ),
    );
  }
}
