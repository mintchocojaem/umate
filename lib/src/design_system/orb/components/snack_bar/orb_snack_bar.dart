import 'package:flutter/material.dart';

import '../../orb.dart';

enum OrbSnackBarType {
  info,
  warning,
  error,
}

class OrbSnackBar extends SnackBar {
  final String message;
  final OrbSnackBarType type;

  const OrbSnackBar({
    super.key,
    required this.message,
    required this.type,
    super.content = const SizedBox(),
    super.onVisible,
  });

  @override
  // TODO: implement duration
  Duration get duration => const Duration(seconds: 3);

  @override
  // TODO: implement padding
  EdgeInsetsGeometry? get padding => const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 16,
  );

  @override
  // TODO: implement content
  Widget get content {
    return Builder(
      builder: (context) {
        final themeData = OrbThemeData.of(context);
        final palette = themeData.palette;
        return Row(
          children: [
            Icon(
              Icons.info,
              color: switch (type) {
                // TODO: Handle this case.
                OrbSnackBarType.info => Colors.blueAccent,
                // TODO: Handle this case.
                OrbSnackBarType.warning => Colors.amberAccent,
                // TODO: Handle this case.
                OrbSnackBarType.error => Colors.redAccent,
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OrbText(
                message,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                type: OrbTextType.bodyMedium,
                color: palette.onSurface,
              ),
            ),
          ],
        );
      }
    );
  }

  @override
  // TODO: implement elevation
  double? get elevation => 0;

}
