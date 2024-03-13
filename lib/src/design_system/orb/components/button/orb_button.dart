import 'dart:async';

import 'package:flutter/material.dart';

enum OrbButtonRadius {
  none,
  small,
  normal,
}

enum OrbButtonSize {
  compact,
  fit,
  wide,
}

class OrbButton extends StatefulWidget {
  final Function() onPressed;
  final String? buttonText;
  final Color? enabledBackgroundColor;
  final Color? enabledForegroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final TextStyle? buttonTextStyle;
  final bool disabled;
  final OrbButtonSize buttonSize;
  final Duration buttonCoolDown;
  final bool showCoolDownTime;
  final Size? minimumSize;
  final OrbButtonRadius buttonRadius;

  const OrbButton({
    super.key,
    required this.onPressed,
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
    OrbButtonSize? buttonSize,
    OrbButtonRadius? buttonRadius,
  }) {
    return OrbButton(
      key: key ?? this.key,
      buttonText: buttonText ?? buttonText,
      onPressed: onPressed ?? this.onPressed,
      buttonRadius: buttonRadius ?? this.buttonRadius,
      buttonSize: buttonSize ?? this.buttonSize,
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrbPrimaryButtonState();
  }
}

class OrbPrimaryButtonState extends State<OrbButton> {
  Duration coolDownTime = Duration.zero;
  bool isLoading = false;
  bool isOnPressed = false;
  Timer timer = Timer(Duration.zero, () {});

  bool disabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String _printDuration(Duration duration) {
    String result = '';
    if (duration.inHours > 0) {
      result += '${duration.inHours}:';
    }
    result += '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:';
    result += duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return result;
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
                coolDownTime = widget.buttonCoolDown;
                setState(() {
                  isLoading = true;
                  isOnPressed = true;
                });
                Future(() async {
                  await widget.onPressed();
                }).whenComplete(() {
                  if (!context.mounted) return;
                  setState(() {
                    isLoading = false;
                  });
                });
                timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                  setState(() {
                    coolDownTime -= const Duration(seconds: 1);
                  });
                  if (coolDownTime == Duration.zero) {
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
              : widget.enabledBackgroundColor ?? themeData.colorScheme.primary,
        ),
        foregroundColor: MaterialStateProperty.all(
          widget.disabled
              ? widget.disabledForegroundColor ??
                  themeData.colorScheme.onSurfaceVariant
              : widget.enabledForegroundColor ??
                  themeData.colorScheme.onPrimary,
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
              OrbButtonSize.fit => 16,
              OrbButtonSize.wide => 24,
            },
            vertical: switch (widget.buttonSize) {
              OrbButtonSize.compact => 8,
              OrbButtonSize.fit => 10,
              OrbButtonSize.wide => 12,
            },
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          widget.minimumSize ??
              switch (widget.buttonSize) {
                OrbButtonSize.compact => const Size(48, 32),
                OrbButtonSize.fit => const Size(48, 40),
                OrbButtonSize.wide => const Size(64, 48),
              },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(switch (widget.buttonRadius) {
              OrbButtonRadius.none => 0,
              OrbButtonRadius.small => 10,
              OrbButtonRadius.normal => 15,
            }),
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: isLoading && !widget.showCoolDownTime
              ? SizedBox(
                  width: themeData.textTheme.bodySmall?.fontSize,
                  height: themeData.textTheme.bodySmall?.fontSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(
                      widget.disabled
                          ? widget.disabledForegroundColor ??
                              themeData.colorScheme.onPrimary
                          : widget.enabledForegroundColor ??
                              themeData.colorScheme.onPrimary,
                    ),
                  ),
                )
              : widget.buttonText != null &&
                      widget.showCoolDownTime &&
                      coolDownTime != Duration.zero
                  ? Text(
                      _printDuration(coolDownTime),
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
