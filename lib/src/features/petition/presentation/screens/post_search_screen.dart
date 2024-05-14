import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../../petition_dependency_injections.dart';
import '../providers/states/search_state.dart';
import '../widgets/search_board_list.dart';

class PostSearchScreen extends ConsumerWidget with DateTimeFormatter {
  const PostSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchPostState = ref.watch(searchPostProvider);

    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);

    return OrbScaffold(
      appBar: const OrbAppBar(
        title: '게시글 검색',
        centerTitle: true,
      ),
      padding: EdgeInsets.zero,
      disableSafeAreaBottom: true,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: OrbSearchBar(
              textStyle: theme.textTheme.bodyLarge,
              onSearch: (query) {
                ref
                    .read(searchPostProvider.notifier)
                    .searchPost(keyword: query);
              },
              onTextChange: (query) {},
            ),
          ),
          Expanded(
            child: searchPostState is SearchInitialState
                ? const Center(
                    child: OrbText(
                      '검색어를 입력해주세요',
                      type: OrbTextType.titleSmall,
                    ),
                  )
                : switch (searchPostState) {
                    SearchSuccessState success => SingleChildScrollView(
                        child: Column(
                          children: [
                            SearchBoardList(
                              title: '공지사항',
                              onTap: (index) {
                                ref
                                    .read(routerServiceProvider)
                                    .pushNamed(
                                  AppRoute.noticePost.name,
                                  pathParameters: {
                                    'id': success
                                        .searchResult.notices.content[index].id
                                        .toString(),
                                  },
                                );
                              },
                              items: [
                                for (final notice
                                    in success.searchResult.notices.content)
                                  SearchBoardItem(
                                    title: notice.title,
                                    author: notice.author,
                                    createdAt:
                                        dateFormatToRelative(notice.createdAt),
                                    body: notice.body,
                                  ),
                              ],
                            ),
                            Container(
                              height: 16,
                              color: currentPalette.surfaceBright,
                            ),
                            SearchBoardList(
                              title: '제휴사업',
                              onTap: (index) {
                                ref
                                    .read(routerServiceProvider)
                                    .pushNamed(
                                  AppRoute.coalitionPost.name,
                                  pathParameters: {
                                    'id': success.searchResult.coalitions
                                        .content[index].id
                                        .toString(),
                                  },
                                );
                              },
                              items: [
                                for (final coalition
                                    in success.searchResult.coalitions.content)
                                  SearchBoardItem(
                                    title: coalition.title,
                                    author: coalition.author,
                                    createdAt: dateFormatToRelative(
                                        coalition.createdAt),
                                    body: coalition.body,
                                  ),
                              ],
                            ),
                            Container(
                              height: 16,
                              color: currentPalette.surfaceBright,
                            ),
                            SearchBoardList(
                              title: '청원게시판',
                              onTap: (index) {
                                ref
                                    .read(routerServiceProvider)
                                    .pushNamed(
                                  AppRoute.petitionPost.name,
                                  pathParameters: {
                                    'id': success.searchResult.petitions
                                        .content[index].id
                                        .toString(),
                                  },
                                );
                              },
                              items: [
                                for (final petition
                                    in success.searchResult.petitions.content)
                                  SearchBoardItem(
                                    title: petition.title,
                                    author: petition.author,
                                    createdAt: dateFormatToRelative(
                                        petition.createdAt),
                                    body: petition.body,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    _ => ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const OrbShimmerContent();
                        },
                      ),
                  },
          ),
        ],
      ),
    );
  }
}
