import 'package:danvery/app/ui/theme/palette.dart';
import 'package:flutter/material.dart';
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
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: Image.asset(
                            "assets/icons/user/default_user_icon.png")
                            .image,
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(width: 8,),
                      Text("닉네임", style: regularStyle,),
                      const SizedBox(width: 8,),
                      Text(publishDate, style: tinyStyle.copyWith(color: Palette.black),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: regularStyle.copyWith(fontWeight: FontWeight.bold)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 8),
                    child: SizedBox(
                      height: regularStyle.fontSize! * 2,
                      child: Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: tinyStyle.copyWith(color: Palette.black),
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
                            children: [
                              Icon(Icons.thumb_up_alt_outlined, color: Palette.grey, size: regularStyle.fontSize,),
                              const SizedBox(width: 4,),
                              Text(likeCount.toString(), style: regularStyle.copyWith(color: Palette.grey),)
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.message_outlined , color: Palette.grey, size: regularStyle.fontSize),
                              const SizedBox(width: 4,),
                              Text(commentCount.toString(), style: regularStyle.copyWith(color: Palette.grey),)
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 32,),
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
      ),
    );
  }
}
