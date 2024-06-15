import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/auth_validator.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/use_cases/send_student_id.dart';

class FindUserIdScreen extends ConsumerStatefulWidget {
  const FindUserIdScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _FindUserIdScreenState();
  }
}

class _FindUserIdScreenState extends ConsumerState<FindUserIdScreen>
    with AuthValidator {
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrbScaffold(
      appBar: const OrbAppBar(),
      title: '아이디를 전송 받을\n휴대폰 번호를 입력해주세요',
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              OrbTextField(
                controller: phoneNumberController,
                hintText: '휴대폰번호',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                maxLength: 11,
                onChanged: (value) {
                  setState(() {});
                },
                validator: (value) {
                  return validatePhoneNumber(phoneNumber: value);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OrbFilledButton(
                text: '아이디 전송하기',
                disabled: phoneNumberController.text.length != 11,
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  final result = await AsyncValue.guard(
                    () => ref.read(
                      sendStudentIdProvider(
                        SendStudentIdParams(
                          phoneNumber: phoneNumberController.text,
                        ),
                      ),
                    ),
                  );

                  result.when(
                    data: (_) {
                      context.showSnackBar(
                        message: '아이디가 전송되었습니다.',
                        type: OrbSnackBarType.info,
                      );
                    },
                    loading: () => null,
                    error: (error, stackTrace) {
                      if (error is! AppException) return;
                      context.showSnackBar(
                        message: error.message,
                        type: OrbSnackBarType.error,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
