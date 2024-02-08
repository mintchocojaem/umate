import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../common_widgets/common_widgets.dart';
import '../../../../../modules/modules.dart';
import '../../../../features.dart';

part 'home_screen_provider.dart';

part 'home_banner.dart';

part 'bus_list_tile.dart';

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
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: themeData.colorScheme.surface,
        centerTitle: false,
        title: Text(
          "Danvery",
          style: themeData.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverPersistentHeaderDelegateImpl(
              minHeight: 320,
              maxHeight: 352,
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: HomeBanner(
                  bannerPath: [
                    "assets/images/test.png",
                    "assets/images/test.png",
                    "assets/images/test.png",
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  OrbBoardContainer(
                    titleText: "버스 정보",
                    child: Consumer(
                      builder: (context, ref, child) {
                        final busArrivalInfo = ref
                            .watch(
                              homeScreenProvider,
                            )
                            .busArrivalInfo;
                        return busArrivalInfo.when(
                          data: (state) {
                            return Column(
                              children: [
                                BusListTile(
                                  busInfo: screenNotifier.getBusInfo(
                                    busNo: "shuttle-bus",
                                    busColor: themeData.colorScheme.primary,
                                  ),
                                ),
                                BusListTile(
                                  busInfo: screenNotifier.getBusInfo(
                                    busNo: "24",
                                    busColor: Colors.lightGreen,
                                  ),
                                ),
                                BusListTile(
                                  busInfo: screenNotifier.getBusInfo(
                                    busNo: "720-3",
                                    busColor: Colors.lightGreen,
                                  ),
                                ),
                                BusListTile(
                                  busInfo: screenNotifier.getBusInfo(
                                    busNo: "8100",
                                    busColor: Colors.red,
                                  ),
                                ),
                                BusListTile(
                                  busInfo: screenNotifier.getBusInfo(
                                    busNo: "1101",
                                    busColor: Colors.red,
                                  ),
                                ),
                                BusListTile(
                                  busInfo: screenNotifier.getBusInfo(
                                    busNo: "102",
                                    busColor: Colors.red,
                                  ),
                                ),
                              ],
                            );
                          },
                          loading: () => const OrbShimmerContent(),
                          error: (error, stack) => const OrbShimmerContent(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  OrbBoardContainer(
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
                                      createdAt:
                                          screenNotifier.petitionCreatedAt(
                                        createdAt: e.createdAt,
                                      ),
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
                  const SizedBox(
                    height: 16,
                  ),
                  const HomeBottomMenuBar(
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
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
