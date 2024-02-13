import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../modules/modules.dart';

class HomeExtraMenu extends StatelessWidget {
  final String title;
  final String content;
  final String imagePath;
  final String url;

  const HomeExtraMenu({
    super.key,
    required this.title,
    required this.content,
    required this.imagePath,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: OrbCardTile(
        title: Text(
          title,
          textAlign: TextAlign.start,
          style: themeData.textTheme.bodySmall?.copyWith(
            color: themeData.colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        content: Text(
          content,
          style: themeData.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subContent: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            imagePath,
            scale: 3,
          ),
        ),
        onTap: () async {
          if (!await launchUrl(Uri.parse(url))) {
            /*
                    throw const ExceptionDto(
                      code: 'CANNOT_LAUNCH_URL',
                      message: '링크를 열 수 없어요',
                    );
                     */
          }
        },
      ),
    );
  }
}
