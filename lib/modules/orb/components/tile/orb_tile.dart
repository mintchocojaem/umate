import 'package:flutter/material.dart';

abstract class OrbTile extends StatelessWidget {
  final String title;
  final String? content;
  final Function()? onTap;

  const OrbTile({
    super.key,
    required this.title,
    this.content,
    this.onTap,
  });
}
