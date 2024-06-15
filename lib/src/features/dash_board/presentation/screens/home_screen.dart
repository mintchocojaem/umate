import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../providers/home_board_provider.dart';
import '../widgets/carousel_indicator.dart';
import '../widgets/web_banner.dart';

class HomeScreen extends ConsumerWidget with DateTimeFormatter {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      homeBoardProvider,
      (_, next) {
        if (!next.isLoading && next.hasError) {
          final error = next.error;
          if (error is! AppException) return;
          context.showSnackBar(
            message: error.message,
            type: OrbSnackBarType.error,
          );
        }
      },
    );

    final homeBoard = ref.watch(homeBoardProvider);

    ValueNotifier<int> currentBannerIndex = ValueNotifier<int>(0);
    return OrbScaffold(
      backgroundColor: context.palette.surfaceBright,
      appBar: OrbAppBar(
        backgroundColor: context.palette.background,
        title: "U Mate",
        titleColor: context.palette.surfaceDim,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/images/logo.png',
            color: context.palette.surfaceDim,
          ),
        ),
      ),
      padding: EdgeInsets.zero,
      body: SingleChildScrollView(
        child: Column(
          children: [
            homeBoard.when(
              data: (data) {
                return ValueListenableBuilder(
                  valueListenable: currentBannerIndex,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            WebBanner(
                              urls: data.carousels.map((e) => e.url).toList(),
                              onTap: (index) {
                                return () async {};
                              },
                              onPageChanged: (int index) {
                                currentBannerIndex.value = index;
                              },
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: CarouselIndicator(
                                    length: data.carousels.length,
                                    currentIndex: value,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              loading: () => Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                color: context.palette.outline,
              ),
              error: (error, stackTrace) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  color: context.palette.outline,
                  child: OrbIcon(
                    Icons.image_not_supported,
                    size: OrbIconSize.large,
                    color: context.palette.error,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
