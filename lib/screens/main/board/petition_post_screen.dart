import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/screens/main/board/widgets/petition_comment.dart';
import 'package:danvery/screens/main/board/widgets/petition_post.dart';
import 'package:danvery/screens/main/board/widgets/petition_statistic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/board/post/post_provider.dart';

class PetitionPostScreen extends ConsumerWidget {

  const PetitionPostScreen({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(postProvider(postId));
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
              data.answer != null
                  ? PetitionComment(
                      body: data.answer!,
                    )
                  : const SizedBox(),
              SizedBox(
                height: data.answer != null ? 16 : 0,
              ),
              const OrbDivider(),
              const SizedBox(
                height: 16,
              ),
              data.statisticList != null ? PetitionStatistic(
                agreeCount: data.agreeCount,
                agrees: [
                  for (var agree in data.statisticList!)
                    ChartData(
                      name: agree!.department,
                      value: agree.agreeCount,
                    ),
                ],
              ) : const SizedBox(),
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
      submitButton: post.isLoading
          ? null
          : OrbButton(
              buttonText: '동의하기',
              onPressed: () async {},
            ),
    );
  }
}
