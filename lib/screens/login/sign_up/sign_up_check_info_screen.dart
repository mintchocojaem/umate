import 'package:danvery/domain/auth/auth.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpCheckInfoScreen extends ConsumerWidget {
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignUpCheckInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    final signup = ref.watch(signUpProvider);
    final Student student = signup.value!.student;

    _studentIdController.text = student.studentId;
    _majorController.text = student.major;
    final themeData = Theme.of(context);
    return OrbScaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${student.studentName}님 정보가 맞나요?',
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: _studentIdController,
              labelText: '학번',
              readOnly: true,
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: _majorController,
              labelText: '학과',
              readOnly: true,
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: _phoneNumberController,
              maxLength: 11,
              labelText: '휴대폰 번호',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              readOnly: false,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '휴대폰 번호를 입력해주세요';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          final phoneNumber = _phoneNumberController.text;
          await ref
              .read(signUpProvider.notifier)
              .sendSMS(signup.value!.signUpToken, phoneNumber);
        },
        buttonText: '본인 인증하기',
      ),
      /*
      submitHelper: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '내정보가 일치하지 않나요?',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.secondary,
            ),
          ],
        ),
      ),
       */
    );
  }
}
