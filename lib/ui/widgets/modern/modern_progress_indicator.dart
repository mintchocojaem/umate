import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';

class ModernProgressIndicator extends StatelessWidget {
  final double maxValue;
  final double currentValue;
  final Color color;
  final double height;

  const ModernProgressIndicator({
    super.key,
    required this.maxValue,
    required this.currentValue,
    required this.color,
    this.height = 8,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var x = boxConstraints.maxWidth;
        var percent = (currentValue / maxValue) * x;
        return Stack(
          children: [
            Container(
              width: x,
              height: height,
              decoration: BoxDecoration(
                color: Palette.lightGrey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: percent,
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        );
      },
    );
  }
}
