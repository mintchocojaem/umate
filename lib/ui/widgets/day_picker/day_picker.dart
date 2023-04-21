import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';

typedef OnDaySelected = void Function(List<int> day);

class DayPicker extends StatefulWidget {
  final List<String> days;
  final List<int>? selectedDayIndex;
  final OnDaySelected oDaySelected;

  const DayPicker(
      {super.key,
      required this.days,
      required this.oDaySelected,
      this.selectedDayIndex});

  @override
  createState() => _DayPicker();
}

class _DayPicker extends State<DayPicker> {
  late List<int> selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedDayIndex ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Palette.darkWhite,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < widget.days.length; i++)
            _dayPickerItem(day: widget.days[i], index: i),
        ],
      ),
    );
  }

  Widget _dayPickerItem({required String day, required int index}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: InkWell(
          onTap: () {
            setState(() {
              if (selectedIndex.contains(index)) {
                selectedIndex.remove(index);
              } else {
                selectedIndex.add(index);
              }
              selectedIndex.sort();
              widget.oDaySelected(selectedIndex);
            });
          },
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              color: selectedIndex.contains(index) ? Palette.blue : Palette.pureWhite,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(day,
                  textAlign: TextAlign.center,
                  style: regularStyle.copyWith(
                    color: selectedIndex.contains(index)
                        ? Palette.white
                        : Palette.grey,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
