import 'package:flutter/material.dart';

class ChartData {
  final String name;
  final int value;

  ChartData({
    required this.name,
    required this.value,
  });
}

class PetitionStatistic extends StatelessWidget {
  final int agreeCount;
  final List<ChartData> agrees;

  const PetitionStatistic({
    super.key,
    required this.agreeCount,
    required this.agrees,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    agrees.sort((a, b) => b.value.compareTo(a.value));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "청원동의",
              style: themeData.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "$agreeCount명",
              style: themeData.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: themeData.colorScheme.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: [
            for (final data in agrees)
              Padding(
                padding: const EdgeInsets.only(bottom: 8, right: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.name,
                      style: themeData.textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "${data.value}명(${(data.value / agreeCount * 100).round()}%)",
                      style: themeData.textTheme.bodySmall?.copyWith(
                        color: themeData.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
