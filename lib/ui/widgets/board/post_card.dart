import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_text_theme.dart';

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
    required this.nickname,
  });

  final String title;
  final String subtitle;
  final String publishDate;
  final String? thumbnailUrl;
  final int imageCount;
  final int commentCount;
  final int likeCount;
  final String nickname;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          Image.asset("assets/icons/user/profile_icon.png")
                              .image,
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      nickname,
                      style: regularStyle.copyWith(
                          color: Palette.darkGrey, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      publishDate,
                      style: tinyStyle.copyWith(color: Palette.grey),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                  child: Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: regularStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Palette.lightBlack)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 8),
                  child: SizedBox(
                    height: 42,
                    child: Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: lightStyle.copyWith(color: Palette.grey),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      spacing: 12,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/post/like_unselected.png",
                              width: 14,
                              height: 14,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              likeCount.toString(),
                              style: lightStyle.copyWith(
                                  color: Palette.grey,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/post/comment_unselected.png",
                              width: 14,
                              height: 14,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              commentCount.toString(),
                              style: lightStyle.copyWith(
                                  color: Palette.grey,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 32,
          ),
          Container(
            decoration: BoxDecoration(
              color: Palette.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            height: 100,
            width: 100,
          )
        ],
      ),
    );
  }
}
