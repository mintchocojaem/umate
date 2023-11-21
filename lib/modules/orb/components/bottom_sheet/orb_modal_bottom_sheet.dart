import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrbModalBottomSheet extends StatelessWidget {
  const OrbModalBottomSheet({
    Key? key,
    this.child,
    this.topAction,
  }) : super(key: key);

  final Widget? child;
  final Widget? topAction;

  Future<void> show(context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => OrbModalBottomSheet(
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
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
            Container(
              height: 4,
              width: 56,
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: themeData.colorScheme.onSurface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
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
