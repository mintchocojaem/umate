import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../core/services/router/router_service.dart';
import '../../../../../core/utils/auth_validator.dart';
import '../../../../../design_system/orb/orb.dart';
import '../../sign_up/widgets/agree_policy_sheet.dart';

class VerifyStudentScreen extends ConsumerStatefulWidget {
  final TextEditingController dkuStudentIdController;
  final TextEditingController dkuPasswordController;
  final Function() onAgreePolicy;
  final Function() onTapCollectUserInfo;
  final Function() onTapThirdParty;
  final bool isDismissible;

  const VerifyStudentScreen({
    super.key,
    required this.dkuStudentIdController,
    required this.dkuPasswordController,
    required this.onAgreePolicy,
    required this.onTapCollectUserInfo,
    required this.onTapThirdParty,
    this.isDismissible = true,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _VerifyStudentScreenState();
  }
}

class _VerifyStudentScreenState extends ConsumerState<VerifyStudentScreen>
    with AuthValidator {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return OrbScaffold(
      appBar: widget.isDismissible
          ? OrbAppBar(
              onAutoImplyLeadingPressed: () {
                ref.read(routerServiceProvider).pop();
              },
            )
          : const OrbAppBar(
              leading: SizedBox(),
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
                controller: widget.dkuStudentIdController,
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
                controller: widget.dkuPasswordController,
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
                        await widget.onAgreePolicy();

                        if (!context.mounted) return;

                        Navigator.pop(context);
                      },
                      onTapCollectUserInfo: () {
                        widget.onTapCollectUserInfo();
                      },
                      onTapThirdParty: () {
                        widget.onTapThirdParty();
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
