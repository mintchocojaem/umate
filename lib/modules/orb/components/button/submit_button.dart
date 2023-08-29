import 'package:flutter/material.dart';

class SubmitButton extends FilledButton {
  final bool isSquare;

  const SubmitButton({
    super.key,
    required super.onPressed,
    required super.child,
    this.isSquare = false,
  });

  SubmitButton copyWith({
    Key? key,
    VoidCallback? onPressed,
    Widget? child,
    bool? isSquare,
  }) {
    return SubmitButton(
      key: key ?? this.key,
      onPressed: onPressed ?? this.onPressed,
      isSquare: isSquare ?? this.isSquare,
      child: child ?? this.child,
    );
  }

  @override
  // TODO: implement style
  ButtonStyle? get style {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(
        const Size(double.infinity, 48),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isSquare ? 0 : 20),
        ),
      ),
    );
  }

}
