import 'package:auto_route/annotations.dart';
import 'package:danvery/src/core/utils/auth_validator.dart';
import 'package:danvery/src/features/auth/domain/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../design_system/orb/components/components.dart';
import '../view_models/sign_up_view_model.dart';

@RoutePage()
class VerifyPhoneNumberScreen extends ConsumerStatefulWidget {
  const VerifyPhoneNumberScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _VerifyPhoneNumberScreenState();
  }
}

class _VerifyPhoneNumberScreenState
    extends ConsumerState<VerifyPhoneNumberScreen> with AuthValidator {
  late final TextEditingController studentIdController;
  late final TextEditingController majorController;
  late final TextEditingController phoneNumberController;
  late final GlobalKey<FormState> formKey;

  late final StudentModel student;

  @override
  void initState() {
    super.initState();
    majorController = TextEditingController();
    studentIdController = TextEditingController();
    phoneNumberController = TextEditingController();

    student = ref.read(signUpViewModelProvider).requireValue.student;

    majorController.text = student.major;
    studentIdController.text = student.studentId;

    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    majorController.dispose();
    studentIdController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final submitButton = OrbButton(
      onPressed: () async {
        ref.read(signUpViewModelProvider.notifier).sendSMS(
              formKey,
              phoneNumber: phoneNumberController.text,
            );
      },
      buttonText: '본인 인증하기',
    );

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
                return validatePhoneNumber(phoneNumber: value);
              },
            ),
          ],
        ),
      ),
      submitButton: submitButton,
      submitButtonOnKeyboard: submitButton,
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
