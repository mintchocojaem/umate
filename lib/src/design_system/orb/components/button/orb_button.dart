import 'dart:async';

import 'package:danvery/src/design_system/orb/theme/palette.dart';
import 'package:flutter/material.dart';

import '../../theme/orb_theme.dart';
import '../components.dart';

enum OrbButtonStyle {
  primary,
  secondary,
  tertiary,
}

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
  final bool disabled;
  final OrbButtonSize buttonSize;
  final Duration buttonCoolDown;
  final bool showCoolDownTime;
  final OrbButtonRadius buttonRadius;
  final OrbButtonStyle buttonStyle;

  const OrbButton({
    super.key,
    required this.onPressed,
    this.buttonText,
    this.disabled = false,
    this.buttonSize = OrbButtonSize.wide,
    this.buttonCoolDown = const Duration(seconds: 1),
    this.showCoolDownTime = false,
    this.buttonRadius = OrbButtonRadius.normal,
    this.buttonStyle = OrbButtonStyle.primary,
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
    final isLightMode = OrbTheme().isLightMode(context);
    final backgroundColor = isLightMode
        ? switch (widget.disabled) {
            true => LightPalette.lightGrayishBlue,
            false => switch (widget.buttonStyle) {
                OrbButtonStyle.primary => LightPalette.vividBlue,
                OrbButtonStyle.secondary => LightPalette.lightSkyBlue,
                OrbButtonStyle.tertiary => LightPalette.lightGrayishBlue,
              },
          }
        : switch (widget.disabled) {
            true => DarkPalette.eerieBlack,
            false => switch (widget.buttonStyle) {
                OrbButtonStyle.primary => DarkPalette.vividBlue,
                OrbButtonStyle.secondary => DarkPalette.deepNavyBlue,
                OrbButtonStyle.tertiary => DarkPalette.outerSpaceGray,
              },
          };
    final foregroundColor = isLightMode
        ? switch (widget.disabled) {
            true => LightPalette.slateGray,
            false => switch (widget.buttonStyle) {
                OrbButtonStyle.primary => LightPalette.pureWhite,
                OrbButtonStyle.secondary => LightPalette.pureWhite,
                OrbButtonStyle.tertiary => LightPalette.pureWhite,
              },
          }
        : switch (widget.disabled) {
            true => DarkPalette.cadetGray,
            false => switch (widget.buttonStyle) {
                OrbButtonStyle.primary => DarkPalette.pureWhite,
                OrbButtonStyle.secondary => DarkPalette.pureWhite,
                OrbButtonStyle.tertiary => DarkPalette.pureWhite,
              },
          };

    final textStyle = switch (widget.buttonSize) {
      OrbButtonSize.compact => OrbTextTheme.bodySmall(),
      OrbButtonSize.fit => OrbTextTheme.bodyMedium(),
      OrbButtonSize.wide => OrbTextTheme.bodyMedium(),
    };

    final Size minimumSize = switch (widget.buttonSize) {
      OrbButtonSize.compact => const Size(48, 32),
      OrbButtonSize.fit => const Size(48, 48),
      OrbButtonSize.wide => const Size(48, 52),
    };

    final double paddingHorizontal = switch (widget.buttonSize) {
      OrbButtonSize.compact => 12,
      OrbButtonSize.fit => 16,
      OrbButtonSize.wide => 24,
    };

    final double paddingVertical = switch (widget.buttonSize) {
      OrbButtonSize.compact => 8,
      OrbButtonSize.fit => 10,
      OrbButtonSize.wide => 12,
    };

    final BorderRadius borderRadius = BorderRadius.circular(
      switch (widget.buttonRadius) {
        OrbButtonRadius.none => 0,
        OrbButtonRadius.small => 10,
        OrbButtonRadius.normal => 15,
      },
    );

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
          backgroundColor,
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: paddingVertical,
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          minimumSize,
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
                      foregroundColor,
                    ),
                  ),
                )
              : widget.buttonText != null &&
                      widget.showCoolDownTime &&
                      coolDownTime != Duration.zero
                  ? OrbText(
                      _printDuration(coolDownTime),
                      overflow: TextOverflow.ellipsis,
                      colorType: OrbTextColorType.title,
                      textTheme: textStyle,
                    )
                  : OrbText(
                      widget.buttonText!,
                      overflow: TextOverflow.ellipsis,
                      colorType: OrbTextColorType.disabled,
                      textTheme: textStyle,
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
