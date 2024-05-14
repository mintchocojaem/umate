import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../design_system/orb/orb.dart';

class PostTagItem {
  String title;

  PostTagItem({
    required this.title,
  });
}

class PostPreviewCard extends StatelessWidget {
  final String title;
  final String content;
  final String author;
  final String duration;
  final List<PostTagItem> tags;
  final VoidCallback? onTap;
  final String? imageUrl;

  const PostPreviewCard({
    super.key,
    required this.title,
    required this.content,
    required this.author,
    required this.duration,
    this.tags = const [],
    this.onTap,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: currentPalette.onSurface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: currentPalette.surface,
              offset: const Offset(0, 1),
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  OrbText(
                    author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    type: OrbTextType.bodySmall,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  OrbText(
                    duration,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    type: OrbTextType.bodySmall,
                    color: currentPalette.surface,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        right: 16,
                        bottom: 4
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OrbText(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            type: OrbTextType.bodyLarge,
                          ),
                          SizedBox(
                            height: 64,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: OrbText(
                                content,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                type: OrbTextType.bodyMedium,
                                fontWeight: OrbFontWeight.light,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          if (kDebugMode) {
                            print(error);
                          }
                          return Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  for (int i = 0; i < tags.length; i++)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: i == 0 ? currentPalette.secondary : null,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: currentPalette.secondary,
                        ),
                      ),
                      child: OrbText(
                        tags[i].title,
                        type: OrbTextType.bodySmall,
                        color: i == 0
                            ? currentPalette.onSecondary
                            : currentPalette.secondary,
                      ),
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
