import 'package:danvery/modules/orb/components/tile/tile.dart';
import 'package:flutter/material.dart';

class CompactTile extends StatelessWidget implements Tile {
  
  @override
  final String title;
  @override
  final String? body;
  @override
  final Widget? leading;
  @override
  final VoidCallback? onTap;

  const CompactTile({
    super.key,
    required this.title,
    this.body,
    this.leading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    ThemeData themeData = Theme.of(context);
    
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) leading!,
          SizedBox(
            width: 80,
            child: Text(
              title,
              style: themeData.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          if (body != null)
            Text(
              body!,
              style: themeData.textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
