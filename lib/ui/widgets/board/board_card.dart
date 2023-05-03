import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_text_theme.dart';

class BoardCard extends StatelessWidget {
  final String title;
  final String? leadingText;
  final VoidCallback? onTap;

  const BoardCard({
    super.key,
    this.leadingText,
    required this.title,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            if (leadingText != null)
              SizedBox(
                width: 80,
                child: Text(
                  leadingText!,
                  style: regularStyle.copyWith(color: Palette.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            Expanded(
              child: Text(
                title,
                style: regularStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
