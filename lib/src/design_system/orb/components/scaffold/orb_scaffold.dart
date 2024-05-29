import 'package:flutter/material.dart';

import '../../orb.dart';

class OrbScaffold extends StatelessWidget {
  final OrbAppBar? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final EdgeInsets padding;
  final bool disableSafeAreaBottom;
  final Color? backgroundColor;
  final bool extendBodyBehindAppBar;
  final bool extendBodyBehindTitle;
  final String? title;

  const OrbScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = false,
    this.floatingActionButton,
    this.disableSafeAreaBottom = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.extendBodyBehindAppBar = false,
    this.extendBodyBehindTitle = false,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final themeData = OrbThemeData.of(context);
    final palette = themeData.palette;
    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      backgroundColor: backgroundColor ?? palette.background,
      body: SafeArea(
        top: !extendBodyBehindAppBar,
        bottom: !disableSafeAreaBottom,
        child: Padding(
          padding: padding,
          child: extendBodyBehindTitle
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    if (title != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: OrbText(
                          title!,
                          type: OrbTextType.titleMedium,
                        ),
                      ),
                    body,
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: OrbText(
                          title!,
                          type: OrbTextType.titleMedium,
                        ),
                      ),
                    Expanded(
                      child: body,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
