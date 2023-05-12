import 'package:flutter/cupertino.dart';

abstract class Tile{

  const Tile({
    required this.title,
    required this.body,
    this.leading,
    this.onTap,
  });

  final String title;
  final String? body;
  final Widget? leading;
  final VoidCallback? onTap;

}
