import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum OrbSnackBarType {
  info,
  warning,
  error,
}

class OrbSnackBar {
  late final GlobalKey<NavigatorState> navigatorKey;
  late final String message;
  late final OrbSnackBarType type;
  final List<Flushbar> _snackBarQueue = [];

  static final OrbSnackBar _instance = OrbSnackBar._internal();

  OrbSnackBar._internal();

  factory OrbSnackBar() {
    return _instance;
  }

  OrbSnackBar.init({
    required this.navigatorKey,
  }) {
    final snackBar = OrbSnackBar();
    snackBar.navigatorKey = navigatorKey;
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
    final context = navigatorKey.currentContext!;

    final flushBar = Flushbar(
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(milliseconds: 2500),
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
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED) {
          if (_snackBarQueue.isNotEmpty) {
            _snackBarQueue.removeAt(0);
            if (_snackBarQueue.isNotEmpty) {
              _snackBarQueue[0].show(context);
            }
          }
        }
      },
    );

    _snackBarQueue.add(flushBar);

    if (_snackBarQueue.length == 1) {
      flushBar.show(context);
    }
  }
}
