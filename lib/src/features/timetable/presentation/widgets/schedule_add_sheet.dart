import 'package:flutter/material.dart';

import '../../../../design_system/orb/orb.dart';

class ScheduleAddSheet extends OrbModalBottomSheet {
  final void Function()? onAddLecture;
  final void Function()? onAddSchedule;

  const ScheduleAddSheet({
    super.key,
    this.onAddLecture,
    this.onAddSchedule,
  });

  @override
  // TODO: implement titleText
  String? get titleText => '추가 유형을 선택해주세요';

  @override
  // TODO: implement child
  Widget? get child => Column(
        children: [
          OrbTile(
            leading: const OrbIcon(
              Icons.menu_book_sharp,
            ),
            title: const OrbText(
              '수업 추가',
            ),
            onTap: () {
              onAddLecture?.call();
            },
          ),
          const SizedBox(
            height: 16,
          ),
          OrbTile(
            leading: OrbIcon(Icons.schedule),
            title: const OrbText(
              '일정 추가',
            ),
            onTap: () {
              onAddSchedule?.call();
            },
          ),
        ],
      );
}
