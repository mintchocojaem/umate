import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/router/router_service.dart';
import '../../../../../core/utils/auth_validator.dart';
import '../../../../../design_system/orb/orb.dart';
import '../../../user_dependency_injections.dart';
import '../../providers/states/verify_student_state.dart';
import '../../widgets/agree_policy_sheet.dart';

class VerifyStudentScreen extends ConsumerStatefulWidget {
  final bool isExpired;

  const VerifyStudentScreen({
    super.key,
    required this.isExpired,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _VerifyStudentScreenState();
  }
}

class _VerifyStudentScreenState extends ConsumerState<VerifyStudentScreen>
    with AuthValidator {
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
      verifyStudentProvider,
      (previous, next) async {
        if (next is VerifyStudentFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            OrbSnackBar(
              message: next.message,
              type: OrbSnackBarType.error,
            ),
          );
        } else if (next is VerifyStudentSuccessState) {
          await Future.delayed(const Duration(milliseconds: 100));
          if(widget.isExpired){
            ref.read(routerServiceProvider).goNamed(
              AppRoute.home.name,
            );
          }else{
            ref.read(routerServiceProvider).pushReplacementNamed(
              AppRoute.signUp.name,
            );
          }
        }
      },
    );

    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return OrbScaffold(
      appBar: const OrbAppBar(),
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
                      enabledColor: currentPalette.primary,
                      disabledColor: currentPalette.surface,
                      onAgree: () async {
                        if (widget.isExpired) {
                          ref
                              .read(verifyStudentProvider.notifier)
                              .refreshStudent(
                                dkuStudentId: dkuStudentIdController.text,
                                dkuPassword: dkuPasswordController.text,
                              );
                        } else {
                          await ref
                              .read(verifyStudentProvider.notifier)
                              .verifyStudent(
                                dkuStudentId: dkuStudentIdController.text,
                                dkuPassword: dkuPasswordController.text,
                                isAgreePolicy: true,
                              );
                        }
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      onTapCollectUserInfo: () async {
                        ref
                            .read(routerServiceProvider)
                            .pushNamed(AppRoute.signUpAgreePolicy.name);
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
