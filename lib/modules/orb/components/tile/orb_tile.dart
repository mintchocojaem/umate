import 'package:flutter/material.dart';

class OrbTile extends StatelessWidget {
  final String title;
  final String? body;
  final Icon? leading;
  final Icon? trailing;
  final VoidCallback? onTap;

  const OrbTile({
    super.key,
    required this.title,
    this.body,
    this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          leading ?? const SizedBox(),
          leading != null ? const SizedBox(
            width: 16,
          ) : const SizedBox(),
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: themeData.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          body != null
              ? Expanded(
                  flex: 2,
                  child: Text(
                    body!,
                    style: themeData.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : const SizedBox(),
          trailing ?? const SizedBox(),
        ],
      ),
    );
  }
}
