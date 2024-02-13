import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with HomeScreenController {

  late Future<PetitionBoardModel> homePetitionBoard;
  late Future<List<BusArrivalInfo>> homeBusArrivalInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePetitionBoard = getHomePetitionBoard(
      ref,
      status: PetitionStatus.expired,
      page: 0,
      size: 4,
    );
    homeBusArrivalInfo = getHomeBusArrivalInfo(
      ref,
      busInfoList: [
        BusInfo(
          busNo: "shuttle-bus",
          busColor: Colors.blueAccent,
        ),
        BusInfo(
          busNo: "24",
          busColor: Colors.lightGreen,
        ),
        BusInfo(
          busNo: "720-3",
          busColor: Colors.lightGreen,
        ),
        BusInfo(
          busNo: "8100",
          busColor: Colors.redAccent,
        ),
        BusInfo(
          busNo: "1101",
          busColor: Colors.redAccent,
        ),
        BusInfo(
          busNo: "102",
          busColor: Colors.redAccent,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      body: RefreshIndicator(
        onRefresh: () async {},
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    HomeBusInfo(
                      homeBusArrivalInfo: homeBusArrivalInfo,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    HomePetitionBoard(
                      homePetitionBoard: homePetitionBoard,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
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
                      ),
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
      ),
    );
  }
}
