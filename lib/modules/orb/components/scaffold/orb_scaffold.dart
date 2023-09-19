import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';

class OrbScaffold extends StatelessWidget {
  final OrbAppBar? orbAppBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final OrbButton? submitButton;
  final Widget? submitHelper;
  final String? pageHelpText;
  final ScrollController? scrollController;
  final bool defaultAppBar;
  final bool shrinkWrap;
  final bool scrollBody;

  const OrbScaffold({
    super.key,
    this.orbAppBar,
    this.body,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = false,
    this.submitButton,
    this.submitHelper,
    this.pageHelpText,
    this.scrollController,
    this.defaultAppBar = true,
    this.shrinkWrap = false,
    this.scrollBody = true,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar:
          defaultAppBar && orbAppBar == null ? const OrbAppBar() : orbAppBar,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(
        top: false,
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
                  Container(
                    color: theme.colorScheme.surface,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          submitButton!,
                          submitHelper ?? const SizedBox(),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            if (MediaQuery.of(context).viewInsets.bottom > 0)
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 0,
                right: 0,
                child: submitButton?.copyWith(borderRadius: 0) ?? const SizedBox(),
              ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
