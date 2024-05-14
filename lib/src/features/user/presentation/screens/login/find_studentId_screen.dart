import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/router/router_service.dart';
import '../../../../../core/utils/auth_validator.dart';
import '../../../../../design_system/orb/orb.dart';
import '../../../user_dependency_injections.dart';
import '../../providers/states/find_student_id_state.dart';

class FindStudentIdScreen extends ConsumerStatefulWidget {
  const FindStudentIdScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _FindStudentIdScreenState();
  }
}

class _FindStudentIdScreenState extends ConsumerState<FindStudentIdScreen>
    with AuthValidator {
  late final TextEditingController phoneNumberController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNumberController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      findStudentIdProvider,
      (prev, next) async {
        if (next is FindStudentIdFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            OrbSnackBar(
              message: next.message,
              type: OrbSnackBarType.error,
            ),
          );
        } else if (next is FindStudentIdSuccessState) {
          await ref.read(routerServiceProvider).pop();
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const OrbSnackBar(
              message: '아이디가 전송되었어요.',
              type: OrbSnackBarType.info,
            ),
          );
        }
      },
    );

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
                validator: (value) {
                  return validatePhoneNumber(phoneNumber: value);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OrbFilledButton(
                text: '전송하기',
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  await ref
                      .read(findStudentIdProvider.notifier)
                      .sendStudentId(phoneNumber: phoneNumberController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
