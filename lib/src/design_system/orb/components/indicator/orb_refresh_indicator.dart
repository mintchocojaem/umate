import 'package:flutter/material.dart';

import '../../orb.dart';

class OrbRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const OrbRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final themeData = OrbThemeData.of(context);
    final palette = themeData.palette;
    return RefreshIndicator(
      color: palette.primary,
      backgroundColor: palette.onPrimary,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
