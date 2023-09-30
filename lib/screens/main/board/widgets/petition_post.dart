import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class PetitionPost extends StatelessWidget {
  final String title;
  final String body;
  final String author;
  final String duration;
  final String status;
  final int agreeCount;
  final int needAgreeCount;

  const PetitionPost({
    super.key,
    required this.title,
    required this.body,
    required this.author,
    required this.duration,
    required this.status,
    required this.agreeCount,
    required this.needAgreeCount,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: themeData.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(Icons.more_vert_rounded),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                "청원인",
                style: themeData.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Text(
                author,
                style: themeData.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                "청원기간",
                style: themeData.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Text(
                duration,
                style: themeData.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                "청원상태",
                style: themeData.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$status(${(agreeCount / needAgreeCount * 100).round()}%)",
                    style: themeData.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  LinearProgressIndicator(
                    value: agreeCount / needAgreeCount,
                    backgroundColor: themeData.colorScheme.surface,
                    color: themeData.colorScheme.primary,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const OrbDivider(),
        const SizedBox(
          height: 16,
        ),
        Text(
          parse(body).documentElement!.text.trimRight(),
          style: themeData.textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
