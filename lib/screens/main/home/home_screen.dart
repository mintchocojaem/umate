import 'package:danvery/screens/main/home/widgets/extra_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/orb/components/components.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrbScaffold(
      shrinkWrap: true,
      orbAppBar: const OrbAppBar(
        title: "Danvery",
      ),
      body: Column(
        children: [
          OrbImageBoard(
            titleText: "소식 / 이벤트",
            images: [
              Image.asset(
                "assets/icons/test/test1.png",
                fit: BoxFit.fill,
              ),
              Image.asset(
                "assets/icons/test/test2.png",
                fit: BoxFit.fill,
              ),
              Image.asset(
                "assets/icons/test/test3.png",
                fit: BoxFit.fill,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          OrbCardBoard(
            titleText: "버스 정보",
            infoText: "Beta",
            orbContentTiles: [
              OrbCardTile(
                titleText: "24",
                titleTextColor: Colors.lightGreen,
                contentText: "정문 출발",
                subContentText: "곧 도착",
              ),
              OrbCardTile(
                titleText: "8100",
                titleTextColor: Colors.red,
                contentText: "정문 출발",
                subContentText: "정보 없음",
              ),
              OrbCardTile(
                titleText: "셔틀",
                titleTextColor: Colors.blue,
                contentText: "정문 출발",
                subContentText: "2분 후",
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          OrbListBoard(
            titleText: "청원게시판",
            orbListTiles: [
              OrbListTile(
                  titleText: '23.09.12', contentText: '상경관과 인문관 사이에 벤치 설치해주세요'),
              OrbListTile(
                  titleText: '23.09.12', contentText: '대운동장에 곰인형 설치해주세요'),
              OrbListTile(
                  titleText: '23.09.12',
                  contentText: '안녕하세요, 저는 소프트웨어학과 동문입니다'),
              OrbListTile(titleText: '23.09.12', contentText: '이런 청원은 어떠신가요?'),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const ExtraMenu(
            items: [
              MenuItem(
                title: '도서관',
                content: '열람실 자리',
                imagePath: 'assets/icons/app/books.png',
                url: 'https://libseat.dankook.ac.kr/mobile/PA/roomList.php?campus=J',
              ),
              MenuItem(
                title: '학식',
                content: '오늘 메뉴',
                imagePath: 'assets/icons/app/school_meal.png',
                url: 'https://www.dankook.ac.kr/web/kor/-556',
              ),
              MenuItem(
                title: '학사일정',
                content: '곧 있을 행사',
                imagePath: 'assets/icons/app/school_schedule.png',
                url: 'https://www.dankook.ac.kr/web/kor/-2014-',
              ),
              MenuItem(
                title: '총학생회',
                content: '웹사이트',
                imagePath: 'assets/icons/app/student_council.png',
                url: 'https://dkustu.com/',
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
