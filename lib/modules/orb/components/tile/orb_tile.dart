import 'package:flutter/material.dart';

abstract class OrbTile extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final Function()? onTap;

  const OrbTile({
    super.key,
    this.title,
    this.content,
    this.onTap,
  });
}
