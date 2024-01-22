import 'dart:async';

import 'package:danvery/src/module/orb/theme/orb_palette.dart';
import 'package:flutter/material.dart';

typedef DisabledCallback = bool Function();

enum OrbButtonRadius {
  none,
  small,
  normal,
}

enum OrbButtonSize {
  compact,
  normal,
  wide,
}

class OrbButton extends StatefulWidget {
  final Function()? onPressed;
  final Color? enabledBackgroundColor;
  final Color? enabledForegroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final bool disabled;
  final OrbButtonSize buttonSize;
  final Duration buttonCoolDown;
  final bool showCoolDownTime;
  final Size? minimumSize;
  final OrbButtonRadius? buttonRadius;

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
    this.buttonSize = OrbButtonSize.wide,
    this.buttonCoolDown = const Duration(seconds: 1),
    this.showCoolDownTime = false,
    this.minimumSize,
    this.buttonRadius = OrbButtonRadius.normal,
  });

  OrbButton copyWith({
    Key? key,
    Function()? onPressed,
    Color? enabledBackgroundColor,
    Color? enabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    String? buttonText,
    TextStyle? buttonTextStyle,
    bool? disabled,
    OrbButtonSize? buttonSize,
    Duration? buttonCoolDown,
    bool? showCoolDownTime,
    Size? minimumSize,
    OrbButtonRadius? buttonRadius,
    DisabledCallback? disabledCallback,
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
      buttonSize: buttonSize ?? this.buttonSize,
      buttonCoolDown: buttonCoolDown ?? this.buttonCoolDown,
      showCoolDownTime: showCoolDownTime ?? this.showCoolDownTime,
      minimumSize: minimumSize ?? this.minimumSize,
      buttonRadius: buttonRadius ?? this.buttonRadius,
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

  bool disabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);

    final Widget button = FilledButton(
      onPressed: widget.disabled
          ? null
          : () {
              if (!isLoading && !isOnPressed) {
                coolDownTime = widget.buttonCoolDown.inSeconds;
                setState(() {
                  isLoading = true;
                  isOnPressed = true;
                });
                Future(() async {
                  await widget.onPressed?.call();
                }).whenComplete(() {
                  if (!context.mounted) return;
                  setState(() {
                    isLoading = false;
                  });
                });
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
              ? widget.disabledBackgroundColor ??
                  themeData.colorScheme.surfaceVariant
              : widget.enabledBackgroundColor ?? OrbPalette.mainColor,
        ),
        foregroundColor: MaterialStateProperty.all(
          widget.disabled
              ? widget.disabledForegroundColor ??
                  themeData.colorScheme.onSurfaceVariant
              : widget.enabledForegroundColor ?? OrbPalette.onMainColor,
        ),
        textStyle: MaterialStateProperty.all(
          widget.buttonTextStyle ??
              themeData.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: switch (widget.buttonSize) {
              OrbButtonSize.compact => 12,
              OrbButtonSize.normal => 16,
              OrbButtonSize.wide => 24,
            },
            vertical: switch (widget.buttonSize) {
              OrbButtonSize.compact => 8,
              OrbButtonSize.normal => 10,
              OrbButtonSize.wide => 12,
            },
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          widget.minimumSize ??
              switch (widget.buttonSize) {
                OrbButtonSize.compact => const Size(48, 32),
                OrbButtonSize.normal => const Size(48, 40),
                OrbButtonSize.wide => const Size(64, 48),
              },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(switch (widget.buttonRadius) {
              OrbButtonRadius.none => 0,
              OrbButtonRadius.small => 10,
              OrbButtonRadius.normal => 15,
              _ => 15,
            }),
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: isLoading && !widget.showCoolDownTime
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SizedBox(
                    width: themeData.textTheme.bodySmall?.fontSize,
                    height: themeData.textTheme.bodySmall?.fontSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(
                        widget.disabled
                            ? widget.disabledForegroundColor ??
                                OrbPalette.onMainColor
                            : widget.enabledForegroundColor ??
                                OrbPalette.onMainColor,
                      ),
                    ),
                  ),
                )
              : widget.buttonText != null &&
                      widget.showCoolDownTime &&
                      coolDownTime != 0
                  ? Text(
                      "${widget.buttonText!}  |  $coolDownTime",
                      overflow: TextOverflow.ellipsis,
                    )
                  : Text(
                    widget.buttonText!,
                    overflow: TextOverflow.ellipsis,
                  ),
        ),
      ),
    );
    return widget.buttonSize != OrbButtonSize.wide
        ? IntrinsicWidth(child: button)
        : button;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
