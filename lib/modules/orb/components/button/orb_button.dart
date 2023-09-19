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

class OrbButton extends StatefulWidget {
  final Future Function()? onPressed;
  final Widget? child;
  final String? buttonText;
  final bool disabled;
  final double? borderRadius;
  final OrbButtonTheme buttonTheme;
  final OrbButtonSize buttonSize;
  final Duration buttonCoolDown;

  const OrbButton({
    super.key,
    this.onPressed,
    this.child,
    this.buttonText,
    this.disabled = false,
    this.borderRadius,
    this.buttonTheme = OrbButtonTheme.primary,
    this.buttonSize = OrbButtonSize.wide,
    this.buttonCoolDown = const Duration(seconds: 1),
  });

  OrbButton copyWith({
    Key? key,
    Future Function()? onPressed,
    String? buttonText,
    bool? disabled,
    double? borderRadius,
    OrbButtonTheme? buttonTheme,
    OrbButtonSize? buttonSize,
    Duration? buttonCoolDown,
    Widget? child,
  }) {
    return OrbButton(
      key: key ?? this.key,
      onPressed: onPressed ?? this.onPressed,
      buttonText: buttonText ?? this.buttonText,
      disabled: disabled ?? this.disabled,
      borderRadius: borderRadius ?? this.borderRadius,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      buttonSize: buttonSize ?? this.buttonSize,
      buttonCoolDown: buttonCoolDown ?? this.buttonCoolDown,
      child: child ?? this.child,
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrbButtonState();
  }
}

class OrbButtonState extends State<OrbButton> {
  bool coolDown = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData theme = Theme.of(context);

    final Widget button = FilledButton(
      onPressed: widget.disabled
          ? null
          : () async {
              if (coolDown && !isLoading) {
                setState(() {
                  isLoading = true;
                });
                widget.onPressed?.call().whenComplete(() {
                  setState(() {
                    isLoading = false;
                  });
                });
              }
              coolDown = false;
              Future.delayed(
                widget.buttonCoolDown,
                () {
                  coolDown = true;
                },
              );
            },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          widget.buttonTheme == OrbButtonTheme.primary
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface.withOpacity(0.2),
        ),
        foregroundColor: MaterialStateProperty.all(
          widget.buttonTheme == OrbButtonTheme.primary
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onSurface,
        ),
        textStyle: MaterialStateProperty.all(
          theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        padding: MaterialStateProperty.all(
          widget.buttonSize == OrbButtonSize.compact
              ? const EdgeInsets.symmetric(vertical: 8, horizontal: 16)
              : const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 15),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SizedBox(
                width: theme.textTheme.bodySmall?.fontSize,
                height: theme.textTheme.bodySmall?.fontSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          if (widget.child != null) widget.child!,
          if (widget.buttonText != null)
            Text(
              widget.buttonText!,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );

    return widget.buttonSize == OrbButtonSize.compact
        ? IntrinsicWidth(child: button)
        : button;
  }
}
