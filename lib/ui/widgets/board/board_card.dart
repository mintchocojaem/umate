import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_text_theme.dart';

class BoardCard extends StatelessWidget {
  final String title;
  final String? leadingText;
  final Widget? leadingImage;
  final String? trailingText;
  final VoidCallback? onTap;

  const BoardCard({
    super.key,
    this.leadingText,
    this.leadingImage,
    required this.title,
    this.trailingText,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(0),
      visualDensity: const VisualDensity(vertical: -3),
      dense: true,
      title: SizedBox(height: 24, child: Text(title, style: regularStyle, overflow: TextOverflow.ellipsis, maxLines: 1,)),
      leading: leadingImage == null
          ? leadingText == null
              ? const SizedBox()
              : SizedBox(
                  height: 24,
                  child: Text(
                    leadingText!,
                    style: regularStyle.copyWith(color: Palette.grey),
                  ))
          : SizedBox(height: 32, width: 32, child: leadingImage),
      trailing: trailingText == null
          ? const SizedBox()
          : Text(
              trailingText!,
              style: regularStyle.copyWith(color: Palette.darkGrey, fontWeight: FontWeight.w500),
            ),
    );
  }
}
