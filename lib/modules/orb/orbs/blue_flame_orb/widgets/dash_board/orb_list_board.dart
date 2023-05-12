import 'package:danvery/modules/orb/orbs/blue_flame_orb/widgets/dash_board/compact_tile.dart';
import 'package:danvery/modules/orb/orbs/blue_flame_orb/widgets/dash_board/orb_board.dart';
import 'package:flutter/material.dart';

export 'package:danvery/modules/orb/orbs/blue_flame_orb/widgets/dash_board/compact_tile.dart';

class OrbListBoard extends OrbBoard{

  final List<CompactTile> tiles;

  const OrbListBoard({
    super.key,
    required String title,
    Widget? trailing,
    required this.tiles,
  }) : super(title: title, trailing: trailing);

  @override
  Widget? get child => ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    itemCount: tiles.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: tiles[index],
      );
    },
  );

}
