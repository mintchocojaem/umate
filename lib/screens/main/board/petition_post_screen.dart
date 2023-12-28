import 'package:danvery/domain/board/post/post_report_type.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/screens/main/board/widgets/petition_comment.dart';
import 'package:danvery/screens/main/board/widgets/petition_post.dart';
import 'package:danvery/screens/main/board/widgets/petition_statistic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/board/post/post_provider.dart';

class PetitionPostScreen extends ConsumerWidget {
  const PetitionPostScreen({
    super.key,
    required this.id,
  });

  final int id;

  final List<PostReportType> reportTypes = const [
    PostReportType.profanity(),
    PostReportType.fighting(),
    PostReportType.advertisement(),
    PostReportType.politics(),
    PostReportType.pornography(),
    PostReportType.inappropriate(),
    PostReportType.fraud(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petition = ref.watch(petitionProvider(id));
    final themeData = Theme.of(context);
    return OrbScaffold(
      orbAppBar: OrbAppBar(
        title: "청원 게시글",
        centerTitle: true,
        showLoadingIndicator: !petition.hasValue,
      ),
      body: petition.when(
        data: (value) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              PetitionPost(
                title: value.title,
                body: value.body,
                agreeCount: value.agreeCount,
                author: value.author,
                duration: "22",
                status: value.status.name,
                needAgreeCount: 50,
                menuItems: [
                  SheetItem(
                    title: "신고하기",
                    color: themeData.colorScheme.error,
                    onPressed: () async {
                      await OrbBottomSheet(
                        items: [
                          for (var item in reportTypes)
                            SheetItem(
                              title: item.value,
                              color: themeData.colorScheme.error,
                              onPressed: () async {
                                ref
                                    .read(postReportProvider.notifier)
                                    .update((state) => item);
                                final postReportType =
                                    ref.read(postReportProvider);
                                if (postReportType != null) {
                                  await OrbDialog(
                                    title: '청원 게시글 신고',
                                    content: Text(
                                      '정말로 해당 청원 게시글을 "${postReportType.value}" 사유로 신고하시겠어요?',
                                      style: themeData.textTheme.bodyMedium,
                                    ),
                                    leftButtonText: '취소',
                                    rightButtonText: '확인',
                                    onLeftButtonPressed: () async {},
                                    onRightButtonPressed: () async {
                                      ref
                                          .read(petitionProvider(id).notifier)
                                          .reportPetitionPost(
                                              categoryName:
                                                  postReportType.name);
                                    },
                                  ).show(context);
                                }
                              },
                            ),
                        ],
                      ).show(context);
                    },
                  ),
                ],
              ),
              value.answer != null
                  ? PetitionComment(
                      body: value.answer!,
                    )
                  : const SizedBox(),
              SizedBox(
                height: value.answer != null ? 16 : 0,
              ),
              const OrbDivider(),
              const SizedBox(
                height: 16,
              ),
              value.statisticList != null
                  ? PetitionStatistic(
                      agreeCount: value.agreeCount,
                      agrees: [
                        for (var agree in value.statisticList!)
                          ChartData(
                            name: agree!.department,
                            value: agree.agreeCount,
                          ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 16,
              ),
            ],
          );
        },
        loading: () {
          return const SizedBox();
        },
        error: (error, stackTrace) {
          return const SizedBox();
        },
      ),
      submitButton: petition.hasValue
          ? OrbButton(
              disabled: petition.value!.agree,
              disabledBackgroundColor: themeData.colorScheme.surface,
              disabledForegroundColor: themeData.colorScheme.onSurface,
              buttonText: petition.value!.agree ? '이미 동의하신 청원입니다' : '동의하기',
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => OrbDialog(
                    title: '청원 게시글 동의',
                    content: Text(
                      '정말로 해당 청원 게시글에 동의하시겠어요?',
                      style: themeData.textTheme.bodyMedium,
                    ),
                    leftButtonText: '취소',
                    rightButtonText: '확인',
                    onLeftButtonPressed: () async {},
                    onRightButtonPressed: () async {
                      await ref
                          .read(petitionProvider(id).notifier)
                          .agreePetitionPost();
                    },
                  ),
                );
              },
            )
          : null,
    );
  }
}
