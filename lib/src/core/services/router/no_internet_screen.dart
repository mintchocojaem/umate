import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../design_system/orb/theme/theme.dart';

@RoutePage()
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
    final isLightMode = OrbTheme().getThemeMode(context) == OrbThemeMode.light;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isLightMode
                ? LightPalette.lightGrayishBlue
                : DarkPalette.eerieBlack,
            borderRadius: BorderRadius.circular(20),
          ),
          child: FadeTransition(
            opacity: _animationController,
            child: Icon(
              Icons.wifi_off,
              size: 48,
              color:
                  isLightMode ? LightPalette.brightRed : DarkPalette.brightRed,
            ),
          ),
        ),
      ),
    );
  }
}
