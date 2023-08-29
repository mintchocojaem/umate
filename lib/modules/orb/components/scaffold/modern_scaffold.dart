import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';

class ModernScaffold extends Scaffold {
  final BuildContext context;
  final SubmitButton? submitButton;
  final bool submitSheet;

  const ModernScaffold({
    super.key,
    super.appBar,
    super.body,
    super.bottomNavigationBar,
    super.extendBodyBehindAppBar,
    super.resizeToAvoidBottomInset,
    this.submitButton,
    this.submitSheet = false,
    required this.context
  });

  @override
  // TODO: implement body
  Widget? get body {
    return SafeArea(
      child: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: super.body ?? const SizedBox(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 16,
            right: 16,
            child: submitButton ?? const SizedBox(),
          ),
          MediaQuery.of(context).viewInsets.bottom > 0 ? Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: submitButton?.copyWith(isSquare: true) ?? const SizedBox(),
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
