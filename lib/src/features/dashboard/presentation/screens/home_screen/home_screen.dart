import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../modules/modules.dart';
import '../../../../features.dart';

part 'home_screen_provider.dart';

part 'home_banner.dart';

part 'home_petition_board.dart';

part 'home_bottom_menu_bar.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    final screenNotifier = ref.watch(homeScreenProvider.notifier);
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: OrbAppBar(
        title: "Danvery",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeBanner(
              bannerPath: [
                "assets/images/test.png",
                "assets/images/test.png",
                "assets/images/test.png",
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: OrbBoardContainer(
                titleText: "청원 게시판",
                child: ref.watch(homeScreenProvider).petitionBoard.when(
                      data: (state) {
                        final petitionList = state.content;
                        return HomePetitionBoard(
                          petitionInfoList: petitionList
                              .map(
                                (e) => HomePetitionPostInfo(
                                  id: e.id,
                                  title: e.title,
                                  body: e.body,
                                  createdAt: screenNotifier
                                      .petitionCreatedAt(e.createdAt),
                                  onTap: (id) {},
                                ),
                              )
                              .toList(),
                        );
                      },
                      loading: () => const OrbShimmerContent(),
                      error: (error, stack) => const OrbShimmerContent(),
                    ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: HomeBottomMenuBar(
                menuList: [
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
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
