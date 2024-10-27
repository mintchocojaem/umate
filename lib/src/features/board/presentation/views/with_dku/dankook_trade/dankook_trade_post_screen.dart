import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../core/services/router/router_service.dart';
import '../../../../../../core/utils/app_exception.dart';
import '../../../../../../core/utils/date_time_formatter.dart';
import '../../../../../../design_system/orb/orb.dart';
import '../../../../domain/models/post_report_type.dart';
import '../../../controllers/post_controller.dart';
import '../../../widgets/image_slider.dart';

class DankookTradePostScreen extends ConsumerWidget with DateTimeFormatter {
  final int id;

  const DankookTradePostScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    ref.listen(dankookTradePostControllerProvider(id), (pref, next) {
      if (!next.isLoading && next.hasError) {
        final error = next.error;
        if (error is! AppException) return;
        context.showErrorSnackBar(
          error: error,
        );
      }
    });

    final post = ref.watch(dankookTradePostControllerProvider(id));
    return OrbScaffold(
      appBar: const OrbAppBar(
        title: '단국거래 게시글',
        centerTitle: true,
      ),
      body: post.when(
        skipLoadingOnRefresh: true,
        skipError: true,
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
                        children: [
                          const SizedBox(
                            width: 64,
                            child: OrbText(
                              "가격",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: OrbText(
                              "${data.price}원",
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
                              "판매 상태",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: OrbText(
                              data.status,
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
                              "거래 장소",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: OrbText(
                              data.tradePlace,
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
                                            .read(
                                                dankookTradePostControllerProvider(
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
                      text: data.status == "판매중" ? "판매 마감하기" : "판매가 마감되었습니다.",
                      disabled: data.status != "판매중",
                      backgroundColor: context.palette.error,
                      onPressed: () async {
                        final result = await ref
                            .read(
                                dankookTradePostControllerProvider(id).notifier)
                            .closePost();
                        if (result && context.mounted) {
                          context.showSnackBar(
                            message: "게시글이 판매 마감 처리되었습니다.",
                          );
                          ref.read(routerServiceProvider).pop();
                        }
                      },
                    )
                  : OrbFilledButton(
                      text: data.status == "판매중" ? "채팅하기" : "판매가 마감되었습니다.",
                      disabled: data.status != "판매중" ||
                          data.kakaoOpenChatLink.isEmpty,
                      onPressed: () {
                        if (data.kakaoOpenChatLink.isNotEmpty) {
                          launchUrlString(data.kakaoOpenChatLink);
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
