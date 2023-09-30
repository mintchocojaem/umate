import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/screens/main/board/widgets/petition_comment.dart';
import 'package:danvery/screens/main/board/widgets/petition_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/board/post/post_provider.dart';

class ChartData {
  final String name;
  final int value;
  final Color color;

  ChartData({
    required this.name,
    required this.value,
    required this.color,
  });
}

class PetitionPostScreen extends ConsumerWidget {
  final int postId;

  PetitionPostScreen({super.key, required this.postId});

  final List<ChartData> dataList = [
    ChartData(
      name: "SW융합대학",
      value: 11,
      color: Colors.blue[900]!,
    ),
    ChartData(
      name: "음악예술대학",
      value: 3,
      color: Colors.blue[800]!,
    ),
    ChartData(
      name: "경영경제대학",
      value: 2,
      color: Colors.blue[600]!,
    ),
    ChartData(
      name: "기타",
      value: 1,
      color: Colors.blue[500]!,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData themeData = Theme.of(context);
    final post = ref.watch(postProvider(postId));
    final int minimumValue =
        dataList.map((e) => e.value).reduce((a, b) => a < b ? a : b);
    final minFlex = dataList.map((e) => e.value).reduce((a, b) => a < b ? b : a) ~/ 4;
    return OrbScaffold(
      orbAppBar: OrbAppBar(
        title: "청원 게시글",
        centerTitle: true,
        showLoadingIndicator: post.isLoading,
      ),
      body: post.when(
        data: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              PetitionPost(
                title: data!.title,
                body: data.body,
                agreeCount: data.agreeCount,
                author: data.author,
                duration: "22",
                status: data.status,
                needAgreeCount: 50,
              ),
              data.answer != null ? PetitionComment(
                body: data.answer!,
              ) : const SizedBox(),
              SizedBox(
                height: data.answer != null ? 16 : 0,
              ),
              const OrbDivider(),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    "청원동의",
                    style: themeData.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "${data.agreeCount}명",
                    style: themeData.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: themeData.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Flex(
                      direction: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final data in dataList)
                          Flexible(
                            flex: data.value <= minimumValue
                                ? minFlex
                                : data.value + minFlex,
                            child: Container(
                              height: 24,
                              color: data.color,
                              child: Center(
                                child: Text(
                                  "${data.value}명",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      themeData.textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final data in dataList)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: data.color,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              data.name,
                              style: themeData.textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
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
      submitButton: post.isLoading ? null : OrbButton(
        buttonText: '동의하기',
        onPressed: () async {},
      ),
    );
  }
}
