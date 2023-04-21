import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_text_theme.dart';

class BusCard extends StatelessWidget {
  final String busNo;
  final String predictTime1;
  final String? predictTime2;
  final Color busColor;
  final String station1;
  final String? station2;

  const BusCard({super.key,required this.busNo, required this.predictTime1, this.predictTime2, required this.busColor, required this.station1, this.station2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(busNo, style: bigTitleStyle.copyWith(color: busColor, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text(station1, style: regularStyle.copyWith(color: Palette.grey, fontWeight: FontWeight.w500)),
                const SizedBox(width: 8),
                Text(predictTime1, style: regularStyle.copyWith(color: Palette.darkGrey, fontWeight: FontWeight.bold)),
              ],
            ),
            station2 != null && predictTime2 != null ?  Row(
              children: [
                Text(station2!, style: regularStyle.copyWith(color: Palette.grey, fontWeight: FontWeight.w500)),
                const SizedBox(width: 8),
                Text(predictTime2!, style: regularStyle.copyWith(color: Palette.darkGrey, fontWeight: FontWeight.bold)),
              ],
            ) : const SizedBox(),
          ]
      ),
    );
  }
}
