import 'package:flutter/material.dart';

/// A interface for [Tile]s.
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
