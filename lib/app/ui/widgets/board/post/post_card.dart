import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_theme.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.publishDate,
    this.thumbnailUrl,
    this.imageCount = 0,
    this.commentCount = 0,
    this.likeCount = 0,
    this.onTap
  });

  final String title;
  final String subtitle;
  final String publishDate;
  final String? thumbnailUrl;
  final int imageCount;
  final int commentCount;
  final int likeCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: middleStyle
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: regularStyle.copyWith(color: darkGrey),
                  ),
                ),
                trailing: thumbnailUrl != null ? Image.network(thumbnailUrl!) : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(publishDate, style: regularStyle.copyWith(color: darkGrey),),
                  Wrap(
                    spacing: 12,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.image_outlined, color: grey, size: regularStyle.fontSize),
                          const SizedBox(width: 2,),
                          Text(imageCount.toString(), style: regularStyle.copyWith(color: grey),)
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.message_outlined , color: grey, size: regularStyle.fontSize),
                          const SizedBox(width: 2,),
                          Text(commentCount.toString(), style: regularStyle.copyWith(color: grey),)
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.thumb_up_alt_outlined, color: grey, size: regularStyle.fontSize,),
                          const SizedBox(width: 2,),
                          Text(likeCount.toString(), style: regularStyle.copyWith(color: grey),)
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
