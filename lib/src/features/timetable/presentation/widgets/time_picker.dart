import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../design_system/orb/orb.dart';
import '../../domain/models/schedule_time_format.dart';

class TimePicker extends StatefulWidget {
  final int timetableStartHour;
  final int timetableEndHour;
  final ScheduleTimeFormat currentTime;
  final void Function(ScheduleTimeFormat)? onTimeChanged;
  final BorderRadius? borderRadius;

  const TimePicker({
    super.key,
    required this.timetableStartHour,
    required this.timetableEndHour,
    required this.currentTime,
    this.onTimeChanged,
    this.borderRadius,
  });

  @override
  createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late final FixedExtentScrollController hourController;
  late final FixedExtentScrollController minuteController;
  late final TextEditingController timeController;

  @override
  void initState() {
    super.initState();

    timeController = TextEditingController(
      text: widget.currentTime.toString(),
    );

    hourController = FixedExtentScrollController(
      initialItem: widget.currentTime.hour - widget.timetableStartHour,
    );

    minuteController = FixedExtentScrollController(
      initialItem: widget.currentTime.minute ~/ 10,
    );

    timeController.addListener(() {
      final time = ScheduleTimeFormat(
        hour: int.parse(timeController.text.substring(0, 2)),
        minute: int.parse(timeController.text.substring(3, 5)),
      );
      widget.onTimeChanged?.call(time);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    hourController.dispose();
    minuteController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final theme = OrbTheme.of(context);
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: theme.textFieldTheme.fillColor,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
              ),
              child: const Center(
                child: OrbText(
                  " : ",
                  type: OrbTextType.titleSmall,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: CupertinoPicker(
                  scrollController: hourController,
                  selectionOverlay: const SizedBox(),
                  itemExtent: 36,
                  onSelectedItemChanged: (value) {
                    final time = ScheduleTimeFormat(
                      hour: value + widget.timetableStartHour,
                      minute: int.parse(timeController.text.substring(3, 5)),
                    );
                    timeController.text = time.toString();
                  },
                  children: [
                    ...List.generate(
                      widget.timetableEndHour - widget.timetableStartHour + 1,
                      (index) {
                        return Center(
                          child: OrbText(
                            (index + widget.timetableStartHour)
                                .toString()
                                .padLeft(2, '0'),
                            type: OrbTextType.titleSmall,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: CupertinoPicker(
                  scrollController: minuteController,
                  selectionOverlay: const SizedBox(),
                  itemExtent: 36,
                  onSelectedItemChanged: (value) {
                    final time = ScheduleTimeFormat(
                      hour: int.parse(timeController.text.substring(0, 2)),
                      minute: value * 10,
                    );
                    timeController.text = time.toString();
                  },
                  children: [
                    ...List.generate(
                      6,
                      (index) {
                        return Center(
                          child: OrbText(
                            (index * 10).toString().padLeft(2, '0'),
                            type: OrbTextType.titleSmall,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
