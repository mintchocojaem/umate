import 'package:auto_route/annotations.dart';
import 'package:danvery/src/core/utils/auth_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/router/route_error_screen.dart';
import '../../../../../core/services/router/router_service.dart';
import '../../../../../core/services/snack_bar/snack_bar_service.dart';
import '../../../../../design_system/orb/components/components.dart';
import '../../../auth_dependency_injections.dart';
import '../../providers/states/sign_up_nickname_state.dart';
import '../../providers/states/sign_up_verify_student_state.dart';

@RoutePage()
class SignUpNicknameScreen extends ConsumerStatefulWidget {
  const SignUpNicknameScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpNicknameScreenState();
  }
}

class _SignUpNicknameScreenState extends ConsumerState<SignUpNicknameScreen>
    with AuthValidator {
  final TextEditingController nicknameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String verifiedNickname = '';

  @override
  void dispose() {
    // TODO: implement dispose
    nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpVerifyStudentState = ref.watch(signUpVerifyStudentProvider);

    if (signUpVerifyStudentState is! SignUpVerifyStudentSuccess) {
      return const RouteErrorScreen();
    }

    final signUpNicknameState = ref.watch(signUpNicknameProvider);

    ref.listen(
      signUpNicknameProvider,
      (prev, next) {
        if (next is SignUpNicknameFailure) {
          ref.read(snackBarServiceProvider).showException(
                context,
                next.exception,
              );
        } else if (next is SignUpNicknameConfirmed) {
          ref.read(routerServiceProvider).replace(const SignUpPasswordRoute());
        } else if (next is SignUpNicknameVerified) {
          verifiedNickname = next.verifiedNickname;
          ref.read(snackBarServiceProvider).show(
                context,
                message: '사용 가능한 닉네임이에요.',
                type: OrbSnackBarType.info,
              );
        }
      },
    );

    final submitButton = OrbButton(
      buttonText: '다음',
      onPressed: () async {
        if (!formKey.currentState!.validate()) {
          return;
        }

        await ref.read(signUpNicknameProvider.notifier).confirmNickname(
              verifiedNickname: verifiedNickname,
              currentNickname: nicknameController.text,
            );
      },
    );

    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '단버리에서 사용할\n닉네임을 입력해주세요',
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OrbTextFormField(
                    controller: nicknameController,
                    labelText: '닉네임',
                    textInputAction: TextInputAction.next,
                    helperText: "",
                    //reason for the height
                    maxLength: 20,
                    validator: (value) {
                      return validateNickname(nickname: value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                OrbButton(
                  buttonText: '중복확인',
                  buttonSize: OrbButtonSize.compact,
                  buttonRadius: OrbButtonRadius.small,
                  enabledBackgroundColor: themeData.colorScheme.surfaceVariant,
                  enabledForegroundColor: themeData.colorScheme.onSurface,
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    if (signUpNicknameState is SignUpNicknameVerified &&
                        signUpNicknameState.verifiedNickname ==
                            nicknameController.text) {
                      return;
                    }

                    await ref
                        .read(signUpNicknameProvider.notifier)
                        .verifyNickname(
                          nickname: nicknameController.text,
                        );
                  },
                ),
              ],
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
