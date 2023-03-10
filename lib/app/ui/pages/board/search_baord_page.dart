import 'package:danvery/app/ui/theme/palette.dart';
import 'package:flutter/material.dart';

class SearchBoardPage extends StatefulWidget {
  const SearchBoardPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchBoardPage();
  }

}

class _SearchBoardPage extends State<SearchBoardPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchTextController = TextEditingController();

    void clearSearchText() {
      searchTextController.clear();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Palette.black,
                ),
                onPressed: () => {Navigator.pop(context)}),
            title: TextFormField(
              controller: searchTextController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Palette.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: '글의 제목, 내용, 키워드를 입력하세요',
                  hintStyle: TextStyle(color: Palette.grey),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () => {clearSearchText()},
                  )),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "OO게시판에서\n원하는 글을 검색해보세요",
          style: TextStyle(
            color: Palette.darkGrey,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
