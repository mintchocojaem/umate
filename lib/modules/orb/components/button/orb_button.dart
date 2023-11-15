import 'dart:async';

import 'package:flutter/material.dart';

enum OrbButtonSize {
  compact,
  wide,
}

class OrbButton extends StatefulWidget {
  final Future Function()? onPressed;
  final Color? enabledBackgroundColor;
  final Color? enabledForegroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final bool disabled;
  final double? borderRadius;
  final OrbButtonSize buttonSize;
  final Duration buttonCoolDown;
  final bool showCoolDownTime;

  const OrbButton({
    super.key,
    this.onPressed,
    this.enabledBackgroundColor,
    this.enabledForegroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.buttonText,
    this.buttonTextStyle,
    this.disabled = false,
    this.borderRadius,
    this.buttonSize = OrbButtonSize.wide,
    this.buttonCoolDown = const Duration(seconds: 1),
    this.showCoolDownTime = false,
  });

  OrbButton copyWith({
    Key? key,
    Future Function()? onPressed,
    Color? enabledBackgroundColor,
    Color? enabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    String? buttonText,
    TextStyle? buttonTextStyle,
    bool? disabled,
    double? borderRadius,
    OrbButtonSize? buttonSize,
    Duration? buttonCoolDown,
    Widget? child,
  }) {
    return OrbButton(
        key: key ?? this.key,
        onPressed: onPressed ?? this.onPressed,
        enabledBackgroundColor:
            enabledBackgroundColor ?? this.enabledBackgroundColor,
        enabledForegroundColor:
            enabledForegroundColor ?? this.enabledForegroundColor,
        disabledBackgroundColor:
            disabledBackgroundColor ?? this.disabledBackgroundColor,
        disabledForegroundColor:
            disabledForegroundColor ?? this.disabledForegroundColor,
        buttonText: buttonText ?? this.buttonText,
        buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
        disabled: disabled ?? this.disabled,
        borderRadius: borderRadius ?? this.borderRadius,
        buttonSize: buttonSize ?? this.buttonSize,
        buttonCoolDown: buttonCoolDown ?? this.buttonCoolDown,
        showCoolDownTime: showCoolDownTime);
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
                  if(!context.mounted) return;
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
          widget.disabled
              ? widget.disabledBackgroundColor ?? theme.colorScheme.primary
              : widget.enabledBackgroundColor ?? theme.colorScheme.primary,
        ),
        foregroundColor: MaterialStateProperty.all(
          widget.disabled
              ? widget.disabledForegroundColor ?? theme.colorScheme.onSurface
              : widget.enabledForegroundColor ?? theme.colorScheme.onSurface,
        ),
        textStyle: MaterialStateProperty.all(
          theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
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
                  valueColor: AlwaysStoppedAnimation(
                    widget.disabled
                        ? widget.disabledForegroundColor ??
                            theme.colorScheme.onSurface
                        : widget.enabledForegroundColor ??
                            theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          if (widget.buttonText != null)
            widget.showCoolDownTime && coolDownTime != 0
                ? Text(
                    coolDownTime.toString(),
                  )
                : Text(
                    widget.buttonText!,
                  ),
        ],
      ),
    );
    return widget.buttonSize == OrbButtonSize.compact
        ? IntrinsicWidth(child: button)
        : button;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
