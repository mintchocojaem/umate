import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/models/notice_post.dart';
import '../../petition_dependency_injections.dart';
import '../providers/states/post_state.dart';
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

    ref.listen(noticePostProvider(id), (pref, next) {
      if (next is PostFailureState) {
        ScaffoldMessenger.of(context).showSnackBar(
          OrbSnackBar(
            message: next.message,
            type: OrbSnackBarType.error,
          ),
        );
      }
    });

    final noticePostState = ref.watch(noticePostProvider(id));

    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return OrbScaffold(
      appBar: const OrbAppBar(
        title: '공지사항',
        centerTitle: true,
      ),
      disableSafeAreaBottom: true,
      body: switch (noticePostState) {
        PostSuccessState<NoticePost> success => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrbText(
                  success.post.title,
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
                      success.post.author,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    OrbText(
                      dateFormatToRelative(success.post.createdAt),
                      color: currentPalette.surface,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                success.post.images.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ImageSlider(
                          imagePaths:
                              success.post.images.map((e) => e.url).toList(),
                          selectedIndicatorColor: currentPalette.surfaceBright,
                          unselectedIndicatorColor: currentPalette.surface,
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        color: currentPalette.surface,
                      ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 64,
                  ),
                  child: OrbText(
                    success.post.body.replaceAll('  ', '\n'),
                    type: OrbTextType.bodyLarge,
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
              ],
            ),
          ),
        _ => const SizedBox(),
      },
    );
  }
}
