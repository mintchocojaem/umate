import 'package:flutter/material.dart';

import '../../../../design_system/orb/orb.dart';

class HomeBoardCard extends StatelessWidget {
  final String title;
  final String createdAt;
  final int viewCount;
  final String info;
  final void Function() onTap;

  const HomeBoardCard({
    super.key,
    required this.title,
    required this.createdAt,
    required this.viewCount,
    required this.info,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, right: 16,),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: currentPalette.surfaceBright,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  OrbText(
                    info,
                    type: OrbTextType.bodyMedium,
                    color: currentPalette.primary,
                    fontWeight: OrbFontWeight.medium,
                  ),
                  const Spacer(),
                  OrbText(
                    createdAt,
                    type: OrbTextType.bodySmall,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 56,
                child: OrbText(
                  title,
                  type: OrbTextType.bodyMedium,
                  maxLines: 2,
                  fontWeight: OrbFontWeight.medium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.remove_red_eye_rounded,
                    color: currentPalette.primary,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  OrbText(
                    "$viewCount",
                    type: OrbTextType.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
