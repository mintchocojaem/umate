import 'package:flutter/material.dart';
import 'package:umate/src/core/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../design_system/orb/orb.dart';

class ExtraMenu extends StatelessWidget {
  final String title;
  final String content;
  final String imagePath;
  final String url;

  const ExtraMenu({
    super.key,
    required this.title,
    required this.content,
    required this.imagePath,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
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
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: context.palette.background,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrbText(
                title,
                textAlign: TextAlign.start,
                type: OrbTextType.bodyLarge,
                fontWeight: OrbFontWeight.medium,
              ),
              const SizedBox(
                height: 4,
              ),
              OrbText(
                content,
                type: OrbTextType.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  imagePath,
                  width: 32,
                  height: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}