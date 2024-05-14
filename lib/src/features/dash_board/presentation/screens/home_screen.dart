import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../../../timetable/domain/models/week_days.dart';
import '../../dash_board_dependency_injections.dart';
import '../providers/states/home_board_state.dart';
import '../widgets/home_banner.dart';
import '../widgets/home_board_card.dart';
import '../widgets/home_bottom_menu_bar.dart';
import '../widgets/home_today_schedule.dart';

class HomeScreen extends ConsumerWidget with DateTimeFormatter {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      homeBoardProvider,
      (prev, next) {
        if (next is HomeBoardFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            OrbSnackBar(
              message: next.message,
              type: OrbSnackBarType.error,
            ),
          );
        }
      },
    );

    final homeBoardState = ref.watch(homeBoardProvider);

    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return OrbScaffold(
      backgroundColor: currentPalette.surfaceBright,
      appBar: OrbAppBar(
        backgroundColor: currentPalette.primary,
        title: "U Mate",
        titleColor: currentPalette.onPrimary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/images/logo.png',
            width: 40,
            height: 40,
            color: currentPalette.onPrimary,
          ),
        ),
      ),
      padding: EdgeInsets.zero,
      body: RefreshIndicator(
        color: currentPalette.primary,
        onRefresh: () {
          return ref.read(homeBoardProvider.notifier).getHomeBoard(
                isRefresh: true,
              );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              switch (homeBoardState) {
                HomeBoardSuccessState success => HomeBanner(
                    banners: success.homeBoard.carousels
                        .map(
                          (e) => InkWell(
                            onTap: () async {
                              final redirectType = e.redirectUrl.split("/")[1];
                              final redirectId = e.redirectUrl.split("/")[2];
                              switch (redirectType) {
                                case "notice":
                                  ref.read(routerServiceProvider).pushNamed(
                                    AppRoute.noticePost.name,
                                    pathParameters: {
                                      "id": redirectId,
                                    },
                                  );
                                  break;
                                case "coalition":
                                  ref.read(routerServiceProvider).pushNamed(
                                    AppRoute.coalitionPost.name,
                                    pathParameters: {
                                      "id": redirectId,
                                    },
                                  );
                                  break;
                                case "petition":
                                  ref.read(routerServiceProvider).pushNamed(
                                    AppRoute.petitionPost.name,
                                    pathParameters: {
                                      "id": redirectId,
                                    },
                                  );
                                  break;
                                default:
                                  await launchUrlString(e.redirectUrl);
                                  break;
                              }
                            },
                            child: Image.network(e.url, fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  color: currentPalette.onPrimary,
                                ),
                              );
                            }, errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 512,
                                height: 512,
                                color: currentPalette.outline,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      currentPalette.onPrimary,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                        .toList(),
                  ),
                _ => HomeBanner(
                    banners: List.generate(
                      3,
                      (index) => Container(
                        width: 512,
                        height: 512,
                        color: currentPalette.outline,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              currentPalette.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              },
              const SizedBox(
                height: 16,
              ),
              Container(
                color: currentPalette.background,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              OrbIcon(
                                Icons.calendar_today_rounded,
                                color: currentPalette.secondary,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const OrbText(
                                "오늘의 일정",
                                type: OrbTextType.titleSmall,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          switch (homeBoardState) {
                            HomeBoardSuccessState success => Builder(
                                builder: (context) {
                                  final items = <TodayScheduleItem>[];
                                  for (final schedule
                                      in success.homeBoard.schedules) {
                                    for (final time in schedule.times) {
                                      if (time.day ==
                                          WeekDays.values[
                                              DateTime.now().weekday - 1]) {
                                        items.add(
                                          TodayScheduleItem(
                                            title: schedule.name,
                                            startTime: time.startTime,
                                            endTime: time.endTime,
                                            place: time.place,
                                            professor: schedule.professor,
                                            color: schedule.color,
                                          ),
                                        );
                                      }
                                    }
                                  }
                                  return HomeTodaySchedule(
                                    schedules: items,
                                  );
                                },
                              ),
                            _ => const OrbShimmerContent(),
                          }
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                color: currentPalette.background,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              OrbIcon(
                                Icons.local_fire_department_rounded,
                                color: currentPalette.error,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const OrbText(
                                "가장 인기있는 청원",
                                type: OrbTextType.titleSmall,
                              ),
                            ],
                          ),
                        ),
                        switch (homeBoardState) {
                          HomeBoardSuccessState success =>
                            success.homeBoard.petitions.isEmpty
                                ? const SizedBox(
                                    height: 64,
                                    child: Center(
                                      child: OrbText(
                                        "진행중인 청원이 존재하지 않아요.",
                                        type: OrbTextType.bodyMedium,
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Row(
                                        children: [
                                          ...List.generate(
                                            5,
                                            (index) => HomeBoardCard(
                                              info: "BEST ${index + 1}",
                                              title: success.homeBoard
                                                  .petitions[index].title,
                                              createdAt: dateFormatToRelative(
                                                success.homeBoard
                                                    .petitions[index].createdAt,
                                              ),
                                              viewCount: success.homeBoard
                                                  .petitions[index].views,
                                              onTap: () {
                                                ref
                                                    .read(routerServiceProvider)
                                                    .pushNamed(
                                                  AppRoute.petitionPost.name,
                                                  pathParameters: {
                                                    "id": success.homeBoard
                                                        .petitions[index].id
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
                          _ => const OrbShimmerContent(),
                        }
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    HomeBottomMenuBar(),
                    SizedBox(
                      width: 16,
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
    );
  }
}
