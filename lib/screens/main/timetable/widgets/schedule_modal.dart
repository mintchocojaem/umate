import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/screens/main/timetable/widgets/schedule_table.dart';
import 'package:flutter/material.dart';

class ScheduleModal extends StatefulWidget {
  const ScheduleModal({Key? key, required this.schedule}) : super(key: key);

  final Schedule schedule;

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ScheduleModal(
        schedule: schedule,
      ),
    );
  }

  @override
  createState() => _ScheduleModal();
}

class _ScheduleModal extends State<ScheduleModal> {

  final List<Color> colors = const [
    Color(0xffFFC3B0),
    Color(0xffFF937C),
    Color(0xffF9684A),
    Color(0xffFBD470),
    Color(0xffFFB84F),
    Color(0xffFF9838),
    Color(0xff86D26A),
    Color(0xffB6E388),
    Color(0xffA8C7FA),
    Color(0xff6F97FA),
    Color(0xff3468EE),
    Color(0xffC1AEFC),
    Color(0xff8D7EEF),
    Color(0xff6553D7),
    Color(0xffB7B7B7),
    Color(0xff939393),
    Color(0xff505050),
    Color(0xffD6C3A8),
    Color(0xffBC9E73),
    Color(0xff8D7047),
  ];

  late final TextEditingController titleController;
  late final TextEditingController dayController;
  late final TextEditingController startTimeController;
  late final TextEditingController endTimeController;
  late final TextEditingController placeController;
  late final TextEditingController memoController;

  late List<ScheduleTime> scheduleTimes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: widget.schedule.title);
    dayController =
        TextEditingController(text: widget.schedule.times[0].day.toString());
    placeController =
        TextEditingController(text: widget.schedule.times[0].place);
    memoController = TextEditingController(text: widget.schedule.memo);

    scheduleTimes = List.from(widget.schedule.times);
    scheduleTimes.sort((a, b) => a.day.compareTo(b.day));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return OrbModalBottomSheet(
      topAction: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OrbButton(
            onPressed: () async {},
            buttonText: "삭제",
            buttonSize: OrbButtonSize.compact,
            buttonRadius: OrbButtonRadius.small,
            enabledBackgroundColor: themeData.colorScheme.background,
            enabledForegroundColor: themeData.colorScheme.error,
          ),
          OrbButton(
            onPressed: () async {},
            buttonText: "저장",
            buttonSize: OrbButtonSize.compact,
            buttonRadius: OrbButtonRadius.small,
            enabledBackgroundColor: themeData.colorScheme.background,
            enabledForegroundColor: themeData.colorScheme.secondary,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OrbTextFormField(
                hintText: "제목",
                textInputAction: TextInputAction.next,
                controller: titleController,
              ),
              const SizedBox(height: 8),
              ListView.builder(
                itemCount: scheduleTimes.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ScheduleTimeTile(
                    key: ValueKey(scheduleTimes[index]),
                    scheduleTime: scheduleTimes[index],
                    last: index == scheduleTimes.length - 1,
                    onTapAddIcon: () {
                      setState(() {
                        scheduleTimes.add(ScheduleTime(
                          day: 0,
                          startTime: "00:00",
                          endTime: "00:00",
                          place: "",
                        ));
                      });
                    },
                    onTapRemoveIcon: (scheduleTime) {
                      setState(() {
                        scheduleTimes.remove(scheduleTime);
                      });
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
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
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
    );
  }
}

class ScheduleTimeTile extends StatefulWidget {
  const ScheduleTimeTile({
    super.key,
    required this.scheduleTime,
    this.last = false,
    required this.onTapAddIcon,
    required this.onTapRemoveIcon,
  });

  final ScheduleTime scheduleTime;
  final bool last;
  final VoidCallback onTapAddIcon;
  final void Function(ScheduleTime) onTapRemoveIcon;

  @override
  createState() => _ScheduleTimeTile();
}

class _ScheduleTimeTile extends State<ScheduleTimeTile> {
  final weekDays = const ['월', '화', '수', '목', '금'];

  late final TextEditingController startTimeController;
  late final TextEditingController endTimeController;
  late final TextEditingController dayController;

  @override
  void initState() {
    super.initState();
    startTimeController = TextEditingController(
        text: widget.scheduleTime.startTime.substring(0, 5));
    endTimeController = TextEditingController(
        text: widget.scheduleTime.endTime.substring(0, 5));
    dayController =
        TextEditingController(text: weekDays[widget.scheduleTime.day - 1]);
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
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          flex: 3,
          child: OrbTextFormField(
            hintText: "시작 시간",
            controller: startTimeController,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          flex: 3,
          child: OrbTextFormField(
            hintText: "종료 시간",
            controller: endTimeController,
          ),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: widget.last
                ? IconButton(
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.lightGreenAccent,
                    ),
                    onPressed: widget.onTapAddIcon,
                  )
                : IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline_rounded,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      widget.onTapRemoveIcon(widget.scheduleTime);
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
