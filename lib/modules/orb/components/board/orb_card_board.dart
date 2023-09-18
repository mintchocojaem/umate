import 'package:flutter/material.dart';

import '../components.dart';

class OrbCardBoard extends OrbBoardContainer {
  final List<OrbCardTile> orbContentTiles;

  const OrbCardBoard({
    super.key,
    required super.titleText,
    required this.orbContentTiles,
    super.infoText,
  });

  @override
  // TODO: implement trailing
  Widget? get trailing => const Icon(Icons.chevron_right);

  @override
  // TODO: implement child
  Widget get child => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final orbTile in orbContentTiles)
              Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                ),
                child: orbTile,
              ),
          ],
        ),
      );
}
