import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../design_system/orb/orb.dart';
import '../../domain/models/week_days.dart';

class ScheduleDayPicker extends StatefulWidget {
  final List<WeekDays> days;
  final WeekDays selectedDay;
  final void Function(WeekDays)? onDayChanged;
  final BorderRadius? borderRadius;

  const ScheduleDayPicker({
    super.key,
    required this.days,
    required this.selectedDay,
    this.onDayChanged,
    this.borderRadius,
  });

  @override
  createState() => _ScheduleDayPickerState();
}

class _ScheduleDayPickerState extends State<ScheduleDayPicker> {
  late final FixedExtentScrollController dayScrollController;

  late final TextEditingController dayController;

  @override
  void initState() {
    super.initState();
    dayScrollController = FixedExtentScrollController(
      initialItem: widget.days.indexOf(widget.selectedDay),
    );
    dayController = TextEditingController(text: widget.selectedDay.korean);
    dayController.addListener(() {
      widget.onDayChanged?.call(
        widget.days.firstWhere(
          (element) => element.korean == dayController.text,
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    dayController.dispose();
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
            ),
          ),
          CupertinoPicker.builder(
            scrollController: dayScrollController,
            selectionOverlay: const SizedBox(),
            itemExtent: 36,
            onSelectedItemChanged: (value) {
              dayController.text = widget.days[value].korean;
            },
            childCount: widget.days.length,
            itemBuilder: (context, index) {
              return Center(
                child: OrbText(
                  widget.days[index].korean,
                  type: OrbTextType.titleSmall,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
