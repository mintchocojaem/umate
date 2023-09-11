import 'package:flutter/material.dart';

enum OrbButtonTheme {
  primary,
  secondary,
  onSurface,
}

enum OrbButtonSize {
  compact,
  wide,
}

class OrbButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final Widget child;
  final bool disabled;
  final double? borderRadius;
  final OrbButtonTheme buttonTheme;
  final OrbButtonSize buttonSize;

  const OrbButton({
    super.key,
    this.onPressed,
    required this.child,
    this.disabled = false,
    this.borderRadius,
    this.buttonTheme = OrbButtonTheme.primary,
    this.buttonSize = OrbButtonSize.wide,
  });

  OrbButton copyWith({
    Key? key,
    VoidCallback? onPressed,
    Widget? child,
    double? borderRadius,
    bool? disabled,
    OrbButtonTheme? buttonTheme,
    OrbButtonSize? buttonSize,
  }) {
    return OrbButton(
      key: key ?? this.key,
      onPressed: onPressed ?? this.onPressed,
      disabled: disabled ?? this.disabled,
      borderRadius: borderRadius ?? this.borderRadius,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      buttonSize: buttonSize ?? this.buttonSize,
      child: child ?? this.child,
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData theme = Theme.of(context);
    bool enabled = true;
    return FilledButton(
      onPressed: disabled ? null : (){
        if(enabled) onPressed?.call();
        enabled = false;
        Future.delayed(const Duration(seconds: 1), () {
          enabled = true;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          buttonTheme == OrbButtonTheme.primary
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface.withOpacity(0.2),
        ),
        foregroundColor: MaterialStateProperty.all(
          buttonTheme == OrbButtonTheme.primary
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onSurface,
        ),
        textStyle: MaterialStateProperty.all(
          theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        minimumSize: buttonSize == OrbButtonSize.compact
            ? MaterialStateProperty.all(const Size(0, 36))
            : MaterialStateProperty.all(const Size(double.infinity, 48)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 15),
          ),
        ),
      ),
      child: child,
    );
  }
}
