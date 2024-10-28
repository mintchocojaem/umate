import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../../../timetable/domain/models/week_days.dart';
import '../controllers/home_controller.dart';
import '../widgets/board_card.dart';
import '../widgets/carousel_indicator.dart';
import '../widgets/extra_menu_bar.dart';
import '../widgets/today_schedule.dart';
import '../widgets/web_banner.dart';

class HomeScreen extends ConsumerWidget with DateTimeFormatter {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      homeControllerProvider,
      (_, next) {
        if (!next.isLoading && next.hasError) {
          final error = next.error;
          if (error is! AppException) return;
          context.showErrorSnackBar(
            error: error,
          );
        }
      },
    );

    final homeBoard = ref.watch(homeControllerProvider);

    ValueNotifier<int> currentBannerIndex = ValueNotifier<int>(0);

    return OrbScaffold(
      backgroundColor: context.palette.surfaceBright,
      appBar: OrbAppBar(
        backgroundColor: context.palette.background,
        title: "U Mate",
        titleColor: context.palette.surfaceDim,
      ),
      padding: EdgeInsets.zero,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(homeControllerProvider);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              homeBoard.when(
                data: (data) {
                  return ValueListenableBuilder(
                    valueListenable: currentBannerIndex,
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              WebBanner(
                                urls: data.carousels.map((e) => e.url).toList(),
                                onTap: (index) {
                                  return () async {};
                                },
                                onPageChanged: (int index) {
                                  currentBannerIndex.value = index;
                                },
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: CarouselIndicator(
                                      length: data.carousels.length,
                                      currentIndex: value,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                loading: () => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * (9 / 16),
                  color: context.palette.outline,
                ),
                error: (error, stackTrace) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * (9 / 16),
                    color: context.palette.outline,
                    child: OrbIcon(
                      Icons.image_not_supported,
                      size: OrbIconSize.large,
                      color: context.palette.error,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              OrbBoardContainer(
                title: "오늘의 일정",
                leading: OrbIcon(
                  Icons.calendar_today_rounded,
                  color: context.palette.secondary,
                ),
                child: homeBoard.when(
                  data: (data) {
                    final items = <TodayScheduleItem>[];
                    for (final schedule in data.schedules) {
                      for (final time in schedule.times) {
                        if (time.day ==
                            WeekDays.values[DateTime.now().weekday - 1]) {
                          items.add(
                            TodayScheduleItem(
                              title: schedule.name,
                              startTime: time.start,
                              endTime: time.end,
                              place: time.place,
                              professor: schedule.professor,
                              color: schedule.color,
                            ),
                          );
                        }
                      }
                    }
                    return TodaySchedule(
                      schedules: items,
                    );
                  },
                  loading: () => const OrbShimmerContent(),
                  error: (error, stackTrace) => const OrbShimmerContent(),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              OrbBoardContainer(
                title: "가장 인기있는 청원",
                isHorizontalScrollable: true,
                leading: OrbIcon(
                  Icons.local_fire_department_rounded,
                  color: context.palette.error,
                ),
                child: homeBoard.when(
                  data: (data) {
                    return data.petitions.isEmpty
                        ? const SizedBox(
                            height: 100,
                            child: Center(
                              child: OrbText(
                                "진행중인 청원이 존재하지 않아요.",
                                type: OrbTextType.bodyMedium,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...List.generate(
                                      data.petitions.length > 5
                                          ? 5
                                          : data.petitions.length,
                                      (index) => BoardCard(
                                        info: "BEST ${index + 1}",
                                        title: data.petitions[index].title,
                                        createdAt: dateFormatToRelative(
                                          data.petitions[index].createdAt,
                                        ),
                                        viewCount: data.petitions[index].views,
                                        onTap: () {
                                          ref
                                              .read(routerServiceProvider)
                                              .pushNamed(
                                            AppRoute.petitionPost.name,
                                            pathParameters: {
                                              "id": data.petitions[index].id
                                                  .toString(),
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                  },
                  loading: () => const OrbShimmerContent(),
                  error: (error, stackTrace) => const OrbShimmerContent(),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Row(
                      children: [
                        ExtraMenu(
                          title: '도서관',
                          content: '열람실 자리',
                          imagePath: 'assets/icons/books.png',
                          url:
                              'https://libseat.dankook.ac.kr/mobile/PA/roomList.php?campus=J',
                        ),
                        ExtraMenu(
                          title: '학식',
                          content: '오늘의 메뉴',
                          imagePath: 'assets/icons/school_meal.png',
                          url: 'https://www.dankook.ac.kr/web/kor/-556',
                        ),
                        ExtraMenu(
                          title: '학사일정',
                          content: '곧 있을 행사',
                          imagePath: 'assets/icons/school_schedule.png',
                          url: 'https://www.dankook.ac.kr/web/kor/-2014-',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
