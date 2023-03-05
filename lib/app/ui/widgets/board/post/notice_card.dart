import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_theme.dart';

class NoticeCard extends StatelessWidget {
  final String category;
  final String title;
  final int imageCount;
  final int commentCount;
  final int likeCount;

  const NoticeCard({
    super.key,
    required this.category,
    required this.title,
    this.imageCount = 0,
    this.commentCount = 0,
    this.likeCount = 0
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3.0,
        child: ListTile(
            leading: Text(category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: middleStyle.copyWith(color: blue)),
            title: Text(title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: middleStyle),
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Wrap(
                spacing: 12,
                children: [
                  Row(
                    children: [
                      Icon(Icons.image_outlined,
                          color: grey, size: regularStyle.fontSize),
                      const SizedBox(width: 2,),
                      Text(
                        imageCount.toString(),
                        style: regularStyle.copyWith(color: grey),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.message_outlined,
                          color: grey, size: regularStyle.fontSize),
                      const SizedBox(width: 2,),
                      Text(
                        commentCount.toString(),
                        style: regularStyle.copyWith(color: grey),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.thumb_up_alt_outlined,
                        color: grey,
                        size: regularStyle.fontSize,
                      ),
                      const SizedBox(width: 2,),
                      Text(
                        likeCount.toString(),
                        style: regularStyle.copyWith(color: grey),
                      )
                    ],
                  )
                ],
              ),
            )
        )
    );
  }
}
