import 'package:danvery/domain/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modules/orb/components/components.dart';

class LoginScreen extends ConsumerWidget {
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ModernScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Column(
        children: [
          ModernTextField(
            controller: _studentIdController,
            labelText: '학번',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 16,
          ),
          ModernTextField(
            controller: _passwordController,
            labelText: '비밀번호',
            obscureText: true,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
      submitButton: SubmitButton(
        onPressed: () async {
          final studentId = _studentIdController.text;
          final password = _passwordController.text;

          await ref.read(tokenProvider.notifier).login(studentId, password);
        },
        child: const Text('로그인'),
      ),
    );
  }
}
