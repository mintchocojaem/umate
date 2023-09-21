import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardScreen extends ConsumerWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrbScaffold(
      defaultAppBar: false,
      body: Column(
        children: [
          SearchBar(),
        ],
      ),
    );
  }
}
