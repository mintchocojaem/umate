import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NoInternetScreen extends StatefulWidget{
  const NoInternetScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoInternetScreenState();
  }

}
class _NoInternetScreenState extends State<NoInternetScreen> with SingleTickerProviderStateMixin{

  late final AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
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
    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.background.withOpacity(0.01),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: themeData.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: FadeTransition(
            opacity: _animationController,
            child: Icon(
              Icons.wifi_off,
              size: 48,
              color: themeData.colorScheme.error,
            ),
          ),
        ),
      ),
    );
  }
}