import 'package:danvery/domain/board/post/post_report_type.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/screens/main/board/widgets/petition_comment.dart';
import 'package:danvery/screens/main/board/widgets/petition_post.dart';
import 'package:danvery/screens/main/board/widgets/petition_statistic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../domain/board/post/post_provider.dart';

class PetitionDetailScreen extends ConsumerWidget {
  const PetitionDetailScreen({
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

  final List<String> fileTypes = const [
    'pdf',
    'doc',
    'docx',
    'ppt',
    'pptx',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petition = ref.watch(petitionDetailProvider(id));
    final themeData = Theme.of(context);
    return OrbScaffold(
      orbAppBar: OrbAppBar(
        title: "청원 게시글",
        centerTitle: true,
        showLoadingIndicator: !petition.hasValue,
        trailing: IconButton(
          onPressed: () {
            OrbBottomSheet(
              items: [
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
                                        .read(
                                            petitionDetailProvider(id).notifier)
                                        .reportPetitionPost(
                                            categoryName: postReportType.name);
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
            ).show(context);
          },
          icon: Icon(
            Icons.more_vert_rounded,
            color: themeData.colorScheme.onSurface,
          ),
        ),
      ),
      body: petition.when(
        data: (value) {
          final image = value.images.firstOrNull;

          final file = value.files.firstOrNull;

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
              ),
              const SizedBox(
                height: 16,
              ),
              image != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          image.url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const SizedBox(),
              file != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => OrbDialog(
                              title: '첨부파일 다운로드',
                              content: Text(
                                '해당 첨부파일을 다운로드 하시겠어요?',
                                style: themeData.textTheme.bodyMedium,
                              ),
                              leftButtonText: '취소',
                              rightButtonText: '확인',
                              onLeftButtonPressed: () async {},
                              onRightButtonPressed: () async {
                                await launchUrlString(
                                  file.url,
                                );
                              },
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            color: themeData.colorScheme.surface,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attachment_rounded,
                                  color: themeData.colorScheme.onSurface,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  file.originalName,
                                  style: themeData.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              value.answer != null
                  ? Column(
                      children: [
                        const OrbDivider(),
                        PetitionComment(
                          body: value.answer!,
                        ),
                      ],
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
                height: 32,
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
                          .read(petitionDetailProvider(id).notifier)
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
