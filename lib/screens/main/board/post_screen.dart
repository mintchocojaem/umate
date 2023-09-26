import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostScreen extends ConsumerWidget{
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrbScaffold();
  }
}
