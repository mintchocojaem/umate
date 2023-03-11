import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:danvery/app/ui/theme/palette.dart';
import 'package:flutter/material.dart';

class CategoryButtonBar extends StatefulWidget {
  const CategoryButtonBar(
      {super.key,
      required this.categories,
      required this.selectedBackGroundColor,
      required this.unSelectedBackGroundColor,
      required this.selectedTextColor,
      required this.unSelectedTextColor});

  final List<String> categories;
  final Color selectedBackGroundColor;
  final Color unSelectedBackGroundColor;
  final Color selectedTextColor;
  final Color unSelectedTextColor;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryButtonBar();
  }
}

class _CategoryButtonBar extends State<CategoryButtonBar> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> categoryBar = [];

    for(int index =0; index<widget.categories.length; index++){
      categoryBar.add(
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: index == selectedIndex
                        ? widget.selectedBackGroundColor
                        : widget.unSelectedBackGroundColor),
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  child: Text(
                    widget.categories[index],
                    style: lightStyle.copyWith(
                        color: index == selectedIndex
                            ? widget.selectedTextColor
                            : widget.unSelectedTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoryBar,
      ),
    );
  }
}
