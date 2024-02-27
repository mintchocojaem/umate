import 'package:flutter/material.dart';

enum OrbSnackBarType {
  info,
  warning,
  error,
}

class OrbSnackBar {
  late final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  late final String message;
  late final OrbSnackBarType type;
  final List<SnackBar> _snackBarQueue = [];

  static final OrbSnackBar _instance = OrbSnackBar._internal();

  OrbSnackBar._internal();

  factory OrbSnackBar() {
    return _instance;
  }

  OrbSnackBar.init({
    required this.scaffoldMessengerKey,
  }) {
    final snackBar = OrbSnackBar();
    snackBar.scaffoldMessengerKey = scaffoldMessengerKey;
  }

  factory OrbSnackBar.show({
    required String message,
    required OrbSnackBarType type,
  }) {
    final snackBar = OrbSnackBar();
    snackBar._show(
      message: message,
      type: type,
    );
    return snackBar;
  }

  void _show({required String message, required OrbSnackBarType type}) {
    if (!scaffoldMessengerKey.currentState!.mounted) {
      return;
    }

    const Duration duration = Duration(milliseconds: 3000);
    final BuildContext context = scaffoldMessengerKey.currentContext!;
    final themeData = Theme.of(context);

    final snackBar = SnackBar(
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: themeData.colorScheme.onSurfaceVariant,
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
            Text(
              message,
              style: themeData.textTheme.bodyMedium?.copyWith(
                color: themeData.colorScheme.background,
              ),
            ),
          ],
        ),
      ),
      duration: duration,
      elevation: 0,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(16),
      onVisible: () {
        Future.delayed(duration, () {
          if (_snackBarQueue.isNotEmpty) {
            scaffoldMessengerKey.currentState!.showSnackBar(_snackBarQueue[0]);
            _snackBarQueue.removeAt(0);
          }
        });
      },
    );

    _snackBarQueue.add(snackBar);

    if (_snackBarQueue.length == 1) {
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
      _snackBarQueue.removeAt(0);
    }
  }
}
