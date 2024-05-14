import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../design_system/orb/orb.dart';

class HomeBottomMenuBar extends StatelessWidget {
  const HomeBottomMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Row(
      children: [
        HomeExtraMenu(
          title: '도서관',
          content: '열람실 자리',
          imagePath: 'assets/icons/books.png',
          url:
              'https://libseat.dankook.ac.kr/mobile/PA/roomList.php?campus=J',
        ),
        HomeExtraMenu(
          title: '학식',
          content: '오늘의 메뉴',
          imagePath: 'assets/icons/school_meal.png',
          url: 'https://www.dankook.ac.kr/web/kor/-556',
        ),
        HomeExtraMenu(
          title: '학사일정',
          content: '곧 있을 행사',
          imagePath: 'assets/icons/school_schedule.png',
          url: 'https://www.dankook.ac.kr/web/kor/-2014-',
        ),
      ],
    );
  }
}

class HomeExtraMenu extends StatelessWidget {
  final String title;
  final String content;
  final String imagePath;
  final String url;

  const HomeExtraMenu({
    super.key,
    required this.title,
    required this.content,
    required this.imagePath,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () async {
          if (!await launchUrl(Uri.parse(url))) {
            /*
                    throw const ExceptionDto(
                      code: 'CANNOT_LAUNCH_URL',
                      message: '링크를 열 수 없어요',
                    );
                     */
          }
        },
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: currentPalette.background,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrbText(
                title,
                textAlign: TextAlign.start,
                type: OrbTextType.bodyLarge,
                fontWeight: OrbFontWeight.medium,
              ),
              const SizedBox(
                height: 4,
              ),
              OrbText(
                content,
                type: OrbTextType.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  imagePath,
                  width: 32,
                  height: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
