import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/utils/app_exception.dart';
import '../../../../../../core/utils/date_time_formatter.dart';
import '../../../../../../design_system/orb/orb.dart';
import '../../../../domain/models/post_report_type.dart';
import '../../../controllers/post_controller.dart';
import '../../../widgets/image_slider.dart';

class BearEatsPostScreen extends ConsumerWidget with DateTimeFormatter {
  final int id;

  const BearEatsPostScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    ref.listen(bearEatsPostControllerProvider(id), (pref, next) {
      if (!next.isLoading && next.hasError) {
        final error = next.error;
        if (error is! AppException) return;
        context.showErrorSnackBar(
          error: error,
        );
      }
    });

    final petitionPost = ref.watch(bearEatsPostControllerProvider(id));
    return OrbScaffold(
      appBar: const OrbAppBar(
        title: '단터디 게시글',
        centerTitle: true,
      ),
      body: petitionPost.when(
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
                          const Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: OrbText(
                              "작성자",
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
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
                          const Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: OrbText(
                              "모집일",
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: OrbText(
                              dateFormatToRelative(data.createdAt),
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
                                    rightButtonColor: context.palette.error,
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
              OrbFilledButton(
                text: "참여하기",
                onPressed: () {},
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
