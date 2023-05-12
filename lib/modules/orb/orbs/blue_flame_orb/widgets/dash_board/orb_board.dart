
import 'package:flutter/material.dart';

class OrbBoard extends StatelessWidget{

  const OrbBoard({
    super.key,
    required this.title,
    required this.trailing,
    this.child,
  });

  final String title;
  final Widget? trailing;
  final Widget? child;

  @override
  Widget build(BuildContext context) {

    ThemeData themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeData.colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: themeData.textTheme.titleMedium,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: themeData.textTheme.titleMedium!.fontSize,
                ),
              ),
            ],
          ),
          if(child != null) child!,
        ],
      ),
    );
  }
}
