import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrbModalBottomSheet extends StatelessWidget {
  const OrbModalBottomSheet({
    super.key,
    this.child,
    this.topAction,
    this.height,
    this.showTopDragHolder = true,
    this.titleText,
  });

  final Widget? child;
  final Widget? topAction;
  final double? height;
  final bool showTopDragHolder;
  final String? titleText;

  Future<void> show(context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => OrbModalBottomSheet(
        showTopDragHolder: showTopDragHolder,
        titleText: titleText,
        topAction: topAction,
        height: height,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: themeData.colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            showTopDragHolder ? Container(
              height: 4,
              width: 56,
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: themeData.colorScheme.onSurface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ) : const SizedBox(),
            titleText != null ? Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    titleText!,
                    style: themeData.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ) : const SizedBox(),
            if (topAction != null) topAction!,
            Expanded(
              child: child ?? const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
