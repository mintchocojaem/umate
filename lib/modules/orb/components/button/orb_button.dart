import 'dart:async';

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
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final bool disabled;
  final double? borderRadius;
  final OrbButtonTheme buttonTheme;
  final OrbButtonSize buttonSize;
  final Duration buttonCoolDown;
  final bool showCoolDownTime;

  const OrbButton({
    super.key,
    this.onPressed,
    this.buttonText,
    this.buttonTextStyle,
    this.disabled = false,
    this.borderRadius,
    this.buttonTheme = OrbButtonTheme.primary,
    this.buttonSize = OrbButtonSize.wide,
    this.buttonCoolDown = const Duration(seconds: 1),
    this.showCoolDownTime = false,
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
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrbButtonState();
  }
}

class OrbButtonState extends State<OrbButton> {
  int coolDownTime = 0;
  bool isLoading = false;
  bool isOnPressed = false;
  Timer timer = Timer(Duration.zero, () {});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData theme = Theme.of(context);

    final Widget button = FilledButton(
      onPressed: widget.disabled
          ? null
          : () async {
              if (!isLoading && !isOnPressed) {
                coolDownTime = widget.buttonCoolDown.inSeconds;
                setState(() {
                  isLoading = true;
                  isOnPressed = true;
                });
                widget.onPressed?.call().whenComplete(() {
                  setState(() {
                    isLoading = false;
                  });
                });
                //로직 고쳐야함 지금은 누를때마다 타이머 추가됨
                timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                  setState(() {
                    coolDownTime--;
                  });
                  if (coolDownTime == 0) {
                    isOnPressed = false;
                    timer.cancel();
                  }
                });
              }
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
              ? const EdgeInsets.symmetric(vertical: 12, horizontal: 12)
              : const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
          if (isLoading && !widget.showCoolDownTime)
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
          if (widget.buttonText != null)
            widget.showCoolDownTime && coolDownTime != 0
                ? Text(
                    coolDownTime.toString(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Text(
                    widget.buttonText!,
                    style: widget.buttonTextStyle ??
                        theme.textTheme.bodyMedium?.copyWith(
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
