import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/orb/components/components.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrbScaffold(
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
                title: "24",
                titleColor: Colors.lightGreen,
                content: "정문 출발",
                subContent: "곧 도착",
              ),
              OrbCardTile(
                title: "8100",
                titleColor: Colors.red,
                content: "정문 출발",
                subContent: "정보 없음",
              ),
              OrbCardTile(
                title: "셔틀",
                titleColor: Colors.blue,
                content: "정문 출발",
                subContent: "2분 후",
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
                  title: '23.09.12', content: '상경관과 인문관 사이에 벤치 설치해주세요'),
              OrbListTile(title: '23.09.12', content: '대운동장에 곰인형 설치해주세요'),
              OrbListTile(title: '23.09.12', content: '안녕하세요, 저는 소프트웨어학과 동문입니다'),
              OrbListTile(title: '23.09.12', content: '이런 청원은 어떠신가요?'),
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
