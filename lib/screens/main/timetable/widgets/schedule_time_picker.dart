import 'package:danvery/screens/main/timetable/widgets/schedule_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../modules/orb/components/components.dart';

class ScheduleTimePicker extends StatefulWidget {
  const ScheduleTimePicker({
    super.key,
    required this.weekOfDay,
    required this.timetableStartHour,
    required this.timetableEndHour,
    required this.lectureStartTime,
    required this.lectureEndTime,
    this.onWeekOfDayChanged,
    this.onStartTimeChanged,
    this.onEndTimeChanged,
  });

  final WeekDays weekOfDay;
  final int timetableStartHour;
  final int timetableEndHour;
  final TimeOfDay lectureStartTime;
  final TimeOfDay lectureEndTime;
  final ValueChanged<WeekDays>? onWeekOfDayChanged;
  final ValueChanged<ScheduleTimeFormat>? onStartTimeChanged;
  final ValueChanged<ScheduleTimeFormat>? onEndTimeChanged;

  @override
  createState() => _ScheduleTimePicker();
}

class _ScheduleTimePicker extends State<ScheduleTimePicker> {
  late final TextEditingController startTimeController;
  late final TextEditingController endTimeController;
  late final TextEditingController dayController;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final DateTime startTime = DateTime(now.year, now.month, now.day,
        widget.lectureStartTime.hour, widget.lectureStartTime.minute);
    final DateTime endTime = DateTime(now.year, now.month, now.day,
        widget.lectureEndTime.hour, widget.lectureEndTime.minute);
    startTimeController =
        TextEditingController(text: (DateFormat('HH:mm').format(startTime)));
    endTimeController =
        TextEditingController(text: (DateFormat('HH:mm').format(endTime)));
    dayController = TextEditingController(text: widget.weekOfDay.korean);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    dayController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          flex: 2,
          child: OrbTextFormField(
            hintText: "요일",
            controller: dayController,
            readOnly: true,
            onTap: () async {
              final dayScrollController = FixedExtentScrollController(
                initialItem: widget.weekOfDay.index,
              );
              await showCupertinoModalPopup(
                context: context,
                builder: (context) => Container(
                  height: 300,
                  color: Theme.of(context).colorScheme.background,
                  child: CupertinoPicker(
                    scrollController: dayScrollController,
                    itemExtent: 50,
                    onSelectedItemChanged: (value) {
                      dayController.text = WeekDays.values[value].korean;
                      widget.onWeekOfDayChanged?.call(WeekDays.values[value]);
                    },
                    children: [
                      for (final day in WeekDays.values)
                        Center(
                          child: Text(day.korean),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          flex: 3,
          child: OrbTextFormField(
            hintText: "시작 시간",
            controller: startTimeController,
            readOnly: true,
            onTap: () async {
              final hourScrollController = FixedExtentScrollController(
                initialItem:
                    int.parse(startTimeController.text.substring(0, 2))  - widget.timetableStartHour,
              );
              final minuteScrollController = FixedExtentScrollController(
                initialItem:
                    int.parse(startTimeController.text.substring(3, 5)) ~/ 10,
              );
              await showCupertinoModalPopup(
                context: context,
                builder: (context) => Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).colorScheme.background,
                  child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            flex: 3,
                            child: CupertinoPicker.builder(
                              scrollController: hourScrollController,
                              itemExtent: 50,
                              onSelectedItemChanged: (value) {
                                setState(() {
                                  startTimeController.text = ScheduleTimeFormat(
                                    hour: value + widget.timetableStartHour,
                                    minute: int.parse(
                                      startTimeController.text.substring(3, 5),
                                    ),
                                  ).toString();
                                });
                                widget.onStartTimeChanged?.call(
                                  ScheduleTimeFormat(
                                    hour: value + widget.timetableStartHour,
                                    minute: int.parse(
                                      startTimeController.text.substring(3, 5),
                                    ),
                                  ),
                                );
                              },
                              childCount: 24 - widget.timetableStartHour,
                              itemBuilder: (context, index) {
                                return Center(
                                  child:
                                      Text((index + widget.timetableStartHour).toString().padLeft(2, '0')),
                                );
                              },
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Center(
                              child: Text(
                                ":",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: CupertinoPicker.builder(
                              scrollController: minuteScrollController,
                              itemExtent: 50,
                              onSelectedItemChanged: (value) {
                                startTimeController.text = ScheduleTimeFormat(
                                  hour: int.parse(
                                    startTimeController.text.substring(0, 2),
                                  ),
                                  minute: value * 10,
                                ).toString();
                                widget.onStartTimeChanged?.call(
                                  ScheduleTimeFormat(
                                    hour: int.parse(
                                      startTimeController.text.substring(0, 2),
                                    ),
                                    minute: value * 10,
                                  ),
                                );
                              },
                              childCount: 6,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Text(
                                    (index * 10).toString().padLeft(2, '0'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          flex: 3,
          child: OrbTextFormField(
            hintText: "종료 시간",
            controller: endTimeController,
            readOnly: true,
            onTap: () async {
              final hourScrollController = FixedExtentScrollController(
                initialItem: int.parse(endTimeController.text.substring(0, 2)) -
                    widget.timetableStartHour,
              );
              final minuteScrollController = FixedExtentScrollController(
                initialItem:
                    int.parse(endTimeController.text.substring(3, 5)) ~/ 10,
              );
              hourScrollController.addListener(() {
                if (endTimeController.text.substring(0, 2) == "24") {
                  minuteScrollController
                      .animateToItem(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  )
                      .whenComplete(() {
                    endTimeController.text = ScheduleTimeFormat(
                      hour: int.parse(
                        endTimeController.text.substring(0, 2),
                      ),
                      minute: 0,
                    ).toString();
                  });
                }
              });
              minuteScrollController.addListener(() {
                if (endTimeController.text.substring(0, 2) == "24") {
                  minuteScrollController
                      .animateToItem(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  )
                      .whenComplete(() {
                    endTimeController.text = ScheduleTimeFormat(
                      hour: int.parse(
                        endTimeController.text.substring(0, 2),
                      ),
                      minute: 0,
                    ).toString();
                  });
                }
              });
              await showCupertinoModalPopup(
                context: context,
                builder: (context) => Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).colorScheme.background,
                  child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            flex: 3,
                            child: CupertinoPicker.builder(
                              scrollController: hourScrollController,
                              itemExtent: 50,
                              onSelectedItemChanged: (value) {
                                setState(() {
                                  endTimeController.text = ScheduleTimeFormat(
                                          hour: value + widget.timetableStartHour,
                                          minute: int.parse(endTimeController
                                              .text
                                              .substring(3, 5)))
                                      .toString();
                                });

                                widget.onEndTimeChanged?.call(
                                  ScheduleTimeFormat(
                                    hour: value + widget.timetableStartHour,
                                    minute: int.parse(
                                      endTimeController.text.substring(3, 5),
                                    ),
                                  ),
                                );
                              },
                              childCount: 25 - widget.timetableStartHour,
                              itemBuilder: (context, index) {
                                return Center(
                                  child:
                                      Text((index + widget.timetableStartHour).toString().padLeft(2, '0')),
                                );
                              },
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Center(
                              child: Text(
                                ":",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: CupertinoPicker.builder(
                              scrollController: minuteScrollController,
                              itemExtent: 50,
                              onSelectedItemChanged: (value) {
                                endTimeController.text = ScheduleTimeFormat(
                                        hour: int.parse(endTimeController.text
                                            .substring(0, 2)),
                                        minute: value * 10)
                                    .toString();
                                widget.onEndTimeChanged?.call(
                                  ScheduleTimeFormat(
                                    hour: int.parse(
                                      endTimeController.text.substring(0, 2),
                                    ),
                                    minute: value * 10,
                                  ),
                                );
                              },
                              childCount: 6,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Text(
                                    (index * 10).toString().padLeft(2, '0'),
                                    style: TextStyle(
                                      color: endTimeController.text
                                                      .substring(0, 2) ==
                                                  "24" &&
                                              index != 0
                                          ? Colors.grey
                                          : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
