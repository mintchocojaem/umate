import 'package:carousel_slider/carousel_slider.dart';
import 'package:danvery/routes/route_path.dart';
import 'package:danvery/routes/router_provider.dart';
import 'package:danvery/screens/main/home/widgets/bus_list_tile.dart';
import 'package:danvery/screens/main/home/widgets/extra_menu.dart';
import 'package:danvery/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/domain.dart';
import '../../../modules/orb/components/components.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData themeData = Theme.of(context);
    final bus = ref.watch(busProvider);
    final homeBoard = ref.watch(homeBoardProvider);
    return OrbScaffold(
      shrinkWrap: true,
      orbAppBar: OrbAppBar(
        title: "Danvery",
        titleStyle: themeData.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: [
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
            ].map(
              (e) {
                return Builder(
                  builder: (context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: e,
                    );
                  },
                );
              },
            ).toList(),
            options: CarouselOptions(
              clipBehavior: Clip.hardEdge,
              aspectRatio: 1.2,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 10),
              autoPlayAnimationDuration: const Duration(seconds: 2),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          OrbBoardContainer(
            titleText: "버스정보",
            infoText: "Beta",
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: themeData.textTheme.bodyMedium?.fontSize,
            ),
            child: bus.when(
              data: (busList) {
                final jungmoonBus24 = busList.jungmoonBus.busArrivalList
                    .where((element) => element.busNo == "24")
                    .single;
                final jungmoonBus720_3 = busList.jungmoonBus.busArrivalList
                    .where((element) => element.busNo == "720-3")
                    .single;
                final jungmoonBus8100 = busList.jungmoonBus.busArrivalList
                    .where((element) => element.busNo == "8100")
                    .single;
                final jungmoonBus102 = busList.jungmoonBus.busArrivalList
                    .where((element) => element.busNo == "102")
                    .single;
                final jungmoonBus1101 = busList.jungmoonBus.busArrivalList
                    .where((element) => element.busNo == "1101")
                    .single;
                final jungmoonBusShuttle = busList.jungmoonBus.busArrivalList
                    .where((element) => element.busNo == "shuttle-bus")
                    .single;
                final gomsangBus24 = busList.gomsangBus.busArrivalList
                    .where((element) => element.busNo == "24")
                    .single;
                final gomsangBus720_3 = busList.gomsangBus.busArrivalList
                    .where((element) => element.busNo == "720-3")
                    .single;
                final gomsangBusShuttle = busList.gomsangBus.busArrivalList
                    .where((element) => element.busNo == "shuttle-bus")
                    .single;
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    BusListTile(
                      jungmoonBus: jungmoonBusShuttle,
                      gomsangBus: gomsangBusShuttle,
                      color: Colors.blue,
                    ),
                    const OrbDivider(),
                    BusListTile(
                      jungmoonBus: jungmoonBus24,
                      gomsangBus: gomsangBus24,
                      color: Colors.lightGreen,
                    ),
                    const OrbDivider(),
                    BusListTile(
                      jungmoonBus: jungmoonBus720_3,
                      gomsangBus: gomsangBus720_3,
                      color: Colors.lightGreen,
                    ),
                    const OrbDivider(),
                    BusListTile(
                      jungmoonBus: jungmoonBus8100,
                      color: Colors.red,
                    ),
                    const OrbDivider(),
                    BusListTile(
                      jungmoonBus: jungmoonBus102,
                      color: Colors.red,
                    ),
                    const OrbDivider(),
                    BusListTile(
                      jungmoonBus: jungmoonBus1101,
                      color: Colors.red,
                    ),
                  ],
                );
              },
              loading: () => const OrbShimmerContent(),
              error: (error, stack) => const OrbShimmerContent(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          OrbBoardContainer(
            titleText: "청원게시판",
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: themeData.textTheme.bodyMedium?.fontSize,
            ),
            onTap: () {
              ref.read(pageControllerProvider).animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
              );
            },
            child: homeBoard.when(
              data: (posts) {
                final length = homeBoard.value!.content.length >= 5
                    ? 5
                    : homeBoard.value!.content.length;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: length,
                  itemBuilder: (context, index) {
                    final petition = homeBoard.value!.content[index];
                    return Column(
                      children: [
                        OrbListTile(
                          titleText: DateFormat("yy.MM.dd")
                              .format(DateTime.parse(petition.createdAt)),
                          boldTitleText: true,
                          contentText: petition.title,
                          onTap: (){
                            ref.read(routerProvider).push(
                              RouteInfo.petitionDetail.fullPath,
                              extra: petition.id,
                            );
                          },
                        ),
                        if (index != length - 1)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: OrbDivider(),
                          ),
                      ],
                    );
                  },
                );
              },
              loading: () => const OrbShimmerContent(),
              error: (error, stack) => const OrbShimmerContent(),
            ),
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
                url:
                    'https://libseat.dankook.ac.kr/mobile/PA/roomList.php?campus=J',
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
