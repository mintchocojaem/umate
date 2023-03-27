import 'package:flutter/material.dart';

typedef OnColorSelected = void Function(Color color);

class ColorPicker extends StatefulWidget {
  final List<Color> colors;
  final OnColorSelected onColorSelected;

  const ColorPicker(
      {super.key, required this.colors, required this.onColorSelected});

  @override
  createState() => _ColorPicker();
}

class _ColorPicker extends State<ColorPicker> {
  final ScrollController _scrollController = ScrollController();

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      thumbColor: Colors.grey.withOpacity(0.5),
      radius: const Radius.circular(8),
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: List.generate(
                widget.colors.length,
                (index) => _colorPickerItem(
                    color: widget.colors[index], index: index)),
          ),
        ),
      ),
    );
  }

  Widget _colorPickerItem({required Color color, required int index}) {
    return GestureDetector(
      onTap: () {
        widget.onColorSelected(color);
        setState(() {
          selectedIndex = widget.colors.indexOf(color);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: selectedIndex == index
              ? const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 18,
                )
              : null,
        ),
      ),
    );
  }
}
