import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      onChanged: (text) {},
      decoration: const InputDecoration(
        hintText: "검색",
        border: InputBorder.none,
        icon: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}
