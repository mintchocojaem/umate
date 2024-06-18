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
    //이거 일정 추가하는 부분이랑 provider 분리해서 써야함. 지금은 하나로 되어 있어서
    //쓰낵바 띄우면 canpop 오류 나서 뒤로가기 표시됨
    ref.listen(
      timetableProvider,
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

    final timetable = ref.watch(timetableProvider);

    return OrbScaffold(
      padding: EdgeInsets.zero,
      appBar: OrbAppBar(
        title: '시간표',
        isLoading: timetable.isLoading,
        trailing: timetable.hasValue
            ? Row(
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
                              'startHour':
                                  timetable.requireValue.startHour.toString(),
                              'endHour': (timetable.requireValue.endHour - 1)
                                  .toString(),
                            },
                          );
                        },
                        onAddSchedule: () async {
                          ref.read(routerServiceProvider).pop();
                          await ref.read(routerServiceProvider).pushNamed(
                            AppRoute.addSchedule.name,
                            queryParameters: {
                              'startHour':
                                  timetable.requireValue.startHour.toString(),
                              'endHour': (timetable.requireValue.endHour - 1)
                                  .toString(),
                              'weekdays':
                                  timetable.requireValue.weekdays.toString(),
                            },
                          );
                        },
                      ).show(context);
                    },
                  ),
                ],
              )
            : null,
      ),
      body: timetable.when(
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
