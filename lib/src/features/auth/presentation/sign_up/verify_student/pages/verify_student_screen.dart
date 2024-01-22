import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../module/orb/components/components.dart';
import '../../../../../../utils/utils.dart';
import 'verify_student_screen_event.dart';
import 'verify_student_screen_state.dart';

class VerifyStudentScreen extends ConsumerWidget
    with VerifyStudentScreenState, VerifyStudentScreenEvent {
  VerifyStudentScreen({super.key});

  final TextEditingController _dkuStudentIdController = TextEditingController();
  final TextEditingController _dkuPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScreenManager _screenManager = ScreenManager();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return ScreenWidget(
      screenManager: _screenManager,
      builder: (BuildContext context, ScreenManager screenManager) {
        return OrbScaffold(
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '단국대학교 포털\n학생인증이 필요해요',
                  style: themeData.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                OrbTextFormField(
                  controller: _dkuStudentIdController,
                  labelText: '학번',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  maxLength: 8,
                  validator: (value) {
                    return checkStudentId(studentId: value);
                  },
                ),
                const SizedBox(height: 16),
                OrbTextFormField(
                  controller: _dkuPasswordController,
                  labelText: '비밀번호',
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    return checkPassword(password: value);
                  },
                ),
                const SizedBox(height: 32),
                Consumer(
                  builder: (context, ref, child) {
                    return OrbListCardTile(
                      titleText: '개인정보 이용약관에 동의하기',
                      leading: Icon(
                        Icons.check,
                        color: getAgreePrivacyPolicyColor(ref),
                      ),
                      onTap: () {
                        agreePrivacyPolicy(ref);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          submitButton: OrbButton(
            onPressed: () async {
              await verifyStudent(
                ref,
                cancelToken: screenManager.newCancelToken(),
                formKey: _formKey,
                dkuStudentIdController: _dkuStudentIdController,
                dkuPasswordController: _dkuPasswordController,
              );
            },
            buttonText: '학생 인증하기',
          ),
        );
      },
    );
  }
}
