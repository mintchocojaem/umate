import 'package:flutter/material.dart';

import '../../../design_system/orb/orb.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoInternetScreenState();
  }
}

class _NoInternetScreenState extends State<NoInternetScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0.2,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = OrbThemeData.of(context);
    final palette = theme.palette;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: palette.surfaceBright,
        ),
        child: FadeTransition(
          opacity: _animationController,
          child: OrbIcon(
            Icons.wifi_off,
            size: OrbIconSize.large,
            color: palette.error,
          ),
        ),
      ),
    );
  }
}
