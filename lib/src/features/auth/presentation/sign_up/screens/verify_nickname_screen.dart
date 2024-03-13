import 'package:auto_route/annotations.dart';
import 'package:danvery/src/core/utils/auth_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/snack_bar/snack_bar_service.dart';
import '../../../../../design_system/orb/components/components.dart';
import '../providers/sign_up_provider.dart';

@RoutePage()
class VerifyNicknameScreen extends ConsumerStatefulWidget {
  final String signUpToken;

  const VerifyNicknameScreen({
    super.key,
    required this.signUpToken,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _VerifyNicknameScreenState();
  }
}

class _VerifyNicknameScreenState extends ConsumerState<VerifyNicknameScreen>
    with AuthValidator {
  late final TextEditingController nicknameController;
  late final GlobalKey<FormState> formKey;

  String availableNickname = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nicknameController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      signUpProvider,
      (prev, next) {
        if (!next.isLoading && next.hasError) {
          ref.read(snackBarServiceProvider).show(
                context,
                message: next.message!,
                type: OrbSnackBarType.error,
              );
        }
      },
    );

    final submitButton = OrbButton(
      buttonText: '다음',
      onPressed: () async {
        await ref.read(signUpProvider.notifier).verifyNickname(
              formKey,
              signUpToken: widget.signUpToken,
              currentNickname: nicknameController.text,
              availableNickname: availableNickname,
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
                    final result =
                        await ref.read(signUpProvider.notifier).checkNickname(
                              formKey,
                              nickname: nicknameController.text,
                            );

                    if (context.mounted && result) {
                      availableNickname = nicknameController.text;
                      ref.read(snackBarServiceProvider).show(
                            context,
                            message: '사용 가능한 닉네임이에요.',
                            type: OrbSnackBarType.info,
                          );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      submitButton: submitButton,
      submitButtonOnKeyboard: submitButton,
    );
  }
}
