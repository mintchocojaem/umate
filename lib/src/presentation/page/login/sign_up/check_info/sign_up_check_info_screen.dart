import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/core.dart';
import '../../../../presentation.dart';

class SignUpCheckInfoScreen extends ConsumerWidget{
  const SignUpCheckInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final screenController = ref.watch(signUpCheckInfoScreenControllerProvider);

    final themeData = Theme.of(context);

    return OrbScaffold(
      orbAppBar: OrbAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            screenController.popPage();
          },
        ),
      ),
      body: Form(
        key: screenController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${screenController.getStudentName()}님 정보가 맞나요?',
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: screenController.studentIdController,
              labelText: '학번',
              readOnly: true,
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: screenController.majorController,
              labelText: '학과',
              readOnly: true,
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: screenController.phoneNumberController,
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
         await screenController.sendSMS();
        },
        buttonText: '본인 인증하기',
      ),
    );
  }
}