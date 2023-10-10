import 'package:flutter/material.dart';

abstract class OrbContainer extends StatelessWidget{

  final Widget? title;
  final Widget? info;
  final Widget? trailing;
  final Widget? child;
  final Decoration? decoration;
  final VoidCallback? onTap;

  const OrbContainer({
    super.key,
    this.title,
    this.info,
    this.trailing,
    this.child,
    this.decoration,
    this.onTap,
  });

}
