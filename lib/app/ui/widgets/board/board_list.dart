import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/palette.dart';

class BoardList extends StatelessWidget {
  final List<Widget> cards;
  final String title;
  final String actionTitle;
  final bool showAction;
  final VoidCallback? onTapAction;

  const BoardList(
      {super.key,
      required this.cards,
      required this.title,
      required this.actionTitle,
      this.showAction = true,
      this.onTapAction});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? Palette.darkGrey : Palette.pureWhite,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          context.isDarkMode
              ? const BoxShadow()
              : BoxShadow(
                  color: Palette.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: titleStyle,
                ),
                GestureDetector(
                  onTap: onTapAction,
                  child: SizedBox(
                    height: 42,
                    width: 80,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          actionTitle,
                          style: regularStyle.copyWith(color: Palette.grey),
                        ),
                        showAction
                            ? Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Palette.grey,
                          size: regularStyle.fontSize,
                        )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 8),
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) {
                  return cards[index];
                })
          ],
        ),
      ),
    );
  }
}
