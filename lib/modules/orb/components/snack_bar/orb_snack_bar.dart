import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum OrbSnackBarType {
  info,
  warning,
  error,
}

class OrbSnackBar {
  final BuildContext context;
  final String message;
  final OrbSnackBarType type;

  OrbSnackBar.show({
    required this.context,
    required this.message,
    required this.type,
  }) {
    Flushbar(
      animationDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      borderRadius: BorderRadius.circular(15),
      padding: const EdgeInsets.all(16),
      backgroundColor: Theme.of(context).colorScheme.surface,
      messageText: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
      icon: switch (type) {
        // TODO: Handle this case.
        OrbSnackBarType.info => const Icon(
            Icons.info,
            color: Colors.blue,
          ),
        // TODO: Handle this case.
        OrbSnackBarType.warning => const Icon(
            Icons.info,
            color: Colors.amber,
          ),
        // TODO: Handle this case.
        OrbSnackBarType.error => const Icon(
            Icons.info,
            color: Colors.red,
          ),
      },
    ).show(context);
  }
}
