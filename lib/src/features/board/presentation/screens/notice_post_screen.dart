import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../view_models/notice_post_view_model.dart';
import '../widgets/image_slider.dart';

class NoticePostScreen extends ConsumerWidget with DateTimeFormatter {
  final int id;

  const NoticePostScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    ref.listen(noticePostViewModelProvider(id), (pref, next) {
      if (!next.isLoading && next.hasError) {
        final error = next.error;
        if (error is! AppException) return;
        context.showErrorSnackBar(
          error: error,
        );
      }
    });

    final noticePost = ref.watch(noticePostViewModelProvider(id));

    return OrbScaffold(
      appBar: const OrbAppBar(
        title: '공지사항',
        centerTitle: true,
      ),
      disableSafeAreaBottom: true,
      body: noticePost.when(
        data: (data) {
          return SingleChildScrollView(
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
                          selectedIndicatorColor: context.palette.surfaceBright,
                          unselectedIndicatorColor: context.palette.surface,
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        color: context.palette.surface,
                      ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 64,
                  ),
                  child: OrbText(
                    data.body.replaceAll('  ', '\n'),
                    type: OrbTextType.bodyMedium,
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: OrbCircularProgressIndicator(),
        ),
        error: (error, stackTrace) {
          return SizedBox();
        },
      ),
    );
  }
}
