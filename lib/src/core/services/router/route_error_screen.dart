import 'package:flutter/material.dart';

class RouteErrorScreen extends StatefulWidget {
  final String errorMessage;
  final String reasonMessage;

  const RouteErrorScreen({
    super.key,
    this.errorMessage = 'Route Error',
    this.reasonMessage = '해당 페이지로 접근할 수 없어요.',
  });

  @override
  State<StatefulWidget> createState() {
    return _RouteErrorScreenState();
  }
}

class _RouteErrorScreenState extends State<RouteErrorScreen>
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
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: _animationController,
              child: Icon(
                Icons.warning_amber_rounded,
                size: 64,
                color: themeData.colorScheme.error,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              widget.errorMessage,
              style: themeData.textTheme.titleMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.reasonMessage,
              textAlign: TextAlign.center,
              style: themeData.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
