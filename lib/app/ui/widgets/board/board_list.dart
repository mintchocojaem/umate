import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/palette.dart';

class BoardList extends StatefulWidget {
  final List<Widget> cards;
  final String title;
  final String actionTitle;
  final bool showAction;

  const BoardList(
      {super.key,
      required this.cards,
      required this.title,
      this.actionTitle = '',
      this.showAction = true});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BoardList();
  }
}

class _BoardList extends State<BoardList> {
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
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(right: 20.0, left: 20, top: 20, bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: titleStyle,
                ),
                Row(
                  children: [
                    Text(
                      widget.actionTitle,
                      style: regularStyle.copyWith(color: Palette.grey),
                    ),
                    widget.showAction
                        ? Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Palette.grey,
                            size: regularStyle.fontSize,
                          )
                        : Container()
                  ],
                ),
              ],
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                itemCount: widget.cards.length,
                itemBuilder: (BuildContext context, int index) {
                  return widget.cards[index];
                })
          ],
        ),
      ),
    );
  }
}
