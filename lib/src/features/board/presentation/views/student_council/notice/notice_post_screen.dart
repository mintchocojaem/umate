import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/services/router/router_service.dart';
import '../../../../../../core/utils/app_exception.dart';
import '../../../../../../core/utils/date_time_formatter.dart';
import '../../../../../../design_system/orb/orb.dart';
import '../../../controllers/post_controller.dart';
import '../../../widgets/image_slider.dart';

class NoticePostScreen extends ConsumerWidget with DateTimeFormatter {
  final int id;

  const NoticePostScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    ref.listen(noticePostControllerProvider(id), (pref, next) {
      if (!next.isLoading && next.hasError) {
        final error = next.error;
        if (error is! AppException) return;
        context.showErrorSnackBar(
          error: error,
        );
      }
    });

    final post = ref.watch(noticePostControllerProvider(id));

    return OrbScaffold(
      appBar: const OrbAppBar(
        title: '공지사항',
        centerTitle: true,
      ),
      disableSafeAreaBottom: true,
      body: post.when(
        skipLoadingOnRefresh: true,
        skipError: true,
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
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    data.mine
                        ? GestureDetector(
                            onTap: () {
                              OrbDialog(
                                title: "게시글 삭제",
                                content: const OrbText(
                                  "정말 해당 게시글을 삭제하시겠어요?",
                                ),
                                rightButtonText: "삭제하기",
                                rightButtonColor: context.palette.error,
                                onRightButtonPressed: () async {
                                  final result = await ref
                                      .read(noticePostControllerProvider(id)
                                          .notifier)
                                      .deletePost();
                                  if (result && context.mounted) {
                                    context.showSnackBar(
                                      message: "게시글을 삭제하였습니다.",
                                    );
                                    ref.read(routerServiceProvider).pop();
                                  }
                                  return true;
                                },
                                leftButtonText: "취소",
                                onLeftButtonPressed: () async {
                                  return true;
                                },
                              ).show(context);
                            },
                            child: Row(
                              children: [
                                OrbIcon(
                                  Icons.delete,
                                  color: context.palette.error,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                OrbText(
                                  "삭제하기",
                                  color: context.palette.error,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const OrbDivider(),
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
