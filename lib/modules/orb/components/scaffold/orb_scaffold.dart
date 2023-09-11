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
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: orbAppBar ?? const OrbAppBar(),
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
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              pageHelpText != null
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 32),
                                      child: Text(
                                        pageHelpText!,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              body ?? const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                submitButton != null
                    ? Container(
                        color: theme.colorScheme.surface,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              submitButton!,
                              submitHelper ?? const SizedBox(),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            MediaQuery.of(context).viewInsets.bottom > 0
                ? Positioned(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 0,
                    right: 0,
                    child: submitButton?.copyWith(borderRadius: 0) ??
                        const SizedBox(),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
