import 'package:flutter/material.dart';

import '../../../../modules/orb/components/components.dart';

class ScheduleModal extends StatelessWidget {
  const ScheduleModal({Key? key}) : super(key: key);

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

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ScheduleModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return OrbModalBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OrbButton(
                onPressed: () async{},
                buttonText: "삭제",
                buttonSize: OrbButtonSize.compact,
                buttonRadius: OrbButtonRadius.small,
                enabledBackgroundColor: themeData.colorScheme.background,
                enabledForegroundColor: themeData.colorScheme.error,
              ),
              OrbButton(
                onPressed: () async{
                },
                buttonText: "저장",
                buttonSize: OrbButtonSize.compact,
                buttonRadius: OrbButtonRadius.small,
                enabledBackgroundColor: themeData.colorScheme.background,
                enabledForegroundColor: themeData.colorScheme.secondary,
              ),
            ],
          ),
          OrbTextFormField(
            hintText: "제목",
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 8),
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 1,
                child: OrbTextFormField(
                  hintText: "요일",
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                flex: 2,
                child: OrbTextFormField(
                  hintText: "시작 시간",
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                flex: 2,
                child: OrbTextFormField(
                  hintText: "종료 시간",
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8),
          OrbTextFormField(
            hintText: "강의실",
          ),
          const SizedBox(height: 8),
          OrbTextFormField(
            hintText: "메모",
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
    );
  }
}
