import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../../modules/orb/components/components.dart';

class BusListTile extends StatelessWidget {
  final Bus jungmoonBus;
  final Bus? gomsangBus;
  final Color color;


  const BusListTile({
    super.key,
    required this.jungmoonBus,
    this.gomsangBus,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return OrbListTile(
      title: Text(
        jungmoonBus.busNo == "shuttle-bus" ? "셔틀버스" : jungmoonBus.busNo,
        style: themeData.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
      content: Container(
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 120
        ),
        child: IntrinsicWidth(
          child: Column(
            children: [
              if(gomsangBus != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "곰상",
                      style: themeData.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      gomsangBus!.predictTime1 != 0 ? '${(gomsangBus!.predictTime1 ~/ 60)}분' : '정보 없음',
                      style: themeData.textTheme.bodyMedium,
                    ),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "정문",
                    style: themeData.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    jungmoonBus.predictTime1 != 0 ? '${(jungmoonBus.predictTime1 ~/ 60)}분' : '정보 없음',
                    style: themeData.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      contentAlign: CrossAxisAlignment.end,
    );
  }
}
