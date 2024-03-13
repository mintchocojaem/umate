import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum OrbSnackBarType {
  info,
  warning,
  error,
}

class OrbSnackBar extends SnackBar {
  final Color color;
  final String message;
  final TextStyle messageStyle;
  final OrbSnackBarType type;

  const OrbSnackBar({
    super.key,
    required this.color,
    required this.message,
    required this.messageStyle,
    required this.type,
    super.content = const SizedBox(),
    super.onVisible,
    super.duration,
  });

  @override
  // TODO: implement content
  Widget get content {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info,
            color: switch (type) {
              // TODO: Handle this case.
              OrbSnackBarType.info => Colors.blue,
              // TODO: Handle this case.
              OrbSnackBarType.warning => Colors.amber,
              // TODO: Handle this case.
              OrbSnackBarType.error => Colors.red,
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: messageStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement elevation
  double? get elevation => 0;

  @override
  // TODO: implement backgroundColor
  Color? get backgroundColor => Colors.transparent;

  @override
  // TODO: implement padding
  EdgeInsetsGeometry? get padding => const EdgeInsets.all(16);
}
