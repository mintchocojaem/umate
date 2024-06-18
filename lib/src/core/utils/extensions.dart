import 'package:flutter/material.dart';
import 'package:umate/src/core/utils/app_exception.dart';

import '../../design_system/orb/orb.dart';

extension BuildContextExtension on BuildContext {
  OrbThemeData get theme => OrbThemeData.of(this);

  OrbPalette get palette => theme.palette;

  /// Shows a floating snack bar with text as its content.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar({
    required AppException error,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      switch (error) {
        AppWarning _ => OrbSnackBar(
            message: error.message,
            type: OrbSnackBarType.warning,
          ),
        _ => OrbSnackBar(
            message: error.message,
            type: OrbSnackBarType.error,
          ),
      },
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
    required String message,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      OrbSnackBar(
        message: message,
        type: OrbSnackBarType.info,
      ),
    );
  }

  void showAppLicensePage() => showLicensePage(
        context: this,
        useRootNavigator: true,
        applicationName: 'Umate',
      );
}
