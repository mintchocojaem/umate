import 'package:flutter/material.dart';

import '../../../../design_system/orb/orb.dart';

class LectureInfoPreviewCard extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const LectureInfoPreviewCard({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrbText(
              title,
              type: OrbTextType.bodyMedium,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
