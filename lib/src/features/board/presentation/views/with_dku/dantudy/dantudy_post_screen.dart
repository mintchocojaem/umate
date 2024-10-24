import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/services/router/router_service.dart';
import '../../../../../../core/utils/app_exception.dart';
import '../../../../../../core/utils/date_time_formatter.dart';
import '../../../../../../design_system/orb/orb.dart';
import '../../../../domain/models/post_report_type.dart';
import '../../../controllers/post_controller.dart';
import '../../../widgets/image_slider.dart';

class DantudyPostScreen extends ConsumerWidget with DateTimeFormatter {
  final int id;

  const DantudyPostScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    ref.listen(dantudyPostControllerProvider(id), (pref, next) {
      if (!next.isLoading && next.hasError) {
        final error = next.error;
        if (error is! AppException) return;
        context.showErrorSnackBar(
          error: error,
        );
      }
    });

    final post = ref.watch(dantudyPostControllerProvider(id));
    return OrbScaffold(
      appBar: const OrbAppBar(
        title: '단터디 게시글',
        centerTitle: true,
      ),
      body: post.when(
        skipError: true,
        skipLoadingOnRefresh: true,
        data: (data) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: OrbText(
                              data.title,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              type: OrbTextType.titleSmall,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 64,
                            child: OrbText(
                              "작성자",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: OrbText(
                              '${data.author}(${data.gender} / ${data.major})',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 64,
                            child: OrbText(
                              "작성일",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: OrbText(
                              dateFormatToRelative(data.createdAt),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 64,
                            child: OrbText(
                              "모집상태",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: OrbText(
                              "${data.recruitedCount} 명 모집됨",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 64,
                            child: OrbText(
                              "태그",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: OrbText(
                              data.tag,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 64,
                            child: OrbText(
                              "시간",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: OrbText(
                              data.studyDate,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const OrbDivider(),
                      const SizedBox(
                        height: 16,
                      ),
                      data.images.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ImageSlider(
                                imagePaths:
                                    data.images.map((e) => e.url).toList(),
                                selectedIndicatorColor:
                                    context.palette.surfaceBright,
                                unselectedIndicatorColor:
                                    context.palette.surface,
                              ),
                            )
                          : const SizedBox(),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 64,
                        ),
                        child: OrbText(
                          data.body.replaceAll("  ", "\n"),
                          type: OrbTextType.bodyMedium,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: context.palette.surfaceBright,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OrbText(
                              '모집 현황 (${data.recruitedUsers.length}명)',
                              type: OrbTextType.bodyLarge,
                              fontWeight: OrbFontWeight.medium,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            if (data.recruitedUsers.isEmpty)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: OrbText(
                                    "아직 모집된 사람이 없습니다.",
                                    type: OrbTextType.bodyMedium,
                                  ),
                                ),
                              ),
                            for (var i = 0; i < data.recruitedUsers.length; i++)
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor:
                                            context.palette.background,
                                        child: OrbIcon(
                                          Icons.person,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          OrbText(
                                            data.recruitedUsers[i].nickname,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            type: OrbTextType.bodyMedium,
                                            fontWeight: OrbFontWeight.medium,
                                          ),
                                          OrbText(
                                            data.recruitedUsers[i].majorName,
                                            type: OrbTextType.bodySmall,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  OrbDivider(),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: context.palette.surfaceBright,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OrbText(
                              '오픈채팅방 링크',
                              type: OrbTextType.bodyLarge,
                              fontWeight: OrbFontWeight.medium,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            OrbText(
                              data.kakaoOpenChatLink.isEmpty
                                  ? '게시글 마감 후 공개됩니다'
                                  : data.kakaoOpenChatLink,
                              type: OrbTextType.bodyMedium,
                              maxLines: 1,
                            ),
                          ],
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
                                            .read(dantudyPostControllerProvider(
                                                    id)
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
                              : GestureDetector(
                                  onTap: () {
                                    OrbActionSheet(
                                      items: [
                                        SheetItem(
                                          title: PostReportType.profanity.name,
                                        ),
                                        SheetItem(
                                          title: PostReportType.fishing.name,
                                        ),
                                        SheetItem(
                                          title:
                                              PostReportType.advertisement.name,
                                        ),
                                        SheetItem(
                                          title: PostReportType.politics.name,
                                        ),
                                        SheetItem(
                                          title:
                                              PostReportType.pornography.name,
                                        ),
                                        SheetItem(
                                          title: PostReportType.fraud.name,
                                        ),
                                        SheetItem(
                                          title: PostReportType
                                              .inappropriateContent.name,
                                        ),
                                      ],
                                      onSelected: (index) {
                                        OrbDialog(
                                          title: "청원 신고",
                                          content: const OrbText(
                                            "정말 해당 청원을 신고하시겠어요?\n\n(허위 신고 시 제재가 가해질 수 있습니다.)",
                                          ),
                                          rightButtonText: "신고하기",
                                          rightButtonColor:
                                              context.palette.error,
                                          onRightButtonPressed: () async {
                                            //
                                            if (!context.mounted) return true;
                                            return true;
                                          },
                                          leftButtonText: "취소",
                                          onLeftButtonPressed: () async {
                                            return true;
                                          },
                                        ).show(context);
                                      },
                                    ).show(context);
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/report.png",
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      OrbText(
                                        "신고하기",
                                        color: context.palette.error,
                                      ),
                                    ],
                                  ),
                                ),
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
                ),
              ),
              const SizedBox(height: 8),
              data.mine
                  ? OrbFilledButton(
                      text: "모집 마감하기",
                      backgroundColor: context.palette.error,
                      onPressed: () async {
                        final result = await ref
                            .read(dantudyPostControllerProvider(id).notifier)
                            .closePost();
                        if (result && context.mounted) {
                          context.showSnackBar(
                            message: "게시글 모집을 마감하였습니다.",
                          );
                          ref.read(routerServiceProvider).pop();
                        }
                      },
                    )
                  : OrbFilledButton(
                      text: data.applied ? "참여 신청 완료" : "참여하기",
                      disabled: data.applied,
                      onPressed: () async {
                        final result = await ref
                            .read(dantudyPostControllerProvider(id).notifier)
                            .enterPost();
                        if (result && context.mounted) {
                          context.showSnackBar(
                            message: "해당 게시글에 참여하였습니다.",
                          );
                        }
                      },
                    ),
            ],
          );
        },
        loading: () => const Center(
          child: OrbCircularProgressIndicator(),
        ),
        error: (error, stackTrace) => const SizedBox(),
      ),
    );
  }
}
