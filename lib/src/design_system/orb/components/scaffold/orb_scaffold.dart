import 'package:flutter/material.dart';

import '../components.dart';

class OrbScaffold extends StatelessWidget {
  final OrbAppBar? orbAppBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final Widget? submitButton;
  final Widget? submitButtonOnKeyboard;
  final Widget? submitHelper;
  final ScrollController? scrollController;
  final bool shrinkWrap;
  final bool scrollBody;
  final FloatingActionButton? floatingActionButton;
  final bool bottomPadding;
  final Color? backgroundColor;

  const OrbScaffold({
    super.key,
    this.orbAppBar = const OrbAppBar(),
    this.body,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = false,
    this.submitButton,
    this.submitButtonOnKeyboard,
    this.submitHelper,
    this.scrollController,
    this.shrinkWrap = false,
    this.scrollBody = true,
    this.floatingActionButton,
    this.bottomPadding = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: orbAppBar ?? const OrbAppBar(),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor ?? themeData.colorScheme.background,
      body: SafeArea(
        bottom: bottomPadding,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: scrollBody
                        ? SingleChildScrollView(
                            controller: scrollController,
                            child: shrinkWrap
                                ? body
                                : IntrinsicHeight(
                                    child: body,
                                  ),
                          )
                        : body,
                  ),
                ),
                if (submitButton != null)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        submitButton!,
                        submitHelper ?? const SizedBox(),
                      ],
                    ),
                  ),
              ],
            ),
            if (MediaQuery.of(context).viewInsets.bottom > 0 &&
                submitButtonOnKeyboard != null)
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 0,
                right: 0,
                child: submitButtonOnKeyboard!,
              ),
          ],
        ),
      ),
    );
  }
}
