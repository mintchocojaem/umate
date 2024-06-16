import 'package:flutter/material.dart';

import '../../../../design_system/orb/orb.dart';
import '../../domain/models/lecture_info.dart';

class LectureTimeInfo {
  final String day;
  final String startTime;
  final String endTime;

  const LectureTimeInfo({
    required this.day,
    required this.startTime,
    required this.endTime,
  });
}

class LectureInfoCard extends StatelessWidget {
  final LectureInfo lectureInfo;
  final Function() onPressedAdd;

  const LectureInfoCard({
    super.key,
    required this.lectureInfo,
    required this.onPressedAdd,
  });

  String getCredit() {
    return '${lectureInfo.credit}학점';
  }

  String getClassCode() {
    return '${lectureInfo.lectureCode}-${lectureInfo.classNumber}';
  }

  String getGrade() {
    return lectureInfo.grade == 0 ? '전학년' : '${lectureInfo.grade}학년';
  }

  String getMajor() {
    return lectureInfo.major.isEmpty ? '전공없음' : lectureInfo.major;
  }

  String getTime() {
    return lectureInfo.times
        .map((e) => '${e.day.korean} ${e.start} ~ ${e.end}')
        .join(', ')
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrbText(
                  lectureInfo.name,
                  type: OrbTextType.bodyLarge,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                OrbText(
                  '${lectureInfo.professor}   ${getClassCode()}',
                ),
                const SizedBox(height: 4),
                OrbText(
                  '${getGrade()}   ${getCredit()}   ${getMajor()}   ${lectureInfo.category}',
                ),
                const SizedBox(height: 4),
                OrbText(
                  getTime(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          OrbFilledButton(
            text: '추가',
            onPressed: onPressedAdd,
            buttonSize: OrbButtonSize.compact,
            buttonTextType: OrbButtonTextType.medium,
            buttonRadius: OrbButtonRadius.small,
          ),
        ],
      ),
    );
  }
}
