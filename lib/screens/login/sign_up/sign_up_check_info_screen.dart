import 'package:danvery/domain/domain.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpCheckInfoScreen extends ConsumerStatefulWidget{
  const SignUpCheckInfoScreen({super.key});

  @override
  createState() => _SignUpCheckInfoScreen();
}

class _SignUpCheckInfoScreen extends ConsumerState<SignUpCheckInfoScreen> {
  late final TextEditingController studentIdController;
  late final TextEditingController majorController;
  late final TextEditingController phoneNumberController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    studentIdController = TextEditingController();
    majorController = TextEditingController();
    phoneNumberController = TextEditingController();
    formKey = GlobalKey<FormState>();

    final Student student = ref.read(signUpProvider).value!.student;
    studentIdController.text = student.studentId;
    majorController.text = student.major;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    studentIdController.dispose();
    majorController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Student student = ref.watch(signUpProvider).value!.student;

    final themeData = Theme.of(context);
    return OrbScaffold(
      body: Form(
        key: formKey,
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
              controller: studentIdController,
              labelText: '학번',
              readOnly: true,
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: majorController,
              labelText: '학과',
              readOnly: true,
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: phoneNumberController,
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
          if (!formKey.currentState!.validate()) {
            return;
          }
          final phoneNumber = phoneNumberController.text;
          await ref
              .read(signUpProvider.notifier)
              .sendSMS(phoneNumber);
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
