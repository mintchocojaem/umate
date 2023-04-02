import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html2md/html2md.dart' as html2md;

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
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nickname,
                          style: regularStyle.copyWith(
                              color: Palette.darkGrey, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          publishDate,
                          style: tinyStyle.copyWith(color: Palette.grey),
                        ),
                      ],
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
                    child: Markdown(
                      selectable: false,
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      softLineBreak: true,
                      shrinkWrap: true,
                      styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
                      styleSheet: MarkdownStyleSheet(
                        //text
                        em: regularStyle.copyWith(
                            color: Palette.darkGrey,
                            fontStyle: FontStyle.normal),
                        del: regularStyle.copyWith(
                            color: Palette.darkGrey,
                            fontStyle: FontStyle.normal),
                        strong: regularStyle.copyWith(
                            color: Palette.darkGrey,
                            fontWeight: FontWeight.normal),
                        //heading
                        h1: regularStyle.copyWith(
                            color: Palette.darkGrey),
                        //sub
                        h2: regularStyle.copyWith(
                            color: Palette.darkGrey),
                        h3: regularStyle.copyWith(
                            color: Palette.darkGrey),
                        h4: regularStyle.copyWith(
                            color: Palette.darkGrey),
                        h5: regularStyle.copyWith(
                            color: Palette.darkGrey),
                        h6: regularStyle.copyWith(
                            color: Palette.darkGrey),
                        //body
                        p: regularStyle.copyWith(
                            color: Palette.darkGrey,
                            fontWeight: FontWeight.normal),
                        //link
                        a: regularStyle.copyWith(
                            color: Palette.lightBlue,
                            decoration: TextDecoration.underline),
                        //code
                        code: regularStyle.copyWith(
                            color: Palette.darkGrey,
                            backgroundColor: Palette.lightGrey),
                        //codeblock
                        codeblockDecoration: BoxDecoration(
                          color: Palette.lightGrey,
                        ),
                        //blockquote
                        blockquoteDecoration: BoxDecoration(
                          color: Palette.lightGrey,
                        ),
                        //table
                        tableHead: regularStyle.copyWith(
                            color: Palette.darkGrey,
                            fontWeight: FontWeight.bold),
                        tableBody: regularStyle.copyWith(
                            color: Palette.darkGrey,
                            fontWeight: FontWeight.normal),
                        tableBorder: TableBorder.all(
                          color: Palette.lightGrey,
                          width: 1,
                        ),
                        //list
                        listBullet: regularStyle.copyWith(
                            color: Palette.darkGrey,
                            fontWeight: FontWeight.normal),
                        listBulletPadding: const EdgeInsets.only(left: 8),
                        listIndent: 8,
                      ),
                      data: html2md.convert(
                        subtitle.replaceAll("\n", " ").replaceAll("\r", ""),
                      ),
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
            width: 16,
          ),
          Container(
            decoration: BoxDecoration(
              color: Palette.lightGrey,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            height: 100,
            width: 100,
          ),
        ],
      ),
    );
  }
}
