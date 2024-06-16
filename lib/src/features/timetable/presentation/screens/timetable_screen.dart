import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/app_exception.dart';
import '../../../../design_system/orb/orb.dart';
import '../providers/timetable_provider.dart';
import '../widgets/schedule_table.dart';
import '../widgets/shedule_add_sheet.dart';

class TimetableScreen extends ConsumerWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      timetableProvider,
      (_, next) {
        if (!next.isLoading && next.hasError) {
          final error = next.error;
          if (error is! AppException) return;
          if (error is AppWarning) {
            context.showSnackBar(
              message: error.message,
              type: OrbSnackBarType.warning,
            );
          } else {
            context.showSnackBar(
              message: error.message,
              type: OrbSnackBarType.error,
            );
          }
        }
      },
    );

    final timetable = ref.watch(timetableProvider);

    return OrbScaffold(
      padding: EdgeInsets.zero,
      appBar: OrbAppBar(
        title: '시간표',
        isLoading: timetable.isLoading,
        trailing: timetable.when(
          data: (data) => Row(
            children: [
              IconButton(
                icon: const OrbIcon(Icons.add),
                onPressed: () {
                  ScheduleAddSheet(
                    onAddLecture: () async {
                      ref.read(routerServiceProvider).pop();
                      await ref.read(routerServiceProvider).pushNamed(
                        AppRoute.addLecture.name,
                        queryParameters: {
                          'startHour': data.startHour.toString(),
                          'endHour': (data.endHour - 1).toString(),
                        },
                      );
                    },
                    onAddSchedule: () async {
                      ref.read(routerServiceProvider).pop();
                      await ref.read(routerServiceProvider).pushNamed(
                        AppRoute.addSchedule.name,
                        queryParameters: {
                          'startHour': data.startHour.toString(),
                          'endHour': (data.endHour - 1).toString(),
                          'weekdays': data.weekdays.toString(),
                        },
                      );
                    },
                  ).show(context);
                },
              ),
            ],
          ),
          loading: () => null,
          error: (error, _) => null,
        ),
      ),
      body: timetable.when(
        skipError: true,
        data: (data) {
          return ScheduleTable(
            schedules: data.schedules,
            tableStartHour: data.startHour,
            tableEndHour: data.endHour,
            weekdays: data.weekdays,
            selectedDayBackgroundColor: context.palette.primary,
            selectedDayTextColor: context.palette.onPrimary,
            unSelectedDayTextColor: context.palette.surfaceDim,
            tableTimeDividerColor: context.palette.surfaceDim,
            tableTimeTextColor: context.palette.surfaceDim,
            onLongPressTable: (day, hour) {
              debugPrint('Long Pressed: $day, $hour');
            },
            onTapSchedule: (schedule) {
              ref.read(routerServiceProvider).pushNamed(
                AppRoute.scheduleDetail.name,
                pathParameters: {
                  'id': schedule.id.toString(),
                },
              );
            },
          );
        },
        loading: () {
          return const SizedBox();
        },
        error: (error, _) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const OrbText(
                  "시간표를 불러오는 중 오류가 발생했어요.",
                  type: OrbTextType.bodyLarge,
                ),
                const SizedBox(height: 8),
                OrbFilledButton(
                  text: "다시 불러오기",
                  buttonSize: OrbButtonSize.compact,
                  buttonRadius: OrbButtonRadius.small,
                  buttonTextType: OrbButtonTextType.small,
                  buttonType: OrbButtonType.secondary,
                  onPressed: () async {
                    await ref.read(timetableProvider.notifier).fetch();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
