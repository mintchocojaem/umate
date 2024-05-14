import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/models/petition_post.dart';
import '../../domain/models/petition_status.dart';
import '../../domain/models/post_report_type.dart';
import '../../petition_dependency_injections.dart';
import '../providers/states/post_state.dart';
import '../widgets/image_slider.dart';

class PetitionPostScreen extends ConsumerWidget with DateTimeFormatter {
  final int id;

  const PetitionPostScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    ref.listen(
      petitionPostProvider(id),
      (prev, next) {
        if (next is PostFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            OrbSnackBar(
              message: next.message,
              type: OrbSnackBarType.error,
            ),
          );
        } else if (next is PostSuccessState<PetitionPost> &&
            next.hasError &&
            next.message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            OrbSnackBar(
              message: next.message,
              type: OrbSnackBarType.error,
            ),
          );
        } else if (next is PostSuccessState<PetitionPost> &&
            !next.hasError &&
            next.message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            OrbSnackBar(
              message: next.message,
              type: OrbSnackBarType.info,
            ),
          );
        }
      },
    );

    final petitionPostState = ref.watch(petitionPostProvider(id));
    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return OrbScaffold(
      appBar: const OrbAppBar(
        title: '청원게시글',
        centerTitle: true,
      ),
      body: switch (petitionPostState) {
        PostSuccessState<PetitionPost> success => Column(
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
                              success.post.title,
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
                          const Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: OrbText(
                              "청원자",
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: OrbText(
                              success.post.author,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: OrbText(
                              "청원기간",
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: OrbText(
                              dateFormatToRelative(success.post.createdAt),
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
                          const Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: OrbText(
                              "청원상태",
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OrbText(
                                  "${success.post.status.korean}(${(success.post.agreeCount / 50 * 100).round()}%)",
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                LinearProgressIndicator(
                                  value: success.post.agreeCount / 50,
                                  minHeight: 8,
                                  borderRadius: BorderRadius.circular(15),
                                  backgroundColor: currentPalette.surfaceBright,
                                  color: currentPalette.secondary,
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
                      success.post.images.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ImageSlider(
                                imagePaths: success.post.images
                                    .map((e) => e.url)
                                    .toList(),
                                selectedIndicatorColor:
                                    currentPalette.surfaceBright,
                                unselectedIndicatorColor:
                                    currentPalette.surface,
                              ),
                            )
                          : const SizedBox(),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 64,
                        ),
                        child: OrbText(
                          success.post.body.replaceAll("  ", "\n"),
                          type: OrbTextType.bodyLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
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
                                    title: PostReportType.advertisement.name,
                                  ),
                                  SheetItem(
                                    title: PostReportType.politics.name,
                                  ),
                                  SheetItem(
                                    title: PostReportType.pornography.name,
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
                                    rightButtonColor: currentPalette.error,
                                    onRightButtonPressed: () async {
                                      await ref
                                          .read(
                                              petitionPostProvider(id).notifier)
                                          .reportPetitionPost(
                                            reportType:
                                                PostReportType.values[index],
                                          );
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
                                  color: currentPalette.error,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const OrbText(
                                "참여인원",
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              OrbText(
                                "${success.post.agreeCount}명",
                                color: currentPalette.primary,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const OrbDivider(),
                      if (success.post.answer != null)
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
                                type: OrbTextType.titleSmall,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              OrbText(
                                success.post.answer ?? "",
                                type: OrbTextType.bodyLarge,
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
                disabled: success.post.agree ||
                    success.post.status == PetitionStatus.expired,
                text: success.post.agree ? "이미 동의하신 청원이에요" : "청원 동의하기",
                onPressed: () {
                  OrbDialog(
                    title: "청원 동의",
                    content: const OrbText(
                        "정말 해당 청원에 동의 하시겠어요?\n(동의 후에는 취소할 수 없어요.)"),
                    rightButtonText: "동의하기",
                    onRightButtonPressed: () async {
                      await ref
                          .read(petitionPostProvider(id).notifier)
                          .agreePetitionPost(id: id);
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
          ),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}
