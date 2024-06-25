import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../view_models/coalition_post_view_model.dart';
import '../widgets/image_slider.dart';

class CoalitionPostScreen extends ConsumerWidget with DateTimeFormatter {
  final int id;

  const CoalitionPostScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    ref.listen(coalitionPostViewModelProvider(id), (pref, next) {
      final error = next.error;
      if (error is! AppException) return;
      if (!next.isLoading && next.hasError) {
        context.showErrorSnackBar(
          error: error,
        );
      }
    });

    final coalitionPost = ref.watch(coalitionPostViewModelProvider(id));

    return OrbScaffold(
      appBar: const OrbAppBar(
        title: '제휴사업',
        centerTitle: true,
      ),
      padding: EdgeInsets.zero,
      disableSafeAreaBottom: true,
      body: coalitionPost.when(
        data: (data) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrbText(
                    data.title,
                    type: OrbTextType.titleSmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      OrbText(
                        data.author,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      OrbText(
                        dateFormatToRelative(data.createdAt),
                        color: context.palette.surface,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  data.images.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ImageSlider(
                            imagePaths: data.images.map((e) => e.url).toList(),
                            selectedIndicatorColor:
                                context.palette.surfaceBright,
                            unselectedIndicatorColor: context.palette.surface,
                          ),
                        )
                      : const SizedBox(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 64,
                    ),
                    child: OrbText(
                      data.body.replaceAll('  ', '\n'),
                      type: OrbTextType.bodyLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(
          child: OrbCircularProgressIndicator(),
        ),
        error: (error, _) => const SizedBox(),
      ),
    );
  }
}
