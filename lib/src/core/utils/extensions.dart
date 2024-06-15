import 'package:flutter/material.dart';

import '../../design_system/orb/orb.dart';

extension BuildContextExtension on BuildContext {
  OrbThemeData get theme => OrbThemeData.of(this);

  OrbPalette get palette => theme.palette;

  /// Shows a floating snack bar with text as its content.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
    required String message,
    required OrbSnackBarType type,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      OrbSnackBar(
        message: message,
        type: type,
      ),
    );
  }

  void showAppLicensePage() => showLicensePage(
        context: this,
        useRootNavigator: true,
        applicationName: 'Umate',
      );
}
