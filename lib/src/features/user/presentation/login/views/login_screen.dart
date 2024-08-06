import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../core/services/router/router_service.dart';
import '../../../../../core/utils/app_exception.dart';
import '../../../../../design_system/orb/orb.dart';
import '../providers/login_token_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    studentIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      loginTokenNotifierProvider,
      (_, next) {
        if (next.isLoading) {
          return;
        } else if (next.hasError) {
          final error = next.error;
          if (error is! AppException) return;
          context.showErrorSnackBar(
            error: error,
          );
        } else if (next.hasValue) {
          ref.read(routerServiceProvider).pushNamed(AppRoute.home.name);
        }
      },
    );

    return OrbScaffold(
      appBar: const OrbAppBar(),
      title: '로그인 하기 위해\n아이디와 비밀번호를 입력해주세요',
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
                controller: studentIdController,
                hintText: '학번(ID)',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLength: 8,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OrbTextField(
                controller: passwordController,
                hintText: '비밀번호',
                obscureText: true,
                textInputAction: TextInputAction.done,
                maxLength: 20,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OrbFilledButton(
                text: '로그인',
                disabled: studentIdController.text.isEmpty ||
                    passwordController.text.isEmpty,
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  await ref.read(loginTokenNotifierProvider.notifier).login(
                        studentId: studentIdController.text,
                        password: passwordController.text,
                      );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OrbTextButton(
                    text: '아이디 찾기',
                    onPressed: () {
                      ref
                          .read(routerServiceProvider)
                          .pushNamed(AppRoute.findUserId.name);
                    },
                  ),
                  const SizedBox(width: 8),
                  const OrbText(
                    ' | ',
                  ),
                  const SizedBox(width: 8),
                  OrbTextButton(
                    text: '비밀번호 찾기',
                    onPressed: () {
                      ref
                          .read(routerServiceProvider)
                          .pushNamed(AppRoute.findPassword.name);
                    },
                  ),
                  const SizedBox(width: 8),
                  const OrbText(
                    ' | ',
                  ),
                  const SizedBox(width: 8),
                  OrbTextButton(
                    text: '회원가입',
                    onPressed: () {
                      ref
                          .read(routerServiceProvider)
                          .pushNamed(AppRoute.signUpVerifyStudent.name);
                    },
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
