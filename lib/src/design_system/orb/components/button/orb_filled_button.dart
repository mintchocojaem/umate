import 'dart:async';

import 'package:flutter/material.dart';

import '../../orb.dart';

enum OrbButtonType {
  primary,
  secondary,
}

class OrbFilledButton extends StatefulWidget {
  final Function() onPressed;
  final String text;
  final bool disabled;
  final OrbButtonTextType buttonTextType;
  final OrbButtonSize buttonSize;
  final Duration buttonCoolDown;
  final bool showCoolDownTime;
  final OrbButtonRadius buttonRadius;
  final OrbButtonType buttonType;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;

  const OrbFilledButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.disabled = false,
    this.buttonTextType = OrbButtonTextType.large,
    this.buttonSize = OrbButtonSize.wide,
    this.buttonCoolDown = const Duration(seconds: 0),
    this.showCoolDownTime = false,
    this.buttonRadius = OrbButtonRadius.normal,
    this.buttonType = OrbButtonType.primary,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrbFilledButtonState();
  }
}

class OrbFilledButtonState extends State<OrbFilledButton> {
  Duration coolDownTime = Duration.zero;
  bool isLoading = false;
  bool isPressed = false;
  late Timer timer;

  bool disabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer(Duration.zero, () {});
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);

    final textStyle = switch (widget.buttonTextType) {
      OrbButtonTextType.large => theme.textTheme.bodyLarge,
      OrbButtonTextType.medium => theme.textTheme.bodyMedium,
      OrbButtonTextType.small => theme.textTheme.bodySmall,
    };

    final minimumSize = switch (widget.buttonSize) {
      OrbButtonSize.compact => Size(0, textStyle.fontSize!),
      OrbButtonSize.fit => Size(0, textStyle.fontSize!),
      OrbButtonSize.wide => Size(0, textStyle.fontSize!),
    };

    final padding = switch (widget.buttonSize) {
      OrbButtonSize.compact => const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
      OrbButtonSize.fit => const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      OrbButtonSize.wide => const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
    };

    final borderRadius = BorderRadius.circular(
      switch (widget.buttonRadius) {
        OrbButtonRadius.none => 0,
        OrbButtonRadius.small => 10,
        OrbButtonRadius.normal => 15,
      },
    );

    //background
    final backgroundColor = switch (widget.buttonType) {
      OrbButtonType.primary =>
        widget.backgroundColor ?? theme.filledButtonTheme.backgroundColor,
      OrbButtonType.secondary =>
        widget.backgroundColor ?? currentPalette.secondary,
    };

    //foreground
    final foregroundColor = switch (widget.buttonType) {
      OrbButtonType.primary =>
        widget.foregroundColor ?? theme.filledButtonTheme.foregroundColor,
      OrbButtonType.secondary =>
        widget.foregroundColor ?? currentPalette.onSecondary,
    };

    final button = FilledButton(
      onPressed: widget.disabled
          ? null
          : () async {
              if (!isLoading && !isPressed) {
                coolDownTime = widget.buttonCoolDown;

                setState(() {
                  isLoading = true;
                  isPressed = true;
                });

                ///OnPressed 가 끝났는데 쿨타임이 남아 있으면 로딩중
                ///쿨타임이 끝났는데 OnPressed가 끝나지 않았으면 로딩중
                if (coolDownTime != Duration.zero) {
                  await widget.onPressed();
                  timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                    if (coolDownTime.inSeconds <= 0) {
                      timer.cancel();
                      setState(() {
                        isLoading = false;
                        isPressed = false;
                      });
                    } else {
                      setState(() {
                        coolDownTime -= const Duration(seconds: 1);
                      });
                    }
                  });
                } else {
                  await widget.onPressed();
                  if(!mounted) return;
                  setState(() {
                    isLoading = false;
                    isPressed = false;
                  });
                }
              }
            },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          widget.disabled
              ? theme.filledButtonTheme.disabledBackgroundColor
              : backgroundColor,
        ),
        foregroundColor: MaterialStateProperty.all(
          widget.disabled
              ? theme.filledButtonTheme.disabledForegroundColor
              : foregroundColor,
        ),
        minimumSize: MaterialStateProperty.all(
          minimumSize,
        ),
        padding: MaterialStateProperty.all(
          padding,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: isLoading && !widget.showCoolDownTime
              ? SizedBox(
                  width: textStyle.fontSize,
                  height: textStyle.fontSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(
                      theme.filledButtonTheme.foregroundColor,
                    ),
                  ),
                )
              : widget.showCoolDownTime && coolDownTime != Duration.zero
                  ? Text(
                      _printDuration(coolDownTime),
                      overflow: TextOverflow.ellipsis,
                      style: textStyle.copyWith(
                        color: widget.disabled
                            ? theme.filledButtonTheme.disabledForegroundColor
                            : foregroundColor,
                        fontWeight: OrbFontWeight.medium.weight,
                        height: 1.0,
                      ),
                    )
                  : Text(
                      widget.text,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle.copyWith(
                        color: widget.disabled
                            ? theme.filledButtonTheme.disabledForegroundColor
                            : foregroundColor,
                        fontWeight: OrbFontWeight.medium.weight,
                        height: 1.0,
                      ),
                    ),
        ),
      ),
    );

    return widget.buttonSize != OrbButtonSize.wide
        ? IntrinsicWidth(child: button)
        : button;
  }
}
