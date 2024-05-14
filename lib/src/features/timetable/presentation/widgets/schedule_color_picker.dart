import 'package:flutter/material.dart';

class ScheduleColorPicker extends StatefulWidget {
  final Color? selectByColor;
  final int? selectByIndex;
  final void Function(Color)? onColorChanged;

  const ScheduleColorPicker({
    super.key,
    this.selectByColor,
    this.selectByIndex,
    this.onColorChanged,
  });

  static const List<Color> colors = [
    Color(0xffFF9D7E),
    Color(0xffFF7E63),
    Color(0xffF9684A),
    Color(0xffF8B70C),
    Color(0xffFFAE36),
    Color(0xffFF9838),
    Color(0xff78BD5F),
    Color(0xff96D654),
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

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScheduleColorPickerState();
  }
}

class _ScheduleColorPickerState extends State<ScheduleColorPicker> {
  late Color selectedColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.selectByColor != null) {
      selectedColor = widget.selectByColor!;
    } else if (widget.selectByIndex != null) {
      selectedColor = ScheduleColorPicker.colors[widget.selectByIndex!];
    } else {
      selectedColor = ScheduleColorPicker.colors.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final Color color in ScheduleColorPicker.colors)
            Padding(
              padding: color == ScheduleColorPicker.colors.last
                  ? const EdgeInsets.only(right: 0)
                  : const EdgeInsets.only(right: 16),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedColor = color;
                    widget.onColorChanged?.call(color);
                  });
                },
                child: Container(
                  width: 32,
                  height: 32,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: selectedColor == color
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
