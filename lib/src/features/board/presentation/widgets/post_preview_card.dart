import 'package:flutter/material.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../design_system/orb/orb.dart';

class PostTagItem {
  String title;

  PostTagItem({
    required this.title,
  });
}

class PostPreviewCard extends StatelessWidget {
  final String title;
  final String author;
  final String duration;
  final String content;
  final List<PostTagItem> tags;
  final VoidCallback? onTap;
  final String? imageUrl;
  final bool _showImage;

  const PostPreviewCard({
    super.key,
    required this.title,
    required this.author,
    required this.duration,
    required this.content,
    this.tags = const [],
    this.onTap,
  })  : imageUrl = null,
        _showImage = false;

  const PostPreviewCard.image({
    super.key,
    required this.title,
    required this.author,
    required this.duration,
    required this.content,
    this.tags = const [],
    this.onTap,
    this.imageUrl,
  }) : _showImage = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: context.palette.onSurface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: context.palette.surface,
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
                    color: context.palette.surface,
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 72,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OrbText(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            type: OrbTextType.bodyLarge,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: OrbText(
                              content,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              type: OrbTextType.bodyMedium,
                              fontWeight: OrbFontWeight.light,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_showImage && imageUrl != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                            width: 72,
                            height: 72,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < tags.length; i++)
                    Container(
                      margin: const EdgeInsets.only(right: 8, top: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: i == 0 ? context.palette.secondary : null,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: context.palette.secondary,
                        ),
                      ),
                      child: OrbText(
                        tags[i].title,
                        type: OrbTextType.bodySmall,
                        color: i == 0
                            ? context.palette.onSecondary
                            : context.palette.secondary,
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
