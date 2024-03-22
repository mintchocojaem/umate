import 'package:danvery/src/core/utils/app_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../design_system/orb/components/snack_bar/orb_snack_bar.dart';

final snackBarServiceProvider = Provider<SnackBarService>(
  (ref) => SnackBarService(),
);

class SnackBarService {

  final List<OrbSnackBar> _snackBarQueue = [];

  void showException(BuildContext context, AppException appException) {
    show(
      context,
      message: appException.message,
      type: switch(appException) {
        AppError() => OrbSnackBarType.error,
        AppWarning() => OrbSnackBarType.warning,
      },
    );
  }

  void show(
    BuildContext context, {
    required String message,
    required OrbSnackBarType type,
  }) {
    const Duration duration = Duration(seconds: 3);
    final ThemeData themeData = Theme.of(context);
    final orbSnackBar = OrbSnackBar(
      color: themeData.colorScheme.surface,
      message: message,
      messageStyle: themeData.textTheme.bodyMedium!.copyWith(
        color: themeData.colorScheme.onBackground,
      ),
      type: type,
      duration: duration,
      onVisible: () {
        Future.delayed(duration, () {
          if (_snackBarQueue.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(_snackBarQueue[0]);
            _snackBarQueue.removeAt(0);
          }
        });
      },
    );

    _snackBarQueue.add(orbSnackBar);

    if (_snackBarQueue.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(orbSnackBar);
      _snackBarQueue.removeAt(0);
    }
  }
}
