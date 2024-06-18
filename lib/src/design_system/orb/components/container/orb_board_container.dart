import 'package:flutter/material.dart';

import '../../orb.dart';

class OrbBoardContainer extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final Widget? child;
  final Function()? onTap;
  final bool isHorizontalScrollable;

  const OrbBoardContainer({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.child,
    this.onTap,
    this.isHorizontalScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final themeData = OrbThemeData.of(context);
    final palette = themeData.palette;
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      reverseDuration: const Duration(milliseconds: 500),
      child: Container(
        color: palette.background,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      leading ?? const SizedBox(),
                      const SizedBox(
                        width: 8,
                      ),
                      OrbText(
                        title,
                        type: OrbTextType.titleSmall,
                      ),
                      const Spacer(),
                      trailing ?? const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isHorizontalScrollable ? 0 : 16,
                  ),
                  child: child ?? const SizedBox(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
