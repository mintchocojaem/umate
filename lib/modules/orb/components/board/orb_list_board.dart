import 'package:flutter/material.dart';

import '../components.dart';

class OrbListBoard extends OrbBoardContainer {
  final List<OrbListTile> orbListTiles;

  const OrbListBoard({
    super.key,
    required super.titleText,
    required this.orbListTiles,
  });

  @override
  // TODO: implement trailing
  Widget? get trailing => const Icon(Icons.chevron_right);

  @override
  // TODO: implement child
  Widget get child => SingleChildScrollView(
    child: Column(
      children: [
        for (final orbTile in orbListTiles)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
            ),
            child: orbTile,
          ),
      ],
    ),
  );

}
