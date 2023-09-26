import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class PostView extends StatelessWidget {
  final String title;
  final String body;

  const PostView({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*
            Image.asset(
              'assets/icons/app/profile.png',
              scale: 8,
            ),
            const SizedBox(
              width: 16,
            ),
             */
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Text(
                        'Jaem',
                        style: themeData.textTheme.bodyMedium),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('3시간 전', style: themeData.textTheme.bodySmall),
                      const Spacer(),
                      Icon(Icons.more_vert_rounded),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: themeData.textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    parse(body).documentElement!.text,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: themeData.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text('동의 수'),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('1'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const OrbDivider()
      ],
    );
  }
}
