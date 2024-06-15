import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/auth_validator.dart';
import '../../../../design_system/orb/orb.dart';
import '../providers/sign_up_info_provider.dart';
import '../widgets/agree_policy_sheet.dart';

class SignUpVerifyStudentScreen extends ConsumerStatefulWidget {
  const SignUpVerifyStudentScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignUpVerifyStudentScreenState();
  }
}

class _SignUpVerifyStudentScreenState
    extends ConsumerState<SignUpVerifyStudentScreen> with AuthValidator {
  final TextEditingController dkuStudentIdController = TextEditingController();
  final TextEditingController dkuPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    dkuStudentIdController.dispose();
    dkuPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ref.listen(
      signUpInfoProvider,
      (_, next) {
        if (!next.isLoading && next.hasError) {
          context.showSnackBar(
            message: (next.error as AppException).message,
            type: OrbSnackBarType.error,
          );
        } else if (next.value != null) {
          ref
              .read(routerServiceProvider)
              .pushReplacementNamed(AppRoute.signUp.name);
        }
      },
    );

    return OrbScaffold(
      appBar: OrbAppBar(
        onAutoImplyLeadingPressed: () {
          ref.read(routerServiceProvider).pop();
        },
      ),
      title: '단국대학교 포털\n학생인증이 필요해요',
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              OrbTextField(
                controller: dkuStudentIdController,
                hintText: '학번',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLength: 8,
                validator: (value) {
                  return validateStudentId(studentId: value);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OrbTextField(
                controller: dkuPasswordController,
                hintText: '비밀번호',
                obscureText: true,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  return validatePassword(
                    password: value,
                    checkRegex: false,
                  );
                },
              ),
              const SizedBox(height: 16),
              OrbFilledButton(
                text: '인증하기',
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                  await showOrbModalBottomSheet(
                    context,
                    AgreePolicySheet(
                      enabledColor: context.palette.primary,
                      disabledColor: context.palette.surface,
                      onAgree: () async {
                        await ref
                            .read(signUpInfoProvider.notifier)
                            .verifyStudent(
                              dkuStudentId: dkuStudentIdController.text,
                              dkuPassword: dkuPasswordController.text,
                              isAgreePolicy: true,
                            );

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      onTapCollectUserInfo: () async {
                        ref.read(routerServiceProvider).pushReplacementNamed(
                            AppRoute.signUpAgreePolicy.name);
                      },
                      onTapThirdParty: () async {
                        ref
                            .read(routerServiceProvider)
                            .pushNamed(AppRoute.signUpAgreePolicy.name);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrbIcon(
                    Icons.info_outline_rounded,
                    color: Colors.grey,
                    size: OrbIconSize.small,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: OrbText(
                      """단국대학교 웹정보 로그인시 사용하는 ID/PW를 통해서 학생인증이 진행됩니다.\n(단국대학교 웹정보 ID/PW는 학생인증 이후 바로 폐기됩니다.) """,
                      type: OrbTextType.bodySmall,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
