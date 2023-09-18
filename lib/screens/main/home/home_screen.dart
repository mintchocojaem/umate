import 'package:danvery/utils/exception_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../modules/orb/components/components.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData themeData = Theme.of(context);
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
          Row(
            children: [
              OrbCardTile(
                constraints: const BoxConstraints(
                  minHeight: 120,
                  minWidth: 100,
                ),
                title: Text(
                  '학교',
                  textAlign: TextAlign.start,
                  style: themeData.textTheme.bodySmall?.copyWith(
                    color: themeData.colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                content: Text(
                  '학사일정 보기',
                  style: themeData.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subContent: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/icons/app/school_schedule.png',
                    scale: 3,
                  ),
                ),
                onTap: () async{
                  final Uri url = Uri.parse('https://www.dankook.ac.kr/web/kor/-2014-');
                  if (!await launchUrl(url)) {
                  throw const ExceptionDto(
                  code: 'CANNOT_LAUNCH_URL',
                  message: '링크를 열 수 없어요',
                  );
                  }
                },
              ),
              const SizedBox(
                width: 8,
              ),
              OrbCardTile(
                constraints: const BoxConstraints(
                  minHeight: 120,
                  minWidth: 100,
                ),
                title: Text(
                  '학교',
                  textAlign: TextAlign.start,
                  style: themeData.textTheme.bodySmall?.copyWith(
                    color: themeData.colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                content: Text(
                  '오늘 학식 보기',
                  style: themeData.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subContent: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/icons/app/school_meal.png',
                    scale: 3,
                  ),
                ),
                onTap: () async {
                  final Uri url = Uri.parse('https://www.dankook.ac.kr/web/kor/-556');
                  if (!await launchUrl(url)) {
                    throw const ExceptionDto(
                      code: 'CANNOT_LAUNCH_URL',
                      message: '링크를 열 수 없어요',
                    );
                  }
                },
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
