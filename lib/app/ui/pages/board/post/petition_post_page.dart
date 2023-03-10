import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PetitionPostPage extends StatefulWidget {
  const PetitionPostPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PetitionPostPage();
  }

}

class _PetitionPostPage extends State<PetitionPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  //color: black,
                ),
                onPressed: () => {Navigator.pop(context)}),
            title: Text(
              '청원게시판',
              style: TextStyle(
                fontSize: 18.0,
                //color: black,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: PetitionPostView(
          title: '여기는 제목 1',
          poster: '123',
          content: '여기는 내용이 나올 곳',
          publishDate: " 날짜는 01/15 12:39",
          commentCnt: 3,
          likeCnt: 10,
        ),
      ),
    );
  }
}

class PetitionPostView extends StatelessWidget {
  final String title;
  final String poster; // 글쓴이
  final String content;
  final String? publishDate; // null 수정 예정
  final String? imageUrl;
  final int? commentCnt;
  final int? likeCnt;

  const PetitionPostView(
      {super.key,
      required this.title,
      required this.poster,
      required this.content,
      this.publishDate,
      this.imageUrl,
      this.commentCnt,
      this.likeCnt});

  @override
  Widget build(BuildContext context) {
    void dialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              icon: Icon(
                Icons.check_circle_outline,
                //color: blue,
                size: 30.0,
              ),
              title: Text(
                "동의가 완료되었습니다.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          });
    }

    TextEditingController agreementTextController = TextEditingController();
    String agreement = "동의합니다.";

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "[학생복지]",
                style: TextStyle(
                  //color: lightBlue,
                  fontSize: 14.0,
                ),
              ),
              Text(
                "셔틀버스 실시간 위치 정보 공유 청원",
                style: TextStyle(
                  //color: black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "청원기간",
                        style: TextStyle(
                          //color: grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Text(
                        "2023-01-15 ~ 2023-02-15",
                        style: TextStyle(
                          //color: grey,
                          fontSize: 16.0,
                        ),
                      ),
                      flex: 4,
                    ),
                    Expanded(
                      child: Text(
                        "청원상태",
                        style: TextStyle(
                          //color: grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Text(
                        "답변완료",
                        style: TextStyle(
                          //color: blue,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(
                    thickness: 1,
                    //color: brightGrey
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(content),
              ),
              PetitionAnswer(),
              Row(
                children: [
                  Text(
                    "참여인원 ",
                    style: TextStyle(
                      //color: grey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "8명",
                    style: TextStyle(
                      //color: blue,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 50,
                        child: TextField(
                          controller: agreementTextController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                //color: brightGrey,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                //color: brightGrey,
                              ),
                            ),
                            hintText: '동의합니다.',
                            hintStyle: TextStyle(
                              //color: brightGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ElevatedButton(
                          child: Text(
                            "동의",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => {dialog()},
                          style: ElevatedButton.styleFrom(
                            //backgroundColor: blue,
                            //foregroundColor: white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
            thickness: 5,
            //color: brightGrey
        ),

        //댓글 위젯
        Comment(),
      ],
    );
  }
}

class PetitionAnswer extends StatelessWidget {
  const PetitionAnswer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          //color: whiteGrey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                "답변",
                style: TextStyle(
                  //color: grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
                "학우분들의 청원에 대한 답변을 드립니다.\n\n해당 정보를 제휴 버스 사업체와 협의 후에 최대한 빠르게 제공을 하기 위해 노력하겠습니다.\n\n감사합니다."),
          ],
        ),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> _comments = [
      "코멘트1",
      "코멘트2",
      "코멘트3",
      "코멘트4",
      "코멘트5",
      "코멘트6",
      "코멘트7",
      "코멘트8",
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _comments.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  _comments[index],
                  style: TextStyle(
                    //color: black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "동의합니다.",
                  style: TextStyle(
                    //color: black,
                    fontSize: 18.0,
                  ),
                ),
                trailing: Text(
                  "01/15 12:39",
                  style: TextStyle(
                    //color: darkGrey,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                //color: brightGrey,
              ),
            ],
          ),
        );
      },
    );
  }
}
