import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_text_theme.dart';

class BoardList extends StatelessWidget {
  final List<Widget> cards;
  final Widget? description;
  final String title;
  final Widget? action;
  final VoidCallback? onTapAction;

  const BoardList(
      {super.key,
      required this.cards,
      this.description,
      required this.title,
      this.action,
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
                  color: Palette.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(right: 20.0, left: 20, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: smallTitleStyle.copyWith(color: Palette.black),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    description ?? const SizedBox()
                  ],
                ),
                SizedBox(
                  height: 42,
                  child: action != null
                      ? InkWell(onTap: onTapAction, child: action)
                      : const SizedBox(),
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
              },
            )
          ],
        ),
      ),
    );
  }
}
