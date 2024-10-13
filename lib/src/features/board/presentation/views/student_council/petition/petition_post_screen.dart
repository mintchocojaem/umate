import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/services/router/router_service.dart';
import '../../../../../../core/utils/app_exception.dart';
import '../../../../../../core/utils/date_time_formatter.dart';
import '../../../../../../design_system/orb/orb.dart';
import '../../../../domain/models/post_report_type.dart';
import '../../../../domain/models/student_council/petition_status.dart';
import '../../../controllers/post_controller.dart';
import '../../../widgets/image_slider.dart';

class PetitionPostScreen extends ConsumerWidget with DateTimeFormatter {
  final int id;

  const PetitionPostScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    ref.listen(petitionPostControllerProvider(id), (pref, next) {
      if (!next.isLoading && next.hasError) {
        final error = next.error;
        if (error is! AppException) return;
        context.showErrorSnackBar(
          error: error,
        );
      }
    });

    final post = ref.watch(petitionPostControllerProvider(id));
    return OrbScaffold(
      appBar: const OrbAppBar(
        title: '청원게시글',
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
                        children: [
                          const SizedBox(
                            width: 64,
                            child: OrbText(
                              "청원자",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: OrbText(
                              data.author,
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
                              "청원기간",
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
                              "청원상태",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OrbText(
                                  "${data.status.korean}(${(data.agreeCount / 50 * 100).round()}%)",
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                LinearProgressIndicator(
                                  value: data.agreeCount / 50,
                                  minHeight: 8,
                                  borderRadius: BorderRadius.circular(15),
                                  backgroundColor:
                                      context.palette.surfaceBright,
                                  color: context.palette.secondary,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const OrbText(
                                "참여인원",
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              OrbText(
                                "${data.agreeCount}명",
                                color: context.palette.primary,
                              ),
                            ],
                          ),
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
                                            .read(
                                                petitionPostControllerProvider(
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
                      if (data.answer != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          constraints: const BoxConstraints(
                            minHeight: 100,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const OrbText(
                                "총학생회 답변",
                                type: OrbTextType.bodyLarge,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              OrbText(
                                data.answer ?? "",
                                type: OrbTextType.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 64,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              OrbFilledButton(
                disabled: data.agree || data.status != PetitionStatus.active,
                text: data.agree ? "이미 동의하신 청원이에요" : "청원 동의하기",
                onPressed: () {
                  OrbDialog(
                    title: "청원 동의",
                    content: const OrbText(
                        "정말 해당 청원에 동의 하시겠어요?\n(동의 후에는 취소할 수 없어요.)"),
                    rightButtonText: "동의하기",
                    onRightButtonPressed: () async {
                      final result = await ref
                          .read(petitionPostControllerProvider(id).notifier)
                          .agreePost();

                      if (!context.mounted) return true;
                      if (result) {
                        context.showSnackBar(
                          message: "청원에 동의하였습니다.",
                        );
                      }
                      return true;
                    },
                    leftButtonText: "닫기",
                    onLeftButtonPressed: () async {
                      return true;
                    },
                  ).show(context);
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
