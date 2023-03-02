import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class CategoryButtonBar extends StatefulWidget {
  const CategoryButtonBar({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryButtonBar();
  }


}

class _CategoryButtonBar extends State<CategoryButtonBar> {

  int _currentIndex = 0;

  final List<String> _buttonTitles = [
    "청원중",
    "답변대기중",
    "답변완료",
    "기간만료",
  ];

  @override
  Widget build(BuildContext context) {

    final deviceWidth = MediaQuery.of(context).size.width;
    final categoryButtonWidth = deviceWidth / 5.0;
    final categoryButtonPadding = (deviceWidth - 40.0) / 24.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _buttonTitles.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 5.0, right: categoryButtonPadding, bottom: 5.0),
              child: SizedBox(
                width: categoryButtonWidth,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: _currentIndex == index ? blue : white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: darkGrey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    _buttonTitles[index],
                    style: TextStyle(
                      color: _currentIndex == index ? white : darkGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
