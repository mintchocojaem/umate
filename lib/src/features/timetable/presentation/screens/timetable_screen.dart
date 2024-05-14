import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../design_system/orb/orb.dart';
import '../../timetable_dependency_injections.dart';
import '../providers/states/schedule_state.dart';
import '../providers/states/timetable_state.dart';
import '../widgets/schedule_add_sheet.dart';
import '../widgets/schedule_table.dart';

class TimetableScreen extends ConsumerWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      timetableProvider,
      (prev, next) {
        if (next is TimetableFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            OrbSnackBar(
              message: next.message,
              type: OrbSnackBarType.error,
            ),
          );
        }
      },
    );

    ref.listen(
      scheduleProvider,
      (prev, next) async {
        if (next is ScheduleSuccessState) {
          await ref.read(timetableProvider.notifier).getFirstTimetable(
                isRefresh: true,
              );
          if(ref.read(timetableProvider) is TimetableSuccessState) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const OrbSnackBar(
                message: '시간표가 수정되었어요.',
                type: OrbSnackBarType.info,
              ),
            );
          }
        }
      },
    );

    final timetableState = ref.watch(timetableProvider);

    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);

    return OrbScaffold(
      padding: EdgeInsets.zero,
      appBar: OrbAppBar(
        title: '시간표',
        isLoading: timetableState is TimetableLoadingState,
        trailing: switch (timetableState) {
          TimetableSuccessState success => Row(
              children: [
                IconButton(
                  icon: const OrbIcon(Icons.add),
                  onPressed: () {
                    ScheduleAddSheet(
                      onAddLecture: () async {
                        ref.read(routerServiceProvider).pop();
                        await ref.read(routerServiceProvider).pushNamed(
                          AppRoute.searchLecture.name,
                          queryParameters: {
                            'startHour': success.timetable.startHour.toString(),
                            'endHour':
                                (success.timetable.endHour - 1).toString(),
                          },
                        );
                      },
                      onAddSchedule: () async {
                        ref.read(routerServiceProvider).pop();
                        await ref.read(routerServiceProvider).pushNamed(
                          AppRoute.addSchedule.name,
                          queryParameters: {
                            'startHour': success.timetable.startHour.toString(),
                            'endHour':
                                (success.timetable.endHour - 1).toString(),
                            'weekdays': success.timetable.weekdays.toString(),
                          },
                        );
                      },
                    ).show(context);
                  },
                ),
              ],
            ),
          _ => null,
        },
      ),
      body: switch (timetableState) {
        TimetableSuccessState success => ScheduleTable(
            schedules: success.timetable.schedules,
            tableStartHour: success.timetable.startHour,
            tableEndHour: success.timetable.endHour,
            weekdays: success.timetable.weekdays,
            selectedDayBackgroundColor: currentPalette.primary,
            selectedDayTextColor: currentPalette.onPrimary,
            unSelectedDayTextColor: currentPalette.surfaceDim,
            tableTimeDividerColor: currentPalette.surfaceDim,
            tableTimeTextColor: currentPalette.surfaceDim,
            onLongPressTable: (day, hour) {
              if (kDebugMode) {
                print('Long Pressed: $day, $hour');
              }
            },
            onTapSchedule: (scheduleInfo) {
              ref.read(routerServiceProvider).pushNamed(
                AppRoute.scheduleInfo.name,
                pathParameters: {
                  'id': scheduleInfo.id.toString(),
                },
                queryParameters: {
                  'startHour': success.timetable.startHour.toString(),
                  'endHour': (success.timetable.endHour - 1).toString(),
                  'weekdays': success.timetable.weekdays.toString(),
                },
              );
            },
          ),
        _ => const SizedBox(),
      },
    );
  }
}
