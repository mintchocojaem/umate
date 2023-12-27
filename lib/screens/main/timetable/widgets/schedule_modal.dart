import 'dart:math';

import 'package:danvery/domain/domain.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/screens/main/timetable/widgets/schedule_table.dart';
import 'package:danvery/screens/main/timetable/widgets/schedule_time_picker.dart';
import 'package:flutter/material.dart';

class ScheduleModal extends StatefulWidget {
  const ScheduleModal({
    super.key,
    this.lecture,
    this.weekOfDay,
    required this.timetableStartHour,
    required this.timetableEndHour,
    this.lectureStartTime,
    this.onAdded,
    this.onEdited,
    this.onDeleted,
    this.onSearch,
  });

  final Lecture? lecture;
  final WeekDays? weekOfDay;
  final int timetableStartHour;
  final int timetableEndHour;
  final ScheduleTimeFormat? lectureStartTime;
  final Future Function(Lecture newLecture)? onAdded;
  final Future Function(Lecture oldLecture, Lecture newLecture)? onEdited;
  final Future Function()? onDeleted;
  final Future<LectureInfo?> Function()? onSearch;

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ScheduleModal(
        lecture: lecture,
        weekOfDay: weekOfDay,
        timetableStartHour: timetableStartHour,
        timetableEndHour: timetableEndHour,
        lectureStartTime: lectureStartTime,
        onAdded: onAdded,
        onEdited: onEdited,
        onDeleted: onDeleted,
        onSearch: onSearch,
      ),
    );
  }

  @override
  createState() => _ScheduleModal();
}

class _ScheduleModal extends State<ScheduleModal> {

  final List<Color> colors = const [
    Color(0xffFF9D7E),
    Color(0xffFF7E63),
    Color(0xffF9684A),
    Color(0xffF9BE25),
    Color(0xffFFB84F),
    Color(0xffFF9838),
    Color(0xff78BD5F),
    Color(0xffA3DB69),
    Color(0xff90B7F9),
    Color(0xff6F97FA),
    Color(0xff3468EE),
    Color(0xffB49EFB),
    Color(0xff8D7EEF),
    Color(0xff6553D7),
    Color(0xffAAAAAA),
    Color(0xff707070),
    Color(0xff505050),
    Color(0xffC6AB85),
    Color(0xffB49262),
    Color(0xff8D7047),
  ];

  late final TextEditingController titleController;
  late final TextEditingController dayController;
  late final TextEditingController startTimeController;
  late final TextEditingController endTimeController;
  late final TextEditingController placeController;
  late final TextEditingController memoController;
  late Color selectedColor;

  late List<LectureTime> lectureTimes;

  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _formKey = GlobalKey<FormState>();

    if (widget.lecture != null) {
      titleController = TextEditingController(text: widget.lecture!.name);
      dayController =
          TextEditingController(text: widget.lecture!.times[0].week.toString());
      placeController =
          TextEditingController(text: widget.lecture!.times[0].place);
      memoController = TextEditingController(text: widget.lecture!.memo);

      lectureTimes = List.from(widget.lecture!.times);
      lectureTimes.sort((a, b) => WeekDays.values
          .indexWhere((element) => element.english == a.week)
          .compareTo(WeekDays.values
              .indexWhere((element) => element.english == b.week)));
      selectedColor = Color(int.parse(widget.lecture!.color));
    } else {
      titleController = TextEditingController();
      dayController = TextEditingController();
      placeController = TextEditingController();
      memoController = TextEditingController();
      lectureTimes = [
        LectureTime(
          start: widget.lectureStartTime != null
              ? ScheduleTimeFormat(
                      hour: widget.lectureStartTime!.hour,
                      minute: widget.lectureStartTime!.minute)
                  .toString()
              : const ScheduleTimeFormat(
                  hour: 9,
                  minute: 0,
                ).toString(),
          end: widget.lectureStartTime != null
              ? ScheduleTimeFormat(
                      hour: widget.lectureStartTime!.hour,
                      minute: widget.lectureStartTime!.minute)
                  .add(const ScheduleTimeFormat(
                    hour: 1,
                    minute: 0,
                  ))
                  .toString()
              : const ScheduleTimeFormat(
                  hour: 10,
                  minute: 0,
                ).toString(),
          week: widget.weekOfDay != null
              ? widget.weekOfDay!.english
              : WeekDays.monday.english,
        ),
      ];
      selectedColor = Color(colors[Random().nextInt(colors.length)].value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return OrbModalBottomSheet(
      topAction: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OrbButton(
            onPressed: () async {
              if(widget.lecture != null) {
                await widget.onDeleted?.call().whenComplete(() => Navigator.pop(context));
              } else {
                Navigator.pop(context);
              }
            },
            buttonText: widget.lecture == null ? "취소" : "삭제",
            buttonSize: OrbButtonSize.compact,
            buttonRadius: OrbButtonRadius.small,
            enabledBackgroundColor: themeData.colorScheme.background,
            enabledForegroundColor: themeData.colorScheme.error,
          ),
          OrbButton(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              final Lecture newLecture;
              if (widget.lecture == null) {
                newLecture = Lecture(
                  name: titleController.text,
                  times: lectureTimes,
                  memo: memoController.text,
                  type: ScheduleType.schedule.value,
                  color: selectedColor.value.toString(),
                );
                await widget.onAdded
                    ?.call(newLecture)
                    .whenComplete(() => Navigator.pop(context));
              } else {
                newLecture = widget.lecture!.copyWith(
                  name: titleController.text,
                  times: lectureTimes,
                  memo: memoController.text,
                  color: selectedColor.value.toString(),
                );
                await widget.onEdited
                    ?.call(widget.lecture!, newLecture)
                    .whenComplete(() => Navigator.pop(context));
              }
            },
            buttonText: widget.lecture == null ? "추가" : "저장",
            buttonSize: OrbButtonSize.compact,
            buttonRadius: OrbButtonRadius.small,
            enabledBackgroundColor: themeData.colorScheme.background,
            enabledForegroundColor: themeData.colorScheme.secondary,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OrbTextFormField(
                  hintText: "제목",
                  textInputAction: TextInputAction.next,
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "제목을 입력해주세요.";
                    }
                    return null;
                  },
                  suffixIcon: widget.onSearch != null ? IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: (){
                      widget.onSearch?.call().then((value){
                        final LectureInfo? lectureInfo = value;
                        if(lectureInfo != null) {
                          setState(() {
                            titleController.text = lectureInfo.name;
                            dayController.text = lectureInfo.times[0].week.toString();
                            placeController.text = lectureInfo.times.map((e) => e.place).toSet().join(", ").replaceAll("null", "");
                            lectureTimes = List.from(lectureInfo.times);
                            lectureTimes.sort((a, b) => WeekDays.values
                                .indexWhere((element) => element.english == a.week)
                                .compareTo(WeekDays.values
                                .indexWhere((element) => element.english == b.week)));
                          });
                        }
                      });
                    },
                  ) : null,
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  itemCount: lectureTimes.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ScheduleTimeWidget(
                      timetableStartHour: widget.timetableStartHour,
                      timetableEndHour: widget.timetableEndHour,
                      key: ValueKey(lectureTimes[index]),
                      lectureTime: lectureTimes[index],
                      last: index == lectureTimes.length - 1,
                      onTapAddIcon: () {
                        setState(() {
                          lectureTimes.add(
                            LectureTime(
                              start: ScheduleTimeFormat(
                                      hour: DateTime.now().hour,
                                      minute: DateTime.now().minute)
                                  .toString(),
                              end: ScheduleTimeFormat(
                                      hour: DateTime.now().hour,
                                      minute: DateTime.now().minute)
                                  .add(
                                    const ScheduleTimeFormat(
                                      hour: 1,
                                      minute: 0,
                                    ),
                                  )
                                  .toString(),
                              week: WeekDays
                                  .values[WeekDays.values.indexWhere((element) =>
                                      element.english ==
                                      lectureTimes[index].week)]
                                  .english,
                            ),
                          );
                        });
                      },
                      onTapRemoveIcon: (scheduleTime) {
                        setState(() {
                          lectureTimes.remove(scheduleTime);
                        });
                      },
                      onWeekOfDayChanged: (WeekDays value) {
                        lectureTimes[index] = lectureTimes[index].copyWith(
                          week: value.english,
                        );
                      },
                      onStartTimeChanged: (ScheduleTimeFormat value) {
                        lectureTimes[index] = lectureTimes[index].copyWith(
                          start: ScheduleTimeFormat(
                                  hour: value.hour, minute: value.minute)
                              .toString(),
                        );
                      },
                      onEndTimeChanged: (ScheduleTimeFormat value) {
                        lectureTimes[index] = lectureTimes[index].copyWith(
                          end: ScheduleTimeFormat(
                                  hour: value.hour, minute: value.minute)
                              .toString(),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 8),
                OrbTextFormField(
                  hintText: "강의실",
                  controller: placeController,
                ),
                const SizedBox(height: 8),
                OrbTextFormField(
                  hintText: "메모",
                  controller: memoController,
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final Color color in colors)
                        Padding(
                          padding: color == colors.last
                              ? const EdgeInsets.only(right: 0)
                              : const EdgeInsets.only(right: 16),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedColor = color;
                              });
                            },
                            child: selectedColor == color
                                ? Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleTimeWidget extends StatelessWidget {
  const ScheduleTimeWidget({
    super.key,
    required this.timetableStartHour,
    required this.timetableEndHour,
    required this.lectureTime,
    this.last = false,
    required this.onTapAddIcon,
    required this.onTapRemoveIcon,
    required this.onWeekOfDayChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
  });

  final int timetableStartHour;
  final int timetableEndHour;
  final LectureTime lectureTime;
  final bool last;
  final VoidCallback onTapAddIcon;
  final void Function(LectureTime) onTapRemoveIcon;

  final ValueChanged<WeekDays> onWeekOfDayChanged;
  final ValueChanged<ScheduleTimeFormat> onStartTimeChanged;
  final ValueChanged<ScheduleTimeFormat> onEndTimeChanged;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          flex: 10,
          child: ScheduleTimePicker(
            timetableStartHour: timetableStartHour,
            timetableEndHour: timetableEndHour,
            weekOfDay: WeekDays.values[WeekDays.values
                .indexWhere((element) => element.english == lectureTime.week)],
            lectureStartTime: TimeOfDay(
              hour: int.parse(
                lectureTime.start.substring(0, 2),
              ),
              minute: int.parse(
                lectureTime.start.substring(3, 5),
              ),
            ),
            lectureEndTime: TimeOfDay(
              hour: int.parse(
                lectureTime.end.substring(0, 2),
              ),
              minute: int.parse(
                lectureTime.end.substring(3, 5),
              ),
            ),
            onWeekOfDayChanged: (weekOfDay) {
              onWeekOfDayChanged(weekOfDay);
            },
            onStartTimeChanged: (time) {
              onStartTimeChanged(time);
            },
            onEndTimeChanged: (time) {
              onEndTimeChanged(time);
            },
          ),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: last
                ? IconButton(
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.lightGreenAccent,
                    ),
                    onPressed: onTapAddIcon,
                  )
                : IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline_rounded,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      onTapRemoveIcon(lectureTime);
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
