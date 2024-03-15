import 'package:auto_route/annotations.dart';
import 'package:danvery/src/core/services/snack_bar/snack_bar_service.dart';
import 'package:danvery/src/core/utils/auth_validator.dart';
import 'package:danvery/src/features/auth/domain/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../design_system/orb/components/components.dart';
import '../providers/sign_up_provider.dart';

@RoutePage()
class SignUpSendCodeScreen extends ConsumerStatefulWidget {
  final String signUpToken;
  final StudentModel student;

  const SignUpSendCodeScreen({
    super.key,
    required this.signUpToken,
    required this.student,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpSendCodeScreenState();
  }
}

class _SignUpSendCodeScreenState extends ConsumerState<SignUpSendCodeScreen>
    with AuthValidator {
  late final TextEditingController studentIdController;
  late final TextEditingController majorController;
  late final TextEditingController phoneNumberController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    majorController = TextEditingController();
    studentIdController = TextEditingController();
    phoneNumberController = TextEditingController();

    formKey = GlobalKey<FormState>();

    majorController.text = widget.student.major;
    studentIdController.text = widget.student.studentId;
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
      onPressed: () async {
        await ref.read(signUpProvider.notifier).sendCodeFlow(
              formKey,
              signUpToken: widget.signUpToken,
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
              '${widget.student.studentName}님 정보가 맞나요?',
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
