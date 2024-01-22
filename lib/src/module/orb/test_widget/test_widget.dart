import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const TestWidget({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
          style: themeData.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        child,
      ],
    );
  }
}
